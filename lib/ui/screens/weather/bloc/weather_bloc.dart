import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/core/model/current_weather_model.dart';
import 'package:flutter_bloc_practice/core/model/forecast_weather_model.dart';
import 'package:flutter_bloc_practice/core/service/weather_service.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchCurrentWeather>(_onFetchCurrentWeather);
    on<FetchForecastWeather>(_onFetchForecastWeather);
  }

  Future<void> _onFetchCurrentWeather(FetchCurrentWeather event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading(isCurrentWeatherLoading: true));
    try {
      final currentWeather = await weatherService.getWeatherByCity(event.cityName);
      emit(CurrentWeatherLoaded(currentWeather));
    } catch (e) {
      emit(WeatherError('Failed to fetch current weather: $e'));
    }
  }

  Future<void> _onFetchForecastWeather(FetchForecastWeather event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading(isForecastWeatherLoading: true));
    try {
      final forecast = await weatherService.getForecastWeatherByCity(event.cityName);
      emit(ForecastWeatherLoaded(forecast));
    } catch (e) {
      emit(WeatherError('Failed to fetch forecast: $e'));
    }
  }
}