import 'package:flutter/material.dart';
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/chat/anonymous_ai_chat_page.dart';
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/sign_in/sign_in_page.dart';
import 'package:lifecoach/ui/sign_up/code_page.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';

Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
  AppRoute.home.path: (_) => const HomePage(),
  AppRoute.anonymousChat.path: (_) => const AnonymousAiChatPage(),
  AppRoute.goals.path: (_) => const GoalsPage(),
  AppRoute.signIn.path: (_) => const SignInPage(),
  AppRoute.signUp.path: (_) => const SignUpPage(),
  AppRoute.code.path: (_) => const CodePage(),
};
