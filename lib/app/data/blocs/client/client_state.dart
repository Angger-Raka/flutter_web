part of 'client_bloc.dart';

sealed class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

final class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientSuccess extends ClientState {
  const ClientSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [];
}

class ClientFailure extends ClientState {
  const ClientFailure(this.message);

  final String message;

  @override
  List<Object> get props => [];
}
