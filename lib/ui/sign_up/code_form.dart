import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/ui/sign_up/code_continue_button.dart';
import 'package:lifecoach/ui/sign_up/code_input.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';

class CodeForm extends StatelessWidget {
  const CodeForm({
    required this.email,
    super.key,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double? titleFontSize = textTheme.titleMedium?.fontSize;
    final double? headlineFontSize = textTheme.headlineSmall?.fontSize;
    return BlocListener<SignUpBloc, SignUpState>(
      listener: _signUpStateListener,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Verify your email',
              style: TextStyle(
                fontSize: headlineFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the verification code sent to your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  email,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    decoration: TextDecoration.underline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil<void>(
                      SignUpPage.route(email: email),
                      (Route<void> route) => false,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const CodeInput(),
            const Padding(padding: EdgeInsets.all(24)),
            const CodeContinueButton(),
            const Padding(padding: EdgeInsets.all(24)),
            const Text('Didn\'t receive a code?'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<SignUpBloc>().add(const ResendCode());
              },
              child: const Text('Resend'),
            ),
          ],
        ),
      ),
    );
  }

  void _signUpStateListener(BuildContext context, SignUpState state) {
    final FormzSubmissionStatus status = state.status;

    if (status.isFailure || state is SignUpErrorState) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state is SignUpErrorState
                  ? state.errorMessage
                  : 'Sign Up Failure',
            ),
          ),
        );
    }
  }
}
