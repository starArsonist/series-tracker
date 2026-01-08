import 'package:flutter/material.dart';
import '../models/series.dart';

class EditSeriesScreen extends StatefulWidget {
  final Series series;

  const EditSeriesScreen({super.key, required this.series});

  @override
  State<EditSeriesScreen> createState() => _EditSeriesScreenState();
}

class _EditSeriesScreenState extends State<EditSeriesScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _currentSeasonController;
  late TextEditingController _currentEpisodeController;
  late SeriesStatus _status;

  @override
  void initState() {
    super.initState();
    final s = widget.series;

    _titleController = TextEditingController(text: s.title);
    _descriptionController = TextEditingController(text: s.description);
    _currentSeasonController =
        TextEditingController(text: s.currentSeason.toString());
    _currentEpisodeController =
        TextEditingController(text: s.currentEpisode.toString());
    _status = s.status;
  }

  void _updateSeries() {
    setState(() {
      widget.series.title = _titleController.text;
      widget.series.description = _descriptionController.text;
      widget.series.currentSeason =
          int.tryParse(_currentSeasonController.text) ?? 1;
      widget.series.currentEpisode =
          int.tryParse(_currentEpisodeController.text) ?? 1;
      widget.series.status = _status;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать сериал'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _currentSeasonController,
              decoration:
              const InputDecoration(labelText: 'Текущий сезон'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _currentEpisodeController,
              decoration:
              const InputDecoration(labelText: 'Текущая серия'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<SeriesStatus>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Статус'),
              items: const [
                DropdownMenuItem(
                  value: SeriesStatus.watching,
                  child: Text('Смотрю'),
                ),
                DropdownMenuItem(
                  value: SeriesStatus.completed,
                  child: Text('Закончил'),
                ),
                DropdownMenuItem(
                  value: SeriesStatus.planned,
                  child: Text('Запланировано'),
                ),
                DropdownMenuItem(
                  value: SeriesStatus.dropped,
                  child: Text('Брошено'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateSeries,
              child: const Text('Обновить'),
            ),
          ],
        ),
      ),
    );
  }
}
