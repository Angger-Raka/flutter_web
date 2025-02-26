import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/datasources/client_datasources.dart';
import 'package:flutter_web/app/data/models/local/client.dart';

part 'list_client_event.dart';
part 'list_client_state.dart';

class ListClientBloc extends Bloc<ListClientEvent, ListClientState> {
  ListClientBloc(
    this.datasource,
  ) : super(ListClientInitial()) {
    on<ListClientEvent>((event, emit) {});
    on<GetAllClient>(getAll);
  }

  final ClientDatasources datasource;

  Future<void> getAll(
    GetAllClient event,
    Emitter<ListClientState> emit,
  ) async {
    emit(ListClientLoading());

    try {
      print('isOffset: ${event.isOffset}');
      final result = await datasource.getAllClient(
        event.isOffset,
      );

      emit(ListClientSuccess(result));
    } catch (e) {
      emit(ListClientFailure(e.toString()));
    }
  }
}
