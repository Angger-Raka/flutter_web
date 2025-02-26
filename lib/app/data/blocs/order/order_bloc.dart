import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

import '../../models/local/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required this.orderDatasources,
    required this.processDatasources,
    required this.stepDatasources,
    required this.clientDatasources,
  }) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<AddOrder>(_add);
    on<UpdateOrder>(_update);
    on<DeleteOrder>(_delete);
  }

  final OrderDatasources orderDatasources;
  final ProcessDatasources processDatasources;
  final StepDatasources stepDatasources;
  final ClientDatasources clientDatasources;

  Future<void> _add(
    AddOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final response = await orderDatasources.addOrder(
        RequestAddOrder(
          tanggalMasuk: event.order.tanggalMasuk,
          tanggalSelesai: event.order.tanggalSelesai,
          pengorder: event.order.pengorder,
          judul: event.order.judul,
          oplahSoftCover: event.order.oplahSoftCover,
          oplahHardCover: event.order.oplahHardCover,
          oplahCoverLidah: event.order.oplahCoverLidah,
          ukuran: event.order.ukuran,
          kertasIsi: event.order.kertasIsi,
          kertasCover: event.order.kertasCover,
          cetakIsi: event.order.cetakIsi,
          cetakCover: event.order.cetakCover,
          laminasiCover: event.order.laminasiCover,
          finishingCover: event.order.finishingCover,
          jenis: event.isOffset ? 'Offset' : 'POD',
          phoneNumber: event.order.phoneNumber,
          client: event.clientId,
          isActive: event.order.isActive,
        ),
      );

      if (response) {
        emit(const OrderSuccess('Order berhasil ditambahkan'));
      } else {
        emit(const OrderFailure('Order gagal ditambahkan'));
      }
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> _update(
    UpdateOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final result = await orderDatasources.updateOrder(
        id: event.order.id.toString(),
        order: event.order,
        clientId: event.clientId,
      );

      if (result) {
        emit(OrderSuccess('Order updated successfully'));
      } else {
        emit(OrderFailure('Failed to update order'));
      }
    } catch (e) {
      emit(OrderFailure('Failed to update order'));
    }
  }

  Future<void> _delete(
    DeleteOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final order = event.order;
    try {
      final resultOrder =
          await orderDatasources.deleteOrder(order.id.toString());

      event.order.processes?.forEach((processId) async {
        // processId.steps?.forEach((step) async {
        //   final resultStep =
        //       await stepDatasources.deleteStep(step.id.toString());
        //   if (!resultStep) {
        //     emit(OrderFailure('Failed to delete step'));
        //   }
        // });
        final resultProcess =
            await processDatasources.deleteProcess(processId.toString());
        if (!resultProcess) {
          emit(OrderFailure('Failed to delete process'));
        }
      });

      if (resultOrder) {
        emit(OrderSuccess('Order deleted successfully'));
      } else {
        emit(OrderFailure('Failed to delete order'));
      }
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
