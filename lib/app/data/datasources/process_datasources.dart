import 'package:dio/dio.dart';
import 'package:flutter_web/app/data/data.dart';

class ProcessDatasources {
  ProcessDatasources({
    required this.dio,
  });

  final Dio dio;

  Future<bool> deleteProcess(String id) async {
    try {
      final response = await dio.delete('/processes/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Process> getProcessById(String id) async {
    try {
      final response = await dio.get('/processes/$id?populate=*');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final attributes = data['attributes'];
        final steps = attributes['steps']['data'] as List<dynamic>;

        return Process(
          id: data['id'] as int?,
          namaProses: attributes['nama_proses'] as String,
          statusProses: attributes['status_proses'] as String,
          steps: steps.map((e) {
            final data = e['attributes'];

            return Stage(
              id: e['id'] as int,
              namaStep: data['nama_step'] as String,
              statusStep: data['status_step'] as String,
            );
          }).toList(),
        );
      } else {
        throw Exception('Failed to get process by id');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
