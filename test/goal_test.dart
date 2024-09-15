import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Goal Model', () {
    test('should create a valid Goal instance', () {
      final Goal goal = Goal(
        id: '1',
        title: 'Test Goal',
        content: 'This is a test goal.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: '1',
      );

      expect(goal.id, '1');
      expect(goal.title, 'Test Goal');
      expect(goal.content, 'This is a test goal.');
      expect(goal.createdAt, isA<DateTime>());
      expect(goal.updatedAt, isA<DateTime>());
    });

    test('should correctly serialize and deserialize', () {
      final Goal goal = Goal(
        id: '1',
        title: 'Test Goal',
        content: 'This is a test goal.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: '1',
      );

      final Map<String, String> json = <String, String>{
        'id': goal.id,
        'title': goal.title,
        'content': goal.content,
        'createdAt': goal.createdAt?.toIso8601String() ?? '',
        'updatedAt': goal.updatedAt?.toIso8601String() ?? '',
      };

      final Goal deserializedGoal = Goal(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        createdAt: DateTime.parse(json['createdAt'] ?? ''),
        updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
        userId: json['userId'] ?? '',
      );

      expect(deserializedGoal.id, goal.id);
      expect(deserializedGoal.title, goal.title);
      expect(deserializedGoal.content, goal.content);
      expect(deserializedGoal.createdAt, goal.createdAt);
      expect(deserializedGoal.updatedAt, goal.updatedAt);
    });
  });
}
