import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/application_services/blocs/sign_up/sign_up.dart';
import 'package:lifecoach/ui/sign_up/code_form.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  group('CodeForm', () {
    late SignUpBloc signUpBloc;
    late LocalizationDelegate localizationDelegate;

    setUpAll(() async {
      localizationDelegate = await LocalizationDelegate.create(
        fallbackLocale: 'en',
        supportedLocales: <String>['en', 'uk'],
      );
    });

    setUp(() {
      signUpBloc = MockSignUpBloc();
      when(() => signUpBloc.state).thenReturn(const SignUpState());
    });

    testWidgets('shows spam folder hint', (WidgetTester tester) async {
      await tester.pumpWidget(
        LocalizedApp(
          localizationDelegate,
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<SignUpBloc>.value(
                value: signUpBloc,
                child: const CodeForm(email: 'user@example.com'),
              ),
            ),
          ),
        ),
      );

      expect(
        find.text(
          'If you do not see the email, please check your spam folder.',
        ),
        findsOneWidget,
      );
    });
  });
}
