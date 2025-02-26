import 'dart:convert';

import 'package:equatable/equatable.dart';

class Stage extends Equatable {
  final int? id;
  final String? namaStep;
  String? statusStep;

  Stage({
    this.id,
    this.namaStep,
    this.statusStep,
  });

  factory Stage.fromMap(Map<String, dynamic> data) => Stage(
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
  factory Stage.fromJson(String data) {
    return Stage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Step] to a JSON string.
  String toJson() => json.encode(toMap());

  Stage copyWith({
    int? id,
    String? namaStep,
    String? statusStep,
  }) {
    return Stage(
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
