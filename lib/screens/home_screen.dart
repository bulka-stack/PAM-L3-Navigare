import 'package:flutter/material.dart';

import 'card_form_screen.dart';
import 'deck_detail_screen.dart';
import 'deck_form_screen.dart';
import 'decks_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'review_session_screen.dart';
import 'stats_screen.dart';

/// Временные «строительные леса» L2 (Задание 6, вариант 1): стартовый экран
/// с кнопкой на каждый экран и простым Navigator.push. На L3 его заменит go_router.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final _screens = <(String, String, IconData, Widget)>[
    (
      '1. Вход / регистрация',
      'Статический экран аутентификации',
      Icons.login_rounded,
      const LoginScreen(),
    ),
    ('2. Мои колоды', 'Поиск + к повторению сегодня', Icons.layers_rounded, const DecksScreen()),
    (
      '3. Карточка колоды',
      'Список карточек и статистика',
      Icons.style_rounded,
      const DeckDetailScreen(),
    ),
    ('4. Новая колода', 'Форма колоды', Icons.create_new_folder_rounded, const DeckFormScreen()),
    (
      '5. Новая карточка',
      'Лицевая и обратная сторона',
      Icons.note_add_rounded,
      const CardFormScreen(),
    ),
    (
      '6. Сессия повторения',
      'Переворот + снова / хорошо / легко',
      Icons.replay_rounded,
      const ReviewSessionScreen(),
    ),
    ('7. Статистика', 'История сессий, % правильных', Icons.bar_chart_rounded, const StatsScreen()),
    ('8. Профиль', 'Пользователь и настройки', Icons.person_rounded, const ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('StudyCards · экраны L2')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _screens.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final (title, subtitle, icon, screen) = _screens[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                foregroundColor: scheme.onPrimaryContainer,
                child: Icon(icon),
              ),
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: Icon(Icons.chevron_right_rounded, color: scheme.outline),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
            ),
          );
        },
      ),
    );
  }
}
