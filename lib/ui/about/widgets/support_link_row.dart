import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportLinkRow extends StatelessWidget {
  const SupportLinkRow({
    required this.label,
    required this.linkLabel,
    required this.url,
    super.key,
  });

  final String label;
  final String linkLabel;
  final String url;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: <Widget>[
          Text(label, style: theme.textTheme.bodyMedium),
          InkWell(
            onTap: _openUrl,
            child: Text(
              linkLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl() async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
