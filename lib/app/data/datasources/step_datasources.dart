import 'package:dio/dio.dart';

class StepDatasources {
  StepDatasources({required this.dio});

  final Dio dio;

  Future<bool> updateStep(
    String id,
    String statusStep,
  ) async {
    try {
      final result = await dio.put(
        '/steps/$id',
        data: {
          "data": {
            "status_step": statusStep,
          },
        },
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to get all order');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteStep(String id) async {
    try {
      final response = await dio.delete('/steps/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception(e);
    }
  }
}
