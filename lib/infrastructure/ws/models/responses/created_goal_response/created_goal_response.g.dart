// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_goal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedGoalResponse _$CreatedGoalResponseFromJson(Map<String, dynamic> json) =>
    CreatedGoalResponse(
      goal: GoalResponse.fromJson(json['goal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatedGoalResponseToJson(
        CreatedGoalResponse instance) =>
    <String, dynamic>{
      'goal': instance.goal,
    };
