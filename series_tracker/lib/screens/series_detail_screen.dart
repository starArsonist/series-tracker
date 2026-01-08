import 'package:flutter/material.dart';
import '../models/series.dart';
import 'edit_series_screen.dart';


class SeriesDetailScreen extends StatefulWidget {
  final Series series;

  const SeriesDetailScreen({super.key, required this.series});

  @override
  State<SeriesDetailScreen> createState() => _SeriesDetailScreenState();
}

class _SeriesDetailScreenState extends State<SeriesDetailScreen> {
  final _reviewController = TextEditingController();

  String _statusText(SeriesStatus status) {
    switch (status) {
      case SeriesStatus.watching:
        return 'Смотрю';
      case SeriesStatus.completed:
        return 'Закончил';
      case SeriesStatus.planned:
        return 'Запланировано';
      case SeriesStatus.dropped:
        return 'Брошено';
    }
  }

  void _addReview() {
    if (_reviewController.text.isEmpty) return;

    setState(() {
      widget.series.reviews.add(_reviewController.text);
      _reviewController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final series = widget.series;

    return Scaffold(
      appBar: AppBar(
        title: Text(series.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSeriesScreen(series: series),
                ),
              );
              setState(() {}); // обновление
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (series.imageUrl != null)
              Center(
                child: Image.network(
                  series.imageUrl!,
                  height: 200,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              series.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Сезоны: ${series.currentSeason}/${series.totalSeasons}',
            ),
            Text(
              'Серии: ${series.currentEpisode}/${series.totalEpisodes}',
            ),
            const SizedBox(height: 8),
            Text(
              'Статус: ${_statusText(series.status)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),
            const Text(
              'Отзывы',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: series.reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.comment),
                    title: Text(series.reviews[index]),
                  );
                },
              ),
            ),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Новый отзыв',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addReview,
              child: const Text('Добавить отзыв'),
            ),
          ],
        ),
      ),
    );
  }
}
