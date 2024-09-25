part of 'delete_order_bloc.dart';

sealed class DeleteOrderState extends Equatable {
  const DeleteOrderState();

  @override
  List<Object> get props => [];
}

final class DeleteOrderInitial extends DeleteOrderState {}

final class DeleteOrderLoading extends DeleteOrderState {}

final class DeleteOrderSuccess extends DeleteOrderState {}

final class DeleteOrderFailed extends DeleteOrderState {
  const DeleteOrderFailed(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
