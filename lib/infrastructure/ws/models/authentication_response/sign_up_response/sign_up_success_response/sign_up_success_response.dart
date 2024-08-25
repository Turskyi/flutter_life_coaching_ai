import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/client_response.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/sign_up_form_response.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/sign_up_response/sign_up_response.dart';

part 'sign_up_success_response.g.dart';

@JsonSerializable()
class SignUpSuccessResponse implements SignUpResponse {
  const SignUpSuccessResponse({this.response, this.client});

  factory SignUpSuccessResponse.fromJson(Map<String, dynamic> json) {
    return _$SignUpSuccessResponseFromJson(json);
  }

  final SignUpFormResponse? response;
  final ClientResponse? client;

  @override
  String get id => response?.id ?? '';

  @override
  String toString() {
    if (kDebugMode) {
      return 'SignUpResponse(response: $response, client: $client)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$SignUpSuccessResponseToJson(this);

  SignUpSuccessResponse copyWith({
    SignUpFormResponse? response,
    ClientResponse? client,
  }) {
    return SignUpSuccessResponse(
      response: response ?? this.response,
      client: client ?? this.client,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignUpSuccessResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => response.hashCode ^ client.hashCode;
}
