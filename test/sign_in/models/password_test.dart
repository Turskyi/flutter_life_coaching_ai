import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  const String passwordString = 'mock-password';
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const Password password = Password.pure();
        expect(password.value, '');
        expect(password.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        const Password password = Password.dirty(passwordString);
        expect(password.value, passwordString);
        expect(password.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns empty error when password is empty', () {
        expect(
          const Password.dirty().error,
          const EmptyPasswordValidationError(),
        );
      });

      test('is valid when password is not empty', () {
        expect(
          const Password.dirty(passwordString).error,
          isNull,
        );
      });
    });
  });
}
