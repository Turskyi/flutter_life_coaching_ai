import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goal_response/goal_response.dart';
import 'package:models/models.dart';

part 'updated_goal_response.g.dart';

@JsonSerializable()
class UpdatedGoalResponse implements GoalResult {
  factory UpdatedGoalResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdatedGoalResponseFromJson(json);
  }

  const UpdatedGoalResponse({required this.goal});

  @override
  @JsonKey(name: 'updatedGoal')
  final GoalResponse goal;

  @override
  String toString() => 'UpdatedGoalResponse(updatedGoal: $goal)';

  Map<String, dynamic> toJson() => _$UpdatedGoalResponseToJson(this);

  UpdatedGoalResponse copyWith({
    GoalResponse? goal,
  }) {
    return UpdatedGoalResponse(
      goal: goal ?? this.goal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UpdatedGoalResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => goal.hashCode;
}
