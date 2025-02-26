part of 'get_client_bloc.dart';

sealed class GetClientState extends Equatable {
  const GetClientState();

  @override
  List<Object> get props => [];
}

final class GetClientInitial extends GetClientState {}

final class GetClientLoading extends GetClientState {}

final class GetClientSuccess extends GetClientState {
  final Client client;

  GetClientSuccess(this.client);

  @override
  List<Object> get props => [client];
}

final class GetClientFailure extends GetClientState {
  final String message;

  GetClientFailure(this.message);

  @override
  List<Object> get props => [message];
}
