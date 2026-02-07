import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              onPressed: () => _showLanguageSelector(context),
              icon: const Icon(Icons.language),
              label: Text(
                _getLanguageName(
                  LocalizedApp.of(context).delegate.currentLocale,
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 56),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  '${constants.imagePath}logo-no-bg.png',
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
                    key: ValueKey<String>(
                      LocalizedApp.of(
                        context,
                      ).delegate.currentLocale.languageCode,
                    ),
                    animatedTexts: <AnimatedText>[
                      TypewriterAnimatedText(
                        constants.appName,
                        textStyle: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.displayMedium?.fontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: constants.fontFamily,
                          // This color will be masked by the gradient.
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
                Text(
                  translate('home.description'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 208,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoute.signIn.path),
                    child: Text(translate('home.view_goals')),
                  ),
                ),
                const SizedBox(height: 10),
                Text(translate('home.or')),
                const SizedBox(height: 10),
                AnonymousAiChatButton(
                  key: ValueKey<String>(
                    LocalizedApp.of(
                      context,
                    ).delegate.currentLocale.languageCode,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return translate('languages.en');
      case 'uk':
        return translate('languages.uk');
      default:
        return locale.languageCode;
    }
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: Text(translate('languages.en')),
                onTap: () {
                  changeLocale(context, 'en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇦', style: TextStyle(fontSize: 24)),
                title: Text(translate('languages.uk')),
                onTap: () {
                  changeLocale(context, 'uk');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
