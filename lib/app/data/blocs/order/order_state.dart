part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String message;

  const OrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OrderFailure extends OrderState {
  final String message;

  const OrderFailure(this.message);

  @override
  List<Object> get props => [message];
}
