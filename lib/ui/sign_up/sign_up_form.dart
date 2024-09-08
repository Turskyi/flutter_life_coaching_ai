import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/sign_up/sign_up_continue_button.dart';
import 'package:lifecoach/ui/sign_up/sign_up_email_input.dart';
import 'package:lifecoach/ui/sign_up/sign_up_password_input.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Create your account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Welcome! Please fill in the details to get started.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              SignUpEmailInput(initialValue: email),
              const Padding(padding: EdgeInsets.all(12)),
              SignUpPasswordInput(initialValue: password),
              const Padding(padding: EdgeInsets.all(12)),
              const SignUpContinueButton(),
              const Padding(padding: EdgeInsets.all(24)),
              const Text('Already have an account?'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoute.signIn.path,
                ),
                child: const Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
