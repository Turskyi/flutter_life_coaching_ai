// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInErrorResponse _$SignInErrorResponseFromJson(Map<String, dynamic> json) =>
    SignInErrorResponse(
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => Error.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      clerkTraceId: json['clerk_trace_id'] as String?,
    );

Map<String, dynamic> _$SignInErrorResponseToJson(
        SignInErrorResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'meta': instance.meta,
      'clerk_trace_id': instance.clerkTraceId,
    };
