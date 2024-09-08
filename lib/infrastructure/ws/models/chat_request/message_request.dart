import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  const MessageRequest({required this.role, required this.content});

  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return _$MessageRequestFromJson(json);
  }

  final String role;
  final String content;

  @override
  String toString() => 'MessageRequest(role: $role, content: $content)';

  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);

  MessageRequest copyWith({
    String? role,
    String? content,
  }) =>
      MessageRequest(
        role: role ?? this.role,
        content: content ?? this.content,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MessageRequest) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => role.hashCode ^ content.hashCode;
}
