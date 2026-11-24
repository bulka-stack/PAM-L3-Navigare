import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

/// Строка истории: колода, дата, сколько карточек и процент правильных ответов.
/// Используется на экранах «Статистика» и «Профиль».
class SessionTile extends StatelessWidget {
  final ReviewSession session;

  const SessionTile({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final text = Theme.of(context).textTheme;
    final onColor = Theme.of(context).colorScheme.onPrimary;
    final p = percent(session.correctCount, session.reviewedCount);
    final color = p >= 80 ? duo.green : (p >= 60 ? duo.orange : duo.red);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: color,
          foregroundColor: onColor,
          child: Text('$p%', style: text.labelMedium?.copyWith(color: onColor)),
        ),
        title: Text(session.deckName, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(formatDateTime(session.date)),
        trailing: Text(
          '${session.correctCount}/${session.reviewedCount}',
          style: text.titleMedium?.copyWith(color: color),
        ),
      ),
    );
  }
}
