import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/ui/sign_up/code_continue_button.dart';
import 'package:lifecoach/ui/sign_up/code_input.dart';

class CodeForm extends StatelessWidget {
  const CodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: const Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enter the 6-digit code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We have sent a 6-digit code to your email. '
              'Please enter it below.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            CodeInput(),
            Padding(padding: EdgeInsets.all(12)),
            CodeContinueButton(),
          ],
        ),
      ),
    );
  }
}
