import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(const SeriesTrackerApp());
}

class SeriesTrackerApp extends StatefulWidget {
  const SeriesTrackerApp({super.key});

  @override
  State<SeriesTrackerApp> createState() => _SeriesTrackerAppState();
}

class _SeriesTrackerAppState extends State<SeriesTrackerApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _pushNotifications = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
      _pushNotifications = prefs.getBool('pushNotifications') ?? false;
    });
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    setState(() => _themeMode = mode);
  }

  Future<void> _savePushNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pushNotifications', value);
    setState(() => _pushNotifications = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Сериал-Трекер',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => SettingsScreen(
          onThemeChanged: _saveThemeMode,
          onPushChanged: _savePushNotifications,
          pushNotifications: _pushNotifications,
          onResetData: () => Navigator.pushNamedAndRemoveUntil(
            context, '/login', (route) => false,
          ),
        ),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
