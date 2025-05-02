import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded weather data for Zocca, IT
    const cityName = "Zocca, IT";
    const temperature = 285.68;
    const feelsLike = 284.87;
    //const weatherMain = "Clear";
    const weatherDescription = "clear sky";
    const humidity = 72; // %
    const sunrise = 1746158722;
    const sunset = 1746210031;

    // Convert Kelvin to Celsius
    final tempCelsius = (temperature - 273.15).toStringAsFixed(1);
    final feelsLikeCelsius = (feelsLike - 273.15).toStringAsFixed(1);

    // Convert Unix timestamps to readable time
    final sunriseTime = TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(sunrise * 1000),
    ).format(context);
    final sunsetTime = TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(sunset * 1000),
    ).format(context);

    // Hardcoded 7-day forecast data (simulated)
    final forecastData = [
      {"day": "Mon", "temp": 14.5, "condition": "Sunny", "icon": Icons.wb_sunny},
      {"day": "Tue", "temp": 13.8, "condition": "Cloudy", "icon": Icons.cloud},
      {"day": "Wed", "temp": 15.2, "condition": "Clear", "icon": Icons.wb_sunny},
      {"day": "Thu", "temp": 12.9, "condition": "Rain", "icon": Icons.water_drop},
      {"day": "Fri", "temp": 14.0, "condition": "Sunny", "icon": Icons.wb_sunny},
      {"day": "Sat", "temp": 13.5, "condition": "Cloudy", "icon": Icons.cloud},
      {"day": "Sun", "temp": 15.0, "condition": "Clear", "icon": Icons.wb_sunny},
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade300,
            Colors.blue.shade100,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // First Section: City, Temperature, Details Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // City Name
                  const Text(
                    cityName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Weather Description
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

                  // Temperature Section
                  Icon(
                    Icons.wb_sunny,
                    size: 78,
                    color: Colors.yellow.shade700,
                  ),
                  Text(
                    '$tempCelsius°C',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Feels like $feelsLikeCelsius°C',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Weather Details Chips
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildWeatherDetailChip(
                        icon: Icons.water_drop,
                        value: '$humidity%',
                      ),
                      _buildWeatherDetailChip(
                        icon: Icons.wb_sunny_outlined,
                        value: sunriseTime,
                      ),
                      _buildWeatherDetailChip(
                        icon: Icons.nights_stay,
                        value: sunsetTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Second Section: 7-Day Forecast
            _buildForecastSection(context, forecastData),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetailChip({
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF494949),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF494949),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(
    BuildContext context,
    List<Map<String, dynamic>> forecastData,
  ) {
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastData.length,
                itemBuilder: (context, index) {
                  final forecast = forecastData[index];
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
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
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
                        Text(
                          forecast['day'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          forecast['icon'] as IconData,
                          size: 24,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${forecast['temp']}°C',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
