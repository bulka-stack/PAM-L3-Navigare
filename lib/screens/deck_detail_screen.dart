import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/duo_button.dart';
import '../widgets/flashcard_tile.dart';
import '../widgets/section_title.dart';
import '../widgets/stat_tile.dart';
import '../widgets/subject_avatar.dart';

/// Экран 3. Карточка колоды: список карточек + статистика колоды.
class DeckDetailScreen extends StatelessWidget {
  const DeckDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final deck = mockDecks.first; // L2: колода зашита в код
    final cards = mockCards;
    final due = cards.where((c) => !c.nextReviewAt.isAfter(mockToday)).length;
    final avgEase = cards.fold<double>(0, (s, c) => s + c.easeFactor) / cards.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Колода'),
        actions: [
          IconButton(onPressed: () {}, tooltip: 'Изменить', icon: const Icon(Icons.edit_rounded)),
          IconButton(
            onPressed: () {},
            tooltip: 'Удалить',
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('КАРТОЧКА'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          Row(
            children: [
              SubjectAvatar(subject: deck.subject, size: 64),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(deck.name, style: text.titleLarge),
                    Text(deck.subject, style: text.bodyMedium?.copyWith(color: duo.muted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.3,
            children: [
              StatTile(
                icon: Icons.style_rounded,
                color: duo.blue,
                value: '${cards.length}',
                label: 'всего карточек',
              ),
              StatTile(
                icon: Icons.bolt_rounded,
                color: duo.orange,
                value: '$due',
                label: 'к повторению',
              ),
              StatTile(
                icon: Icons.emoji_events_rounded,
                color: duo.gold,
                value: '${cards.where((c) => c.intervalDays >= 21).length}',
                label: 'выучено',
              ),
              StatTile(
                icon: Icons.speed_rounded,
                color: duo.purple,
                value: avgEase.toStringAsFixed(2),
                label: 'средний ease',
              ),
            ],
          ),
          const SizedBox(height: 16),
          DuoButton(
            label: 'Повторить $due ${plural(due, 'карточку', 'карточки', 'карточек')}',
            icon: Icons.play_arrow_rounded,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          SectionTitle('Карточки (${cards.length})'),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) => FlashcardTile(card: cards[i], today: mockToday),
          ),
        ],
      ),
    );
  }
}
