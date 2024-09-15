import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal {
  const Goal({
    required this.title,
    required this.content,
    required this.userId,
    this.id = '',
    this.createdAt,
    this.updatedAt,
  });

  factory Goal.fromJson(Map<String, dynamic> json) =>
      _$GoalFromJson(json);

  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  Goal copyWith({
    String? userId,
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Goal(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => _$GoalToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Goal) return false;
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
