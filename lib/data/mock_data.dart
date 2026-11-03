// Зашитые в код данные L2, используемые несколькими экранами.
// Поля взяты из модели данных темы T13 (Deck, Card, ReviewSession).

/// Колода карточек по дисциплине.
class Deck {
  final String name;
  final String subject;
  final int cardCount;
  final int dueToday; // карточек к повторению сегодня
  final int learned; // карточек с интервалом ≥ 21 дня («выучено»)

  const Deck(this.name, this.subject, this.cardCount, this.dueToday, this.learned);
}

/// Флеш-карточка: лицевая и обратная сторона + параметры интервального повторения.
/// (Класс не называется Card, чтобы не конфликтовать с виджетом Card из Material.)
class Flashcard {
  final String front;
  final String back;
  final double easeFactor;
  final int intervalDays;
  final DateTime nextReviewAt;

  const Flashcard(this.front, this.back, this.easeFactor, this.intervalDays, this.nextReviewAt);
}

/// Завершённая сессия повторения.
class ReviewSession {
  final String deckName;
  final DateTime date;
  final int reviewedCount;
  final int correctCount;

  const ReviewSession(this.deckName, this.date, this.reviewedCount, this.correctCount);
}

/// Пользователь (профиль).
class UserProfile {
  final String name;
  final String email;
  final String group;
  final int streakDays;
  final int xp;
  final int dailyGoal;
  final int reviewedToday;

  const UserProfile(
    this.name,
    this.email,
    this.group,
    this.streakDays,
    this.xp,
    this.dailyGoal,
    this.reviewedToday,
  );
}

/// Дисциплины, по которым группируются колоды.
const subjects = [
  'Языки',
  'Математика',
  'Программирование',
  'Естественные науки',
  'История',
  'Экономика',
];

/// «Сегодня» для зашитых данных L2 (дата повторения сравнивается с ней).
final mockToday = DateTime(2026, 11, 4);

const mockUser = UserProfile(
  'Андрей Костин',
  'andrii.kostin@isa.utm.md',
  'TI-235',
  12,
  1240,
  20,
  14,
);

const mockDecks = [
  Deck('Английский: IT-лексика', 'Языки', 24, 6, 15),
  Deck('Румынский язык: глаголы A2', 'Языки', 18, 4, 9),
  Deck('Дискретная математика', 'Математика', 16, 5, 8),
  Deck('Матанализ: производные и интегралы', 'Математика', 20, 3, 14),
  Deck('Алгоритмы и структуры данных', 'Программирование', 22, 7, 10),
  Deck('Dart и Flutter: виджеты', 'Программирование', 15, 2, 11),
  Deck('Физика: механика', 'Естественные науки', 12, 4, 5),
  Deck('Микроэкономика: основные понятия рыночного равновесия', 'Экономика', 10, 0, 10),
];

/// Карточки первой колоды («Английский: IT-лексика») — для экрана колоды.
final mockCards = [
  Flashcard(
    'deployment',
    'развёртывание — выкладка приложения на сервер',
    2.5,
    6,
    DateTime(2026, 11, 4),
  ),
  Flashcard('to merge', 'объединять (ветки в Git)', 2.36, 15, DateTime(2026, 11, 12)),
  Flashcard('bug report', 'отчёт об ошибке', 2.6, 24, DateTime(2026, 11, 25)),
  Flashcard('backward compatible', 'обратно совместимый', 2.1, 3, DateTime(2026, 11, 4)),
  Flashcard('throughput', 'пропускная способность', 1.9, 1, DateTime(2026, 11, 4)),
  Flashcard('to deprecate', 'объявлять устаревшим (API, метод)', 2.5, 9, DateTime(2026, 11, 9)),
  Flashcard('requirement', 'требование', 2.8, 32, DateTime(2026, 12, 3)),
  Flashcard('edge case', 'граничный случай', 2.3, 4, DateTime(2026, 11, 5)),
  Flashcard('latency', 'задержка, время отклика', 2.5, 1, DateTime(2026, 11, 4)),
  Flashcard(
    'release candidate',
    'кандидат в релиз — версия перед выпуском',
    2.7,
    21,
    DateTime(2026, 11, 22),
  ),
];

/// История сессий повторения — для экранов статистики и профиля.
final mockSessions = [
  ReviewSession('Английский: IT-лексика', DateTime(2026, 11, 3, 21, 40), 18, 15),
  ReviewSession('Алгоритмы и структуры данных', DateTime(2026, 11, 3, 8, 15), 12, 9),
  ReviewSession('Дискретная математика', DateTime(2026, 11, 2, 19, 5), 10, 7),
  ReviewSession('Румынский язык: глаголы A2', DateTime(2026, 11, 2, 7, 50), 15, 14),
  ReviewSession('Dart и Flutter: виджеты', DateTime(2026, 11, 1, 22, 10), 8, 8),
  ReviewSession('Физика: механика', DateTime(2026, 10, 31, 18, 30), 9, 5),
  ReviewSession('Матанализ: производные и интегралы', DateTime(2026, 10, 30, 20, 0), 14, 11),
  ReviewSession('Английский: IT-лексика', DateTime(2026, 10, 29, 9, 20), 20, 17),
];

/// Карточек повторено по дням недели (Пн…Вс) — для графика активности.
const mockWeekActivity = [22, 35, 18, 27, 0, 14, 30];
