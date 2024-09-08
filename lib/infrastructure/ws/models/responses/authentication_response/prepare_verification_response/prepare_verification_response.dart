import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/client_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_form_response.dart';
import 'package:models/models.dart';

part 'prepare_verification_response.g.dart';

@JsonSerializable()
class PrepareVerificationResponse implements CodeResponse {
  const PrepareVerificationResponse({
    this.signUpFormResponse,
    this.clientResponse,
  });

  factory PrepareVerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$PrepareVerificationResponseFromJson(json);
  }

  @JsonKey(name: 'response')
  final SignUpFormResponse? signUpFormResponse;
  @JsonKey(name: 'client')
  final ClientResponse? clientResponse;

  @override
  String toString() {
    if (kDebugMode) {
      return 'PrepareVerificationResponse('
          'response: $signUpFormResponse, '
          'client: $clientResponse)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$PrepareVerificationResponseToJson(this);

  PrepareVerificationResponse copyWith({
    SignUpFormResponse? signUpFormResponse,
    ClientResponse? clientResponse,
  }) {
    return PrepareVerificationResponse(
      signUpFormResponse: signUpFormResponse ?? this.signUpFormResponse,
      clientResponse: clientResponse ?? this.clientResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PrepareVerificationResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => signUpFormResponse.hashCode ^ clientResponse.hashCode;
}
