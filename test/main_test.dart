import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  test('injectDependencies registers dependencies correctly', () async {
    await injectDependencies();
    expect(GetIt.instance.isRegistered<AuthenticationRepository>(), true);
  });
}
