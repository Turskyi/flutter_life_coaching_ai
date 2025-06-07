import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/application_services/blocs/sign_in/sign_in.dart';

void main() {
  const String email = 'test@lifecoaching-ai.com';
  const String password = 'mock-password';
  group('SignInEvent', () {
    group('SignInEmailChanged', () {
      test('supports value comparisons', () {
        expect(
          const SignInEmailChanged(email),
          const SignInEmailChanged(email),
        );
      });
    });

    group('SignInPasswordChanged', () {
      test('supports value comparisons', () {
        expect(
          const SignInPasswordChanged(password),
          const SignInPasswordChanged(password),
        );
      });
    });

    group('SignInSubmitted', () {
      test('supports value comparisons', () {
        expect(const SignInSubmitted(), const SignInSubmitted());
      });
    });
  });
}
