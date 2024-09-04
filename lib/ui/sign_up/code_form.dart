import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
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
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state.status.isFailure || state is SignUpErrorState) {
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
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Verify your email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter the verification code sent to your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () =>
                      Navigator.of(context).pushAndRemoveUntil<void>(
                    SignUpPage.route(email: email),
                    (Route<dynamic> route) => false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const CodeInput(),
            const Padding(padding: EdgeInsets.all(12)),
            const Text('Didn\'t receive a code?'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  context.read<SignUpBloc>().add(const ResendCode()),
              child: const Text('Resend'),
            ),
            const Padding(padding: EdgeInsets.all(24)),
            const CodeContinueButton(),
          ],
        ),
      ),
    );
  }
}
