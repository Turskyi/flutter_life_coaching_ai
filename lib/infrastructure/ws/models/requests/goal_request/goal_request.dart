import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal_response.g.dart';

@JsonSerializable()
class GoalResponse {
  const GoalResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoalResponse.fromJson(Map<String, dynamic> json) =>
      _$GoalResponseFromJson(json);

  final String id;
  final String title;
  final String content;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  String toString() {
    if (kDebugMode) {
      return 'GoalResponse('
          'id: $id, '
          'title: $title, '
          'content: $content, '
          'userId: $userId, '
          'createdAt: $createdAt, '
          'updatedAt: $updatedAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$GoalResponseToJson(this);

  GoalResponse copyWith({
    String? id,
    String? title,
    String? content,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GoalResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GoalResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      userId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
