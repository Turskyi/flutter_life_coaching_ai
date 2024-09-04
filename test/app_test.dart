import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/application_services/authentication/authentication.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:lifecoach/ui/app/app_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockAuthenticationRepository authenticationRepository;
  late MockUserRepository userRepository;

  setUp(() {
    // Ensure dependencies are injected before each test
    injectDependencies();
    authenticationRepository = MockAuthenticationRepository();
    userRepository = MockUserRepository();

    // Set up the mock to return a valid stream
    when(() => authenticationRepository.status).thenAnswer(
      (_) => Stream<AuthenticationStatus>.value(
        AuthenticationStatus.unauthenticated(),
      ),
    );
  });

  testWidgets('App initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      RepositoryProvider<AuthenticationRepository>.value(
        value: authenticationRepository,
        child: BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
          )..add(const AuthenticationSubscriptionRequested()),
          child: const AppView(),
        ),
      ),
    );

    // Wait for all asynchronous operations to complete
    await tester.pumpAndSettle();

    // Verify that the app is rendered correctly
    expect(find.byType(AppView), findsOneWidget);
  });
}
