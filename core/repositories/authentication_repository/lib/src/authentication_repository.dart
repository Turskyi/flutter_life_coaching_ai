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
    final bool isAuthenticated = _checkInitialAuthenticationStatus();
    if (isAuthenticated) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
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
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> signOut() async {
    await _restClient.signOut();
    await _removeToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  bool _checkInitialAuthenticationStatus() {
    final String token =
        _preferences.getString(StorageKeys.authToken.key) ?? '';
    return token.isNotEmpty;
  }

  Future<bool> _saveToken(String token) async =>
      _preferences.setString(StorageKeys.authToken.key, token);

  Future<bool> _removeToken() => _preferences.remove(StorageKeys.authToken.key);
}
