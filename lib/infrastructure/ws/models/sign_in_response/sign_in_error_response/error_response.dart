import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class Error {
  final String? message;
  @JsonKey(name: 'long_message')
  final String? longMessage;
  final String? code;

  const Error({this.message, this.longMessage, this.code});

  @override
  String toString() {
    return 'Error(message: $message, longMessage: $longMessage, code: $code)';
  }

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);

  Error copyWith({
    String? message,
    String? longMessage,
    String? code,
  }) {
    return Error(
      message: message ?? this.message,
      longMessage: longMessage ?? this.longMessage,
      code: code ?? this.code,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Error) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode ^ longMessage.hashCode ^ code.hashCode;
}
