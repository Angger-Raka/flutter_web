import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/data.dart';

part 'get_client_event.dart';
part 'get_client_state.dart';

class GetClientBloc extends Bloc<GetClientEvent, GetClientState> {
  GetClientBloc(
    this.datasource,
  ) : super(GetClientInitial()) {
    on<GetClientEvent>((event, emit) {});
    on<GetClient>(_get);
  }

  final ClientDatasources datasource;

  Future<void> _get(
    GetClient event,
    Emitter<GetClientState> emit,
  ) async {
    emit(GetClientLoading());

    try {
      final result = await datasource.getClient(
        event.clientId,
      );

      emit(GetClientSuccess(result));
    } catch (e) {
      emit(GetClientFailure(e.toString()));
    }
  }
}
