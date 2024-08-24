import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/authentication/bloc/authentication_bloc.dart';
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

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const GoalsPage());

  @override
  Widget build(BuildContext context) {
    //TODO: Use userId to get user's goals.
    // final String userId = context.select(
    //   (AuthenticationBloc bloc) => bloc.state.user.id,
    // );
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
      body: FutureBuilder<List<Goal>>(
        //TODO: Replace with future: DBService().getGoals(userId),
        future: Future<List<Goal>>.value(<Goal>[
          Goal(
            id: 'testId',
            title: 'test title',
            content: 'test description',
            createdAt: DateTime.now().subtract(const Duration(hours: 1)),
            updatedAt: DateTime.now().subtract(const Duration(minutes: 1)),
          ),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<Goal>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "You don't have any goals yet. Why don't you create one?",
              ),
            );
          } else {
            final List<Goal> allGoals = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: allGoals.length,
              itemBuilder: (BuildContext context, int index) {
                final Goal goal = allGoals[index];
                return GoalWidget(goal: goal);
              },
            );
          }
        },
      ),
    );
  }
}
