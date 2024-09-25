import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';
import 'meta.dart';

class Tessst extends Equatable {
  final List<Datum>? data;
  final Meta? meta;

  const Tessst({this.data, this.meta});

  factory Tessst.fromMap(Map<String, dynamic> data) => Tessst(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
        meta: data['meta'] == null
            ? null
            : Meta.fromMap(data['meta'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
        'meta': meta?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Tessst].
  factory Tessst.fromJson(String data) {
    return Tessst.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Tessst] to a JSON string.
  String toJson() => json.encode(toMap());

  Tessst copyWith({
    List<Datum>? data,
    Meta? meta,
  }) {
    return Tessst(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  @override
  List<Object?> get props => [data, meta];
}
