import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/ui/app/app_view.dart';
import 'package:user_repository/user_repository.dart';

/// We are injecting a single instance of the [AuthenticationRepository] and
/// [UserRepository] into the [App] widget
/// It contains the root [App] widget for the entire application.
/// [App] is responsible for creating/providing the [AuthenticationBloc] which
/// will be consumed by the [AppView]. This decoupling will enable us to
/// easily test both the [App] and [AppView] widgets.
/// [RepositoryProvider] is used to provide the single instance of
/// [AuthenticationRepository] to the entire application.
/// By default, [BlocProvider] is lazy and does not call create until the first
/// time the Bloc is accessed. Since [AuthenticationBloc] should always
/// subscribe to the [AuthenticationStatus] stream immediately (via the
/// [AuthenticationSubscriptionRequested] event), we can explicitly opt out of
/// this behavior by setting `lazy: false`.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = GetIt.instance<AuthenticationRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationRepository>.value(
      value: _authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        // By default, BlocProvider is lazy and does not call create until the
        // first time the Bloc is accessed. Since AuthenticationBloc should
        // always subscribe to the AuthenticationStatus stream immediately (via
        // the AuthenticationSubscriptionRequested event), we can explicitly
        // opt out of this behavior by setting `lazy: false`.
        lazy: false,
        create: (_) => GetIt.instance<AuthenticationBloc>()
          ..add(const AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }
}
