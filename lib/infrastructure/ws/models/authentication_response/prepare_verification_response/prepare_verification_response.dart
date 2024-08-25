import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'client.dart';
import 'response.dart';

part 'prepare_verification_response.g.dart';

@JsonSerializable()
class PrepareVerificationResponse {
  final Response? response;
  final Client? client;

  const PrepareVerificationResponse({this.response, this.client});

  @override
  String toString() {
    return 'PrepareVerificationResponse(response: $response, client: $client)';
  }

  factory PrepareVerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$PrepareVerificationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PrepareVerificationResponseToJson(this);

  PrepareVerificationResponse copyWith({
    Response? response,
    Client? client,
  }) {
    return PrepareVerificationResponse(
      response: response ?? this.response,
      client: client ?? this.client,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PrepareVerificationResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => response.hashCode ^ client.hashCode;
}
