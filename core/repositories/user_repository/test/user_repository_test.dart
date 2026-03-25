import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('UserRepository', () {
    late SharedPreferences preferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      preferences = await SharedPreferences.getInstance();
    });

    test('returns user id from storage when present', () async {
      await preferences.setString(StorageKeys.userId.key, 'user-123');

      final UserRepository userRepository = UserRepository(preferences);
      final User user = userRepository.getUser();

      expect(user.id, 'user-123');
    });

    test('returns empty user id when storage has no value', () {
      final UserRepository userRepository = UserRepository(preferences);
      final User user = userRepository.getUser();

      expect(user.id, isEmpty);
    });
  });
}
