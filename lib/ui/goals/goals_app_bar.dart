import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/router/app_route.dart';

class GoalsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GoalsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // This registers a dependency on the localization provider,
    // triggering a rebuild when changeLocale is called.
    LocalizationProvider.of(context).state;

    return AppBar(
      title: Text(translate('goals.title')),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          tooltip: translate('chat.title'),
          onPressed: () => Navigator.pushNamed(context, AppRoute.chat.path),
        ),
      ],
    );
  }
}
