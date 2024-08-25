import 'package:flutter/material.dart';
import 'package:lifecoach/ui/sign_up/sign_up_paage.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: const Text('Don’t have an account? Sign up'),
    );
  }
}
