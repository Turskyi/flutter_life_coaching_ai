import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({required this.email, required this.password, super.key});

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(translate('sign_up.prompt')),
        const SizedBox(height: 8),
        ElevatedButton(
          key: const Key('signInForm_sigh_up_raisedButton'),
          onPressed: () => Navigator.of(
            context,
          ).push<void>(SignUpPage.route(email: email, password: password)),
          child: Text(translate('sign_up.button')),
        ),
      ],
    );
  }
}
