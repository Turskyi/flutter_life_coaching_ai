import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/sign_in_response/client_response.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  const MetaResponse({this.clientResponse});

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  @JsonKey(name: 'client')
  final ClientResponse? clientResponse;

  @override
  String toString() => 'MetaResponse(clientResponse: $clientResponse)';

  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);

  MetaResponse copyWith({
    ClientResponse? clientResponse,
  }) {
    return MetaResponse(
      clientResponse: clientResponse ?? this.clientResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MetaResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => clientResponse.hashCode;
}
