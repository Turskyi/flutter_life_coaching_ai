import 'package:flutter/material.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/widgets/anonymous_ai_chat_button.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO:
    // final String? userId = AuthService().getUserId();
    //
    // if (userId != null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacementNamed(context, AppRoute.goals.path);
    //   });
    // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo-no-bg.png',
                  width: 200,
                  height: 200,
                ),
                const Text(
                  constants.appName,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Discover your true potential with AI-powered life-coaching '
                  'app. Set and achieve your goals with personalized guidance '
                  'and insightful questions designed to help you find your own '
                  'answers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoute.goals.path,
                    ),
                    child: const Text('View Goals'),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('or'),
                const SizedBox(height: 10),
                const AnonymousAiChatButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
