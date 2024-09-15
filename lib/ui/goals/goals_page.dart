import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:lifecoach/ui/goals/add_edit_goal_dialog.dart';
import 'package:lifecoach/ui/goals/app_drawer.dart';
import 'package:lifecoach/ui/goals/goal_widget.dart';
import 'package:lifecoach/ui/goals/goals_app_bar.dart';
import 'package:lifecoach/ui/goals/shimmer_goal.dart';
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
      appBar: const GoalsAppBar(),
      drawer: const AppDrawer(),
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
            const double axisSpacing = 16.0;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: axisSpacing,
                mainAxisSpacing: axisSpacing,
              ),
              itemCount:
                  state is CreatingGoal ? allGoals.length + 1 : allGoals.length,
              itemBuilder: (_, int index) {
                if (state is CreatingGoal && index == allGoals.length) {
                  return const ShimmerGoal();
                }
                final Goal goal = allGoals[index];
                return GoalWidget(goal: goal);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => BlocProvider<GoalsBloc>.value(
            value: context.read<GoalsBloc>(),
            child: const AddEditGoalDialog(),
          ),
        ),
        tooltip: 'Add Goal',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleGoalsState(BuildContext context, GoalsState state) {
    if (state is UnauthenticatedGoalsAccessState) {
      context
          .read<AuthenticationBloc>()
          .add(const AuthenticationSignOutPressed());
    } else if (state is GoalDeleted) {
      final String message = state.message;
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }
  }
}
