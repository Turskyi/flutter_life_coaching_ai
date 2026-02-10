import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
  bool _obscureText = true;

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
              SnackBar(content: Text(translate('reset_password.error'))),
            );
        }
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  translate(
                    'reset_password.instruction',
                    args: <String, String>{'email': widget.email},
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: translate(
                      'reset_password.verification_code_label',
                    ),
                    helperText: translate(
                      'reset_password.verification_code_helper',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: translate('reset_password.new_password_label'),
                    helperText: translate('reset_password.new_password_helper'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _toggleVisibility,
                    ),
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
                            child: Text(
                              translate('reset_password.submit_button'),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleVisibility() => setState(() => _obscureText = !_obscureText);
}
