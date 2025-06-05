import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownText extends StatelessWidget {
  const MarkdownText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: _parseMarkdown(
          context: context,
          text: text
              // Replace escaped newlines with actual newlines.
              .replaceAll(r'\n', '\n')
              // Replace escaped quotes with actual quotes.
              .replaceAll(r'\"', '"'),
        ),
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }

  List<TextSpan> _parseMarkdown({
    required BuildContext context,
    required String text,
  }) {
    final List<TextSpan> spans = <TextSpan>[];
    final RegExp exp = RegExp(r'(\*\*.*?\*\*|\*.*?\*|\[.*?\]\(.*?\)|[^*]+)');
    final Iterable<RegExpMatch> matches = exp.allMatches(text);

    for (final RegExpMatch match in matches) {
      if (match.groupCount == 0) continue;

      final String matchText = match.group(0) ?? '';

      if (matchText.startsWith('**') && matchText.endsWith('**')) {
        spans.add(
          TextSpan(
            text: matchText.substring(2, matchText.length - 2),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else if (matchText.startsWith('*') && matchText.endsWith('*')) {
        spans.add(
          TextSpan(
            text: matchText.substring(1, matchText.length - 1),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      } else if (matchText.startsWith('[') && matchText.contains('](')) {
        final int linkTextEnd = matchText.indexOf('](');
        final String linkText = matchText.substring(1, linkTextEnd);
        final String linkUrl =
            matchText.substring(linkTextEnd + 2, matchText.length - 1);
        spans.add(
          TextSpan(
            text: linkText,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(context: context, url: linkUrl),
          ),
        );
      } else {
        spans.add(TextSpan(text: matchText));
      }
    }
    return spans;
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
        _showErrorSnackBar(context: context, url: uri);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context: context, url: uri);
      }
    }
  }

  void _showErrorSnackBar({required BuildContext context, required Uri url}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            text: 'Could not launch ${url.path}. ',
            style: const TextStyle(color: Colors.white),
            children: <InlineSpan>[
              const TextSpan(
                text:
                    'You can copy this link and paste it into your browser:\n',
              ),
              TextSpan(
                text: url.toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  // Makes the URL look like a clickable link
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
          label: 'Copy',
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: url.toString())),
        ),
        // Extended duration for readability.
        duration: const Duration(seconds: 10),
      ),
    );
  }
}
