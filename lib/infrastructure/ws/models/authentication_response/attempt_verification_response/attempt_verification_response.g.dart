// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptVerificationResponse _$AttemptVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    AttemptVerificationResponse(
      signUpFormResponse: json['response'] == null
          ? null
          : SignUpFormResponse.fromJson(
              json['response'] as Map<String, dynamic>),
      clientResponse: json['client'] == null
          ? null
          : ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttemptVerificationResponseToJson(
        AttemptVerificationResponse instance) =>
    <String, dynamic>{
      'response': instance.signUpFormResponse,
      'client': instance.clientResponse,
    };
