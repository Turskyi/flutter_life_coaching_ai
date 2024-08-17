import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_active_token_response.g.dart';

@JsonSerializable()
class LastActiveTokenResponse {
  const LastActiveTokenResponse({this.object, this.jwt});

  factory LastActiveTokenResponse.fromJson(Map<String, dynamic> json) {
    return _$LastActiveTokenResponseFromJson(json);
  }

  final String? object;
  final String? jwt;

  @override
  String toString() => 'LastActiveTokenResponse(object: $object, jwt: $jwt)';

  Map<String, dynamic> toJson() => _$LastActiveTokenResponseToJson(this);

  LastActiveTokenResponse copyWith({
    String? object,
    String? jwt,
  }) {
    return LastActiveTokenResponse(
      object: object ?? this.object,
      jwt: jwt ?? this.jwt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LastActiveTokenResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => object.hashCode ^ jwt.hashCode;
}
