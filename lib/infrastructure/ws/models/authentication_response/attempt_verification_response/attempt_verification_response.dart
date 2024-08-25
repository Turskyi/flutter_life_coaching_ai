import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'client.dart';
import 'response.dart';

part 'attempt_verification_response.g.dart';

@JsonSerializable()
class AttemptVerificationResponse {
  const AttemptVerificationResponse({this.response, this.client});

  factory AttemptVerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$AttemptVerificationResponseFromJson(json);
  }

  final Response? response;
  final Client? client;

  @override
  String toString() {
    return 'AttemptVerificationResponse(response: $response, client: $client)';
  }

  Map<String, dynamic> toJson() => _$AttemptVerificationResponseToJson(this);

  AttemptVerificationResponse copyWith({
    Response? response,
    Client? client,
  }) {
    return AttemptVerificationResponse(
      response: response ?? this.response,
      client: client ?? this.client,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AttemptVerificationResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => response.hashCode ^ client.hashCode;
}
