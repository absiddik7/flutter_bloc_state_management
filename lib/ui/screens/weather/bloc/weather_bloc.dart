import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_practice/core/model/current_weather_model.dart';
import 'package:flutter_bloc_practice/core/service/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchCurrentWeather>(_fetchCurrentWeather);
  }

  Future<void> _fetchCurrentWeather(FetchCurrentWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final currentWeather = await weatherService.getWeatherByCity(event.cityName);
      emit(WeatherLoaded(currentWeather));
    } catch (e) {
      emit(const WeatherError('Failed to fetch weather data'));
    }
  }
}
