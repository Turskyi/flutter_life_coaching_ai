import 'package:flutter/material.dart';
import 'package:lifecoach/ui/sign_up/sign_up_modal.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Don’t have an account?'),
        const SizedBox(height: 8),
        ElevatedButton(
          key: const Key('signInForm_sigh_up_raisedButton'),
          onPressed: () => _showSignUpModal(context),
          child: const Text('Sign up'),
        ),
      ],
    );
  }

  Future<void> _showSignUpModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const SignUpModal(),
    );
  }
}
