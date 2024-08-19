import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/application_services/sign_in/sign_in.dart';

void main() {
  const String username = 'mock-username';
  const String password = 'mock-password';
  group('LoginEvent', () {
    group('LoginUsernameChanged', () {
      test('supports value comparisons', () {
        expect(
          const LoginUsernameChanged(username),
          const LoginUsernameChanged(username),
        );
      });
    });

    group('LoginPasswordChanged', () {
      test('supports value comparisons', () {
        expect(
          const LoginPasswordChanged(password),
          const LoginPasswordChanged(password),
        );
      });
    });

    group('LoginSubmitted', () {
      test('supports value comparisons', () {
        expect(const LoginSubmitted(), const LoginSubmitted());
      });
    });
  });
}
