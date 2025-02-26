part of 'list_client_bloc.dart';

sealed class ListClientEvent extends Equatable {
  const ListClientEvent();

  @override
  List<Object> get props => [];
}

class GetAllClient extends ListClientEvent {
  const GetAllClient(this.isOffset);

  final bool isOffset;

  @override
  List<Object> get props => [isOffset];
}
