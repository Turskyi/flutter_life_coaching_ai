import 'package:flutter/material.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/router/routes.dart' as routes;

@immutable
class LifeCoachingAiApp extends StatelessWidget {
  const LifeCoachingAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: constants.appName,
      initialRoute: AppRoute.home.path,
      routes: routes.routeMap,
      theme: ThemeData.dark(),
    );
  }
}
