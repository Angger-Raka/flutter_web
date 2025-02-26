import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

class Printer extends Equatable {
  final int? id;
  final String? name;
  final List<Order>? orders;

  const Printer({
    this.id,
    this.name,
    this.orders,
  });

  factory Printer.fromMap(Map<String, dynamic> data) => Printer(
        id: data['id'] as int?,
        name: data['name'] as String?,
        orders: data['orders'] != null
            ? List<Order>.from(data['orders'] as List<dynamic>)
            : [],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'orders': orders,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Printer].
  factory Printer.fromJson(String data) {
    return Printer.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Printer] to a JSON string.
  String toJson() => json.encode(toMap());

  Printer copyWith({
    int? id,
    String? name,
    List<Order>? orders,
  }) {
    return Printer(
      id: id ?? this.id,
      name: name ?? this.name,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        orders,
      ];
}
