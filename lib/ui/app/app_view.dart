import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/env/env.dart';
import 'package:lifecoach/infrastructure/data_sources/local/local_data_source.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/about/about_page.dart';
import 'package:lifecoach/ui/chat/ai_chat_page.dart';
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/privacy/privacy_policy_page.dart';
import 'package:lifecoach/ui/sign_in/sign_in_page.dart';
import 'package:lifecoach/ui/sign_up/code_page.dart';
import 'package:lifecoach/ui/sign_up/sign_up_page.dart';
import 'package:lifecoach/ui/splash_page.dart';
import 'package:models/models.dart';
import 'package:resend/resend.dart';

/// [AppView] is a [StatefulWidget] because it maintains a [GlobalKey] which is
/// used to access the [NavigatorState]. By default, [AppView] will render the
/// [SplashPage] and it uses [BlocListener] to navigate to different pages
/// based on changes in the [AuthenticationState].
/// Upon a successful `signIn` request, the state of the [AuthenticationBloc]
/// will change to authenticated and the user will be navigated to the
/// [GoalsPage] where we display the user’s goals as well as a button to
/// sign out.
@immutable
class AppView extends StatefulWidget {
  const AppView({
    required this.localDataSource,
    required this.authenticationBloc,
    super.key,
  });

  final AuthenticationBloc authenticationBloc;
  final LocalDataSource localDataSource;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext _) {
    Resend(apiKey: Env.resendApiKey);
    final Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
      AppRoute.home.path: (BuildContext _) => const HomePage(),
      AppRoute.chat.path: (BuildContext _) => BlocProvider<ChatBloc>(
        create: (BuildContext _) {
          return GetIt.I.get<ChatBloc>()
            ..add(const LoadingInitialChatStateEvent());
        },
        child: BlocListener<ChatBloc, ChatState>(
          listener: _chatStateListener,
          child: const AiChatPage(),
        ),
      ),
      AppRoute.goals.path: (BuildContext _) => BlocProvider<GoalsBloc>(
        create: (_) => GetIt.I.get<GoalsBloc>()..add(const LoadGoals()),
        child: const GoalsPage(),
      ),
      AppRoute.signIn.path: (BuildContext _) => const SignInPage(),
      AppRoute.signUp.path: (BuildContext _) => const SignUpPage(),
      AppRoute.privacyPolity.path: (_) => const PrivacyPolicyPage(),
      AppRoute.about.path: (BuildContext _) {
        final Language savedLanguage = widget.localDataSource
            .getSavedLanguage();
        return AboutPage(initialLanguage: savedLanguage);
      },
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: constants.appName,
      initialRoute: AppRoute.home.path,
      routes: routeMap,
      theme: ThemeData.dark(),
      navigatorKey: _navigatorKey,
      builder: (BuildContext _, Widget? child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: _authenticationBlocStateListener,
          child: child,
        );
      },
      onGenerateRoute: (RouteSettings _) => SplashPage.route(),
    );
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
        SnackBar(
          content: Text(state.errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _authenticationBlocStateListener(
    BuildContext context,
    AuthenticationState state,
  ) {
    final AuthenticationStatus status = state.status;

    switch (status) {
      case CodeAuthenticationStatus():
        _navigator?.pushAndRemoveUntil<void>(
          CodePage.route(email: status.email),
          (Route<void> _) => false,
        );
      case DeletingAuthenticatedUserStatus():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deletion in progress...')),
        );
      case AuthenticatedStatus():
        _navigator?.pushAndRemoveUntil<void>(
          GoalsPage.route(widget.authenticationBloc),
          (Route<void> _) => false,
        );
      case UnauthenticatedStatus():
        _navigator?.pushAndRemoveUntil<void>(
          HomePage.route(),
          (Route<void> _) => false,
        );
        if (status.message.isNotEmpty) {
          final String message = status.message;
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          );
        }
      case UnknownAuthenticationStatus():
        break;
    }
  }
}
