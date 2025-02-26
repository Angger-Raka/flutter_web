part of 'selection_bloc.dart';

sealed class SelectionEvent extends Equatable {
  const SelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectionChange extends SelectionEvent {
  const SelectionChange(this.selection);

  final Selection selection;

  @override
  List<Object> get props => [selection];
}
