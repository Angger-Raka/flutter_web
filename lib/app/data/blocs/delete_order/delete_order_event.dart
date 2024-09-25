part of 'delete_order_bloc.dart';

sealed class DeleteOrderEvent extends Equatable {
  const DeleteOrderEvent();

  @override
  List<Object> get props => [];
}

class DeleteOrder extends DeleteOrderEvent {
  const DeleteOrder(this.order);

  final Order order;

  @override
  List<Object> get props => [order];
}
