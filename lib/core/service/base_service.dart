import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseService {
  late final Dio _dio;

  BaseService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? '',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
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
