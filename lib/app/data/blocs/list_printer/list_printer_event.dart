part of 'list_printer_bloc.dart';

sealed class ListPrinterEvent extends Equatable {
  const ListPrinterEvent();

  @override
  List<Object> get props => [];
}

class GetAllPrinter extends ListPrinterEvent {
  final bool isOffset;

  GetAllPrinter(
    this.isOffset,
  );

  @override
  List<Object> get props => [isOffset];
}
