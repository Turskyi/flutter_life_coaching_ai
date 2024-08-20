import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_in/sign_in.dart';
import 'package:lifecoach/ui/sign_in/sign_in_form.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

void main() {
  group('SignInForm', () {
    late SignInBloc loginBloc;

    setUp(() {
      loginBloc = MockLoginBloc();
    });

    testWidgets('adds SignInEmailChanged to SignInBloc when email is updated',
        (WidgetTester tester) async {
      const String email = 'test@turskyi.com';
      when(() => loginBloc.state).thenReturn(const SignInState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('signInForm_emailInput_textField')),
        email,
      );
      verify(
        () => loginBloc.add(const SignInEmailChanged(email)),
      ).called(1);
    });

    testWidgets(
        'adds SignInPasswordChanged to SignInBloc when password is updated',
        (WidgetTester tester) async {
      const String password = 'password';
      when(() => loginBloc.state).thenReturn(const SignInState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('signInForm_passwordInput_textField')),
        password,
      );
      verify(
        () => loginBloc.add(const SignInPasswordChanged(password)),
      ).called(1);
    });

    testWidgets('continue button is disabled by default',
        (WidgetTester tester) async {
      when(() => loginBloc.state).thenReturn(const SignInState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      final ElevatedButton button =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);
    });

    testWidgets(
        'loading indicator is shown when status is submission in progress',
        (WidgetTester tester) async {
      when(() => loginBloc.state).thenReturn(
        const SignInState(status: FormzSubmissionStatus.inProgress),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('loading indicator is shown when status is submission success',
        (WidgetTester tester) async {
      when(() => loginBloc.state).thenReturn(
        const SignInState(status: FormzSubmissionStatus.success),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('continue button is enabled when status is validated',
        (WidgetTester tester) async {
      when(() => loginBloc.state).thenReturn(const SignInState(isValid: true));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      final ElevatedButton button =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, isTrue);
    });

    testWidgets(
        'SignInSubmitted is added to SignInBloc when continue is tapped',
        (WidgetTester tester) async {
      when(() => loginBloc.state).thenReturn(const SignInState(isValid: true));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      verify(() => loginBloc.add(const SignInSubmitted())).called(1);
    });

    testWidgets('shows SnackBar when status is submission failure',
        (WidgetTester tester) async {
      whenListen(
        loginBloc,
        Stream<SignInState>.fromIterable(<SignInState>[
          const SignInState(status: FormzSubmissionStatus.inProgress),
          const SignInState(status: FormzSubmissionStatus.failure),
        ]),
        initialState: const SignInState(status: FormzSubmissionStatus.failure),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<SignInBloc>.value(
              value: loginBloc,
              child: const SignInForm(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
