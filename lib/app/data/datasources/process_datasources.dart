import 'package:dio/dio.dart';

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
}
