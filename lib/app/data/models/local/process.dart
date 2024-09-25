import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'step.dart';

class Process extends Equatable {
  final int? id;
  final String? namaProses;
  final String? statusProses;
  final List<Step>? steps;

  const Process({
    this.id,
    this.namaProses,
    this.statusProses,
    this.steps = const [],
  });

  factory Process.fromMap(Map<String, dynamic> data) => Process(
        id: data['id'] as int?,
        namaProses: data['nama_proses'] as String?,
        statusProses: data['status_proses'] as String?,
        steps: data['steps'] == null
            ? null
            : List<Step>.from(data['steps'].map((x) => Step.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_proses': namaProses,
        'status_proses': statusProses,
        'steps': steps?.map((x) => x.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Process].
  factory Process.fromJson(String data) {
    return Process.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Process] to a JSON string.
  String toJson() => json.encode(toMap());

  Process copyWith({
    int? id,
    String? namaProses,
    String? statusProses,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    List<Step>? steps,
  }) {
    return Process(
      id: id ?? this.id,
      namaProses: namaProses ?? this.namaProses,
      statusProses: statusProses ?? this.statusProses,
      steps: steps ?? this.steps,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      namaProses,
      statusProses,
      steps,
    ];
  }
}
