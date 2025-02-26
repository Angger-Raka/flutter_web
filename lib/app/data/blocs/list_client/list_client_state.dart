part of 'list_client_bloc.dart';

sealed class ListClientState extends Equatable {
  const ListClientState();

  @override
  List<Object> get props => [];
}

final class ListClientInitial extends ListClientState {}

final class ListClientLoading extends ListClientState {}

final class ListClientSuccess extends ListClientState {
  final List<Client> clients;

  const ListClientSuccess(this.clients);

  @override
  List<Object> get props => [clients];
}

final class ListClientFailure extends ListClientState {
  final String message;

  const ListClientFailure(this.message);

  @override
  List<Object> get props => [message];
}
