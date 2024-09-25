part of 'update_step_bloc.dart';

sealed class UpdateStepState extends Equatable {
  const UpdateStepState();

  @override
  List<Object> get props => [];
}

final class UpdateStepInitial extends UpdateStepState {}

final class UpdateStepLoading extends UpdateStepState {}

final class UpdateStepSuccess extends UpdateStepState {}

final class UpdateStepFailure extends UpdateStepState {}
