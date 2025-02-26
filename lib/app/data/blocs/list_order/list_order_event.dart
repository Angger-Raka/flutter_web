part of 'list_order_bloc.dart';

sealed class ListOrderEvent extends Equatable {
  const ListOrderEvent();

  @override
  List<Object> get props => [];
}

class GetAllOrder extends ListOrderEvent {
  const GetAllOrder(
    this.isOffset,
  );

  final bool isOffset;

  @override
  List<Object> get props => [isOffset];
}
