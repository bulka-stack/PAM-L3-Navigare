import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/subject_avatar.dart';

/// Экран 5. Форма новой карточки / редактирования: лицевая и обратная сторона.
/// Макет L2 — без валидации и без сохранения.
class CardFormScreen extends StatelessWidget {
  const CardFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final deck = mockDecks.first;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text('Новая карточка'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              SubjectAvatar(subject: deck.subject, size: 36),
              const SizedBox(width: 10),
              Expanded(child: Text(deck.name, style: text.titleMedium)),
            ],
          ),
          const SizedBox(height: 24),
          Text('Лицевая сторона', style: text.titleMedium),
          const SizedBox(height: 8),
          const TextField(
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(hintText: 'Термин или вопрос, например: latency'),
          ),
          const SizedBox(height: 20),
          Text('Обратная сторона', style: text.titleMedium),
          const SizedBox(height: 8),
          const TextField(
            minLines: 3,
            maxLines: 6,
            decoration: InputDecoration(hintText: 'Ответ, например: задержка, время отклика'),
          ),
          const SizedBox(height: 24),
          Text('ПРЕДПРОСМОТР', style: text.labelLarge?.copyWith(color: duo.muted)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
              child: Column(
                children: [
                  Text('latency', style: text.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'нажмите, чтобы перевернуть',
                    style: text.bodySmall?.copyWith(color: duo.muted),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          DuoButton(label: 'Сохранить карточку', onPressed: () {}),
          const SizedBox(height: 12),
          DuoButton(
            label: 'Сохранить и добавить ещё',
            variant: DuoButtonVariant.outline,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
