// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpSuccessResponse _$SignUpSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    SignUpSuccessResponse(
      response: json['response'] == null
          ? null
          : SignUpFormResponse.fromJson(
              json['response'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpSuccessResponseToJson(
        SignUpSuccessResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'client': instance.client,
    };
