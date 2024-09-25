import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

part 'delete_order_event.dart';
part 'delete_order_state.dart';

class DeleteOrderBloc extends Bloc<DeleteOrderEvent, DeleteOrderState> {
  DeleteOrderBloc(
    this.orderDatasources,
    this.processDatasources,
    this.stepDatasources,
  ) : super(DeleteOrderInitial()) {
    on<DeleteOrderEvent>((event, emit) {});
    on<DeleteOrder>(deleteOrder);
  }

  final OrderDatasources orderDatasources;
  final ProcessDatasources processDatasources;
  final StepDatasources stepDatasources;

  Future<void> deleteOrder(
    DeleteOrder event,
    Emitter<DeleteOrderState> emit,
  ) async {
    emit(DeleteOrderLoading());
    final order = event.order;
    try {
      final resultOrder =
          await orderDatasources.deleteOrder(order.id.toString());

      event.order.processes?.forEach((process) async {
        process.steps?.forEach((step) async {
          final resultStep =
              await stepDatasources.deleteStep(step.id.toString());
          if (!resultStep) {
            emit(DeleteOrderFailed('Failed to delete step'));
          }
        });
        final resultProcess =
            await processDatasources.deleteProcess(process.id.toString());
        if (!resultProcess) {
          emit(DeleteOrderFailed('Failed to delete process'));
        }
      });

      if (resultOrder) {
        emit(DeleteOrderSuccess());
      } else {
        emit(DeleteOrderFailed('Failed to delete order'));
      }
    } catch (e) {
      emit(DeleteOrderFailed(e.toString()));
    }
  }
}
