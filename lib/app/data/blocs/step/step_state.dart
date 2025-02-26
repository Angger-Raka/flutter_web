part of 'step_bloc.dart';

sealed class StepsState extends Equatable {
  const StepsState();

  @override
  List<Object> get props => [];
}

final class StepInitial extends StepsState {}

final class StepLoading extends StepsState {}

final class StepSuccess extends StepsState {
  StepSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class StepFailure extends StepsState {
  StepFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
