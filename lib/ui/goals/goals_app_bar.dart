import 'package:flutter/material.dart';
import 'package:lifecoach/router/app_route.dart';

class GoalsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GoalsAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Goals'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          tooltip: 'Life-Coach AI',
          onPressed: () => Navigator.pushNamed(context, AppRoute.chat.path),
        ),
      ],
    );
  }
}
