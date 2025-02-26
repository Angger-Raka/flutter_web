import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/core/core.dart';

part 'selection_event.dart';
part 'selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionInitial()) {
    on<SelectionEvent>((event, emit) {});
    on<SelectionChange>((event, emit) {
      if (event.selection == Selection.pod) {
        emit(SelectionPOD());
      } else if (event.selection == Selection.offset) {
        emit(SelectionOffset());
      }
    });
  }
}
