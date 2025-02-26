part of 'get_order_bloc.dart';

sealed class GetOrderState extends Equatable {
  const GetOrderState();

  @override
  List<Object> get props => [];
}

final class GetOrderInitial extends GetOrderState {}

final class GetOrderLoading extends GetOrderState {}

final class GetOrderSuccess extends GetOrderState {
  final Order order;

  GetOrderSuccess(this.order);

  @override
  List<Object> get props => [order];
}

final class GetOrderFailure extends GetOrderState {
  final String message;

  GetOrderFailure(this.message);

  @override
  List<Object> get props => [message];
}
