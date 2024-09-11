import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'goal_response.dart';

part 'goals_response.g.dart';

@JsonSerializable()
class GoalsResponse {
  const GoalsResponse({required this.goals});

  factory GoalsResponse.fromJson(Map<String, dynamic> json) {
    return _$GoalsResponseFromJson(json);
  }

  @JsonKey(name: 'goals')
  final List<GoalResponse> goals;

  @override
  String toString() {
    if (kDebugMode) {
      return 'GoalsResponse(goals: $goals)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$GoalsResponseToJson(this);

  GoalsResponse copyWith({
    List<GoalResponse>? goals,
  }) {
    return GoalsResponse(
      goals: goals ?? this.goals,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GoalsResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => goals.hashCode;
}
