import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/models/models.dart';
import 'package:lifecoach/models/validation_error.dart';

void main() {
  const String emailString = 'test@turskyi.com';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const Email email = Email.pure();
        expect(email.value, '');
        expect(email.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        const Email email = Email.dirty(emailString);
        expect(email.value, emailString);
        expect(email.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns empty error when email is empty', () {
        expect(
          const Email.dirty().error,
          const EmptyEmailValidationError(),
        );
      });

      test('is valid when email is not empty', () {
        expect(
          const Email.dirty(emailString).error,
          isNull,
        );
      });
    });
  });
}
