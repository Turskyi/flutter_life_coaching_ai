import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
import 'package:models/models.dart';

class SignUpPasswordInput extends StatefulWidget {
  const SignUpPasswordInput({
    required this.initialValue,
    super.key,
  });

  final String initialValue;

  @override
  State<SignUpPasswordInput> createState() => _SignUpPasswordInputState();
}

class _SignUpPasswordInputState extends State<SignUpPasswordInput> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue;
    context.read<SignUpBloc>().add(SignUpPasswordChanged(widget.initialValue));
  }

  @override
  Widget build(BuildContext context) {
    final PasswordValidationError? displayError = context.select(
      (SignUpBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('signUpForm_passwordInput_textField'),
      controller: _textEditingController,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (String password) =>
          context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _toggleVisibility() => setState(() => _obscureText = !_obscureText);
}
