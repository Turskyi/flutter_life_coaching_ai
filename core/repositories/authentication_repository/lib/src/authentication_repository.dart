import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/src/authentication_status.dart';
import 'package:authentication_repository/src/env/env.dart';
import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The AuthenticationRepository exposes a Stream of AuthenticationStatus
/// updates which will be used to notify the application when a user signs in
/// or out.
/// Since we are maintaining a StreamController internally, a dispose method
/// is exposed so that the controller can be closed when it is no longer needed.
class AuthenticationRepository {
  AuthenticationRepository(this._restClient, this._preferences);

  final RestClient _restClient;
  final SharedPreferences _preferences;

  final StreamController<AuthenticationStatus> _controller =
      StreamController<AuthenticationStatus>();

  clerk.DefaultPersistor? _persistor;

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

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _restClient.signEmail(email);

    final LoginResponse loginResponse = await _restClient.signIn(
      email,
      password,
      'password',
    );

    await _saveToken(loginResponse.token);
    await _saveUserId(loginResponse.userId);
    _controller.add(AuthenticationStatus.authenticated());
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _authInit();

    final clerk.Client? signUpResponse = await _auth?.attemptSignUp(
      strategy: clerk.Strategy.password,
      emailAddress: email,
      password: password,
      passwordConfirmation: password,
    );

    final String? signUpId = signUpResponse?.id;

    if (signUpId?.isNotEmpty == true) {
      await _saveSignUpId(signUpId ?? '');

      _controller.add(AuthenticationStatus.code(email));
    }

    await _saveEmail(email);
  }

  Future<void> sendCodeToUser() async {
    final String signUpId = _preferences.getString(
          StorageKeys.signUpId.key,
        ) ??
        '';

    if (signUpId.isNotEmpty) {
      await _authInit();

      await _auth?.attemptSignUp(
        strategy: clerk.Strategy.resetPasswordEmailCode,
        emailAddress: _email,
      );
    } else {
      //TODO:  this should never happen, so better come up with better handling.
      throw Exception('Signup id is empty');
    }
  }

  Future<void> verify(String code) async {
    final String signUpId = _preferences.getString(
          StorageKeys.signUpId.key,
        ) ??
        '';

    if (signUpId.isNotEmpty) {
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
      }
    } else {
      //TODO:  this should never happen, so better come up with better handling.
      _controller.add(AuthenticationStatus.unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _auth?.signOut();
    _auth?.terminate();

    await _restClient.signOut();

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
    final String token = _preferences.getString(
          StorageKeys.authToken.key,
        ) ??
        '';

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

  String get _email => _preferences.getString(StorageKeys.email.key) ?? '';

  Future<bool> _removeToken() => _preferences.remove(StorageKeys.authToken.key);

  Future<bool> _removeSignUpId() => _preferences.remove(
        StorageKeys.signUpId.key,
      );

  Future<bool> _removeEmail() => _preferences.remove(StorageKeys.email.key);

  Future<bool> _removeUserId() => _preferences.remove(StorageKeys.userId.key);

  Future<MessageResponse> deleteAccount(String userId) {
    _controller.add(AuthenticationStatus.deleting());
    return signOut().then((_) => _restClient.deleteAccount(userId));
  }

  bool canSendCode() {
    final String signUpId = _preferences.getString(
          StorageKeys.signUpId.key,
        ) ??
        '';
    return signUpId.isNotEmpty;
  }

  Future<void> _authInit() async {
    _persistor ??= await clerk.DefaultPersistor.create(
      storageDirectory: Directory.current,
    );
    if (_auth == null && _persistor != null) {
      _auth = clerk.Auth(
        persistor: _persistor!,
        config: const clerk.AuthConfig(
          publishableKey: Env.clerkPublishableKey,
        ),
      );

      await _auth?.initialize();
    }
  }
}
