// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepareVerificationResponse _$PrepareVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    PrepareVerificationResponse(
      signUpFormResponse: json['response'] == null
          ? null
          : SignUpFormResponse.fromJson(
              json['response'] as Map<String, dynamic>),
      clientResponse: json['client'] == null
          ? null
          : ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrepareVerificationResponseToJson(
        PrepareVerificationResponse instance) =>
    <String, dynamic>{
      'response': instance.signUpFormResponse,
      'client': instance.clientResponse,
    };
