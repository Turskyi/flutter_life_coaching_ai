// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      object: json['object'] as String?,
      id: json['id'] as String?,
      status: json['status'] as String?,
      supportedIdentifiers: (json['supported_identifiers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      supportedFirstFactors: json['supported_first_factors'],
      supportedSecondFactors: json['supported_second_factors'],
      firstFactorVerification: json['first_factor_verification'] == null
          ? null
          : FirstFactorVerificationResponse.fromJson(
              json['first_factor_verification'] as Map<String, dynamic>),
      secondFactorVerification: json['second_factor_verification'],
      identifier: json['identifier'] as String?,
      userData: json['user_data'],
      createdSessionId: json['created_session_id'] as String?,
      abandonAt: (json['abandon_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'status': instance.status,
      'supported_identifiers': instance.supportedIdentifiers,
      'supported_first_factors': instance.supportedFirstFactors,
      'supported_second_factors': instance.supportedSecondFactors,
      'first_factor_verification': instance.firstFactorVerification,
      'second_factor_verification': instance.secondFactorVerification,
      'identifier': instance.identifier,
      'user_data': instance.userData,
      'created_session_id': instance.createdSessionId,
      'abandon_at': instance.abandonAt,
    };
