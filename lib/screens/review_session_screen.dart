import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/duo_button.dart';
import '../widgets/duo_progress_bar.dart';
import '../widgets/stat_tile.dart';

/// Экран 6. Сессия повторения: переворот карточки + оценка «снова / хорошо / легко».
/// L3: ход сессии — эфемерное состояние экрана (setState); расписание (SRS) — на L4.
class ReviewSessionScreen extends StatefulWidget {
  /// null — все колоды (кнопка «Начать повторение» на экране колод).
  final int? deckId;

  const ReviewSessionScreen({super.key, this.deckId});

  @override
  State<ReviewSessionScreen> createState() => _ReviewSessionScreenState();
}

enum Grade { again, good, easy }

class _ReviewSessionScreenState extends State<ReviewSessionScreen> {
  late final List<Flashcard> _queue;
  int _index = 0;
  bool _flipped = false;
  int _correct = 0;

  @override
  void initState() {
    super.initState();
    _queue = mockCards
        .where((c) => widget.deckId == null || c.deckId == widget.deckId)
        .where((c) => !c.nextReviewAt.isAfter(mockToday))
        .toList();
  }

  bool get _finished => _index >= _queue.length;

  void _grade(Grade grade) {
    setState(() {
      if (grade != Grade.again) _correct++;
      _index++;
      _flipped = false;
    });
  }

  Future<void> _close() async {
    if (_index == 0 || _finished) {
      context.pop();
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Завершить сессию?'),
        content: Text('Повторено ${cardsLabel(_index)} из ${_queue.length}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Продолжить'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogCtx).colorScheme.error,
              minimumSize: const Size(0, 44),
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Завершить'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) context.pop();
  }

  void _finish() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Сессия завершена: $_correct из ${_queue.length} верно')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final deckName = widget.deckId == null
        ? 'Все колоды'
        : mockDecks.where((d) => d.id == widget.deckId).firstOrNull?.name ?? '';

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
                    tooltip: 'Закрыть',
                    onPressed: _close,
                    icon: Icon(Icons.close_rounded, color: duo.muted, size: 30),
                  ),
                  Expanded(
                    child: DuoProgressBar(value: _queue.isEmpty ? 1 : _index / _queue.length),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_index.clamp(0, _queue.length)}/${_queue.length}',
                    style: text.titleMedium?.copyWith(color: duo.muted),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(deckName, style: text.titleMedium?.copyWith(color: duo.muted)),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _queue.isEmpty
                      ? _EmptyState(onBack: () => context.pop())
                      : _finished
                      ? _Summary(total: _queue.length, correct: _correct, onDone: _finish)
                      : _CardFace(
                          card: _queue[_index],
                          flipped: _flipped,
                          onFlip: () => setState(() => _flipped = true),
                        ),
                ),
              ),
              if (!_finished && _queue.isNotEmpty) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _flipped
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Насколько легко вы вспомнили ответ?',
                              textAlign: TextAlign.center,
                              style: text.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: DuoButton(
                                    label: 'Снова',
                                    variant: DuoButtonVariant.danger,
                                    onPressed: () => _grade(Grade.again),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DuoButton(
                                    label: 'Хорошо',
                                    onPressed: () => _grade(Grade.good),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DuoButton(
                                    label: 'Легко',
                                    variant: DuoButtonVariant.secondary,
                                    onPressed: () => _grade(Grade.easy),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : DuoButton(
                          label: 'Показать ответ',
                          variant: DuoButtonVariant.secondary,
                          onPressed: () => setState(() => _flipped = true),
                        ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Карточка: лицевая сторона, после переворота — ещё и ответ.
class _CardFace extends StatelessWidget {
  final Flashcard card;
  final bool flipped;
  final VoidCallback onFlip;

  const _CardFace({required this.card, required this.flipped, required this.onFlip});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: flipped ? null : onFlip,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
        child: DecoratedBox(
          key: ValueKey('${card.id}-$flipped'),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: flipped ? duo.green : duo.border, width: 2),
          ),
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ВОПРОС', style: text.labelLarge?.copyWith(color: duo.muted)),
                  const SizedBox(height: 8),
                  Text(card.front, textAlign: TextAlign.center, style: text.headlineMedium),
                  if (flipped) ...[
                    const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                    Text('ОТВЕТ', style: text.labelLarge?.copyWith(color: duo.green)),
                    const SizedBox(height: 8),
                    Text(card.back, textAlign: TextAlign.center, style: text.titleLarge),
                  ] else ...[
                    const SizedBox(height: 24),
                    Text(
                      'нажмите, чтобы перевернуть',
                      style: text.bodySmall?.copyWith(color: duo.muted),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Итог сессии — «урок пройден».
class _Summary extends StatelessWidget {
  final int total;
  final int correct;
  final VoidCallback onDone;

  const _Summary({required this.total, required this.correct, required this.onDone});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.emoji_events_rounded, size: 96, color: duo.gold),
        const SizedBox(height: 12),
        Text(
          'Сессия завершена!',
          textAlign: TextAlign.center,
          style: text.headlineMedium?.copyWith(color: duo.gold),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.style_rounded,
                color: duo.blue,
                value: '$total',
                label: 'повторено',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: StatTile(
                icon: Icons.check_circle_rounded,
                color: duo.green,
                value: '${percent(correct, total)}%',
                label: 'точность',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        DuoButton(label: 'Продолжить', onPressed: onDone),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onBack;
  const _EmptyState({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.check_circle_rounded, size: 96, color: duo.green),
        const SizedBox(height: 12),
        Text('На сегодня всё повторено!', textAlign: TextAlign.center, style: text.headlineSmall),
        const SizedBox(height: 24),
        DuoButton(label: 'Назад', onPressed: onBack),
      ],
    );
  }
}
