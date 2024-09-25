import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../datasources/datasources.dart';
import '../../models/models.dart';

part 'update_step_event.dart';
part 'update_step_state.dart';

class UpdateStepBloc extends Bloc<UpdateStepEvent, UpdateStepState> {
  UpdateStepBloc(
    this.datasources,
  ) : super(UpdateStepInitial()) {
    on<UpdateStepEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateStep>(_update);
  }

  final StepDatasources datasources;

  Future<void> _update(
    UpdateStep event,
    Emitter<UpdateStepState> emit,
  ) async {
    emit(UpdateStepLoading());
    try {
      final result = await datasources.updateStep(
        event.id,
        event.status,
      );

      if (result) {
        emit(UpdateStepSuccess());
      } else {
        emit(UpdateStepFailure());
      }
    } catch (e) {
      emit(UpdateStepFailure());
    }
  }
}
