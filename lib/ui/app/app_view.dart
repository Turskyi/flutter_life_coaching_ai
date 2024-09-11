import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/router/routes.dart' as routes;
import 'package:lifecoach/ui/goals/goals_page.dart';
import 'package:lifecoach/ui/home/home_page.dart';
import 'package:lifecoach/ui/sign_up/code_page.dart';
import 'package:lifecoach/ui/splash_page.dart';

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
  const AppView({required this.authenticationBloc, super.key});

  final AuthenticationBloc authenticationBloc;

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
            final AuthenticationStatus status = state.status;
            switch (status) {
              case CodeAuthenticationStatus():
                _navigator.pushAndRemoveUntil<void>(
                  CodePage.route(email: status.email),
                  (Route<void> route) => false,
                );
              case AuthenticatedStatus():
                _navigator.pushAndRemoveUntil<void>(
                  GoalsPage.route(widget.authenticationBloc),
                  (Route<void> route) => false,
                );
              case UnauthenticatedStatus():
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (Route<void> route) => false,
                );
              case UnknownAuthenticationStatus():
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
