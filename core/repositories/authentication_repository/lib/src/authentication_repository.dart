import 'dart:async';

import 'package:authentication_repository/src/authentication_status.dart';
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

  Stream<AuthenticationStatus> get status async* {
    final bool isSignUpSent = canSendCode();

    if (isSignUpSent) {
      final String email = _preferences.getString(StorageKeys.email.key) ?? '';

      yield AuthenticationStatus.code(email);
    } else {
      final bool isAuthenticated = _checkInitialAuthenticationStatus();

      if (isAuthenticated) {
        yield AuthenticationStatus.authenticated();
      } else {
        yield AuthenticationStatus.unauthenticated();
      }
    }

    // Yield the stream of authentication status changes
    yield* _controller.stream;
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final LoginResponse loginResponse = await _restClient.signIn(
      email,
      password,
      'password',
    );

    await _saveToken(loginResponse.token);
    _controller.add(AuthenticationStatus.authenticated());
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final RegisterResponse signUpResponse = await _restClient.signUp(
      email,
      password,
    );

    await _restClient.prepare(
      signUpResponse.id,
      'email_code',
    );

    await _saveSignUpId(signUpResponse.id);
    _controller.add(AuthenticationStatus.code(email));
    await _saveEmail(email);
  }

  Future<CodeResponse> sendCode() {
    final String signUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';

    if (signUpId.isNotEmpty) {
      return _restClient.prepare(signUpId, 'email_code');
    } else {
      //TODO:  this should never happen, so better come up with better handling.
      throw Exception('Signup id is empty');
    }
  }

  Future<void> verify(String code) async {
    final String signUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';

    if (signUpId.isNotEmpty) {
      await _restClient.verify(
        signUpId,
        code,
        // This value is always `email_code`.
        'email_code',
      );
      _controller.add(AuthenticationStatus.authenticated());
      await _removeSignUpId();
    } else {
      //TODO:  this should never happen, so better come up with better handling.
      _controller.add(AuthenticationStatus.unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _restClient.signOut();
    await _removeToken();
    await _removeEmail();
    _controller.add(AuthenticationStatus.unauthenticated());
  }

  void dispose() => _controller.close();

  bool _checkInitialAuthenticationStatus() {
    final String token =
        _preferences.getString(StorageKeys.authToken.key) ?? '';
    return token.isNotEmpty;
  }

  bool canSendCode() {
    final String signUpId =
        _preferences.getString(StorageKeys.signUpId.key) ?? '';
    return signUpId.isNotEmpty;
  }

  Future<bool> _saveToken(String token) async =>
      _preferences.setString(StorageKeys.authToken.key, token);

  Future<bool> _saveSignUpId(String id) async =>
      _preferences.setString(StorageKeys.signUpId.key, id);

  Future<bool> _saveEmail(String email) async =>
      _preferences.setString(StorageKeys.email.key, email);

  Future<bool> _removeToken() => _preferences.remove(StorageKeys.authToken.key);

  Future<bool> _removeSignUpId() =>
      _preferences.remove(StorageKeys.signUpId.key);

  Future<bool> _removeEmail() => _preferences.remove(StorageKeys.email.key);
}
