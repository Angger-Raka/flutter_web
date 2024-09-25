import 'dart:convert';

import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String? tanggalMasuk;
  final String? tanggalSelesai;
  final String? judul;
  final String? pengorder;
  final String? oplahSoftCover;
  final String? oplahHardCover;
  final String? oplahCoverLidah;
  final String? ukuran;
  final String? kertasCover;
  final String? kertasIsi;
  final String? cetakCover;
  final String? laminasiCover;
  final String? finishingCover;
  final List<String>? processes;
  final String? status;

  const Data({
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
    this.cetakCover,
    this.laminasiCover,
    this.finishingCover,
    this.processes,
    this.status,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        tanggalMasuk: data['tanggal_masuk'] as String?,
        tanggalSelesai: data['tanggal_selesai'] as String?,
        judul: data['Judul'] as String?,
        pengorder: data['pengorder'] as String?,
        oplahSoftCover: data['oplah_soft_cover'] as String?,
        oplahHardCover: data['oplah_hard_cover'] as String?,
        oplahCoverLidah: data['oplah_cover_lidah'] as String?,
        ukuran: data['ukuran'] as String?,
        kertasCover: data['kertas_cover'] as String?,
        kertasIsi: data['kertas_isi'] as String?,
        cetakCover: data['cetak_cover'] as String?,
        laminasiCover: data['laminasi_cover'] as String?,
        finishingCover: data['finishing_cover'] as String?,
        processes: data['processes'] as List<String>?,
        status: data['status'] as String?,
      );

  Map<String, dynamic> toMap() => {
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
        'cetak_cover': cetakCover,
        'laminasi_cover': laminasiCover,
        'finishing_cover': finishingCover,
        'processes': processes,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? tanggalMasuk,
    String? tanggalSelesai,
    String? judul,
    String? pengorder,
    String? oplahSoftCover,
    String? oplahHardCover,
    String? oplahCoverLidah,
    String? ukuran,
    String? kertasCover,
    String? kertasIsi,
    String? cetakCover,
    String? laminasiCover,
    String? finishingCover,
    List<String>? processes,
    String? status,
  }) {
    return Data(
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
      cetakCover: cetakCover ?? this.cetakCover,
      laminasiCover: laminasiCover ?? this.laminasiCover,
      finishingCover: finishingCover ?? this.finishingCover,
      processes: processes ?? this.processes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
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
      cetakCover,
      laminasiCover,
      finishingCover,
      processes,
      status,
    ];
  }
}
