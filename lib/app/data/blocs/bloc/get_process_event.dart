part of 'get_process_bloc.dart';

sealed class GetProcessEvent extends Equatable {
  const GetProcessEvent();

  @override
  List<Object> get props => [];
}

class GetProcess extends GetProcessEvent {
  final int processId;

  GetProcess(this.processId);

  @override
  List<Object> get props => [processId];
}
