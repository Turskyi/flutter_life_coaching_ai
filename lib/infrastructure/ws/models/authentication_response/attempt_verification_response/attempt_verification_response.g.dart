// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptVerificationResponse _$AttemptVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    AttemptVerificationResponse(
      response: json['response'] == null
          ? null
          : Response.fromJson(json['response'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttemptVerificationResponseToJson(
        AttemptVerificationResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'client': instance.client,
    };
