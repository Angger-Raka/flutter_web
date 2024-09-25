part of 'update_step_bloc.dart';

sealed class UpdateStepEvent extends Equatable {
  const UpdateStepEvent();

  @override
  List<Object> get props => [];
}

class UpdateStep extends UpdateStepEvent {
  final String id;
  final String status;

  UpdateStep({
    required this.id,
    required this.status,
  });

  @override
  List<Object> get props => [id, status];
}
