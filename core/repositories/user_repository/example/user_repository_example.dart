import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

Future<void> main() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(StorageKeys.userId.key, 'example-user-id');

  final UserRepository userRepository = UserRepository(preferences);
  final User user = userRepository.getUser();

  print('Current user id: ${user.id}');
}
