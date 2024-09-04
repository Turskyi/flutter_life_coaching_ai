import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await injectDependencies();
  });

  test('injectDependencies registers dependencies correctly', () async {
    expect(GetIt.instance.isRegistered<AuthenticationRepository>(), true);
  });
}
