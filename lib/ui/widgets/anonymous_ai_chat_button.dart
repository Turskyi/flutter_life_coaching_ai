import 'package:flutter/material.dart';
import 'package:lifecoach/router/app_route.dart';

class AnonymousAiChatButton extends StatelessWidget {
  const AnonymousAiChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AppRoute.anonymousChat.path,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.chat, size: 20),
            SizedBox(width: 8),
            Expanded(child: Text('Chat Anonymously with Life-Coach AI')),
          ],
        ),
      ),
    );
  }
}
