import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attributes.dart';

class Datum extends Equatable {
  final int? id;
  final Attributes? attributes;

  const Datum({this.id, this.attributes});

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        id: data['id'] as int?,
        attributes: data['attributes'] == null
            ? null
            : Attributes.fromMap(data['attributes'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'attributes': attributes?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    int? id,
    Attributes? attributes,
  }) {
    return Datum(
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props => [id, attributes];
}
