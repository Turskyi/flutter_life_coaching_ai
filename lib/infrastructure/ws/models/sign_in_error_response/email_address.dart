import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'verification.dart';

part 'email_address.g.dart';

@JsonSerializable()
class EmailAddress {
  final String? id;
  final String? object;
  @JsonKey(name: 'email_address')
  final String? emailAddress;
  final bool? reserved;
  final Verification? verification;
  @JsonKey(name: 'linked_to')
  final List<dynamic>? linkedTo;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;

  const EmailAddress({
    this.id,
    this.object,
    this.emailAddress,
    this.reserved,
    this.verification,
    this.linkedTo,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'EmailAddress(id: $id, object: $object, emailAddress: $emailAddress, reserved: $reserved, verification: $verification, linkedTo: $linkedTo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory EmailAddress.fromJson(Map<String, dynamic> json) {
    return _$EmailAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmailAddressToJson(this);

  EmailAddress copyWith({
    String? id,
    String? object,
    String? emailAddress,
    bool? reserved,
    Verification? verification,
    List<dynamic>? linkedTo,
    int? createdAt,
    int? updatedAt,
  }) {
    return EmailAddress(
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
    if (other is! EmailAddress) return false;
    final mapEquals = const DeepCollectionEquality().equals;
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
