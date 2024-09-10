import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/sign_in/bloc/sign_in_bloc.dart';
import 'package:models/models.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

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
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: displayError != null ? 'invalid password' : null,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
    );
  }

  void _toggleVisibility() => setState(() => _obscureText = !_obscureText);
}
