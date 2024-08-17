import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'authentication_response.dart';
import 'client_response.dart';

part 'sign_in_response.g.dart';
part 'sign_in_error_response.g.dart';

@JsonSerializable()
class SignInResponse {
  const SignInResponse({required this.client, this.authenticationResponse});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('errors')) {
      return _$SignInErrorResponseFromJson(json);
    }
    return _$SignInResponseFromJson(json);
  }

  @JsonKey(name: 'response')
  final AuthenticationResponse? authenticationResponse;
  final ClientResponse client;

  @override
  String toString() {
    if (kDebugMode) {
      return 'SignInResponse('
          'response: $authenticationResponse, '
          'client: $client)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  SignInResponse copyWith({
    AuthenticationResponse? authenticationResponse,
    ClientResponse? client,
  }) {
    return SignInResponse(
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
      client: client ?? this.client,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignInResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => authenticationResponse.hashCode ^ client.hashCode;
}
