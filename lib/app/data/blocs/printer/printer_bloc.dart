import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

import '../../models/models.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc(this.datasources) : super(PrinterInitial()) {
    on<PrinterEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddPrinter>(_add);
    on<UpdatePrinter>(_update);
    on<DeletePrinter>(_delete);
  }

  final PrinterDatasources datasources;

  Future<void> _add(
    AddPrinter event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterLoading());
    try {
      final response = await datasources.addPrinter(
        printer: event.printer,
        isOffset: event.isOffset,
      );

      if (response) {
        emit(const PrinterSuccess('Printer berhasil ditambahkan'));
      } else {
        emit(const PrinterFailure('Printer gagal ditambahkan'));
      }
    } catch (e) {
      emit(const PrinterFailure('Printer gagal ditambahkan'));
    }
  }

  Future<void> _update(
    UpdatePrinter event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterLoading());
    try {
      final response = await datasources.updatePrinter(
        printer: event.printer,
      );

      if (response) {
        emit(const PrinterSuccess('Printer berhasil diubah'));
      } else {
        emit(const PrinterFailure('Printer gagal diubah'));
      }
    } catch (e) {
      emit(const PrinterFailure('Printer gagal diubah'));
    }
  }

  Future<void> _delete(
    DeletePrinter event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterLoading());
    final printer = event.printer;
    try {
      final response = await datasources.deletePrinter(
        id: printer.id.toString(),
      );

      if (response) {
        emit(const PrinterSuccess('Printer berhasil dihapus'));
      } else {
        emit(const PrinterFailure('Printer gagal dihapus'));
      }
    } catch (e) {
      emit(const PrinterFailure('Printer gagal dihapus'));
    }
  }
}
