part of 'process_bloc.dart';

sealed class ProcessState extends Equatable {
  const ProcessState();
  
  @override
  List<Object> get props => [];
}

final class ProcessInitial extends ProcessState {}
