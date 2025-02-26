part of 'client_bloc.dart';

sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class AddClient extends ClientEvent {
  final Client client;
  final bool isOffset;

  AddClient({
    required this.client,
    required this.isOffset,
  });
}

class UpdateClient extends ClientEvent {
  final Client client;

  UpdateClient({
    required this.client,
  });
}

class DeleteClient extends ClientEvent {
  final String clientId;

  DeleteClient(
    this.clientId,
  );
}
