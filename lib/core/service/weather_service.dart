import 'package:flutter_bloc_practice/core/model/current_weather_model.dart';
import 'package:flutter_bloc_practice/core/service/base_service.dart';

class WeatherService extends BaseService {
  Future<CurrentWeatherModel> getWeatherByCity(String cityName) async {
    final service = BaseService();

    try {
      final response = await service.get('/weather', params: {'q': cityName});
      return CurrentWeatherModel.fromJson(response.data);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
