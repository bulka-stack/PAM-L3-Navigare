import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/subject_avatar.dart';

/// Экран 5. Форма новой карточки / редактирования: лицевая и обратная сторона.
/// L3: валидация темы — обе стороны непустые (и не совпадают).
class CardFormScreen extends StatefulWidget {
  final int deckId;

  /// null — новая карточка, иначе редактирование.
  final int? cardId;

  const CardFormScreen({super.key, required this.deckId, this.cardId});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  static const maxFront = 200;
  static const maxBack = 500;

  final _formKey = GlobalKey<FormState>();
  final _frontCtrl = TextEditingController();
  final _backCtrl = TextEditingController();
  final _frontFocus = FocusNode();
  bool _showBack = false; // предпросмотр: какая сторона видна (эфемерно)

  bool get _isEdit => widget.cardId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final card = mockCards.where((c) => c.id == widget.cardId).firstOrNull;
      if (card != null) {
        _frontCtrl.text = card.front;
        _backCtrl.text = card.back;
      }
    }
  }

  @override
  void dispose() {
    _frontCtrl.dispose();
    _backCtrl.dispose();
    _frontFocus.dispose();
    super.dispose();
  }

  String? _validateFront(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Лицевая сторона не может быть пустой';
    if (v.length > maxFront) return 'Не длиннее $maxFront символов';
    return null;
  }

  String? _validateBack(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Обратная сторона не может быть пустой';
    if (v.length > maxBack) return 'Не длиннее $maxBack символов';
    if (v.toLowerCase() == _frontCtrl.text.trim().toLowerCase()) {
      return 'Ответ не должен повторять вопрос';
    }
    return null;
  }

  /// [addAnother] — «Сохранить и добавить ещё»: форма очищается, экран остаётся.
  void _save({bool addAnother = false}) {
    if (!_formKey.currentState!.validate()) return;
    final front = _frontCtrl.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEdit ? 'Карточка «$front» сохранена' : 'Карточка «$front» добавлена'),
      ),
    );
    if (addAnother) {
      _formKey.currentState!.reset();
      _frontCtrl.clear();
      _backCtrl.clear();
      setState(() => _showBack = false);
      _frontFocus.requestFocus();
    } else {
      context.pop();
    }
  }

  Future<void> _confirmDelete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Удалить карточку?'),
        content: Text('«${_frontCtrl.text.trim()}» исчезнет из колоды.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Нет')),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogCtx).colorScheme.error,
              minimumSize: const Size(0, 44),
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Карточка удалена')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final deck = mockDecks.where((d) => d.id == widget.deckId).firstOrNull;
    final previewText = _showBack ? _backCtrl.text.trim() : _frontCtrl.text.trim();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close_rounded)),
        title: Text(_isEdit ? 'Карточка' : 'Новая карточка'),
        actions: [
          if (_isEdit)
            IconButton(
              tooltip: 'Удалить',
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (deck != null)
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
            TextFormField(
              controller: _frontCtrl,
              focusNode: _frontFocus,
              minLines: 2,
              maxLines: 4,
              maxLength: maxFront,
              textInputAction: TextInputAction.next,
              onChanged: (_) => setState(() {}), // обновить предпросмотр
              decoration: const InputDecoration(
                hintText: 'Термин или вопрос, например: latency',
                counterText: '',
              ),
              validator: _validateFront,
            ),
            const SizedBox(height: 20),
            Text('Обратная сторона', style: text.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _backCtrl,
              minLines: 3,
              maxLines: 6,
              maxLength: maxBack,
              textInputAction: TextInputAction.done,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Ответ, например: задержка, время отклика',
                counterText: '',
              ),
              validator: _validateBack,
            ),
            const SizedBox(height: 24),
            Text('ПРЕДПРОСМОТР', style: text.labelLarge?.copyWith(color: duo.muted)),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => setState(() => _showBack = !_showBack),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        _showBack ? 'ОТВЕТ' : 'ВОПРОС',
                        style: text.labelMedium?.copyWith(color: _showBack ? duo.green : duo.muted),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        previewText.isEmpty ? '…' : previewText,
                        textAlign: TextAlign.center,
                        style: text.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'нажмите, чтобы перевернуть',
                        style: text.bodySmall?.copyWith(color: duo.muted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            DuoButton(label: _isEdit ? 'Сохранить' : 'Сохранить карточку', onPressed: _save),
            if (!_isEdit) ...[
              const SizedBox(height: 12),
              DuoButton(
                label: 'Сохранить и добавить ещё',
                variant: DuoButtonVariant.outline,
                onPressed: () => _save(addAnother: true),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
