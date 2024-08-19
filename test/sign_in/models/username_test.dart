import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/models/enums/username_validation_error.dart';
import 'package:lifecoach/models/models.dart';

void main() {
  const String usernameString = 'mock-username';
  group('Username', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const Username username = Username.pure();
        expect(username.value, '');
        expect(username.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        const Username username = Username.dirty(usernameString);
        expect(username.value, usernameString);
        expect(username.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns empty error when username is empty', () {
        expect(
          const Username.dirty().error,
          UsernameValidationError.empty,
        );
      });

      test('is valid when username is not empty', () {
        expect(
          const Username.dirty(usernameString).error,
          isNull,
        );
      });
    });
  });
}
