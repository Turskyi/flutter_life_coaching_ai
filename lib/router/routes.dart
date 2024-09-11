import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/chat/anonymous_ai_chat_page.dart';
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/sign_in/sign_in_page.dart';
import 'package:lifecoach/ui/sign_up/code_page.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';
import 'package:models/models.dart';

Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
  AppRoute.home.path: (_) => const HomePage(),
  AppRoute.anonymousChat.path: (_) => BlocProvider<ChatBloc>(
        create: (_) => GetIt.I.get<ChatBloc>()..add(const LoadHomeEvent()),
        child: BlocListener<ChatBloc, ChatState>(
          listener: (BuildContext context, ChatState state) {
            if (state is ChatInitial) {
              final Language currentLanguage = Language.fromIsoLanguageCode(
                LocalizedApp.of(context).delegate.currentLocale.languageCode,
              );
              final Language savedLanguage = state.language;
              if (currentLanguage != savedLanguage) {
                changeLocale(context, savedLanguage.isoLanguageCode)
                    // The returned value in `then` is always `null`.
                    .then((_) {
                  if (context.mounted) {
                    context
                        .read<ChatBloc>()
                        .add(ChangeLanguageEvent(savedLanguage));
                  }
                });
              }
            }
          },
          child: const AnonymousAiChatPage(),
        ),
      ),
  AppRoute.goals.path: (_) => BlocProvider<GoalsBloc>(
        create: (_) => GetIt.I.get<GoalsBloc>()..add(const LoadGoals()),
        child: const GoalsPage(),
      ),
  AppRoute.signIn.path: (_) => const SignInPage(),
  AppRoute.signUp.path: (_) => const SignUpPage(),
  AppRoute.code.path: (_) => const CodePage(),
};
