import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'error.dart';

part 'sign_up_error_response.g.dart';

@JsonSerializable()
class SignUpErrorResponse {
  final List<Error>? errors;
  @JsonKey(name: 'clerk_trace_id')
  final String? clerkTraceId;

  const SignUpErrorResponse({this.errors, this.clerkTraceId});

  @override
  String toString() {
    return 'SignUpErrorResponse(errors: $errors, clerkTraceId: $clerkTraceId)';
  }

  factory SignUpErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$SignUpErrorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignUpErrorResponseToJson(this);

  SignUpErrorResponse copyWith({
    List<Error>? errors,
    String? clerkTraceId,
  }) {
    return SignUpErrorResponse(
      errors: errors ?? this.errors,
      clerkTraceId: clerkTraceId ?? this.clerkTraceId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignUpErrorResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => errors.hashCode ^ clerkTraceId.hashCode;
}
