import 'package:flutter/material.dart';
import 'package:lifecoach/models/goal.dart';
import 'package:lifecoach/ui/goals/add_edit_goal_dialog.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({required this.goal, super.key});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final bool wasUpdated = goal.updatedAt.isAfter(goal.createdAt);
    final String createdUpdatedAtTimestamp = wasUpdated
        ? goal.updatedAt.toLocal().toString().split(' ')[0]
        : goal.createdAt.toLocal().toString().split(' ')[0];

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => AddEditGoalDialog(goal: goal),
      ),
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                goal.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$createdUpdatedAtTimestamp${wasUpdated ? ' (updated)' : ''}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                goal.content,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
