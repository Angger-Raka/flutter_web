part of 'selection_bloc.dart';

sealed class SelectionState extends Equatable {
  const SelectionState();

  @override
  List<Object> get props => [];
}

final class SelectionInitial extends SelectionState {}

class SelectionPOD extends SelectionState {}

class SelectionOffset extends SelectionState {}
