import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_goal_response.g.dart';

@JsonSerializable()
class DeleteGoalResponse {
  final String? message;

  const DeleteGoalResponse({this.message});

  @override
  String toString() => 'DeleteGoalResponse(message: $message)';

  factory DeleteGoalResponse.fromJson(Map<String, dynamic> json) {
    return _$DeleteGoalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeleteGoalResponseToJson(this);

  DeleteGoalResponse copyWith({
    String? message,
  }) {
    return DeleteGoalResponse(
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeleteGoalResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode;
}
