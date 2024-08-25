import 'package:flutter/material.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Don’t have an account?'),
        const SizedBox(height: 8),
        ElevatedButton(
          key: const Key('signInForm_sigh_up_raisedButton'),
          onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
          child: const Text('Sign up'),
        ),
      ],
    );
  }
}
