import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_in/bloc/sign_in_bloc.dart';
import 'package:models/models.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordValidationError? displayError = context.select(
      (SignInBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('signInForm_passwordInput_textField'),
      keyboardType: TextInputType.visiblePassword,
      onChanged: (String password) =>
          context.read<SignInBloc>().add(SignInPasswordChanged(password)),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}
