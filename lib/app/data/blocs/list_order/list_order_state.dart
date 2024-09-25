part of 'list_order_bloc.dart';

sealed class ListOrderState extends Equatable {
  const ListOrderState();

  @override
  List<Object> get props => [];
}

final class ListOrderInitial extends ListOrderState {}

final class ListOrderLoading extends ListOrderState {}

final class ListOrderSuccess extends ListOrderState {
  final List<Order> data;

  ListOrderSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class ListOrderFailure extends ListOrderState {
  final String message;

  ListOrderFailure(this.message);

  @override
  List<Object> get props => [message];
}
