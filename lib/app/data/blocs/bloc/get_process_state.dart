part of 'get_process_bloc.dart';

sealed class GetProcessState extends Equatable {
  const GetProcessState();

  @override
  List<Object> get props => [];
}

final class GetProcessInitial extends GetProcessState {}

final class GetProcessLoading extends GetProcessState {}

final class GetProcessSuccess extends GetProcessState {
  final Process process;

  GetProcessSuccess(this.process);

  @override
  List<Object> get props => [process];
}

final class GetProcessFailure extends GetProcessState {
  final String message;

  GetProcessFailure(this.message);

  @override
  List<Object> get props => [message];
}
