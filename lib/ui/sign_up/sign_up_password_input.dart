import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
import 'package:models/models.dart';

class SignUpPasswordInput extends StatelessWidget {
  const SignUpPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordValidationError? displayError = context.select(
      (SignUpBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('signUpForm_passwordInput_textField'),
      keyboardType: TextInputType.visiblePassword,
      onChanged: (String password) =>
          context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}
