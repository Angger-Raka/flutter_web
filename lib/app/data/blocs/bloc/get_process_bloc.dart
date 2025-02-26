import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data.dart';

part 'get_process_event.dart';
part 'get_process_state.dart';

class GetProcessBloc extends Bloc<GetProcessEvent, GetProcessState> {
  GetProcessBloc(
    this.datasources,
  ) : super(GetProcessInitial()) {
    on<GetProcessEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetProcess>(_getProcess);
  }

  final ProcessDatasources datasources;

  Future<void> _getProcess(
    GetProcess event,
    Emitter<GetProcessState> emit,
  ) async {
    emit(GetProcessLoading());
    try {
      final process = await datasources.getProcessById(
        event.processId.toString(),
      );
      emit(GetProcessSuccess(process));
    } catch (e) {
      emit(GetProcessFailure(e.toString()));
    }
  }
}
