import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/env/env.dart';
import 'package:lifecoach/infrastructure/data_sources/local/local_data_source.dart';
import 'package:lifecoach/infrastructure/services/theme_service.dart';
import 'package:lifecoach/res/app_theme.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/sign_in/reset_password_page.dart';
import 'package:lifecoach/ui/sign_up/code_page.dart';
import 'package:lifecoach/ui/splash_page.dart';
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
    required this.routeMap,
    required this.themeService,
    super.key,
  });

  final AuthenticationBloc authenticationBloc;
  final LocalDataSource localDataSource;
  final Map<String, WidgetBuilder> routeMap;
  final ThemeService themeService;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    Resend(apiKey: Env.resendApiKey);

    final LocalizationDelegate localizationDelegate = LocalizedApp.of(
      context,
    ).delegate;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: widget.themeService.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return LocalizationProvider(
          state: LocalizationProvider.of(context).state,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: constants.appName,
            initialRoute: AppRoute.home.path,
            routes: widget.routeMap,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            navigatorKey: _navigatorKey,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              localizationDelegate,
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
            builder: (BuildContext _, Widget? child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: _authenticationBlocStateListener,
                child: child,
              );
            },
            onGenerateRoute: (RouteSettings _) => SplashPage.route(),
          ),
        );
      },
    );
  }

  void _authenticationBlocStateListener(
    BuildContext context,
    AuthenticationState state,
  ) {
    final AuthenticationStatus status = state.status;

    String? currentRouteName;
    _navigator?.popUntil((Route<dynamic> route) {
      currentRouteName = route.settings.name;
      return true;
    });

    switch (status) {
      case CodeAuthenticationStatus():
        _navigator?.pushAndRemoveUntil<void>(
          CodePage.route(email: status.email),
          (Route<void> _) => false,
        );
      case ResetPasswordAuthenticationStatus():
        _navigator?.push(ResetPasswordPage.route(email: status.email));
        break;
      case DeletingAuthenticatedUserStatus():
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(translate('account_deletion'))));
      case AuthenticatedStatus():
        final bool isOnGuestRoute =
            currentRouteName == AppRoute.home.path ||
            currentRouteName == AppRoute.signIn.path ||
            currentRouteName == AppRoute.signUp.path ||
            currentRouteName == null;

        if (isOnGuestRoute) {
          _navigator?.pushAndRemoveUntil<void>(
            GoalsPage.route(widget.authenticationBloc),
            (Route<void> _) => false,
          );
        }
      case UnauthenticatedStatus():
        final List<String> publicRoutes = <String>[
          AppRoute.home.path,
          AppRoute.about.path,
          AppRoute.support.path,
          AppRoute.privacyPolity.path,
          AppRoute.signIn.path,
          AppRoute.signUp.path,
          AppRoute.resetPassword.path,
          AppRoute.instruction.path,
        ];

        final bool isPublicRoute = publicRoutes.contains(currentRouteName);

        if (!isPublicRoute) {
          _navigator?.pushAndRemoveUntil<void>(
            HomePage.route(),
            (Route<void> _) => false,
          );
        }

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
