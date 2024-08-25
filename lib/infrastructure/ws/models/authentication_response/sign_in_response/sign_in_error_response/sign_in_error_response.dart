import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/sign_in_response/sign_in_response.dart';

import '../../error_response.dart';
import 'meta_response.dart';

part 'sign_in_error_response.g.dart';

@JsonSerializable()
class SignInErrorResponse implements SignInResponse {
  const SignInErrorResponse({
    this.errors,
    this.metaResponse,
    this.clerkTraceId,
  });

  factory SignInErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$SignInErrorResponseFromJson(json);
  }

  final List<ErrorResponse>? errors;
  @JsonKey(name: 'meta')
  final MetaResponse? metaResponse;
  @JsonKey(name: 'clerk_trace_id')
  final String? clerkTraceId;

  @override
  String get token =>
      metaResponse
          ?.clientResponse?.sessions.firstOrNull?.lastActiveToken?.jwt ??
      '';

  @override
  String toString() => 'SignInErrorResponse('
      'errors: $errors, '
      'meta: $metaResponse, '
      'clerkTraceId: $clerkTraceId,'
      'token: $token)';

  Map<String, dynamic> toJson() => _$SignInErrorResponseToJson(this);

  SignInErrorResponse copyWith({
    List<ErrorResponse>? errors,
    MetaResponse? metaResponse,
    String? clerkTraceId,
  }) {
    return SignInErrorResponse(
      errors: errors ?? this.errors,
      metaResponse: metaResponse ?? this.metaResponse,
      clerkTraceId: clerkTraceId ?? this.clerkTraceId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignInErrorResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      errors.hashCode ^ metaResponse.hashCode ^ clerkTraceId.hashCode;
}
