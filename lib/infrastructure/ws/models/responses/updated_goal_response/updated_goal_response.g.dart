// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_goal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedGoalResponse _$UpdatedGoalResponseFromJson(Map<String, dynamic> json) =>
    UpdatedGoalResponse(
      goal: GoalResponse.fromJson(json['updatedGoal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdatedGoalResponseToJson(
        UpdatedGoalResponse instance) =>
    <String, dynamic>{
      'updatedGoal': instance.goal,
    };
