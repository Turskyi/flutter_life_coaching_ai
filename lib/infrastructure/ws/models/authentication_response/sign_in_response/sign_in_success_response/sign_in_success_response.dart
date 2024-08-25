import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/sign_in_response/client_response.dart';
import 'package:lifecoach/infrastructure/ws/models/sign_in_response/sign_in_response.dart';

import 'authentication_response.dart';

part 'sign_in_success_response.g.dart';

@JsonSerializable()
class SignInSuccessResponse implements SignInResponse {
  const SignInSuccessResponse({
    this.clientResponse,
    this.authenticationResponse,
  });

  factory SignInSuccessResponse.fromJson(Map<String, dynamic> json) {
    return _$SignInSuccessResponseFromJson(json);
  }

  @JsonKey(name: 'response')
  final AuthenticationResponse? authenticationResponse;
  @JsonKey(name: 'client')
  final ClientResponse? clientResponse;

  @override
  String get token =>
      clientResponse?.sessions.firstOrNull?.lastActiveToken?.jwt ?? '';

  @override
  String toString() {
    if (kDebugMode) {
      return 'SignInSuccessResponse('
          'response: $authenticationResponse, '
          'clientResponse: $clientResponse)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$SignInSuccessResponseToJson(this);

  SignInSuccessResponse copyWith({
    AuthenticationResponse? authenticationResponse,
    ClientResponse? clientResponse,
  }) {
    return SignInSuccessResponse(
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
      clientResponse: clientResponse ?? this.clientResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignInSuccessResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => authenticationResponse.hashCode ^ clientResponse.hashCode;
}
