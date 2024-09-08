import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message_request.dart';

part 'chat_request.g.dart';

@JsonSerializable()
class ChatRequest {
  const ChatRequest({required this.messages});

  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return _$ChatRequestFromJson(json);
  }

  final List<MessageRequest> messages;

  @override
  String toString() => 'ChatRequest(messages: $messages)';

  Map<String, dynamic> toJson() => _$ChatRequestToJson(this);

  ChatRequest copyWith({List<MessageRequest>? messages}) =>
      ChatRequest(messages: messages ?? this.messages);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ChatRequest) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => messages.hashCode;
}
