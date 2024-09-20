import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecoach/ui/privacy/privacy_policy_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpModal extends StatefulWidget {
  const SignUpModal({super.key});

  @override
  State<SignUpModal> createState() => _SignUpModalState();
}

class _SignUpModalState extends State<SignUpModal> {
  bool _isConsentGiven = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign Up via Web'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'To create an account, you will be redirected to our '
              'mobile-friendly sign-up page in your web browser. '
              'After completing the sign-up, '
              'you can return to the app to log in and continue.',
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isConsentGiven,
                  onChanged: (bool? value) {
                    setState(() {
                      _isConsentGiven = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'I consent to the collection of my data. ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Learn more.',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Using theme color for link
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Privacy Policy
                              _launchPrivacyPolicy(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isConsentGiven
              ? () {
                  Navigator.of(context).pop();
                  _redirectToWebSignUp(context);
                }
              : null,
          child: const Text('Proceed to Web Sign-Up'),
        ),
      ],
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

  void _launchPrivacyPolicy(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const PrivacyPolicyPage(),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, Uri url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            text: 'Unable to open the sign-up page. ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ), // Using theme color
            children: <InlineSpan>[
              TextSpan(
                text:
                    'You can copy this link and paste it into your browser:\n',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ), // Using theme color
              ),
              TextSpan(
                text: url.toString(),
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Using theme color for link
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
        duration: const Duration(seconds: 10),
      ),
    );
  }
}
