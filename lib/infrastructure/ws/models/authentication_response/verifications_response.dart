import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifications_response.g.dart';

@JsonSerializable()
class VerificationsResponse {
  const VerificationsResponse({
    this.emailAddress,
    this.phoneNumber,
    this.web3Wallet,
    this.externalAccount,
  });

  factory VerificationsResponse.fromJson(Map<String, dynamic> json) {
    return _$VerificationsResponseFromJson(json);
  }

  @JsonKey(name: 'email_address')
  final VerificationsResponse? emailAddress;
  @JsonKey(name: 'phone_number')
  final dynamic phoneNumber;
  @JsonKey(name: 'web3_wallet')
  final dynamic web3Wallet;
  @JsonKey(name: 'external_account')
  final dynamic externalAccount;

  @override
  String toString() {
    if (kDebugMode) {
      return 'Verifications('
          'emailAddress: $emailAddress, '
          'phoneNumber: $phoneNumber, '
          'web3Wallet: $web3Wallet, '
          'externalAccount: $externalAccount)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$VerificationsResponseToJson(this);

  VerificationsResponse copyWith({
    dynamic emailAddress,
    dynamic phoneNumber,
    dynamic web3Wallet,
    dynamic externalAccount,
  }) {
    return VerificationsResponse(
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      web3Wallet: web3Wallet ?? this.web3Wallet,
      externalAccount: externalAccount ?? this.externalAccount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VerificationsResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      emailAddress.hashCode ^
      phoneNumber.hashCode ^
      web3Wallet.hashCode ^
      externalAccount.hashCode;
}
