import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/ui/goals/goal_card.dart';
import 'package:models/models.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({required this.goal, super.key});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoalCard(goal: goal),
        BlocBuilder<GoalsBloc, GoalsState>(
          builder: (_, GoalsState state) {
            if (state is SubmittingGoal && state.goalId == goal.id) {
              return Positioned.fill(
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
