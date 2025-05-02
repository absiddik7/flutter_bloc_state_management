import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/core/model/current_weather_model.dart';
import 'package:flutter_bloc_practice/core/service/weather_service.dart';
import 'package:flutter_bloc_practice/ui/screens/weather/bloc/weather_event.dart';
import 'package:flutter_bloc_practice/ui/screens/weather/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final response = await weatherService.get('/weather', params: {'q': event.cityName});
      final weather = CurrentWeatherModel.fromJson(response.data);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather: $e'));
    }
  }
}
