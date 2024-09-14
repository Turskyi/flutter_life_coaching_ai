import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [UserRepository] will be responsible for the user domain and will
/// expose APIs to interact with the current user.
class UserRepository {
  const UserRepository(this._preferences);

  final SharedPreferences _preferences;

  User getUser() {
    final String userId = _preferences.getString(StorageKeys.userId.key) ?? '';
    return User(userId);
  }
}
