import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

part 'get_order_event.dart';
part 'get_order_state.dart';

class GetOrderBloc extends Bloc<GetOrderEvent, GetOrderState> {
  GetOrderBloc(
    this.datasource,
  ) : super(GetOrderInitial()) {
    on<GetOrderEvent>((event, emit) {});
    on<GetOrder>(_getOrder);
  }

  final OrderDatasources datasource;

  Future<void> _getOrder(
    GetOrder event,
    Emitter<GetOrderState> emit,
  ) async {
    emit(GetOrderLoading());

    try {
      final result = await datasource.getOrder(
        orderId: event.orderId,
        isOffset: event.isOffset,
      );

      emit(GetOrderSuccess(result));
    } catch (e) {
      emit(GetOrderFailure(e.toString()));
    }
  }
}
