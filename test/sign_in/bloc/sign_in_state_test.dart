import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_in/sign_in.dart';
import 'package:lifecoach/models/password.dart';
import 'package:lifecoach/models/username.dart';

void main() {
  const Username username = Username.dirty('username');
  const Password password = Password.dirty('password');
  group('LoginState', () {
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

    test('returns object with updated username when username is passed', () {
      expect(
        const SignInState().copyWith(username: username),
        const SignInState(username: username),
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
