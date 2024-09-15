import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goal_response/goal_response.dart';
import 'package:models/models.dart';

part 'created_goal_response.g.dart';

@JsonSerializable()
class CreatedGoalResponse implements GoalResult {
  factory CreatedGoalResponse.fromJson(Map<String, dynamic> json) {
    return _$CreatedGoalResponseFromJson(json);
  }

  const CreatedGoalResponse({required this.goal});

  @override
  @JsonKey(name: 'goal')
  final GoalResponse goal;

  @override
  String toString() => 'GoalResult(goal: $goal)';

  Map<String, dynamic> toJson() => _$CreatedGoalResponseToJson(this);

  CreatedGoalResponse copyWith({
    GoalResponse? goal,
  }) {
    return CreatedGoalResponse(
      goal: goal ?? this.goal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CreatedGoalResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => goal.hashCode;
}
