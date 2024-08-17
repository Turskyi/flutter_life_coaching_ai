import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  const ErrorResponse({this.message, this.longMessage, this.code});

  final String? message;
  @JsonKey(name: 'long_message')
  final String? longMessage;
  final String? code;

  @override
  String toString() => 'ErrorResponse('
      'message: $message, '
      'longMessage: $longMessage, '
      'code: $code)';

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  ErrorResponse copyWith({
    String? message,
    String? longMessage,
    String? code,
  }) {
    return ErrorResponse(
      message: message ?? this.message,
      longMessage: longMessage ?? this.longMessage,
      code: code ?? this.code,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ErrorResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode ^ longMessage.hashCode ^ code.hashCode;
}
