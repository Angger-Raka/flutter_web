import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class RequestUpdateOrder extends Equatable {
  final Data? data;

  const RequestUpdateOrder({this.data});

  factory RequestUpdateOrder.fromMap(Map<String, dynamic> data) {
    return RequestUpdateOrder(
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RequestUpdateOrder].
  factory RequestUpdateOrder.fromJson(String data) {
    return RequestUpdateOrder.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RequestUpdateOrder] to a JSON string.
  String toJson() => json.encode(toMap());

  RequestUpdateOrder copyWith({
    Data? data,
  }) {
    return RequestUpdateOrder(
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [data];
}
