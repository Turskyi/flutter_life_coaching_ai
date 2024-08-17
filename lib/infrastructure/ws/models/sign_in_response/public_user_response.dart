import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_user_response.g.dart';

@JsonSerializable()
class PublicUserResponse {
  const PublicUserResponse({
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.hasImage,
    this.identifier,
    this.profileImageUrl,
  });

  factory PublicUserResponse.fromJson(Map<String, dynamic> json) {
    return _$PublicUserResponseFromJson(json);
  }

  @JsonKey(name: 'first_name')
  final dynamic firstName;
  @JsonKey(name: 'last_name')
  final dynamic lastName;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'has_image')
  final bool? hasImage;
  final String? identifier;
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;

  @override
  String toString() {
    if (kDebugMode) {
      return 'PublicUserResponse('
          'firstName: $firstName, '
          'lastName: $lastName, '
          'imageUrl: $imageUrl, '
          'hasImage: $hasImage, '
          'identifier: $identifier, '
          'profileImageUrl: $profileImageUrl)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$PublicUserResponseToJson(this);

  PublicUserResponse copyWith({
    dynamic firstName,
    dynamic lastName,
    String? imageUrl,
    bool? hasImage,
    String? identifier,
    String? profileImageUrl,
  }) {
    return PublicUserResponse(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      hasImage: hasImage ?? this.hasImage,
      identifier: identifier ?? this.identifier,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PublicUserResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      imageUrl.hashCode ^
      hasImage.hashCode ^
      identifier.hashCode ^
      profileImageUrl.hashCode;
}
