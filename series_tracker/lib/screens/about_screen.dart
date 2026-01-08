import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.movie,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Text(
              'Сериал-Трекер',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'v1.0.0',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Разработано:\nВаша группа\nОмский Государственный Технический Университет',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Приложение для отслеживания просмотра сериалов.\nДобавляйте сериалы, отмечайте прогресс, оставляйте отзывы и управляйте списком любимых шоу.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  const Text(
                    '© 2026 Все права защищены',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Спасибо за использование!')),
                    ),
                    child: const Text(
                      'Спасибо за использование!',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
