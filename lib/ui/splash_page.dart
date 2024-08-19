import 'package:flutter/material.dart';

/// The splash feature will just contain a simple view which will be rendered
/// right when the app is launched while the app determines whether the user
/// is authenticated.
/// SplashPage exposes a static Route which makes it very easy to navigate to
/// via Navigator.of(context).push(SplashPage.route());
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const SplashPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
