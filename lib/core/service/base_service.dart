import 'package:dio/dio.dart';
import 'package:flutter_bloc_practice/core/api_key.dart';
import 'package:flutter_bloc_practice/core/env.dart';

class BaseService {
  late final Dio _dio;

  BaseService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final fullParams = {
        ...?params,
        'appid': apiKey,
      };

      final response = await _dio.get(endpoint, queryParameters: fullParams);
      return response;
    } on DioException catch (e) {
      throw Exception('GET request failed: ${e.response?.statusCode} ${e.message}');
    }
  }
}
