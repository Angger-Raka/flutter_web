import 'package:dio/dio.dart';
import 'package:flutter_web/app/data/data.dart';

class ClientDatasources {
  final Dio dio;

  ClientDatasources({required this.dio});

  Future<Client> getClient(
    int clientId,
  ) async {
    try {
      final response = await dio.get('/clients/$clientId');
      if (response.statusCode == 200) {
        final client = Client(
          id: response.data['data']['id'],
          name: response.data['data']['attributes']['name'],
          email: response.data['data']['attributes']['email'],
          phone: response.data['data']['attributes']['phone'],
          address: response.data['data']['attributes']['address'],
        );
        return client;
      } else {
        throw Exception('Failed to get client');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addClient(
    Client client,
    bool isOffset,
  ) async {
    try {
      final response = await dio.post(
        '/clients',
        data: {
          "data": {
            "name": client.name,
            "email": client.email,
            "phone": client.phone,
            "address": client.address,
            "jenis": isOffset ? 'Offset' : 'POD',
          }
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<List<Client>> getAllClient(
    bool isOffset,
  ) async {
    try {
      final additional = 'filters[jenis][\$eq]=${isOffset ? 'Offset' : 'POD'}';
      final response = await dio.get('/clients?$additional');
      if (response.statusCode == 200) {
        final List<Client> listClient = [];
        print(response.data['data']);
        for (final clients in response.data['data']) {
          final client = Client(
            id: clients['id'],
            name: clients['attributes']['name'],
            email: clients['attributes']['email'],
            phone: clients['attributes']['phone'],
            address: clients['attributes']['address'],
          );
          listClient.add(client);
        }
        return listClient;
      } else {
        throw Exception('Failed to get all client');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> deleteClient(String id) async {
    try {
      final response = await dio.delete('/clients/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updateClient(
    String id,
    Client client,
  ) async {
    try {
      final response = await dio.put(
        '/clients/$id',
        data: {
          "data": client.toMap(),
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception(e);
    }
  }
}
