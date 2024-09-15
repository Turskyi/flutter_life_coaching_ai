import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'delete_goal_response.g.dart';

@JsonSerializable()
class DeleteGoalResponse implements MessageResponse {
  const DeleteGoalResponse({required this.message});

  factory DeleteGoalResponse.fromJson(Map<String, dynamic> json) {
    return _$DeleteGoalResponseFromJson(json);
  }

  @override
  @JsonKey(name: 'message')
  final String message;

  @override
  String toString() => 'DeleteGoalResponse(message: $message)';

  Map<String, dynamic> toJson() => _$DeleteGoalResponseToJson(this);

  DeleteGoalResponse copyWith({
    String? message,
  }) =>
      DeleteGoalResponse(
        message: message ?? this.message,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeleteGoalResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode;
}
