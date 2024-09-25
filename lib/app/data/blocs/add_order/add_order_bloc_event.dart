part of 'add_order_bloc_bloc.dart';

sealed class AddOrderBlocEvent extends Equatable {
  const AddOrderBlocEvent();

  @override
  List<Object> get props => [];
}

class AddOrderEvent extends AddOrderBlocEvent {
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

  const AddOrderEvent({
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
  });

  @override
  List<Object> get props {
    return [
      tanggalMasuk!,
      tanggalSelesai!,
      pengorder!,
      judul!,
      oplahSoftCover!,
      oplahHardCover!,
      oplahCoverLidah!,
      ukuran!,
      kertasIsi!,
      kertasCover!,
      cetakIsi!,
      cetakCover!,
      laminasiCover!,
      finishingCover!,
    ];
  }
}
