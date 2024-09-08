import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/client_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_form_response.dart';

part 'attempt_verification_response.g.dart';

@JsonSerializable()
class AttemptVerificationResponse {
  const AttemptVerificationResponse({
    this.signUpFormResponse,
    this.clientResponse,
  });

  factory AttemptVerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$AttemptVerificationResponseFromJson(json);
  }

  @JsonKey(name: 'response')
  final SignUpFormResponse? signUpFormResponse;
  @JsonKey(name: 'client')
  final ClientResponse? clientResponse;

  @override
  String toString() {
    if (kDebugMode) {
      return 'AttemptVerificationResponse('
          'response: $signUpFormResponse, '
          'client: $clientResponse)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$AttemptVerificationResponseToJson(this);

  AttemptVerificationResponse copyWith({
    SignUpFormResponse? signUpFormResponse,
    ClientResponse? clientResponse,
  }) =>
      AttemptVerificationResponse(
        signUpFormResponse: signUpFormResponse ?? this.signUpFormResponse,
        clientResponse: clientResponse ?? this.clientResponse,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AttemptVerificationResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => signUpFormResponse.hashCode ^ clientResponse.hashCode;
}
