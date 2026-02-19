import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';

class AiConsentDialog extends StatelessWidget {
  const AiConsentDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const AiConsentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String bodyText = translate(
      'privacy.ai_consent_body',
    ).replaceAll('{aiModel}', constants.aiModel);

    return AlertDialog(
      title: Text(translate('privacy.ai_consent_title')),
      content: SingleChildScrollView(child: Text(bodyText)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            Navigator.of(context).pushNamed(AppRoute.privacyPolity.path);
          },
          child: Text(translate('privacy.ai_consent_view_policy')),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(translate('privacy.ai_consent_continue')),
        ),
      ],
    );
  }
}
