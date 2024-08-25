import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';

/// The [SignUpContinueButton] widget is only enabled if the status of the form
/// is valid and a [CircularProgressIndicator] is shown in its place while the
/// form is being submitted.
class SignUpContinueButton extends StatelessWidget {
  const SignUpContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isUpProgressOrSuccess = context.select(
      (SignUpBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isUpProgressOrSuccess) return const CircularProgressIndicator();

    final bool isValid =
        context.select((SignUpBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<SignUpBloc>().add(const SignUpSubmitted())
          : null,
      child: const Text('Continue'),
    );
  }
}
