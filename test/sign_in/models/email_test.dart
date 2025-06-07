import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';

void main() {
  const String emailString = 'test@${constants.domain}';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const EmailAddress email = EmailAddress.pure();
        expect(email.value, '');
        expect(email.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        const EmailAddress email = EmailAddress.dirty(emailString);
        expect(email.value, emailString);
        expect(email.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns empty error when email is empty', () {
        expect(
          const EmailAddress.dirty().error,
          const EmptyEmailValidationError(),
        );
      });

      test('is valid when email is not empty', () {
        expect(
          const EmailAddress.dirty(emailString).error,
          isNull,
        );
      });
    });
  });
}
