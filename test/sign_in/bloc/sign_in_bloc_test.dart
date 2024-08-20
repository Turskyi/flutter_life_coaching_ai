import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_in/sign_in.dart';
import 'package:lifecoach/models/email.dart';
import 'package:lifecoach/models/password.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('SignInBloc', () {
    test('initial state is SignInState', () {
      final SignInBloc loginBloc = SignInBloc(
        authenticationRepository: authenticationRepository,
      );
      expect(loginBloc.state, const SignInState());
    });

    group('SignInSubmitted', () {
      blocTest<SignInBloc, SignInState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when sign in succeeds',
        setUp: () {
          when(
            () => authenticationRepository.signIn(
              email: 'test@turskyi.com',
              password: 'password',
            ),
          ).thenAnswer((_) => Future<String>.value('user'));
        },
        build: () => SignInBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (SignInBloc bloc) {
          bloc..add(const SignInEmailChanged('test@turskyi.com'))..add(
              const SignInPasswordChanged('password'))..add(
              const SignInSubmitted());
        },
        expect: () => const <SignInState>[
          SignInState(email: Email.dirty('test@turskyi.com')),
          SignInState(
            email: Email.dirty('test@turskyi.com'),
            password: Password.dirty('password'),
            isValid: true,
          ),
          SignInState(
            email: Email.dirty('test@turskyi.com'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          SignInState(
            email: Email.dirty('test@turskyi.com'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.success,
          ),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        'emits [SignInInProgress, SignInFailure] when signIn fails',
        setUp: () {
          when(
            () => authenticationRepository.signIn(
              email: 'test@turskyi.com',
              password: 'password',
            ),
          ).thenThrow(Exception('oops'));
        },
        build: () => SignInBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (dynamic bloc) {
          bloc..add(const SignInEmailChanged('test@turskyi.com'))..add(
              const SignInPasswordChanged('password'))..add(
              const SignInSubmitted());
        },
        expect: () => const <SignInState>[
          SignInState(
            email: Email.dirty('test@turskyi.com'),
          ),
          SignInState(
            email: Email.dirty('test@turskyi.com'),
            password: Password.dirty('password'),
            isValid: true,
          ),
          SignInState(
            email: Email.dirty('test@turskyi.com'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          SignInState(
            email: Email.dirty('test@turskyi.com'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.failure,
          ),
        ],
      );
    });
  });
}
