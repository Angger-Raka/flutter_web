part of 'update_order_bloc.dart';

sealed class UpdateOrderEvent extends Equatable {
  const UpdateOrderEvent();

  @override
  List<Object> get props => [];
}

class UpdateOrder extends UpdateOrderEvent {
  final Order order;

  UpdateOrder(this.order);

  @override
  List<Object> get props => [order];
}
