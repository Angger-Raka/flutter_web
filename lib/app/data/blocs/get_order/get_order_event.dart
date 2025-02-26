part of 'get_order_bloc.dart';

sealed class GetOrderEvent extends Equatable {
  const GetOrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrder extends GetOrderEvent {
  final String orderId;
  final bool isOffset;

  GetOrder(this.orderId, {this.isOffset = false});

  @override
  List<Object> get props => [
        orderId,
        isOffset,
      ];
}
