import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/models/local/order.dart';

import '../../datasources/order_datasources.dart';
import '../../models/models.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  ListOrderBloc(
    this.datasource,
  ) : super(ListOrderInitial()) {
    on<ListOrderEvent>((event, emit) {});
    on<GetAllOrder>(getAll);
  }

  final OrderDatasources datasource;

  Future<void> getAll(
    GetAllOrder event,
    Emitter<ListOrderState> emit,
  ) async {
    emit(ListOrderLoading());

    try {
      final result = await datasource.getAllOrder(
        isOffset: event.isOffset,
      );

      emit(ListOrderSuccess(result));
    } catch (e) {
      emit(ListOrderFailure(e.toString()));
    }
  }
}
