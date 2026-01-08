import 'package:flutter/material.dart';
import '../models/series.dart';

class AddSeriesScreen extends StatefulWidget {
  const AddSeriesScreen({super.key});

  @override
  State<AddSeriesScreen> createState() => _AddSeriesScreenState();
}

class _AddSeriesScreenState extends State<AddSeriesScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _seasonsController = TextEditingController();
  final _episodesController = TextEditingController();
  final _imageUrlController = TextEditingController();

  SeriesStatus _status = SeriesStatus.planned;

  void _saveSeries() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _seasonsController.text.isEmpty ||
        _episodesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }

    final newSeries = Series(
      id: DateTime.now().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      totalSeasons: int.parse(_seasonsController.text),
      totalEpisodes: int.parse(_episodesController.text),
      imageUrl:
      _imageUrlController.text.isEmpty ? null : _imageUrlController.text,
      status: _status,
    );

    Navigator.pop(context, newSeries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить сериал'),
      ),
      body: SingleChildScrollView(
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
              controller: _seasonsController,
              decoration:
              const InputDecoration(labelText: 'Количество сезонов'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _episodesController,
              decoration:
              const InputDecoration(labelText: 'Количество серий'),
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
                  child: Text('Просмотрено'),
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
            const SizedBox(height: 12),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'URL обложки (необязательно)',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveSeries,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
