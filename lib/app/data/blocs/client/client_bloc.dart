import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web/app/data/models/local/client.dart';

import '../../datasources/datasources.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc(
    this.datasources,
  ) : super(ClientInitial()) {
    // on<ClientEvent>((event, emit) {});
    on<AddClient>(_add);
    on<UpdateClient>(_update);
    on<DeleteClient>(_delete);
  }

  final ClientDatasources datasources;

  Future<void> _add(
    AddClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(ClientLoading());
    try {
      final result = await datasources.addClient(
        event.client,
        event.isOffset,
      );

      if (result) {
        emit(
          const ClientSuccess('Client berhasil ditambahkan'),
        );
      } else {
        emit(
          const ClientFailure('Client gagal ditambahkan'),
        );
      }
    } catch (e) {
      emit(ClientFailure('Terjadi kesalahan pada $e'));
    }
  }

  Future<void> _update(
    UpdateClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(ClientLoading());
    try {
      final result = await datasources.updateClient(
        event.client.id.toString(),
        event.client,
      );

      if (result) {
        emit(
          const ClientSuccess('Client berhasil diupdate'),
        );
      } else {
        emit(
          const ClientFailure('Client gagal diupdate'),
        );
      }
    } catch (e) {
      emit(ClientFailure('Terjadi kesalahan pada $e'));
    }
  }

  Future<void> _delete(
    DeleteClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(ClientLoading());
    try {
      final result = await datasources.deleteClient(
        event.clientId,
      );

      if (result) {
        emit(
          const ClientSuccess('Client berhasil dihapus'),
        );
      } else {
        emit(
          const ClientFailure('Client gagal dihapus'),
        );
      }
    } catch (e) {
      emit(ClientFailure('Terjadi kesalahan pada $e'));
    }
  }
}
