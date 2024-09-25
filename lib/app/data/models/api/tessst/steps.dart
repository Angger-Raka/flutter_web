import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class Steps extends Equatable {
  final List<Datum>? data;

  const Steps({this.data});

  factory Steps.fromMap(Map<String, dynamic> data) => Steps(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Steps].
  factory Steps.fromJson(String data) {
    return Steps.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Steps] to a JSON string.
  String toJson() => json.encode(toMap());

  Steps copyWith({
    List<Datum>? data,
  }) {
    return Steps(
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [data];
}
