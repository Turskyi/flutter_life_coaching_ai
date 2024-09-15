import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'goal_request.g.dart';

@JsonSerializable(createFactory: false)
class GoalRequest extends Goal {
  const GoalRequest({
    required super.title,
    required super.content,
    required super.userId,
    super.id,
    super.createdAt,
    super.updatedAt,
  });

  @override
  String toString() {
    if (kDebugMode) {
      return 'GoalRequest('
          'id: $id, '
          'title: $title, '
          'content: $content, '
          'userId: $userId)';
    } else {
      return super.toString();
    }
  }

  @override
  Map<String, dynamic> toJson() => _$GoalRequestToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GoalRequest) return false;
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
