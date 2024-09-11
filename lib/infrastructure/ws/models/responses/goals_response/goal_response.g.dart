// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalResponse _$GoalResponseFromJson(Map<String, dynamic> json) => GoalResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GoalResponseToJson(GoalResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
