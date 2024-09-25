import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../datasources/order_datasources.dart';
import '../../models/models.dart';

part 'update_order_event.dart';
part 'update_order_state.dart';

class UpdateOrderBloc extends Bloc<UpdateOrderEvent, UpdateOrderState> {
  UpdateOrderBloc(
    this.datasources,
  ) : super(UpdateOrderInitial()) {
    on<UpdateOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateOrder>(_update);
  }

  final OrderDatasources datasources;

  Future<void> _update(
    UpdateOrder event,
    Emitter<UpdateOrderState> emit,
  ) async {
    emit(UpdateOrderLoading());
    try {
      final result = await datasources.updateOrder(
        event.order.id.toString(),
        event.order,
      );

      if (result) {
        emit(UpdateOrderSuccess());
      } else {
        emit(UpdateOrderFailure());
      }
    } catch (e) {
      emit(UpdateOrderFailure());
    }
  }
}
