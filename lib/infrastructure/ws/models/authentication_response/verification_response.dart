import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'verification_response.g.dart';

@JsonSerializable()
class VerificationResponse implements Verification {
  const VerificationResponse({
    this.status,
    this.strategy,
    this.attempts,
    this.expireAt,
    this.nextAction,
    this.supportedStrategies,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$VerificationResponseFromJson(json);
  }

  final String? status;
  final String? strategy;
  final int? attempts;
  @JsonKey(name: 'expire_at')
  final int? expireAt;
  @JsonKey(name: 'next_action')
  final String? nextAction;
  @JsonKey(name: 'supported_strategies')
  final List<String>? supportedStrategies;

  @override
  String toString() {
    if (kDebugMode) {
      return 'VerificationResponse('
          'status: $status, '
          'strategy: $strategy, '
          'attempts: $attempts, '
          'expireAt: $expireAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$VerificationResponseToJson(this);

  VerificationResponse copyWith({
    String? status,
    String? strategy,
    int? attempts,
    int? expireAt,
  }) {
    return VerificationResponse(
      status: status ?? this.status,
      strategy: strategy ?? this.strategy,
      attempts: attempts ?? this.attempts,
      expireAt: expireAt ?? this.expireAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VerificationResponse) return false;
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
