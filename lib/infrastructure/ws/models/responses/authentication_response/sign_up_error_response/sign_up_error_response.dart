import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/error_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_response/sign_up_response.dart';

part 'sign_up_error_response.g.dart';

@JsonSerializable()
class SignUpErrorResponse implements SignUpResponse {
  const SignUpErrorResponse({this.errors, this.clerkTraceId});

  factory SignUpErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$SignUpErrorResponseFromJson(json);
  }

  @JsonKey(name: 'errors')
  final List<ErrorResponse>? errors;

  @JsonKey(name: 'clerk_trace_id')
  final String? clerkTraceId;

  @override
  String get id => clerkTraceId ?? '';

  @override
  String toString() {
    if (kDebugMode) {
      return 'SignUpErrorResponse('
          'errors: $errors, '
          'clerkTraceId: $clerkTraceId)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$SignUpErrorResponseToJson(this);

  SignUpErrorResponse copyWith({
    List<ErrorResponse>? errors,
    String? clerkTraceId,
  }) =>
      SignUpErrorResponse(
        errors: errors ?? this.errors,
        clerkTraceId: clerkTraceId ?? this.clerkTraceId,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignUpErrorResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => errors.hashCode ^ clerkTraceId.hashCode;
}
