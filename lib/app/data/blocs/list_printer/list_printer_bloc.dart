import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../datasources/datasources.dart';
import '../../models/local/local.dart';

part 'list_printer_event.dart';
part 'list_printer_state.dart';

class ListPrinterBloc extends Bloc<ListPrinterEvent, ListPrinterState> {
  ListPrinterBloc(
    this.datasources,
  ) : super(ListPrinterInitial()) {
    on<ListPrinterEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllPrinter>(getAll);
  }

  final PrinterDatasources datasources;

  Future<void> getAll(
    GetAllPrinter event,
    Emitter<ListPrinterState> emit,
  ) async {
    emit(ListPrinterLoading());

    try {
      final result = await datasources.getAllPrinter(
        isOffset: event.isOffset,
      );

      emit(ListPrinterSuccess(result));
    } catch (e) {
      emit(ListPrinterFailure(e.toString()));
    }
  }
}
