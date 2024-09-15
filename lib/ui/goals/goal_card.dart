import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/ui/goals/add_edit_goal_dialog.dart';
import 'package:models/models.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    required this.goal,
    super.key,
  });

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final DateTime? createdAt = goal.createdAt;
    final bool wasUpdated =
        createdAt != null ? goal.updatedAt?.isAfter(createdAt) ?? false : false;
    final String createdUpdatedAtTimestamp = wasUpdated
        ? goal.updatedAt?.toLocal().toString().split(' ').firstOrNull ?? ''
        : createdAt?.toLocal().toString().split(' ').firstOrNull ?? '';
    return Positioned.fill(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (_) => BlocProvider<GoalsBloc>.value(
              value: context.read<GoalsBloc>(),
              child: AddEditGoalDialog(goal: goal),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                    _getTimeStamp(
                      timestamp: createdUpdatedAtTimestamp,
                      wasUpdated: wasUpdated,
                    ),
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
        ),
      ),
    );
  }

  String _getTimeStamp({
    required String timestamp,
    required bool wasUpdated,
  }) =>
      '$timestamp${wasUpdated ? ' (updated)' : ''}';
}
