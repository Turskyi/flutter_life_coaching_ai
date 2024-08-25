import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';

class SignUpEmailInput extends StatelessWidget {
  const SignUpEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailValidationError? displayError = context.select(
      (SignUpBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      keyboardType: TextInputType.emailAddress,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(constants.emailMaxLength),
      ],
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (String email) =>
          context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
      decoration: InputDecoration(
        labelText: 'Email address',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}
