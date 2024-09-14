import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:lifecoach/di/user_repository_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

class TestUserRepositoryModule extends UserRepositoryModule {}

void main() {
  group('UserRepositoryModule', () {
    late TestUserRepositoryModule userRepositoryModule;
    late UserRepository userRepository;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await injectDependencies();
      userRepositoryModule = TestUserRepositoryModule();
      userRepository = userRepositoryModule
          .getUserRepository(GetIt.instance<SharedPreferences>());
    });

    test('should return a UserRepository instance', () {
      expect(userRepository, isA<UserRepository>());
    });
  });
}
