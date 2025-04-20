import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/application_services/blocs/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';
import 'package:models/models.dart';
import 'package:user_repository/user_repository.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  const User user = User('id');
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;

  setUp(() {
    authenticationRepository = _MockAuthenticationRepository();
    userRepository = _MockUserRepository();

    // Mock the status stream from AuthenticationRepository.
    when(() => authenticationRepository.status)
        .thenAnswer((_) => const Stream<AuthenticationStatus>.empty());

    // Always mock getUser to return a valid user unless you are testing error
    // cases.
    when(() => userRepository.getUser()).thenReturn(user);
  });

  AuthenticationBloc buildBloc() {
    return AuthenticationBloc(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
    );
  }

  group('AuthenticationBloc', () {
    test('initial state is AuthenticationState.unknown', () {
      final AuthenticationBloc authenticationBloc = buildBloc();
      expect(authenticationBloc.state, const AuthenticationState.unknown());
      authenticationBloc.close();
    });

    group('AuthenticationSubscriptionRequested', () {
      final Exception error = Exception('oops');

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unauthenticated] when status is unauthenticated',
        setUp: () {
          when(() => authenticationRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.value(
              AuthenticationStatus.unauthenticated(),
            ),
          );
        },
        build: buildBloc,
        act: (AuthenticationBloc bloc) =>
            bloc.add(const AuthenticationSubscriptionRequested()),
        expect: () =>
            const <AuthenticationState>[AuthenticationState.unauthenticated()],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [authenticated] when status is authenticated',
        setUp: () {
          when(() => authenticationRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.value(
              AuthenticationStatus.authenticated(),
            ),
          );
          when(() => userRepository.getUser())
              .thenReturn(user); // Mock the user
        },
        build: buildBloc,
        act: (AuthenticationBloc bloc) =>
            bloc.add(const AuthenticationSubscriptionRequested()),
        expect: () => <AuthenticationState>[
          const AuthenticationState.authenticated(user),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unauthenticated] when status is authenticated but getUser '
        'returns empty',
        setUp: () {
          when(() => authenticationRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.value(
              AuthenticationStatus.authenticated(),
            ),
          );
          when(() => userRepository.getUser()).thenReturn(User.anonymous);
        },
        build: buildBloc,
        act: (AuthenticationBloc bloc) =>
            bloc.add(const AuthenticationSubscriptionRequested()),
        expect: () =>
            const <AuthenticationState>[AuthenticationState.unauthenticated()],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unknown] when status is unknown',
        setUp: () {
          when(() => authenticationRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.value(
              AuthenticationStatus.unknown(),
            ),
          );
        },
        build: buildBloc,
        act: (AuthenticationBloc bloc) =>
            bloc.add(const AuthenticationSubscriptionRequested()),
        expect: () =>
            const <AuthenticationState>[AuthenticationState.unknown()],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'adds error when status stream emits an error',
        setUp: () {
          when(() => authenticationRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.error(error),
          );
        },
        build: buildBloc,
        act: (AuthenticationBloc bloc) =>
            bloc.add(const AuthenticationSubscriptionRequested()),
        errors: () => <Exception>[error],
      );
    });
  });

  test('AuthenticationLogoutPressed calls signOut on authenticationRepository',
      () async {
    when(() => authenticationRepository.signOut())
        .thenAnswer((_) async => Future<void>.value());

    final AuthenticationBloc bloc = buildBloc();
    bloc.add(const AuthenticationSignOutPressed());
    await untilCalled(() => authenticationRepository.signOut());

    verify(() => authenticationRepository.signOut()).called(1);
  });
}
