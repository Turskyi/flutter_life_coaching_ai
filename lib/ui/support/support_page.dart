import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/ui/about/widgets/body_paragraph.dart';
import 'package:lifecoach/ui/about/widgets/bullet_point.dart';
import 'package:lifecoach/ui/about/widgets/section_title.dart';
import 'package:lifecoach/ui/about/widgets/support_link_row.dart';
import 'package:lifecoach/ui/common/home_app_bar_button.dart';
import 'package:models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({required this.initialLanguage, super.key});

  final Language initialLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kIsWeb ? HomeAppBarButton(language: initialLanguage) : null,
        title: Text(translate('support.title')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(
              translate(
                'support.header',
                args: <String, Object?>{'appName': constants.appName},
              ),
            ),
            BodyParagraph(translate('support.intro')),
            SectionTitle(translate('support.contactUs')),
            BodyParagraph(translate('support.assistance')),
            SupportLinkRow(
              label: translate('about.email'),
              linkLabel: constants.supportEmail,
              url: '${constants.mailToScheme}:${constants.supportEmail}',
            ),
            SupportLinkRow(
              label: translate('about.telegram'),
              linkLabel: translate('support.telegramGroup'),
              url: constants.telegramUrl,
            ),
            SupportLinkRow(
              label: translate('about.website'),
              linkLabel: '${constants.domain}/support',
              url: '${constants.website}/#/support',
            ),
            SectionTitle(translate('support.accountManagement')),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                BodyParagraph(translate('support.accountDeletionIntro')),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => _launchUrl(constants.deletionInstructionsLink),
                  child: Text(
                    translate('support.accountDeletionLink'),
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                BodyParagraph(translate('support.accountDeletionOutro')),
              ],
            ),
            SectionTitle(translate('support.privacyPolicy')),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                BodyParagraph(translate('support.privacyPolicyIntro')),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/privacy-policy');
                  },
                  child: Text(
                    translate('menu.privacyPolicy'),
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SectionTitle(translate('support.commonQuestions')),
            BulletPoint(translate('support.q1')),
            BulletPoint(translate('support.q2')),
            BulletPoint(translate('support.q3')),
            BulletPoint(translate('support.q4')),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}
