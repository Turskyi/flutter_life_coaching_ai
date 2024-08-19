import 'dart:async';

import 'package:authentication_repository/src/authentication_status.dart';

/// The AuthenticationRepository exposes a Stream of AuthenticationStatus
/// updates which will be used to notify the application when a user signs in
/// or out.
/// Since we are maintaining a StreamController internally, a dispose method
/// is exposed so that the controller can be closed when it is no longer needed.
class AuthenticationRepository {
  final StreamController<AuthenticationStatus> _controller =
      StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    //TODO: implement real logic.
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    //TODO: implement real logic
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void signOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
