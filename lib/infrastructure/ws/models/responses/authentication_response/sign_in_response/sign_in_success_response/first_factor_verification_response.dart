import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'first_factor_verification_response.g.dart';

@JsonSerializable()
class FirstFactorVerificationResponse {
  const FirstFactorVerificationResponse({
    this.status,
    this.strategy,
    this.attempts,
    this.expireAt,
  });

  factory FirstFactorVerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$FirstFactorVerificationResponseFromJson(json);
  }

  final String? status;
  final String? strategy;
  final int? attempts;
  @JsonKey(name: 'expire_at')
  final dynamic expireAt;

  @override
  String toString() {
    if (kDebugMode) {
      return 'FirstFactorVerificationResponse('
          'status: $status, '
          'strategy: $strategy, '
          'attempts: $attempts, '
          'expireAt: $expireAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() =>
      _$FirstFactorVerificationResponseToJson(this);

  FirstFactorVerificationResponse copyWith({
    String? status,
    String? strategy,
    int? attempts,
    dynamic expireAt,
  }) {
    return FirstFactorVerificationResponse(
      status: status ?? this.status,
      strategy: strategy ?? this.strategy,
      attempts: attempts ?? this.attempts,
      expireAt: expireAt ?? this.expireAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FirstFactorVerificationResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      status.hashCode ^
      strategy.hashCode ^
      attempts.hashCode ^
      expireAt.hashCode;
}
