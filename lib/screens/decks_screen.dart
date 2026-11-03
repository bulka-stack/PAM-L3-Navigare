import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/deck_card.dart';
import '../widgets/duo_button.dart';
import '../widgets/streak_chip.dart';

/// Экран 2. Мои колоды: поиск + число карточек к повторению сегодня.
class DecksScreen extends StatelessWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final dueTotal = mockDecks.fold<int>(0, (sum, d) => sum + d.dueToday);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Мои колоды'),
        actions: [
          StreakChip(
            icon: Icons.local_fire_department_rounded,
            color: duo.orange,
            value: '${mockUser.streakDays}',
          ),
          StreakChip(icon: Icons.bolt_rounded, color: duo.gold, value: '${mockUser.xp}'),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Новая колода',
        child: const Icon(Icons.add_rounded, size: 32),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // «Сегодня к повторению» — главный призыв, как урок дня в Duolingo.
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: duo.green, width: 2),
                    ),
                    color: duo.greenLight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Сегодня к повторению',
                            style: text.titleMedium?.copyWith(color: duo.greenShadow),
                          ),
                          Text(
                            cardsLabel(dueTotal),
                            style: text.headlineMedium?.copyWith(color: duo.greenShadow),
                          ),
                          const SizedBox(height: 12),
                          DuoButton(
                            label: 'Начать повторение',
                            icon: Icons.play_arrow_rounded,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск колоды',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: subjects.length + 1,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, i) => ChoiceChip(
                        label: Text(i == 0 ? 'Все' : subjects[i - 1]),
                        selected: i == 0,
                        onSelected: (_) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            sliver: SliverList.separated(
              itemCount: mockDecks.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => DeckCard(deck: mockDecks[index]),
            ),
          ),
        ],
      ),
    );
  }
}
