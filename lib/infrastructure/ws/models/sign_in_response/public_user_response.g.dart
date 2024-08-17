// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicUserResponse _$PublicUserResponseFromJson(Map<String, dynamic> json) =>
    PublicUserResponse(
      firstName: json['first_name'],
      lastName: json['last_name'],
      imageUrl: json['image_url'] as String?,
      hasImage: json['has_image'] as bool?,
      identifier: json['identifier'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
    );

Map<String, dynamic> _$PublicUserResponseToJson(PublicUserResponse instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'image_url': instance.imageUrl,
      'has_image': instance.hasImage,
      'identifier': instance.identifier,
      'profile_image_url': instance.profileImageUrl,
    };
