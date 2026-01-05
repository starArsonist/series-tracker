import 'package:flutter/material.dart';

void main() {
  runApp(const SeriesTrackerApp());
}

class SeriesTrackerApp extends StatelessWidget {
  const SeriesTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Сериал-Трекер',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Placeholder(),
    );
  }
}
