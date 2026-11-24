import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/subject_avatar.dart';

/// Экран 4. Форма новой колоды / редактирования.
/// L3: Form + TextFormField + validator, контроллер освобождается в dispose.
class DeckFormScreen extends StatefulWidget {
  /// null — новая колода, иначе редактирование колоды с этим id.
  final int? deckId;

  const DeckFormScreen({super.key, this.deckId});

  @override
  State<DeckFormScreen> createState() => _DeckFormScreenState();
}

class _DeckFormScreenState extends State<DeckFormScreen> {
  static const maxNameLength = 60;

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  String? _subject;

  bool get _isEdit => widget.deckId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final deck = mockDecks.where((d) => d.id == widget.deckId).firstOrNull;
      if (deck != null) {
        _nameCtrl.text = deck.name;
        _subject = deck.subject;
      }
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Название колоды обязательно';
    if (v.length < 3) return 'Минимум 3 символа';
    if (v.length > maxNameLength) return 'Не длиннее $maxNameLength символов';
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return; // ошибки уже на экране
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEdit
              ? 'Колода «${_nameCtrl.text.trim()}» сохранена'
              : 'Колода «${_nameCtrl.text.trim()}» создана',
        ),
      ),
    );
    context.pop(); // открыто push-ем → закрывается pop-ом
  }

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close_rounded)),
        title: Text(_isEdit ? 'Редактирование колоды' : 'Новая колода'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(child: SubjectAvatar(subject: _subject ?? '', size: 88)),
            const SizedBox(height: 24),
            Text('Название', style: text.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameCtrl,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              maxLength: maxNameLength,
              decoration: const InputDecoration(
                hintText: 'Например: Английский: IT-лексика',
                counterText: '',
              ),
              validator: _validateName,
            ),
            const SizedBox(height: 20),
            Text('Дисциплина', style: text.titleMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _subject,
              hint: const Text('Выберите дисциплину'),
              items: [
                for (final s in subjects)
                  DropdownMenuItem(
                    value: s,
                    child: Row(
                      children: [
                        Icon(SubjectAvatar.iconFor(s), color: SubjectAvatar.colorFor(context, s)),
                        const SizedBox(width: 12),
                        Text(s),
                      ],
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _subject = v), // эфемерно: превью иконки
              validator: (v) => v == null ? 'Выберите дисциплину' : null,
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
            DuoButton(label: _isEdit ? 'Сохранить' : 'Создать колоду', onPressed: _save),
          ],
        ),
      ),
    );
  }
}
