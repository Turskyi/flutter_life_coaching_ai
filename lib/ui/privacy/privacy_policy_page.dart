import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color linkColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: Text(translate('privacy.title'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              translate(
                'privacy.title_for_app',
                args: <String, Object?>{'appName': constants.appName},
              ),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              translate(
                'privacy.last_updated',
                args: <String, Object?>{'date': _updateDate},
              ),
            ),
            const SizedBox(height: 20),
            Text(
              translate('privacy.introduction_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              translate(
                'privacy.introduction_body',
                args: <String, Object?>{'appName': constants.appName},
              ),
            ),
            const SizedBox(height: 20),
            Text(
              translate('privacy.info_collect_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(translate('privacy.info_collect_body')),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: translate('privacy.email_collect_prefix'),
                children: <InlineSpan>[
                  TextSpan(
                    text: constants.authServiceName,
                    style: TextStyle(color: linkColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(
                        context: context,
                        url: constants.authServiceLink,
                      ),
                  ),
                  TextSpan(text: translate('privacy.email_collect_suffix')),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: translate('privacy.user_id_collect_prefix'),
                children: <InlineSpan>[
                  TextSpan(
                    text: constants.authServiceName,
                    style: TextStyle(color: linkColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(
                        context: context,
                        url: constants.authServiceLink,
                      ),
                  ),
                  TextSpan(text: translate('privacy.user_id_collect_suffix')),
                ],
              ),
            ),
            Text(translate('privacy.goals_collect')),
            const SizedBox(height: 20),
            Text(
              translate('privacy.privacy_ai_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(translate('privacy.privacy_ai_body')),
            const SizedBox(height: 20),
            Text(
              translate('privacy.storage_security_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: translate('privacy.storage_security_body1_prefix'),
                children: <InlineSpan>[
                  TextSpan(
                    text: constants.remoteDbServiceName,
                    style: TextStyle(color: linkColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(
                        context: context,
                        url: constants.remoteDbServiceLink,
                      ),
                  ),
                  TextSpan(
                    text: translate('privacy.storage_security_body1_suffix'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: translate('privacy.storage_security_body2_prefix'),
                children: <InlineSpan>[
                  TextSpan(
                    text: translate('privacy.storage_security_body2_link'),
                    style: TextStyle(color: linkColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(
                        context: context,
                        url: constants.deletionInstructionsLink,
                      ),
                  ),
                  TextSpan(
                    text: translate('privacy.storage_security_body2_suffix'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              translate('privacy.sharing_info_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(translate('privacy.sharing_info_body')),
            const SizedBox(height: 10),
            Text(translate('privacy.sharing_info_bullet1')),
            Text(translate('privacy.sharing_info_bullet2')),
            const SizedBox(height: 20),
            Text(
              translate('privacy.rights_choices_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(translate('privacy.rights_choices_body')),
            const SizedBox(height: 10),
            Text(translate('privacy.rights_choices_bullet1')),
            Text(translate('privacy.rights_choices_bullet2')),
            Text(translate('privacy.rights_choices_bullet3')),
            const SizedBox(height: 20),
            Text(
              translate('privacy.changes_policy_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(translate('privacy.changes_policy_body')),
            const SizedBox(height: 20),
            Text(
              translate('privacy.contact_us_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(translate('privacy.contact_us_body')),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: translate('privacy.email_label'),
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: <InlineSpan>[
                  TextSpan(
                    text: constants.privacyEmail,
                    style: TextStyle(
                      color: linkColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: constants.privacyEmail,
                        );
                        launchUrl(emailLaunchUri);
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              translate(
                'privacy.thank_you',
                args: <String, Object?>{'appName': constants.appName},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL({
    required BuildContext context,
    required String url,
  }) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (context.mounted) {
        _showErrorSnackbar(context: context, url: uri);
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
      if (context.mounted) {
        _showErrorSnackbar(context: context, url: uri);
      }
    }
  }

  void _showErrorSnackbar({required BuildContext context, required Uri url}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            text: translate(
              'privacy.error_launch',
              args: <String, Object?>{'url': url.path},
            ),
            style: const TextStyle(color: Colors.white),
            children: <InlineSpan>[
              TextSpan(text: translate('privacy.error_copy_instruction')),
              TextSpan(
                text: url.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
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
          label: translate('privacy.copy_label'),
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: url.toString())),
        ),
        duration: const Duration(seconds: 10),
      ),
    );
  }
}

const String _updateDate = 'February 2026';
