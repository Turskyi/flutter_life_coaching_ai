import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_in/bloc/sign_in_bloc.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({required this.email, super.key});

  final String email;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (BuildContext context, SignInState state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Reset Password Failed')),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Enter the code sent to ${widget.email} and your new password.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _codeController,
            decoration: const InputDecoration(
              labelText: 'Verification Code',
              helperText: 'Enter the code from your email',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'New Password',
              helperText: 'Enter your new password',
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (BuildContext context, SignInState state) {
              return state.status.isInProgress
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(
                          ResetPasswordSubmitted(
                            code: _codeController.text,
                            newPassword: _passwordController.text,
                          ),
                        );
                      },
                      child: const Text('Reset Password'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
