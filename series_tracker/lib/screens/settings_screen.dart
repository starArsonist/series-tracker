import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final Function(bool) onPushChanged;
  final bool pushNotifications;
  final VoidCallback onResetData;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onPushChanged,
    required this.pushNotifications,
    required this.onResetData,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemeMode.system;
  }

  String _themeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return 'Системная';
      case ThemeMode.light: return 'Светлая';
      case ThemeMode.dark: return 'Тёмная';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Пуш-уведомления
          SwitchListTile(
            title: const Text('Пуш-уведомления'),
            subtitle: const Text('Уведомления о новых сериях'),
            value: widget.pushNotifications,
            onChanged: widget.onPushChanged,
            secondary: const Icon(Icons.notifications),
          ),

          const Divider(),

          // Тёмная тема
          ListTile(
            title: const Text('Тёмная тема'),
            subtitle: Text(_themeText(_themeMode)),
            leading: const Icon(Icons.dark_mode),
            trailing: DropdownButton<ThemeMode>(
              value: _themeMode,
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('Системная')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Светлая')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Тёмная')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _themeMode = value);
                  widget.onThemeChanged(value);
                }
              },
            ),
          ),

          const Divider(),

          // Сброс данных
          ListTile(
            title: const Text('Сбросить данные'),
            subtitle: const Text('Очистка всех сериалов и отзывов'),
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Сбросить данные?'),
                  content: const Text('Все сериалы и отзывы будут удалены.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onResetData();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Сбросить'),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
