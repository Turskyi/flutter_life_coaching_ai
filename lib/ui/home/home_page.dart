import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/common/anonymous_ai_chat_button.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const HomePage());

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
                ShaderMask(
                  shaderCallback: (Rect bounds) => const LinearGradient(
                    colors: <Color>[
                      Colors.white,
                      Colors.white,
                      Colors.blueGrey,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ).createShader(bounds),
                  child: AnimatedTextKit(
                    animatedTexts: <AnimatedText>[
                      TypewriterAnimatedText(
                        constants.appName,
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          // This color will be masked by the gradient
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Discover your true potential with AI-powered life-coaching '
                  'app.\nSet and achieve your goals with personalized guidance '
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
                      AppRoute.signIn.path,
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
