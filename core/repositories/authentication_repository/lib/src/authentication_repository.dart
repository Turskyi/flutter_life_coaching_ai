import 'dart:async';

import 'package:authentication_repository/src/authentication_status.dart';
import 'package:authentication_repository/src/env/env.dart';
import 'package:authentication_repository/src/shared_preferences_persistor.dart';
import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [AuthenticationRepository] exposes a [Stream] of [AuthenticationStatus]
/// updates which will be used to notify the application when a user signs in
/// or out.
/// Since we are maintaining a [StreamController] internally, a dispose method
/// is exposed so that the controller can be closed when it is no longer needed.
class AuthenticationRepository {
  AuthenticationRepository(this._restClient, this._preferences);

  final RestClient _restClient;
  final SharedPreferences _preferences;

  final StreamController<AuthenticationStatus> _controller =
      StreamController<AuthenticationStatus>();

  clerk.Auth? _auth;

  Stream<AuthenticationStatus> get status async* {
    final bool isAuthenticated = _checkInitialAuthenticationStatus();

    if (isAuthenticated) {
      yield AuthenticationStatus.authenticated();
    } else {
      yield AuthenticationStatus.unauthenticated();
    }

    // Yield the stream of authentication status changes
    yield* _controller.stream;
  }

  Future<void> signIn({required String email, required String password}) async {
    final String trimmedEmail = email.trim();
    await _restClient.signEmail(trimmedEmail);
    final String trimmedPassword = password.trim();

    final LoginResponse loginResponse = await _restClient.signIn(
      trimmedEmail,
      trimmedPassword,
      'password',
    );

    await _saveToken(loginResponse.token);
    await _saveUserId(loginResponse.userId);
    _controller.add(AuthenticationStatus.authenticated());
  }

  Future<void> signUp({required String email, required String password}) async {
    await _authInit();

    await _auth?.attemptSignUp(
      strategy: clerk.Strategy.emailCode,
      emailAddress: email,
      password: password,
      passwordConfirmation: password,
    );

    final String? signUpId = _auth?.signUp?.id;

    if (signUpId?.isNotEmpty == true) {
      await _saveSignUpId(signUpId ?? '');
      await _saveEmail(email);

      _controller.add(AuthenticationStatus.code(email));
    }
  }

  Future<void> forgotPassword(String email) async {
    await _authInit();
    await _auth?.attemptSignIn(
      strategy: clerk.Strategy.resetPasswordEmailCode,
      identifier: email,
    );
    _controller.add(AuthenticationStatus.resetPassword(email));
  }

  Future<void> resetPassword({
    required String code,
    required String newPassword,
  }) async {
    await _authInit();
    await _auth?.attemptSignIn(
      strategy: clerk.Strategy.resetPasswordEmailCode,
      code: code,
      password: newPassword,
    );

    final String? userId = _auth?.client.user?.id;

    if (userId?.isNotEmpty == true) {
      await _saveUserId(userId ?? '');
      _controller.add(AuthenticationStatus.authenticated());
    } else {
      throw Exception('Reset password failed');
    }
  }

  Future<void> sendCodeToUser() async {
    final String signUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';

    if (signUpId.isEmpty) {
      throw StateError(
        'Cannot send verification code because sign-up session is missing.',
      );
    } else {
      await _authInit();

      await _auth?.attemptSignUp(strategy: clerk.Strategy.emailCode);
    }
  }

  Future<void> verify(String code) async {
    final String signUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';

    if (signUpId.isEmpty) {
      throw StateError(
        'Cannot verify sign-up code because sign-up session is missing.',
      );
    } else {
      await _authInit();

      final clerk.Client? clerkClient = await _auth?.attemptSignUp(
        strategy: clerk.Strategy.emailCode,
        code: code,
      );

      final String? userId = clerkClient?.user?.id;

      if (userId?.isNotEmpty == true) {
        await _saveUserId(userId ?? '');
        _controller.add(AuthenticationStatus.authenticated());
        await _removeSignUpId();
      } else {
        throw StateError(
          'Verification completed without a user id from Clerk.',
        );
      }
    }
  }

  Future<void> signOut() async {
    await _auth?.signOut();
    _auth?.terminate();

    await _removeToken();
    await _removeEmail();
    await _removeUserId();
    _controller.add(AuthenticationStatus.unauthenticated());
  }

  void dispose() {
    _auth?.terminate();
    _controller.close();
  }

  bool _checkInitialAuthenticationStatus() {
    final String token = _preferences.getString(StorageKeys.email.key) ?? '';

    return token.isNotEmpty;
  }

  Future<bool> _saveToken(String token) {
    return _preferences.setString(StorageKeys.authToken.key, token);
  }

  Future<bool> _saveUserId(String userId) {
    return _preferences.setString(StorageKeys.userId.key, userId);
  }

  Future<bool> _saveSignUpId(String id) {
    return _preferences.setString(StorageKeys.signUpId.key, id);
  }

  Future<bool> _saveEmail(String email) {
    return _preferences.setString(StorageKeys.email.key, email);
  }

  Future<bool> _removeToken() => _preferences.remove(StorageKeys.authToken.key);

  Future<bool> _removeSignUpId() =>
      _preferences.remove(StorageKeys.signUpId.key);

  Future<bool> _removeEmail() => _preferences.remove(StorageKeys.email.key);

  Future<bool> _removeUserId() => _preferences.remove(StorageKeys.userId.key);

  Future<MessageResponse> deleteAccount(String userId) {
    _controller.add(AuthenticationStatus.deleting());
    return signOut().then((_) => _restClient.deleteAccount(userId));
  }

  /// Returns `true` only when there is an active Clerk sign-up session that
  /// matches the sign-up id persisted in local storage.
  ///
  /// The stored id is written after a successful [signUp] call reaches the
  /// verification stage. It may remain in local storage between app launches,
  /// so this method also requires the current in-memory Clerk [_auth] instance
  /// to expose the same active `signUp.id`.
  ///
  /// This means `canSendCode()` can legitimately return `true` during the same
  /// live sign-up flow, but stale ids from older runs should be filtered out by
  /// [_clearStaleSignUpId] during [_authInit].
  bool canSendCode() {
    final String signUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';
    final String activeSignUpId = _auth?.signUp?.id ?? '';

    return signUpId.isNotEmpty && signUpId == activeSignUpId;
  }

  Future<void> _authInit() async {
    if (_auth == null) {
      _auth = clerk.Auth(
        config: clerk.AuthConfig(
          publishableKey: Env.clerkPublishableKey,
          persistor: SharedPreferencesPersistor(_preferences),
        ),
      );

      await _auth?.initialize();
      await _clearStaleSignUpId();
    }
  }

  /// Removes a locally persisted sign-up id when it no longer matches the
  /// active Clerk sign-up session after authentication initialization.
  ///
  /// This runs only during [_authInit], not on every [canSendCode] call. Its
  /// purpose is to reconcile leftover local state from previous app runs with
  /// Clerk's current in-memory session state.
  ///
  /// If a user is in an active sign-up flow, the stored id and Clerk's current
  /// `signUp.id` should match and the value is kept. If the stored id belongs
  /// to an older abandoned flow, it is removed.
  Future<void> _clearStaleSignUpId() async {
    final String storedSignUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';

    if (storedSignUpId.isEmpty) {
      return;
    }

    final String activeSignUpId = _auth?.signUp?.id ?? '';

    if (activeSignUpId != storedSignUpId) {
      await _removeSignUpId();
    }
  }
}
