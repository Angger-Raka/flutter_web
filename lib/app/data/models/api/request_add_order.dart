import 'dart:convert';

import 'package:equatable/equatable.dart';

class RequestAddOrder extends Equatable {
  final String? tanggalMasuk;
  final String? tanggalSelesai;
  final String? pengorder;
  final String? judul;
  final String? oplahSoftCover;
  final String? oplahHardCover;
  final String? oplahCoverLidah;
  final String? ukuran;
  final String? kertasIsi;
  final String? kertasCover;
  final String? cetakIsi;
  final String? cetakCover;
  final String? laminasiCover;
  final String? finishingCover;
  final String? jenis;
  final String? phoneNumber;
  final String? client;
  final bool? isActive;

  const RequestAddOrder({
    this.tanggalMasuk,
    this.tanggalSelesai,
    this.pengorder,
    this.judul,
    this.oplahSoftCover,
    this.oplahHardCover,
    this.oplahCoverLidah,
    this.ukuran,
    this.kertasIsi,
    this.kertasCover,
    this.cetakIsi,
    this.cetakCover,
    this.laminasiCover,
    this.finishingCover,
    this.jenis,
    this.phoneNumber,
    this.client,
    this.isActive,
  });

  factory RequestAddOrder.fromMap(Map<String, dynamic> data) {
    return RequestAddOrder(
      tanggalMasuk: data['tanggal_masuk'] as String?,
      tanggalSelesai: data['tanggal_selesai'] as String?,
      pengorder: data['pengorder'] as String?,
      judul: data['judul'] as String?,
      oplahSoftCover: data['oplah_soft_cover'] as String?,
      oplahHardCover: data['oplah_hard_cover'] as String?,
      oplahCoverLidah: data['oplah_cover_lidah'] as String?,
      ukuran: data['ukuran'] as String?,
      kertasIsi: data['kertas_isi'] as String?,
      kertasCover: data['kertas_cover'] as String?,
      cetakIsi: data['cetak_isi'] as String?,
      cetakCover: data['cetak_cover'] as String?,
      laminasiCover: data['laminasi_cover'] as String?,
      finishingCover: data['finishing_cover'] as String?,
      jenis: data['jenis'] as String?,
      phoneNumber: data['phone_number'] as String?,
      client: data['client'] as String?,
      isActive: data['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'tanggal_masuk': tanggalMasuk,
        'tanggal_selesai': tanggalSelesai,
        'pengorder': pengorder,
        'judul': judul,
        'oplah_soft_cover': oplahSoftCover,
        'oplah_hard_cover': oplahHardCover,
        'oplah_cover_lidah': oplahCoverLidah,
        'ukuran': ukuran,
        'kertas_isi': kertasIsi,
        'kertas_cover': kertasCover,
        'cetak_isi': cetakIsi,
        'cetak_cover': cetakCover,
        'laminasi_cover': laminasiCover,
        'finishing_cover': finishingCover,
        'jenis': jenis,
        'phone_number': phoneNumber,
        'client': client,
        'is_active': isActive,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RequestAddOrder].
  factory RequestAddOrder.fromJson(String data) {
    return RequestAddOrder.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RequestAddOrder] to a JSON string.
  String toJson() => json.encode(toMap());

  RequestAddOrder copyWith({
    String? tanggalMasuk,
    String? tanggalSelesai,
    String? pengorder,
    String? judul,
    String? oplahSoftCover,
    String? oplahHardCover,
    String? oplahCoverLidah,
    String? ukuran,
    String? kertasIsi,
    String? kertasCover,
    String? cetakIsi,
    String? cetakCover,
    String? laminasiCover,
    String? finishingCover,
    String? jenis,
    String? phoneNumber,
    String? client,
    bool? isActive,
  }) {
    return RequestAddOrder(
      tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
      tanggalSelesai: tanggalSelesai ?? this.tanggalSelesai,
      pengorder: pengorder ?? this.pengorder,
      judul: judul ?? this.judul,
      oplahSoftCover: oplahSoftCover ?? this.oplahSoftCover,
      oplahHardCover: oplahHardCover ?? this.oplahHardCover,
      oplahCoverLidah: oplahCoverLidah ?? this.oplahCoverLidah,
      ukuran: ukuran ?? this.ukuran,
      kertasIsi: kertasIsi ?? this.kertasIsi,
      kertasCover: kertasCover ?? this.kertasCover,
      cetakIsi: cetakIsi ?? this.cetakIsi,
      cetakCover: cetakCover ?? this.cetakCover,
      laminasiCover: laminasiCover ?? this.laminasiCover,
      finishingCover: finishingCover ?? this.finishingCover,
      jenis: jenis ?? this.jenis,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      client: client ?? this.client,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props {
    return [
      tanggalMasuk,
      tanggalSelesai,
      pengorder,
      judul,
      oplahSoftCover,
      oplahHardCover,
      oplahCoverLidah,
      ukuran,
      kertasIsi,
      kertasCover,
      cetakIsi,
      cetakCover,
      laminasiCover,
      finishingCover,
      jenis,
      phoneNumber,
      client,
      isActive,
    ];
  }
}
