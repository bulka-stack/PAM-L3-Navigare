import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/section_title.dart';
import '../widgets/session_tile.dart';
import '../widgets/stat_tile.dart';
import '../widgets/week_activity_chart.dart';

/// Экран 7. Статистика: история сессий и процент правильных ответов.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final reviewed = mockSessions.fold<int>(0, (s, e) => s + e.reviewedCount);
    final correct = mockSessions.fold<int>(0, (s, e) => s + e.correctCount);

    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.3,
                    children: [
                      StatTile(
                        icon: Icons.check_circle_rounded,
                        color: duo.green,
                        value: '${percent(correct, reviewed)}%',
                        label: 'точность',
                      ),
                      StatTile(
                        icon: Icons.local_fire_department_rounded,
                        color: duo.orange,
                        value: daysLabel(mockUser.streakDays),
                        label: 'серия',
                      ),
                      StatTile(
                        icon: Icons.style_rounded,
                        color: duo.blue,
                        value: '$reviewed',
                        label: 'повторено',
                      ),
                      StatTile(
                        icon: Icons.timer_rounded,
                        color: duo.purple,
                        value: '${mockSessions.length}',
                        label: 'сессий',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const SectionTitle('Активность за неделю'),
                  const WeekActivityChart(values: mockWeekActivity),
                  const SizedBox(height: 8),
                  const SectionTitle('История сессий'),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.separated(
              itemCount: mockSessions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) => SessionTile(session: mockSessions[i]),
            ),
          ),
        ],
      ),
    );
  }
}
