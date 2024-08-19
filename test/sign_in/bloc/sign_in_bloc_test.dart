import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_in/sign_in.dart';
import 'package:lifecoach/models/password.dart';
import 'package:lifecoach/models/username.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('LoginBloc', () {
    test('initial state is LoginState', () {
      final SignInBloc loginBloc = SignInBloc(
        authenticationRepository: authenticationRepository,
      );
      expect(loginBloc.state, const SignInState());
    });

    group('LoginSubmitted', () {
      blocTest<SignInBloc, SignInState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when login succeeds',
        setUp: () {
          when(
            () => authenticationRepository.signIn(
              username: 'username',
              password: 'password',
            ),
          ).thenAnswer((_) => Future<String>.value('user'));
        },
        build: () => SignInBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (SignInBloc bloc) {
          bloc
            ..add(const LoginUsernameChanged('username'))
            ..add(const LoginPasswordChanged('password'))
            ..add(const LoginSubmitted());
        },
        expect: () => const <SignInState>[
          SignInState(username: Username.dirty('username')),
          SignInState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            isValid: true,
          ),
          SignInState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          SignInState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.success,
          ),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        'emits [LoginInProgress, LoginFailure] when logIn fails',
        setUp: () {
          when(
            () => authenticationRepository.signIn(
              username: 'username',
              password: 'password',
            ),
          ).thenThrow(Exception('oops'));
        },
        build: () => SignInBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (dynamic bloc) {
          bloc
            ..add(const LoginUsernameChanged('username'))
            ..add(const LoginPasswordChanged('password'))
            ..add(const LoginSubmitted());
        },
        expect: () => const <SignInState>[
          SignInState(
            username: Username.dirty('username'),
          ),
          SignInState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            isValid: true,
          ),
          SignInState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          SignInState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.failure,
          ),
        ],
      );
    });
  });
}
