import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'goal_response.g.dart';

@JsonSerializable()
class GoalResponse extends Goal {
  const GoalResponse({
    required super.id,
    required super.title,
    required super.content,
    required super.userId,
    required DateTime super.createdAt,
    required DateTime super.updatedAt,
  });

  factory GoalResponse.fromJson(Map<String, dynamic> json) =>
      _$GoalResponseFromJson(json);

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
