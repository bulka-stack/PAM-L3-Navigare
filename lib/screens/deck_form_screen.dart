import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/subject_avatar.dart';

/// Экран 4. Форма новой колоды / редактирования — макет L2 (без валидации и сохранения).
class DeckFormScreen extends StatelessWidget {
  const DeckFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text('Новая колода'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(child: SubjectAvatar(subject: 'Языки', size: 88)),
          const SizedBox(height: 24),
          Text('Название', style: text.titleMedium),
          const SizedBox(height: 8),
          const TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: 'Например: Английский: IT-лексика'),
          ),
          const SizedBox(height: 20),
          Text('Дисциплина', style: text.titleMedium),
          const SizedBox(height: 8),
          DropdownMenu<String>(
            initialSelection: subjects.first,
            expandedInsets: EdgeInsets.zero,
            dropdownMenuEntries: [
              for (final s in subjects)
                DropdownMenuEntry(
                  value: s,
                  label: s,
                  leadingIcon: Icon(
                    SubjectAvatar.iconFor(s),
                    color: SubjectAvatar.colorFor(context, s),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: duo.blueLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: duo.blue, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_rounded, color: duo.blueShadow),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Небольшие колоды по 15–25 карточек запоминаются быстрее.',
                      style: text.bodyMedium?.copyWith(color: duo.blueShadow),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          DuoButton(label: 'Создать колоду', onPressed: () {}),
        ],
      ),
    );
  }
}
