import 'dart:convert';

import 'package:equatable/equatable.dart';

class Step extends Equatable {
  final int? id;
  final String? namaStep;
  final String? statusStep;

  const Step({
    this.id,
    this.namaStep,
    this.statusStep,
  });

  factory Step.fromMap(Map<String, dynamic> data) => Step(
        id: data['id'] as int?,
        namaStep: data['nama_step'] as String?,
        statusStep: data['status_step'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_step': namaStep,
        'status_step': statusStep,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Step].
  factory Step.fromJson(String data) {
    return Step.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Step] to a JSON string.
  String toJson() => json.encode(toMap());

  Step copyWith({
    int? id,
    String? namaStep,
    String? statusStep,
  }) {
    return Step(
      id: id ?? this.id,
      namaStep: namaStep ?? this.namaStep,
      statusStep: statusStep ?? this.statusStep,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      namaStep,
      statusStep,
    ];
  }
}
