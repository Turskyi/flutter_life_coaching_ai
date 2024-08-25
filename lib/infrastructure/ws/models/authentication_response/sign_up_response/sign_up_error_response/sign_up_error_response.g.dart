// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpErrorResponse _$SignUpErrorResponseFromJson(Map<String, dynamic> json) =>
    SignUpErrorResponse(
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      clerkTraceId: json['clerk_trace_id'] as String?,
    );

Map<String, dynamic> _$SignUpErrorResponseToJson(
        SignUpErrorResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'clerk_trace_id': instance.clerkTraceId,
    };
