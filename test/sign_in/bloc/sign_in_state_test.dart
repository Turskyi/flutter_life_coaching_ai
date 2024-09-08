import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_in/sign_in.dart';
import 'package:models/models.dart';

void main() {
  const EmailAddress email = EmailAddress.dirty('email');
  const Password password = Password.dirty('password');
  group('SignInState', () {
    test('supports value comparisons', () {
      expect(const SignInState(), const SignInState());
    });

    test('returns same object when no properties are passed', () {
      expect(const SignInState().copyWith(), const SignInState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const SignInState().copyWith(status: FormzSubmissionStatus.initial),
        const SignInState(),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        const SignInState().copyWith(email: email),
        const SignInState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const SignInState().copyWith(password: password),
        const SignInState(password: password),
      );
    });
  });
}
