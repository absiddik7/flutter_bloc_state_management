import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/core/service/weather_service.dart';
import 'package:flutter_bloc_practice/ui/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/ui/screens/weather/bloc/weather_bloc.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherService>(
          create: (context) => WeatherService(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(context.read<WeatherService>()),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightGreen,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
