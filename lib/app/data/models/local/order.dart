import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

import 'process.dart';

class Order extends Equatable {
  final int? id;
  final int? idClient;
  final String? tanggalMasuk;
  final String? tanggalSelesai;
  final dynamic judul;
  final String? pengorder;
  final String? oplahSoftCover;
  final String? oplahHardCover;
  final String? oplahCoverLidah;
  final String? ukuran;
  final String? kertasCover;
  final String? kertasIsi;
  final String? cetakIsi;
  final String? cetakCover;
  final String? laminasiCover;
  final String? finishingCover;
  final String? phoneNumber;
  final bool? isActive;
  final List<Process>? processes;
  final Client? client;

  const Order({
    this.id,
    this.idClient,
    this.tanggalMasuk,
    this.tanggalSelesai,
    this.judul,
    this.pengorder,
    this.oplahSoftCover,
    this.oplahHardCover,
    this.oplahCoverLidah,
    this.ukuran,
    this.kertasCover,
    this.kertasIsi,
    this.cetakIsi,
    this.cetakCover,
    this.laminasiCover,
    this.finishingCover,
    this.phoneNumber,
    this.isActive,
    this.processes = const [],
    this.client,
  });

  factory Order.fromMap(Map<String, dynamic> data) => Order(
        id: data['id'] as int?,
        idClient: data['id_client'] as int?,
        tanggalMasuk: data['tanggal_masuk'] as String?,
        tanggalSelesai: data['tanggal_selesai'] as String?,
        judul: data['Judul'] as dynamic,
        pengorder: data['pengorder'] as String?,
        oplahSoftCover: data['oplah_soft_cover'] as String?,
        oplahHardCover: data['oplah_hard_cover'] as String?,
        oplahCoverLidah: data['oplah_cover_lidah'] as String?,
        ukuran: data['ukuran'] as String?,
        kertasCover: data['kertas_cover'] as String?,
        kertasIsi: data['kertas_isi'] as String?,
        cetakIsi: data['cetak_isi'] as String?,
        cetakCover: data['cetak_cover'] as String?,
        laminasiCover: data['laminasi_cover'] as String?,
        finishingCover: data['finishing_cover'] as String?,
        phoneNumber: data['phone_number'] as String?,
        processes: data['processes'] == null
            ? []
            : List<Process>.from(
                data['processes'].map((x) => Process.fromMap(x)),
              ),
        isActive: data['is_active'] as bool?,
        client: data['client'] == null
            ? null
            : Client.fromMap(data['client'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        // 'id': id,
        'tanggal_masuk': tanggalMasuk,
        'tanggal_selesai': tanggalSelesai,
        'Judul': judul,
        'pengorder': pengorder,
        'oplah_soft_cover': oplahSoftCover,
        'oplah_hard_cover': oplahHardCover,
        'oplah_cover_lidah': oplahCoverLidah,
        'ukuran': ukuran,
        'kertas_cover': kertasCover,
        'kertas_isi': kertasIsi,
        'cetak_isi': cetakIsi,
        'cetak_cover': cetakCover,
        'laminasi_cover': laminasiCover,
        'finishing_cover': finishingCover,
        'phone_number': phoneNumber,
        'processes': processes?.map((x) => x.toMap()).toList(),
        'is_active': isActive,
        'client': client?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());

  Order copyWith({
    int? id,
    String? tanggalMasuk,
    String? tanggalSelesai,
    dynamic judul,
    String? pengorder,
    String? oplahSoftCover,
    String? oplahHardCover,
    String? oplahCoverLidah,
    String? ukuran,
    String? kertasCover,
    String? kertasIsi,
    String? cetakIsi,
    String? cetakCover,
    String? laminasiCover,
    String? finishingCover,
    String? phoneNumber,
    List<Process>? processes,
    bool? isActive,
    Client? client,
  }) {
    return Order(
      id: id ?? this.id,
      tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
      tanggalSelesai: tanggalSelesai ?? this.tanggalSelesai,
      judul: judul ?? this.judul,
      pengorder: pengorder ?? this.pengorder,
      oplahSoftCover: oplahSoftCover ?? this.oplahSoftCover,
      oplahHardCover: oplahHardCover ?? this.oplahHardCover,
      oplahCoverLidah: oplahCoverLidah ?? this.oplahCoverLidah,
      ukuran: ukuran ?? this.ukuran,
      kertasCover: kertasCover ?? this.kertasCover,
      kertasIsi: kertasIsi ?? this.kertasIsi,
      cetakIsi: cetakIsi ?? this.cetakIsi,
      cetakCover: cetakCover ?? this.cetakCover,
      laminasiCover: laminasiCover ?? this.laminasiCover,
      finishingCover: finishingCover ?? this.finishingCover,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      processes: processes ?? this.processes,
      isActive: isActive ?? this.isActive,
      client: client ?? this.client,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      tanggalMasuk,
      tanggalSelesai,
      judul,
      pengorder,
      oplahSoftCover,
      oplahHardCover,
      oplahCoverLidah,
      ukuran,
      kertasCover,
      kertasIsi,
      cetakIsi,
      cetakCover,
      laminasiCover,
      finishingCover,
      phoneNumber,
      processes,
      isActive,
      client,
    ];
  }
}
