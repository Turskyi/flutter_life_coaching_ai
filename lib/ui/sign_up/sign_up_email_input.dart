import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';

class SignUpEmailInput extends StatefulWidget {
  const SignUpEmailInput({
    required this.initialValue,
    super.key,
  });
  final String initialValue;

  @override
  State<SignUpEmailInput> createState() => _SignUpEmailInputState();
}

class _SignUpEmailInputState extends State<SignUpEmailInput> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue;
    context.read<SignUpBloc>().add(SignUpEmailChanged(widget.initialValue));
  }

  @override
  Widget build(BuildContext context) {
    final EmailValidationError? displayError = context.select(
      (SignUpBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      controller: _textEditingController,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(constants.emailMaxLength),
      ],
      onChanged: (String email) =>
          context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
      decoration: InputDecoration(
        labelText: 'Email address',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
