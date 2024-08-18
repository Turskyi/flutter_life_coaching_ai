import 'package:flutter/material.dart';
import 'package:lifecoach/models/goal.dart';
import 'package:lifecoach/ui/goals/goal_widget.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO:
    // final String? userId = AuthService().getUserId();
    //
    // if (userId == null) {
    //   throw Exception('userId undefined 😞');
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: FutureBuilder<List<Goal>>(
        //TODO: future: DBService().getGoals(userId),
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
