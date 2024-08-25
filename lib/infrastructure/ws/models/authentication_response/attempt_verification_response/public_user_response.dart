import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_user_data.g.dart';

@JsonSerializable()
class PublicUserData {
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

  const PublicUserData({
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.hasImage,
    this.identifier,
    this.profileImageUrl,
  });

  @override
  String toString() {
    return 'PublicUserData(firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl, hasImage: $hasImage, identifier: $identifier, profileImageUrl: $profileImageUrl)';
  }

  factory PublicUserData.fromJson(Map<String, dynamic> json) {
    return _$PublicUserDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PublicUserDataToJson(this);

  PublicUserData copyWith({
    dynamic firstName,
    dynamic lastName,
    String? imageUrl,
    bool? hasImage,
    String? identifier,
    String? profileImageUrl,
  }) {
    return PublicUserData(
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
    if (other is! PublicUserData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
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
