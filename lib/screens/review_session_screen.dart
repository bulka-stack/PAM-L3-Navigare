import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/duo_progress_bar.dart';

/// Экран 6. Сессия повторения: карточка (перевёрнута — видны обе стороны)
/// и оценка «снова / хорошо / легко». На L2 — статический кадр.
class ReviewSessionScreen extends StatelessWidget {
  /// null — все колоды.
  final int? deckId;

  const ReviewSessionScreen({super.key, this.deckId});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final card = mockCards[4]; // throughput
    const position = 4;
    const total = 12;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: Icon(Icons.close_rounded, color: duo.muted, size: 30),
                  ),
                  const Expanded(child: DuoProgressBar(value: position / total)),
                  const SizedBox(width: 12),
                  Text('$position/$total', style: text.titleMedium?.copyWith(color: duo.muted)),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  mockDecks.first.name,
                  style: text.titleMedium?.copyWith(color: duo.muted),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: duo.border, width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ВОПРОС', style: text.labelLarge?.copyWith(color: duo.muted)),
                          const SizedBox(height: 8),
                          Text(card.front, textAlign: TextAlign.center, style: text.headlineMedium),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Divider(),
                          ),
                          Text('ОТВЕТ', style: text.labelLarge?.copyWith(color: duo.green)),
                          const SizedBox(height: 8),
                          Text(card.back, textAlign: TextAlign.center, style: text.titleLarge),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Насколько легко вы вспомнили ответ?',
                  textAlign: TextAlign.center,
                  style: text.titleMedium,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: DuoButton(
                        label: 'Снова',
                        caption: '1 день',
                        variant: DuoButtonVariant.danger,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DuoButton(label: 'Хорошо', caption: '2 дня', onPressed: () {}),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DuoButton(
                        label: 'Легко',
                        caption: '2 дня',
                        variant: DuoButtonVariant.secondary,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
