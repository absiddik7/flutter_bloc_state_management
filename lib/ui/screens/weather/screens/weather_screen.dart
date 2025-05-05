// Refactored WeatherScreen using best practices and modularization

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/ui/screens/weather/bloc/weather_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WeatherBloc>().add(const FetchCurrentWeather('Dhaka'));

    final forecastData = _generateForecast();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade300, Colors.blue.shade100],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    ),
                  );
                } else if (state is WeatherError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                } else if (state is CurrentWeatherLoaded) {
                  final cityName = state.currentWeather.name;
                  final weatherDescription = state.currentWeather.weather[0].description;
                  final tempCelsius = (state.currentWeather.main.temp - 273.15).toStringAsFixed(1);
                  final feelsLikeCelsius = (state.currentWeather.main.feelsLike - 273.15).toStringAsFixed(1);
                  final humidity = state.currentWeather.main.humidity;
                  final sunriseTime = _formatUnixTime(state.currentWeather.sys.sunrise, context);
                  final sunsetTime = _formatUnixTime(state.currentWeather.sys.sunset, context);

                  return _buildCurrentWeatherSection(context, cityName, weatherDescription, tempCelsius,
                      feelsLikeCelsius, humidity, sunriseTime, sunsetTime);
                }

                return const Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              },
            ),
            _ForecastSection(forecastData: forecastData),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherSection(BuildContext context, String cityName, String weatherDescription,
      String tempCelsius, String feelsLikeCelsius, int humidity, String sunriseTime, String sunsetTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cityName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(2, 2))],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            weatherDescription.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Icon(Icons.wb_sunny, size: 78, color: Colors.yellow.shade700),
          Text('$tempCelsius°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text('Feels like $feelsLikeCelsius°C', style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _WeatherDetailChip(icon: Icons.water_drop, value: '$humidity%'),
              _WeatherDetailChip(icon: Icons.wb_sunny_outlined, value: sunriseTime),
              _WeatherDetailChip(icon: Icons.nights_stay, value: sunsetTime),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static String _formatUnixTime(int timestamp, BuildContext context) {
    return TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
    ).format(context);
  }

  List<Map<String, dynamic>> _generateForecast() => [
        {"day": "Mon", "temp": 14.5, "icon": Icons.wb_sunny},
        {"day": "Tue", "temp": 13.8, "icon": Icons.cloud},
        {"day": "Wed", "temp": 15.2, "icon": Icons.wb_sunny},
        {"day": "Thu", "temp": 12.9, "icon": Icons.water_drop},
        {"day": "Fri", "temp": 14.0, "icon": Icons.wb_sunny},
        {"day": "Sat", "temp": 13.5, "icon": Icons.cloud},
        {"day": "Sun", "temp": 15.0, "icon": Icons.wb_sunny},
      ];
}

class _WeatherDetailChip extends StatelessWidget {
  final IconData icon;
  final String value;

  const _WeatherDetailChip({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF494949)),
          const SizedBox(width: 8),
          Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF494949))),
        ],
      ),
    );
  }
}

class _ForecastSection extends StatelessWidget {
  final List<Map<String, dynamic>> forecastData;

  const _ForecastSection({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '7-Day Forecast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastData.length,
                itemBuilder: (context, index) {
                  final forecast = forecastData[index];
                  return _ForecastCard(
                    day: forecast['day'],
                    temp: forecast['temp'],
                    icon: forecast['icon'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForecastCard extends StatelessWidget {
  final String day;
  final double temp;
  final IconData icon;

  const _ForecastCard({required this.day, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent.withOpacity(0.4),
            Colors.blueAccent.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Icon(icon, size: 24, color: Colors.white.withOpacity(0.9)),
          const SizedBox(height: 8),
          Text('${temp.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
