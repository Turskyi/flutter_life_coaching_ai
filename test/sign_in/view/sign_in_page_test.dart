import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/ui/sign_in/sign_in_form.dart';
import 'package:lifecoach/ui/sign_in/sign_in_page.dart';

import '../../test_mocks/mock_authentication_repository.dart';

void main() {
  group('SignInPage', () {
    late AuthenticationRepository authenticationRepository;
    late LocalizationDelegate localizationDelegate;

    setUpAll(() async {
      localizationDelegate = await LocalizationDelegate.create(
        fallbackLocale: 'en',
        supportedLocales: <String>['en', 'uk'],
      );
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('is routable', () {
      expect(SignInPage.route(), isA<MaterialPageRoute<void>>());
    });

    testWidgets('renders a LoginForm', (WidgetTester tester) async {
      await tester.pumpWidget(
        LocalizedApp(
          localizationDelegate,
          RepositoryProvider<AuthenticationRepository>.value(
            value: authenticationRepository,
            child: const MaterialApp(home: Scaffold(body: SignInPage())),
          ),
        ),
      );
      expect(find.byType(SignInForm), findsOneWidget);
    });
  });
}
