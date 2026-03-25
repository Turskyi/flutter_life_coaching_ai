import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/application_services/blocs/authentication/authentication.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/application_services/repositories/chat_repository_impl.dart';
import 'package:lifecoach/application_services/repositories/goals_repository_impl.dart';
import 'package:lifecoach/application_services/repositories/settings_repository_impl.dart';
import 'package:lifecoach/domain_services/chat_repository.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:lifecoach/domain_services/settings_repository.dart';
import 'package:lifecoach/infrastructure/data_sources/local/local_data_source.dart';
import 'package:lifecoach/infrastructure/data_sources/remote/resend/feedback_email_remote_data_source.dart';
import 'package:lifecoach/infrastructure/data_sources/remote/rest/retrofit_client/retrofit_client.dart';
import 'package:lifecoach/infrastructure/services/theme_service.dart';
import 'package:lifecoach/router/router.dart' as router;
import 'package:lifecoach/ui/app/app.dart';
import 'package:mocktail/mocktail.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_mocks/mock_authentication_repository.dart';
import 'test_mocks/mock_user_repository.dart';

void main() {
  late MockAuthenticationRepository authenticationRepository;
  late MockUserRepository userRepository;
  late LocalizationDelegate localizationDelegate;

  setUpAll(() async {
    localizationDelegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: <String>['en', 'uk'],
    );
  });

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    userRepository = MockUserRepository();

    // Set up the mock to return a valid stream
    when(() => authenticationRepository.status).thenAnswer(
      (_) => Stream<AuthenticationStatus>.value(
        AuthenticationStatus.unauthenticated(),
      ),
    );

    when(() => userRepository.getUser()).thenReturn(User.anonymous);
  });

  testWidgets('App initializes correctly', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final LocalDataSource localDataSource = LocalDataSource(preferences);

    final SettingsRepository settingsRepository = SettingsRepositoryImpl(
      preferences,
    );

    final ChatRepository chatRepository = ChatRepositoryImpl(
      RetrofitClient(Dio()),
    );

    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(RetrofitClient(Dio()), preferences);

    final GoalsRepository goalsRepository = GoalsRepositoryImpl(
      RetrofitClient(Dio()),
    );
    const FeedbackEmailRemoteDataSource feedbackEmailRemoteDataSource =
        FeedbackEmailRemoteDataSource();

    final AuthenticationBloc authenticationBloc = AuthenticationBloc(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
    );

    final GoalsBloc goalsBloc = GoalsBloc(
      goalsRepository,
      authenticationBloc,
      feedbackEmailRemoteDataSource,
    );

    final ChatBloc chatBloc = ChatBloc(
      chatRepository,
      settingsRepository,
      userRepository,
    );

    final Map<String, WidgetBuilder> routeMap = router.buildAppRoutes(
      chatBloc: chatBloc,
      goalsBloc: goalsBloc,
    );

    final ThemeService themeService = ThemeService(preferences);

    await tester.pumpWidget(
      LocalizedApp(
        localizationDelegate,
        App(
          authenticationRepository: authenticationRepository,
          authenticationBloc: authenticationBloc,
          localDataSource: localDataSource,
          routeMap: routeMap,
          themeService: themeService,
        ),
      ),
    );

    // Wait for all asynchronous operations to complete
    await tester.pumpAndSettle();

    // Verify that the app is rendered correctly
    expect(find.byType(App), findsOneWidget);
  });
}
