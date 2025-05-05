part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {
  final bool isCurrentWeatherLoading;
  final bool isForecastWeatherLoading;

  const WeatherLoading({this.isCurrentWeatherLoading = false, this.isForecastWeatherLoading = false});

  @override
  List<Object> get props => [isCurrentWeatherLoading, isForecastWeatherLoading];
}

final class CurrentWeatherLoaded extends WeatherState {
  final CurrentWeatherModel currentWeather;
  const CurrentWeatherLoaded(this.currentWeather);

  @override
  List<Object> get props => [currentWeather];
}

final class ForecastWeatherLoaded extends WeatherState {
  final ForecastWeatherModel? forecastWeather;
  const ForecastWeatherLoaded(this.forecastWeather);

  @override
  List<Object?> get props => [forecastWeather];
}

final class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
