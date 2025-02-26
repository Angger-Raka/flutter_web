part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrder extends OrderEvent {
  final Order order;
  final String clientId;
  final bool isOffset;

  const AddOrder(
    this.order,
    this.clientId,
    this.isOffset,
  );

  @override
  List<Object> get props => [
        order,
        clientId,
        isOffset,
      ];
}

class UpdateOrder extends OrderEvent {
  final Order order;
  final int clientId;

  const UpdateOrder(
    this.order,
    this.clientId,
  );

  @override
  List<Object> get props => [
        order,
        clientId,
      ];
}

class DeleteOrder extends OrderEvent {
  final Order order;

  const DeleteOrder(this.order);

  @override
  List<Object> get props => [order];
}
