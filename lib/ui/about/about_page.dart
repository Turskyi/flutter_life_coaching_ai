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

class AboutPage extends StatefulWidget {
  const AboutPage({required this.initialLanguage, super.key});

  final Language initialLanguage;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    final Language currentLanguage = Language.fromIsoLanguageCode(
      LocalizedApp.of(context).delegate.currentLocale.languageCode,
    );
    final Language savedLanguage = widget.initialLanguage;
    if (currentLanguage != savedLanguage) {
      changeLocale(context, savedLanguage.isoLanguageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kIsWeb
            ? HomeAppBarButton(language: widget.initialLanguage)
            : null,
        title: Text(translate('about.title')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BodyParagraph(translate('about.paragraph1')),
            SectionTitle(translate('about.whyMattersTitle')),
            BodyParagraph(translate('about.whyMattersParagraph')),
            SectionTitle(translate('about.whyAiCanHelpTitle')),
            BodyParagraph(translate('about.whyAiCanHelpParagraph')),
            SectionTitle(translate('about.whyAppExistsTitle')),
            BodyParagraph(translate('about.whyAppExistsParagraph')),
            SectionTitle(translate('about.howItWorksTitle')),
            BulletPoint(translate('about.howItWorksBullet1')),
            BulletPoint(translate('about.howItWorksBullet2')),
            BulletPoint(translate('about.howItWorksBullet3')),
            BulletPoint(translate('about.howItWorksBullet4')),
            BulletPoint(translate('about.howItWorksBullet5')),
            SectionTitle(translate('about.privacyFirstTitle')),
            BodyParagraph(translate('about.privacyFirstParagraph')),
            SectionTitle(translate('about.supportTitle')),
            SupportLinkRow(
              label: translate('about.website'),
              linkLabel: constants.domain,
              url: constants.website,
            ),
            SupportLinkRow(
              label: translate('about.email'),
              linkLabel: constants.supportEmail,
              url: '${constants.mailToScheme}:${constants.supportEmail}',
            ),
            SupportLinkRow(
              label: translate('about.telegram'),
              linkLabel: translate('about.supportGroup'),
              url: constants.telegramUrl,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
