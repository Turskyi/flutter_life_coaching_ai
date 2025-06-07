import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_in/sign_in.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:mocktail/mocktail.dart';
import 'package:models/models.dart';

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
              email: 'test@${constants.domain}',
              password: 'password',
            ),
          ).thenAnswer((_) => Future<String>.value('user'));
        },
        build: () => SignInBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (SignInBloc bloc) {
          bloc
            ..add(const SignInEmailChanged('test@${constants.domain}'))
            ..add(
              const SignInPasswordChanged('password'),
            )
            ..add(
              const SignInSubmitted(),
            );
        },
        expect: () => const <SignInState>[
          SignInState(email: EmailAddress.dirty('test@${constants.domain}')),
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
            password: Password.dirty('password'),
            isValid: true,
          ),
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
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
              email: 'test@${constants.domain}',
              password: 'password',
            ),
          ).thenThrow(Exception('oops'));
        },
        build: () => SignInBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (dynamic bloc) {
          bloc
            ..add(const SignInEmailChanged('test@${constants.domain}'))
            ..add(
              const SignInPasswordChanged('password'),
            )
            ..add(
              const SignInSubmitted(),
            );
        },
        expect: () => const <SignInState>[
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
          ),
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
            password: Password.dirty('password'),
            isValid: true,
          ),
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          SignInState(
            email: EmailAddress.dirty('test@${constants.domain}'),
            password: Password.dirty('password'),
            isValid: true,
            status: FormzSubmissionStatus.failure,
          ),
        ],
      );
    });
  });
}
