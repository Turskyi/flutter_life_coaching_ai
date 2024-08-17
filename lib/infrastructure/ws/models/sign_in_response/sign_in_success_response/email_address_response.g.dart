// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailAddressResponse _$EmailAddressResponseFromJson(
        Map<String, dynamic> json) =>
    EmailAddressResponse(
      id: json['id'] as String?,
      object: json['object'] as String?,
      emailAddress: json['email_address'] as String?,
      reserved: json['reserved'] as bool?,
      verification: json['verification'] == null
          ? null
          : VerificationResponse.fromJson(
              json['verification'] as Map<String, dynamic>),
      linkedTo: json['linked_to'] as List<dynamic>?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmailAddressResponseToJson(
        EmailAddressResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'email_address': instance.emailAddress,
      'reserved': instance.reserved,
      'verification': instance.verification,
      'linked_to': instance.linkedTo,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
