part of 'get_client_bloc.dart';

sealed class GetClientEvent extends Equatable {
  const GetClientEvent();

  @override
  List<Object> get props => [];
}

class GetClient extends GetClientEvent {
  final int clientId;

  GetClient(this.clientId);

  @override
  List<Object> get props => [clientId];
}
