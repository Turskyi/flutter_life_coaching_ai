import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:lifecoach/ui/goals/goal_widget.dart';
import 'package:models/models.dart';

/// The [GoalsPage] can access the current user id via
/// `context.select((AuthenticationBloc bloc) => bloc.state.user.id)` and
/// displays it via a [Text] widget. In addition, when the sign out button is
/// tapped, an [AuthenticationLogoutRequested] event is added to the
/// [AuthenticationBloc].
/// `context.select((AuthenticationBloc bloc) => bloc.state.user.id)` will
/// trigger updates if the user id changes.
class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  static Route<void> route(AuthenticationBloc authenticationBloc) =>
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<GoalsBloc>(
          create: (_) => GoalsBloc(
            GetIt.I.get<GoalsRepository>(),
            authenticationBloc,
          )..add(const LoadGoals()),
          child: const GoalsPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign out'),
              onTap: () => context
                  .read<AuthenticationBloc>()
                  .add(const AuthenticationSignOutPressed()),
            ),
            // const _SignOutButton(),
          ],
        ),
      ),
      body: BlocConsumer<GoalsBloc, GoalsState>(
        listener: _handleGoalsState,
        builder: (BuildContext context, GoalsState state) {
          if (state is GoalsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GoalsError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.goals.isEmpty) {
            return const Center(
              child: Text(
                "You don't have any goals yet. Why don't you create one?",
              ),
            );
          } else {
            final List<Goal> allGoals = state.goals;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: allGoals.length,
              itemBuilder: (_, int index) {
                final Goal goal = allGoals[index];
                return GoalWidget(goal: goal);
              },
            );
          }
        },
      ),
    );
  }

  void _handleGoalsState(BuildContext context, GoalsState state) {
    if (state is GoalsError) {
      context
          .read<AuthenticationBloc>()
          .add(const AuthenticationSignOutPressed());
    }
  }
}
