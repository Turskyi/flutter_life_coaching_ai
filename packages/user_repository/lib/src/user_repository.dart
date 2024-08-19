import 'dart:async';

import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

/// The [UserRepository] will be responsible for the user domain and will
/// expose APIs to interact with the current user.
class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    //TODO: For now the UserRepository exposes a single
    // method getUser which will retrieve the current user. We are stubbing
    // this but in practice this is where we would query the current user from
    // the backend.
    return Future<User?>.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4()),
    );
  }
}
