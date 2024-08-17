import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'first_factor_verification_response.dart';

part 'authentication_response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  const AuthenticationResponse({
    this.object,
    this.id,
    this.status,
    this.supportedIdentifiers,
    this.supportedFirstFactors,
    this.supportedSecondFactors,
    this.firstFactorVerification,
    this.secondFactorVerification,
    this.identifier,
    this.userData,
    this.createdSessionId,
    this.abandonAt,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthenticationResponseFromJson(json);
  }

  final String? object;
  final String? id;
  final String? status;
  @JsonKey(name: 'supported_identifiers')
  final List<String>? supportedIdentifiers;
  @JsonKey(name: 'supported_first_factors')
  final dynamic supportedFirstFactors;
  @JsonKey(name: 'supported_second_factors')
  final dynamic supportedSecondFactors;
  @JsonKey(name: 'first_factor_verification')
  final FirstFactorVerificationResponse? firstFactorVerification;
  @JsonKey(name: 'second_factor_verification')
  final dynamic secondFactorVerification;
  final String? identifier;
  @JsonKey(name: 'user_data')
  final dynamic userData;
  @JsonKey(name: 'created_session_id')
  final String? createdSessionId;
  @JsonKey(name: 'abandon_at')
  final int? abandonAt;

  @override
  String toString() {
    if (kDebugMode) {
      return 'AuthenticationResponse('
          'object: $object, '
          'id: $id, '
          'status: $status, '
          'supportedIdentifiers: $supportedIdentifiers, '
          'supportedFirstFactors: $supportedFirstFactors, '
          'supportedSecondFactors: $supportedSecondFactors, '
          'firstFactorVerification: $firstFactorVerification, '
          'secondFactorVerification: $secondFactorVerification, '
          'identifier: $identifier, '
          'userData: $userData, '
          'createdSessionId: $createdSessionId, '
          'abandonAt: $abandonAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

  AuthenticationResponse copyWith({
    String? object,
    String? id,
    String? status,
    List<String>? supportedIdentifiers,
    dynamic supportedFirstFactors,
    dynamic supportedSecondFactors,
    FirstFactorVerificationResponse? firstFactorVerification,
    dynamic secondFactorVerification,
    String? identifier,
    dynamic userData,
    String? createdSessionId,
    int? abandonAt,
  }) {
    return AuthenticationResponse(
      object: object ?? this.object,
      id: id ?? this.id,
      status: status ?? this.status,
      supportedIdentifiers: supportedIdentifiers ?? this.supportedIdentifiers,
      supportedFirstFactors:
          supportedFirstFactors ?? this.supportedFirstFactors,
      supportedSecondFactors:
          supportedSecondFactors ?? this.supportedSecondFactors,
      firstFactorVerification:
          firstFactorVerification ?? this.firstFactorVerification,
      secondFactorVerification:
          secondFactorVerification ?? this.secondFactorVerification,
      identifier: identifier ?? this.identifier,
      userData: userData ?? this.userData,
      createdSessionId: createdSessionId ?? this.createdSessionId,
      abandonAt: abandonAt ?? this.abandonAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AuthenticationResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      object.hashCode ^
      id.hashCode ^
      status.hashCode ^
      supportedIdentifiers.hashCode ^
      supportedFirstFactors.hashCode ^
      supportedSecondFactors.hashCode ^
      firstFactorVerification.hashCode ^
      secondFactorVerification.hashCode ^
      identifier.hashCode ^
      userData.hashCode ^
      createdSessionId.hashCode ^
      abandonAt.hashCode;
}
