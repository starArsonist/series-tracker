import 'package:flutter/material.dart';
import '../models/series.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final List<Series> seriesList;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) {
    final total = seriesList.length;
    final completed = seriesList
        .where((s) => s.status == SeriesStatus.completed)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Пользователь: $username',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Всего сериалов: $total'),
            Text('Завершено: $completed'),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
