import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'client.dart';
import 'response.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  final Response? response;
  final Client? client;

  const SignUpResponse({this.response, this.client});

  @override
  String toString() {
    return 'SignUpResponse(response: $response, client: $client)';
  }

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return _$SignUpResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);

  SignUpResponse copyWith({
    Response? response,
    Client? client,
  }) {
    return SignUpResponse(
      response: response ?? this.response,
      client: client ?? this.client,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignUpResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => response.hashCode ^ client.hashCode;
}
