import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goal_response/goal_response.dart';

part 'goal_result.g.dart';

@JsonSerializable()
class GoalResult {
  factory GoalResult.fromJson(Map<String, dynamic> json) {
    return _$GoalResultFromJson(json);
  }

  const GoalResult({this.goalResponse});

  @JsonKey(name: 'goal')
  final GoalResponse? goalResponse;

  @override
  String toString() => 'GoalResult(goal: $goalResponse)';

  Map<String, dynamic> toJson() => _$GoalResultToJson(this);

  GoalResult copyWith({
    GoalResponse? goalResponse,
  }) {
    return GoalResult(
      goalResponse: goalResponse ?? this.goalResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GoalResult) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => goalResponse.hashCode;
}
