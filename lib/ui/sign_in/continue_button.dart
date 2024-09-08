import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_in/bloc/sign_in_bloc.dart';

/// The [ContinueButton] widget is only enabled if the status of the form is
/// valid and a [CircularProgressIndicator] is shown in its place while the
/// form is being submitted.
class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isInProgressOrSuccess = context.select(
      (SignInBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final bool isValid =
        context.select((SignInBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('signInForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<SignInBloc>().add(const SignInSubmitted())
          : null,
      child: const Text('Continue'),
    );
  }
}
