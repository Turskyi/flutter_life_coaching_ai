import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownMessage extends StatelessWidget {
  const MarkdownMessage({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: message,
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(fontSize: 16.0),
        h1: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        h2: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
