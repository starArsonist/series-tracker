import 'package:flutter/material.dart';
import '../models/series.dart';
import 'add_series_screen.dart';
import 'series_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Series> _seriesList = [
    Series(
      id: '1',
      title: 'Во все тяжкие',
      description: 'История школьного учителя химии...',
      totalSeasons: 5,
      totalEpisodes: 62,
      currentSeason: 2,
      currentEpisode: 5,
      status: SeriesStatus.watching,
    ),
    Series(
      id: '2',
      title: 'Тьма',
      description: 'Мистический сериал про путешествия во времени',
      totalSeasons: 3,
      totalEpisodes: 26,
      status: SeriesStatus.completed,
    ),
    Series(
      id: '2',
      title: 'Очень странные дела',
      description: 'Паранормальное в маленьком городке Хоукинсе',
      totalSeasons: 5,
      totalEpisodes: 56,
      status: SeriesStatus.watching,
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои сериалы'),
      ),
      body: ListView.builder(
        itemCount: _seriesList.length,
        itemBuilder: (context, index) {
          final series = _seriesList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: series.imageUrl != null
                  ? Image.network(
                series.imageUrl!,
                width: 50,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.movie),
              title: Text(series.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Сезон ${series.currentSeason}, серия ${series
                        .currentEpisode}',
                  ),
                  Text(
                    'Статус: ${_statusText(series.status)}',
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeriesDetailScreen(series: series),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSeries = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSeriesScreen(),
            ),
          );

          if (newSeries != null) {
            setState(() {
              _seriesList.add(newSeries);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
