import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/ui/screens/wallet/wallet_screen.dart';
import 'package:flutter_bloc_practice/ui/screens/weather/weather_screen.dart';
import 'package:flutter_bloc_practice/ui/screens/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const WeatherScreen(), const HistoryScreen(), const SettingsScreen()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        //backgroundColor: Colors.transparent,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            activeIcon: Icon(
              Icons.sunny,
              color: Colors.amber,
            ),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            activeIcon: Icon(
              Icons.account_balance_wallet,
              color: Colors.lightGreen,
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
