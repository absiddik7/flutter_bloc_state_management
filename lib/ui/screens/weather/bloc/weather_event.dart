part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchCurrentWeather extends WeatherEvent {
  final String cityName;

  const FetchCurrentWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}
