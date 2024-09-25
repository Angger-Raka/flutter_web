import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  const Pagination({this.page, this.pageSize, this.pageCount, this.total});

  factory Pagination.fromMap(Map<String, dynamic> data) => Pagination(
        page: data['page'] as int?,
        pageSize: data['pageSize'] as int?,
        pageCount: data['pageCount'] as int?,
        total: data['total'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'page': page,
        'pageSize': pageSize,
        'pageCount': pageCount,
        'total': total,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pagination].
  factory Pagination.fromJson(String data) {
    return Pagination.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pagination] to a JSON string.
  String toJson() => json.encode(toMap());

  Pagination copyWith({
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
  }) {
    return Pagination(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      pageCount: pageCount ?? this.pageCount,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [page, pageSize, pageCount, total];
}
