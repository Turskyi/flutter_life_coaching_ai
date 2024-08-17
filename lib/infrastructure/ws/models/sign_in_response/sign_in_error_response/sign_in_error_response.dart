import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'error.dart';
import 'meta.dart';

part 'sign_in_error_response.g.dart';

@JsonSerializable()
class SignInErrorResponse {
  final List<Error>? errors;
  final Meta? meta;
  @JsonKey(name: 'clerk_trace_id')
  final String? clerkTraceId;

  const SignInErrorResponse({this.errors, this.meta, this.clerkTraceId});

  @override
  String toString() {
    return 'SignInErrorResponse(errors: $errors, meta: $meta, clerkTraceId: $clerkTraceId)';
  }

  factory SignInErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$SignInErrorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignInErrorResponseToJson(this);

  SignInErrorResponse copyWith({
    List<Error>? errors,
    Meta? meta,
    String? clerkTraceId,
  }) {
    return SignInErrorResponse(
      errors: errors ?? this.errors,
      meta: meta ?? this.meta,
      clerkTraceId: clerkTraceId ?? this.clerkTraceId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignInErrorResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => errors.hashCode ^ meta.hashCode ^ clerkTraceId.hashCode;
}
