import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/infrastructure/data_sources/local/local_data_source.dart';
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/about/about_page.dart';
import 'package:lifecoach/ui/chat/ai_chat_page.dart';
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/instruction/instruction_page.dart';
import 'package:lifecoach/ui/privacy/privacy_policy_page.dart';
import 'package:lifecoach/ui/sign_in/reset_password_page.dart';
import 'package:lifecoach/ui/sign_in/sign_in_page.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';
import 'package:lifecoach/ui/support/support_page.dart';
import 'package:models/models.dart';

Map<String, WidgetBuilder> buildAppRoutes({
  required ChatBloc chatBloc,
  required GoalsBloc goalsBloc,
  required LocalDataSource localDataSource,
}) {
  return <String, WidgetBuilder>{
    AppRoute.home.path: (BuildContext _) => const HomePage(),
    AppRoute.chat.path: (BuildContext _) => BlocProvider<ChatBloc>.value(
      value: chatBloc..add(const LoadingInitialChatStateEvent()),
      child: const BlocListener<ChatBloc, ChatState>(
        listener: _chatStateListener,
        child: AiChatPage(),
      ),
    ),
    AppRoute.goals.path: (BuildContext _) => BlocProvider<GoalsBloc>.value(
      value: goalsBloc..add(const LoadGoals()),
      child: const GoalsPage(),
    ),
    AppRoute.signIn.path: (BuildContext _) => const SignInPage(),
    AppRoute.signUp.path: (BuildContext _) => const SignUpPage(),
    AppRoute.resetPassword.path: (BuildContext context) {
      final Object? args = ModalRoute.of(context)?.settings.arguments;
      final String email = args is String ? args : '';
      return ResetPasswordPage(email: email);
    },
    AppRoute.privacyPolity.path: (BuildContext _) => const PrivacyPolicyPage(),
    AppRoute.about.path: (BuildContext _) => const AboutPage(),
    AppRoute.support.path: (BuildContext _) => const SupportPage(),
    AppRoute.instruction.path: (BuildContext _) => const InstructionPage(),
  };
}

void _chatStateListener(BuildContext context, ChatState state) {
  if (state is ChatInitial) {
    final Language currentLanguage = Language.fromIsoLanguageCode(
      LocalizedApp.of(context).delegate.currentLocale.languageCode,
    );
    final Language savedLanguage = state.language;
    if (currentLanguage != savedLanguage) {
      changeLocale(context, savedLanguage.isoLanguageCode)
      // The returned value in `then` is always `null`.
      .then((Object? _) {
        if (context.mounted) {
          context.read<ChatBloc>().add(ChangeLanguageEvent(savedLanguage));
        }
      });
    }
  } else if (state is FeedbackError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
    );
  }
}
