import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach/application_services/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/splash_page.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/routes.dart' as routes;

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
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: constants.appName,
      initialRoute: AppRoute.home.path,
      routes: routes.routeMap,
      theme: ThemeData.dark(),
      navigatorKey: _navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  GoalsPage.route(),
                  (Route<void> route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (Route<void> route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
