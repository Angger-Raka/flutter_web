import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

part 'step_event.dart';
part 'step_state.dart';

class StepBloc extends Bloc<StepEvent, StepsState> {
  StepBloc({
    required this.datasources,
  }) : super(StepInitial()) {
    on<StepEvent>((event, emit) {});
    on<UpdateStep>(_update);
  }

  final StepDatasources datasources;

  Future<void> _update(
    UpdateStep event,
    Emitter<StepsState> emit,
  ) async {
    emit(StepLoading());
    try {
      final result = await datasources.updateStep(
        event.id,
        event.status,
      );

      if (result) {
        emit(StepSuccess('Step berhasil diupdate'));
      } else {
        emit(StepFailure('Step gagal diupdate'));
      }
    } catch (e) {
      emit(StepFailure('Terjadi kesalahan pada $e'));
    }
  }
}
