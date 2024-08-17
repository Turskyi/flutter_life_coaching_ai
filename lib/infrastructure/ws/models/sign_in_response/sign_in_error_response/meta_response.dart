import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'client.dart';

part 'meta.g.dart';

@JsonSerializable()
class Meta {
  final Client? client;

  const Meta({this.client});

  @override
  String toString() => 'Meta(client: $client)';

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  Meta copyWith({
    Client? client,
  }) {
    return Meta(
      client: client ?? this.client,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Meta) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => client.hashCode;
}
