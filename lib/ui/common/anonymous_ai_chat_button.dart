import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AnonymousAiChatButton extends StatelessWidget {
  const AnonymousAiChatButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 208,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
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
