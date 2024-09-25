import 'package:dio/dio.dart';
import 'package:flutter_web/constant.dart';

class DioClient {
  DioClient({
    required this.dio,
    required this.baseUrl,
  });

  final Dio dio;
  final String baseUrl;

  Dio get client {
    return dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        sendTimeout: const Duration(seconds: 50),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
  }
}
