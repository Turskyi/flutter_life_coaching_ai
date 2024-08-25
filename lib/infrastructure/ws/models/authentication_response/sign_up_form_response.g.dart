// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpFormResponse _$SignUpFormResponseFromJson(Map<String, dynamic> json) =>
    SignUpFormResponse(
      object: json['object'] as String?,
      id: json['id'] as String?,
      status: json['status'] as String?,
      requiredFields: (json['required_fields'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      optionalFields: json['optional_fields'] as List<dynamic>?,
      missingFields: json['missing_fields'] as List<dynamic>?,
      unverifiedFields: (json['unverified_fields'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      verifications: json['verifications'] == null
          ? null
          : VerificationsResponse.fromJson(
              json['verifications'] as Map<String, dynamic>),
      username: json['username'],
      emailAddress: json['email_address'] as String?,
      phoneNumber: json['phone_number'],
      web3Wallet: json['web3_wallet'],
      passwordEnabled: json['password_enabled'] as bool?,
      firstName: json['first_name'],
      lastName: json['last_name'],
      customAction: json['custom_action'] as bool?,
      externalId: json['external_id'],
      createdSessionId: json['created_session_id'] as String?,
      createdUserId: json['created_user_id'] as String?,
      abandonAt: (json['abandon_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SignUpFormResponseToJson(SignUpFormResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'status': instance.status,
      'required_fields': instance.requiredFields,
      'optional_fields': instance.optionalFields,
      'missing_fields': instance.missingFields,
      'unverified_fields': instance.unverifiedFields,
      'verifications': instance.verifications,
      'username': instance.username,
      'email_address': instance.emailAddress,
      'phone_number': instance.phoneNumber,
      'web3_wallet': instance.web3Wallet,
      'password_enabled': instance.passwordEnabled,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'custom_action': instance.customAction,
      'external_id': instance.externalId,
      'created_session_id': instance.createdSessionId,
      'created_user_id': instance.createdUserId,
      'abandon_at': instance.abandonAt,
    };
