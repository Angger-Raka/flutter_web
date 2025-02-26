part of 'printer_bloc.dart';

sealed class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class AddPrinter extends PrinterEvent {
  final Printer printer;
  final bool isOffset;

  AddPrinter(
    this.printer, {
    this.isOffset = false,
  });

  @override
  List<Object> get props => [printer, isOffset];
}

class UpdatePrinter extends PrinterEvent {
  final Printer printer;

  const UpdatePrinter(this.printer);

  @override
  List<Object> get props => [printer];
}

class DeletePrinter extends PrinterEvent {
  final Printer printer;

  const DeletePrinter(this.printer);

  @override
  List<Object> get props => [printer];
}
