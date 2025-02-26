part of 'step_bloc.dart';

sealed class StepEvent extends Equatable {
  const StepEvent();

  @override
  List<Object> get props => [];
}

class UpdateStep extends StepEvent {
  final String id;
  final String status;

  UpdateStep({
    required this.id,
    required this.status,
  });

  @override
  List<Object> get props => [id, status];
}
