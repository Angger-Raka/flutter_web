import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class Processes extends Equatable {
  final List<Datum>? data;

  const Processes({this.data});

  factory Processes.fromMap(Map<String, dynamic> data) => Processes(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Processes].
  factory Processes.fromJson(String data) {
    return Processes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Processes] to a JSON string.
  String toJson() => json.encode(toMap());

  Processes copyWith({
    List<Datum>? data,
  }) {
    return Processes(
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [data];
}
