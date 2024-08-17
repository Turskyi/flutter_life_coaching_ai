import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'verification_response.dart';

part 'email_address_response.g.dart';

@JsonSerializable()
class EmailAddressResponse {
  const EmailAddressResponse({
    this.id,
    this.object,
    this.emailAddress,
    this.reserved,
    this.verification,
    this.linkedTo,
    this.createdAt,
    this.updatedAt,
  });

  factory EmailAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$EmailAddressResponseFromJson(json);
  }

  final String? id;
  final String? object;
  @JsonKey(name: 'email_address')
  final String? emailAddress;
  final bool? reserved;
  final VerificationResponse? verification;
  @JsonKey(name: 'linked_to')
  final List<dynamic>? linkedTo;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;

  @override
  String toString() {
    if (kDebugMode) {
      return 'EmailAddressResponse('
          'id: $id, '
          'object: $object, '
          'emailAddress: $emailAddress, '
          'reserved: $reserved, '
          'verification: $verification, '
          'linkedTo: $linkedTo, '
          'createdAt: $createdAt, '
          'updatedAt: $updatedAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$EmailAddressResponseToJson(this);

  EmailAddressResponse copyWith({
    String? id,
    String? object,
    String? emailAddress,
    bool? reserved,
    VerificationResponse? verification,
    List<dynamic>? linkedTo,
    int? createdAt,
    int? updatedAt,
  }) {
    return EmailAddressResponse(
      id: id ?? this.id,
      object: object ?? this.object,
      emailAddress: emailAddress ?? this.emailAddress,
      reserved: reserved ?? this.reserved,
      verification: verification ?? this.verification,
      linkedTo: linkedTo ?? this.linkedTo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! EmailAddressResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      object.hashCode ^
      emailAddress.hashCode ^
      reserved.hashCode ^
      verification.hashCode ^
      linkedTo.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
