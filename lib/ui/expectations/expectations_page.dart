import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/domain_services/settings_repository.dart';
import 'package:lifecoach/ui/about/widgets/body_paragraph.dart';
import 'package:lifecoach/ui/about/widgets/bullet_point.dart';

class ExpectationsPage extends StatelessWidget {
  const ExpectationsPage({
    required this.settingsRepository,
    required this.nextRoute,
    super.key,
  });

  final SettingsRepository settingsRepository;
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(translate('expectations.title'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BodyParagraph(translate('expectations.introduction')),
            const SizedBox(height: 16),
            BulletPoint(translate('expectations.bullet1')),
            BulletPoint(translate('expectations.bullet2')),
            BulletPoint(translate('expectations.bullet3')),
            BulletPoint(translate('expectations.bullet4')),
            BulletPoint(translate('expectations.bullet5')),
            const SizedBox(height: 24),
            Text(
              translate('expectations.note'),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  await settingsRepository.setExpectationsShown(shown: true);
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, nextRoute);
                  }
                },
                child: Text(translate('expectations.button')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
