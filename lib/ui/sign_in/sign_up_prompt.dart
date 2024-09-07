import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Up via Web'),
          content: const Text(
            'To create an account, you will be redirected to our '
            'mobile-friendly sign-up page in your web browser. '
            'After completing the sign-up, '
            'you can return to the app to log in and continue.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('Proceed to Web Sign-Up'),
              onPressed: () {
                Navigator.of(context).pop();
                _redirectToWebSignUp(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _redirectToWebSignUp(BuildContext context) async {
    final Uri url = Uri.parse('https://lifecoach.turskyi.com/sign-up');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        _showErrorSnackbar(context, url);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, url);
      }
    }
  }

  void _showErrorSnackbar(BuildContext context, Uri url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            text: 'Unable to open the sign-up page. ',
            style: const TextStyle(color: Colors.white),
            children: <InlineSpan>[
              const TextSpan(
                text:
                    'You can copy this link and paste it into your browser:\n',
              ),
              TextSpan(
                text: url.toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  // Makes the URL look like a clickable link
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      Clipboard.setData(ClipboardData(text: url.toString())),
              ),
            ],
          ),
        ),
        action: SnackBarAction(
          label: 'Copy',
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: url.toString())),
        ),
        // Extended duration for readability.
        duration: const Duration(seconds: 10),
      ),
    );
  }
}
