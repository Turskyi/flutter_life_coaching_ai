import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/router/app_route.dart';

class AnonymousAiChatButton extends StatelessWidget {
  const AnonymousAiChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 208,
      height: 60,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, AppRoute.chat.path),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.chat, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                translate('chat.anonymous_button'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
