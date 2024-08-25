// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepareVerificationResponse _$PrepareVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    PrepareVerificationResponse(
      response: json['response'] == null
          ? null
          : Response.fromJson(json['response'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrepareVerificationResponseToJson(
        PrepareVerificationResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'client': instance.client,
    };
