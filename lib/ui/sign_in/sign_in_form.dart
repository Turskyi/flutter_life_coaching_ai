import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_in/bloc/sign_in_bloc.dart';
import 'package:lifecoach/ui/sign_in/continue_button.dart';
import 'package:lifecoach/ui/sign_in/email_input.dart';
import 'package:lifecoach/ui/sign_in/password_input.dart';
import 'package:lifecoach/ui/sign_in/sign_up_prompt.dart';

/// The [SignInForm] handles notifying the [SignInBloc] of user events and
/// also responds to state changes using [BlocBuilder] and [BlocListener].
/// [BlocListener] is used to show a [SnackBar] if the login submission fails.
/// In addition, [BlocBuilder] widgets are used to wrap each of the [TextField]
/// widgets and make use of the `buildWhen` property in order to optimize for
/// rebuilds. The `onChanged` callback is used to notify the [SignInBloc] of
/// changes to the email/password.
class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (BuildContext context, SignInState state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: const Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EmailInput(),
            Padding(padding: EdgeInsets.all(12)),
            PasswordInput(),
            Padding(padding: EdgeInsets.all(12)),
            ContinueButton(),
            Padding(padding: EdgeInsets.all(12)),
            SignUpPrompt(),
          ],
        ),
      ),
    );
  }
}
