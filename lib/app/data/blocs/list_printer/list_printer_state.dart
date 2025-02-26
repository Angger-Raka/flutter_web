part of 'list_printer_bloc.dart';

sealed class ListPrinterState extends Equatable {
  const ListPrinterState();

  @override
  List<Object> get props => [];
}

final class ListPrinterInitial extends ListPrinterState {}

final class ListPrinterLoading extends ListPrinterState {}

final class ListPrinterSuccess extends ListPrinterState {
  final List<Printer> printers;

  ListPrinterSuccess(this.printers);

  @override
  List<Object> get props => [printers];
}

final class ListPrinterFailure extends ListPrinterState {
  final String message;

  ListPrinterFailure(this.message);

  @override
  List<Object> get props => [message];
}
