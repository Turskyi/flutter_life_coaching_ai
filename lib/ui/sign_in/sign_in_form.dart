import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/sign_in/bloc/sign_in_bloc.dart';
import 'package:lifecoach/models/enums/password_validation_error.dart';
import 'package:lifecoach/models/enums/username_validation_error.dart';

/// The [SignInForm] handles notifying the [SignInBloc] of user events and
/// also responds to state changes using [BlocBuilder] and [BlocListener].
/// [BlocListener] is used to show a [SnackBar] if the login submission fails.
/// In addition, [BlocBuilder] widgets are used to wrap each of the [TextField]
/// widgets and make use of the `buildWhen` property in order to optimize for
/// rebuilds. The `onChanged` callback is used to notify the [SignInBloc] of
/// changes to the username/password.
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
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsernameValidationError? displayError = context.select(
      (SignInBloc bloc) => bloc.state.username.displayError,
    );

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (String username) {
        context.read<SignInBloc>().add(LoginUsernameChanged(username));
      },
      decoration: InputDecoration(
        labelText: 'username',
        errorText: displayError != null ? 'invalid username' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PasswordValidationError? displayError = context.select(
      (SignInBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (String password) {
        context.read<SignInBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

/// The [_LoginButton] widget is only enabled if the status of the form is
/// valid and a [CircularProgressIndicator] is shown in its place while the
/// form is being submitted.
class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isInProgressOrSuccess = context.select(
      (SignInBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final bool isValid =
        context.select((SignInBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<SignInBloc>().add(const LoginSubmitted())
          : null,
      child: const Text('Login'),
    );
  }
}
