import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_in/bloc/sign_in_bloc.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({

    super.key
  });

  @override
  Widget build(BuildContext context) {
    final EmailValidationError? displayError = context.select(
      (SignInBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      keyboardType: TextInputType.emailAddress,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(constants.emailMaxLength),
      ],
      key: const Key('signInForm_emailInput_textField'),
      onChanged: (String email) =>
          context.read<SignInBloc>().add(SignInEmailChanged(email)),
      decoration: InputDecoration(
        labelText: 'Email address',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}
