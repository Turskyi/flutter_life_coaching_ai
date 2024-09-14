import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

@module
abstract class UserRepositoryModule {
  @lazySingleton
  UserRepository getUserRepository(SharedPreferences preferences) =>
      UserRepository(preferences);
}
