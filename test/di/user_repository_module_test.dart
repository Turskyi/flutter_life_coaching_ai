import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/di/user_repository_module.dart';
import 'package:user_repository/user_repository.dart';

import '../retrofit_client_mock.mocks.dart';

class TestUserRepositoryModule extends UserRepositoryModule {}

void main() {
  group('UserRepositoryModule', () {
    late TestUserRepositoryModule userRepositoryModule;
    late MockRetrofitClient mockRetrofitClient;
    late UserRepository userRepository;

    setUp(() {
      userRepositoryModule = TestUserRepositoryModule();
      mockRetrofitClient = MockRetrofitClient();
      userRepository =
          userRepositoryModule.getUserRepository(mockRetrofitClient);
    });

    test('should return a UserRepository instance', () {
      expect(userRepository, isA<UserRepository>());
    });
  });
}
