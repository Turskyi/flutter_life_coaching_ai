// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalsResponse _$GoalsResponseFromJson(Map<String, dynamic> json) =>
    GoalsResponse(
      goals: (json['goals'] as List<dynamic>)
          .map((e) => GoalResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoalsResponseToJson(GoalsResponse instance) =>
    <String, dynamic>{
      'goals': instance.goals,
    };
