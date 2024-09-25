part of 'add_order_bloc_bloc.dart';

sealed class AddOrderBlocState extends Equatable {
  const AddOrderBlocState();

  @override
  List<Object> get props => [];
}

final class AddOrderBlocInitial extends AddOrderBlocState {}

final class AddOrderBlocLoading extends AddOrderBlocState {}

final class AddOrderBlocSuccess extends AddOrderBlocState {
  final String message;

  const AddOrderBlocSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AddOrderBlocFailure extends AddOrderBlocState {
  final String message;

  const AddOrderBlocFailure(this.message);

  @override
  List<Object> get props => [message];
}
