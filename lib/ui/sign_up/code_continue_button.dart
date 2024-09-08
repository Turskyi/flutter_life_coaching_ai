import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_up/bloc/sign_up_bloc.dart';

/// The [CodeContinueButton] widget is only enabled if the status of the form is
/// valid and a [CircularProgressIndicator] is shown in its place while the
/// form is being submitted.
class CodeContinueButton extends StatelessWidget {
  const CodeContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isValid =
        context.select((SignUpBloc bloc) => bloc.state.isValid);

    final bool isInProgress = isValid &&
        context.select(
          (SignUpBloc bloc) => bloc.state.status.isInProgress,
        );

    if (isInProgress) return const CircularProgressIndicator();

    return ElevatedButton(
      key: const Key('codeForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<SignUpBloc>().add(const CodeSubmitted())
          : null,
      child: const Text('Continue'),
    );
  }
}
