part of 'printer_bloc.dart';

sealed class PrinterState extends Equatable {
  const PrinterState();

  @override
  List<Object> get props => [];
}

final class PrinterInitial extends PrinterState {}

final class PrinterLoading extends PrinterState {}

final class PrinterSuccess extends PrinterState {
  final String message;

  const PrinterSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class PrinterFailure extends PrinterState {
  final String message;

  const PrinterFailure(this.message);

  @override
  List<Object> get props => [message];
}
