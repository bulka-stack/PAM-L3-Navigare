import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/duo_button.dart';
import '../widgets/duo_progress_bar.dart';
import '../widgets/section_title.dart';
import '../widgets/session_tile.dart';
import '../widgets/stat_tile.dart';

/// Экран 8. Профиль пользователя.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    const user = mockUser;
    final initials = user.name.split(' ').map((p) => p[0]).take(2).join();

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: duo.blueLight,
              foregroundColor: duo.blueShadow,
              child: Text(initials, style: text.headlineMedium?.copyWith(color: duo.blueShadow)),
            ),
          ),
          const SizedBox(height: 12),
          Text(user.name, textAlign: TextAlign.center, style: text.headlineSmall),
          Text(
            '${user.email} · ${user.group}',
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(color: duo.muted),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.3,
            children: [
              StatTile(
                icon: Icons.local_fire_department_rounded,
                color: duo.orange,
                value: '${user.streakDays}',
                label: 'дней подряд',
              ),
              StatTile(
                icon: Icons.bolt_rounded,
                color: duo.gold,
                value: '${user.xp}',
                label: 'очков XP',
              ),
              StatTile(
                icon: Icons.layers_rounded,
                color: duo.blue,
                value: '${mockDecks.length}',
                label: 'колод',
              ),
              StatTile(
                icon: Icons.style_rounded,
                color: duo.green,
                value: '${mockDecks.fold<int>(0, (s, d) => s + d.cardCount)}',
                label: 'карточек',
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SectionTitle('Цель на день'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.reviewedToday} из ${cardsLabel(user.dailyGoal)}',
                    style: text.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  DuoProgressBar(value: user.reviewedToday / user.dailyGoal, color: duo.orange),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const SectionTitle('Настройки'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  value: true,
                  onChanged: (_) {},
                  secondary: const Icon(Icons.notifications_rounded),
                  title: const Text('Напоминание в 20:00'),
                ),
                const Divider(height: 2),
                ListTile(
                  leading: const Icon(Icons.flag_rounded),
                  title: const Text('Ежедневная цель'),
                  trailing: Text(
                    cardsLabel(user.dailyGoal),
                    style: text.titleSmall?.copyWith(color: scheme.secondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const SectionTitle('Последняя сессия'),
          SessionTile(session: mockSessions.first),
          const SizedBox(height: 24),
          DuoButton(
            label: 'Выйти из аккаунта',
            variant: DuoButtonVariant.outline,
            icon: Icons.logout_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
