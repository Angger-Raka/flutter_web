import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/datasources/datasources.dart';
import 'package:flutter_web/app/data/models/models.dart';
import 'package:flutter_web/constant.dart';

part 'add_order_bloc_event.dart';
part 'add_order_bloc_state.dart';

class AddOrderBloc extends Bloc<AddOrderBlocEvent, AddOrderBlocState> {
  AddOrderBloc(this.datasources) : super(AddOrderBlocInitial()) {
    on<AddOrderBlocEvent>((event, emit) {});
    on<AddOrderEvent>(addOrder);
  }

  final OrderDatasources datasources;

  Future<void> addOrder(
    AddOrderEvent event,
    Emitter<AddOrderBlocState> emit,
  ) async {
    emit(AddOrderBlocLoading());
    try {
      final response = await datasources.addOrder(RequestAddOrder(
        tanggalMasuk: event.tanggalMasuk,
        tanggalSelesai: event.tanggalSelesai,
        pengorder: event.pengorder,
        judul: event.judul,
        oplahSoftCover: event.oplahSoftCover,
        oplahHardCover: event.oplahHardCover,
        oplahCoverLidah: event.oplahCoverLidah,
        ukuran: event.ukuran,
        kertasIsi: event.kertasIsi,
        kertasCover: event.kertasCover,
        cetakIsi: event.cetakIsi,
        cetakCover: event.cetakCover,
        laminasiCover: event.laminasiCover,
        finishingCover: event.finishingCover,
        jenis: isOffset ? 'Offset' : 'POD',
      ));

      if (response) {
        emit(const AddOrderBlocSuccess('Order berhasil ditambahkan'));
      } else {
        emit(const AddOrderBlocFailure('Order gagal ditambahkan'));
      }
    } catch (e) {
      emit(AddOrderBlocFailure(e.toString()));
    }
  }
}
