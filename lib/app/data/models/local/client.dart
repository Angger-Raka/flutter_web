import 'dart:convert';

import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final List<int>? orders;

  const Client({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.orders,
  });

  factory Client.fromMap(Map<String, dynamic> data) => Client(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        address: data['address'] as String?,
        orders: data['orders'] != null
            ? List<int>.from(data['orders'] as List<dynamic>)
            : [],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'orders': orders,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Client].
  factory Client.fromJson(String data) {
    return Client.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Client] to a JSON string.
  String toJson() => json.encode(toMap());

  Client copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    List<int>? orders,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        address,
        orders,
      ];
}
