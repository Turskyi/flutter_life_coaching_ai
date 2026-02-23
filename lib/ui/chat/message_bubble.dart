import 'package:flutter/material.dart';
import 'package:lifecoach/ui/chat/bubble_background.dart';
import 'package:lifecoach/ui/chat/markdown_text.dart';
import 'package:models/models.dart';

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.message, super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Alignment messageAlignment = message.isMine
        ? Alignment.topRight
        : Alignment.topLeft;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: <Color>[
                if (message.isMine) ...<Color>[
                  colorScheme.tertiary.withOpacity(0.8),
                  colorScheme.tertiary,
                ] else ...<Color>[colorScheme.primary, colorScheme.secondary],
              ],
              child: DefaultTextStyle.merge(
                style: TextStyle(fontSize: 18.0, color: colorScheme.onPrimary),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MarkdownText(text: '${message.text}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
