// Зашитые в код данные (L2 → L3: у каждой сущности появился id).
// Поля взяты из модели данных темы T13 (Deck, Card, ReviewSession).

/// Колода карточек по дисциплине.
class Deck {
  final int id; // НОВОЕ на L3: идентичность, которая путешествует в адресе /decks/:id
  final String name;
  final String subject;
  final int cardCount;
  final int dueToday; // карточек к повторению сегодня
  final int learned; // карточек с интервалом ≥ 21 дня («выучено»)

  const Deck(this.id, this.name, this.subject, this.cardCount, this.dueToday, this.learned);
}

/// Флеш-карточка: лицевая и обратная сторона + параметры интервального повторения.
/// (Класс не называется Card, чтобы не конфликтовать с виджетом Card из Material.)
class Flashcard {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final double easeFactor;
  final int intervalDays;
  final DateTime nextReviewAt;

  const Flashcard(
    this.id,
    this.deckId,
    this.front,
    this.back,
    this.easeFactor,
    this.intervalDays,
    this.nextReviewAt,
  );
}

/// Завершённая сессия повторения.
class ReviewSession {
  final int id;
  final int deckId;
  final String deckName;
  final DateTime date;
  final int reviewedCount;
  final int correctCount;

  const ReviewSession(
    this.id,
    this.deckId,
    this.deckName,
    this.date,
    this.reviewedCount,
    this.correctCount,
  );
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

/// «Сегодня» для зашитых данных (дата повторения сравнивается с ней).
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
  Deck(1, 'Английский: IT-лексика', 'Языки', 10, 4, 3),
  Deck(2, 'Румынский язык: глаголы A2', 'Языки', 7, 3, 2),
  Deck(3, 'Дискретная математика', 'Математика', 6, 3, 1),
  Deck(4, 'Матанализ: производные и интегралы', 'Математика', 7, 2, 4),
  Deck(5, 'Алгоритмы и структуры данных', 'Программирование', 7, 4, 2),
  Deck(6, 'Dart и Flutter: виджеты', 'Программирование', 6, 1, 3),
  Deck(7, 'Физика: механика', 'Естественные науки', 6, 3, 1),
  Deck(8, 'Микроэкономика: основные понятия рыночного равновесия', 'Экономика', 6, 0, 6),
];

/// Карточки всех колод (deckId связывает карточку с колодой).
final mockCards = [
  // Английский: IT-лексика
  Flashcard(
    1,
    1,
    'deployment',
    'развёртывание — выкладка приложения на сервер',
    2.5,
    6,
    DateTime(2026, 11, 4),
  ),
  Flashcard(2, 1, 'to merge', 'объединять (ветки в Git)', 2.36, 15, DateTime(2026, 11, 12)),
  Flashcard(3, 1, 'bug report', 'отчёт об ошибке', 2.6, 24, DateTime(2026, 11, 25)),
  Flashcard(4, 1, 'backward compatible', 'обратно совместимый', 2.1, 3, DateTime(2026, 11, 4)),
  Flashcard(5, 1, 'throughput', 'пропускная способность', 1.9, 1, DateTime(2026, 11, 4)),
  Flashcard(
    6,
    1,
    'to deprecate',
    'объявлять устаревшим (API, метод)',
    2.5,
    9,
    DateTime(2026, 11, 9),
  ),
  Flashcard(7, 1, 'requirement', 'требование', 2.8, 32, DateTime(2026, 12, 3)),
  Flashcard(8, 1, 'edge case', 'граничный случай', 2.3, 4, DateTime(2026, 11, 5)),
  Flashcard(9, 1, 'latency', 'задержка, время отклика', 2.5, 1, DateTime(2026, 11, 4)),
  Flashcard(
    10,
    1,
    'release candidate',
    'кандидат в релиз — версия перед выпуском',
    2.7,
    21,
    DateTime(2026, 11, 22),
  ),
  // Румынский язык: глаголы A2
  Flashcard(11, 2, 'a merge', 'идти (eu merg, tu mergi)', 2.5, 12, DateTime(2026, 11, 10)),
  Flashcard(12, 2, 'a vrea', 'хотеть (eu vreau, tu vrei)', 2.4, 5, DateTime(2026, 11, 4)),
  Flashcard(13, 2, 'a putea', 'мочь (eu pot, tu poți)', 2.2, 2, DateTime(2026, 11, 4)),
  Flashcard(14, 2, 'a ști', 'знать (eu știu, tu știi)', 2.6, 25, DateTime(2026, 11, 24)),
  Flashcard(15, 2, 'a lua', 'брать (eu iau, tu iei)', 2.0, 1, DateTime(2026, 11, 4)),
  Flashcard(16, 2, 'a face', 'делать (eu fac, tu faci)', 2.7, 30, DateTime(2026, 11, 30)),
  Flashcard(17, 2, 'a spune', 'говорить, сказать (eu spun)', 2.5, 7, DateTime(2026, 11, 7)),
  // Дискретная математика
  Flashcard(
    18,
    3,
    'Формула включений-исключений для двух множеств',
    '|A ∪ B| = |A| + |B| − |A ∩ B|',
    2.3,
    4,
    DateTime(2026, 11, 4),
  ),
  Flashcard(
    19,
    3,
    'Число сочетаний C(n, k)',
    'n! / (k! · (n − k)!)',
    2.5,
    10,
    DateTime(2026, 11, 8),
  ),
  Flashcard(20, 3, 'Число размещений A(n, k)', 'n! / (n − k)!', 2.1, 2, DateTime(2026, 11, 4)),
  Flashcard(21, 3, 'Закон де Моргана', '¬(A ∧ B) ≡ ¬A ∨ ¬B', 2.6, 22, DateTime(2026, 11, 19)),
  Flashcard(22, 3, 'Импликация A → B через ∨', '¬A ∨ B', 1.8, 1, DateTime(2026, 11, 4)),
  Flashcard(
    23,
    3,
    'Сумма степеней вершин графа',
    '2 · |E| (лемма о рукопожатиях)',
    2.5,
    8,
    DateTime(2026, 11, 6),
  ),
  // Матанализ: производные и интегралы
  Flashcard(24, 4, '(sin x)\'', 'cos x', 2.8, 35, DateTime(2026, 12, 4)),
  Flashcard(25, 4, '(ln x)\'', '1 / x', 2.7, 28, DateTime(2026, 11, 26)),
  Flashcard(26, 4, '(eˣ)\'', 'eˣ', 2.9, 40, DateTime(2026, 12, 7)),
  Flashcard(27, 4, '∫ 1/x dx', 'ln |x| + C', 2.4, 6, DateTime(2026, 11, 4)),
  Flashcard(28, 4, '(u · v)\'', 'u\'v + uv\'', 2.5, 14, DateTime(2026, 11, 13)),
  Flashcard(29, 4, '∫ cos x dx', 'sin x + C', 2.6, 21, DateTime(2026, 11, 21)),
  Flashcard(30, 4, '(tg x)\'', '1 / cos² x', 2.0, 2, DateTime(2026, 11, 4)),
  // Алгоритмы и структуры данных
  Flashcard(31, 5, 'Сложность бинарного поиска', 'O(log n)', 2.6, 23, DateTime(2026, 11, 23)),
  Flashcard(
    32,
    5,
    'Сложность быстрой сортировки (в среднем)',
    'O(n log n); в худшем случае O(n²)',
    2.2,
    3,
    DateTime(2026, 11, 4),
  ),
  Flashcard(
    33,
    5,
    'Стек',
    'LIFO: последним пришёл — первым вышел',
    2.7,
    30,
    DateTime(2026, 11, 29),
  ),
  Flashcard(34, 5, 'Очередь', 'FIFO: первым пришёл — первым вышел', 2.5, 9, DateTime(2026, 11, 4)),
  Flashcard(
    35,
    5,
    'Обход графа в ширину (BFS)',
    'использует очередь; находит кратчайший путь по рёбрам',
    2.0,
    1,
    DateTime(2026, 11, 4),
  ),
  Flashcard(36, 5, 'Хеш-таблица: поиск в среднем', 'O(1)', 2.4, 5, DateTime(2026, 11, 6)),
  Flashcard(
    37,
    5,
    'Алгоритм Дейкстры',
    'кратчайшие пути от вершины при неотрицательных весах',
    1.9,
    2,
    DateTime(2026, 11, 4),
  ),
  // Dart и Flutter: виджеты
  Flashcard(
    38,
    6,
    'StatelessWidget',
    'виджет без изменяемого состояния; build зависит только от параметров',
    2.7,
    26,
    DateTime(2026, 11, 24),
  ),
  Flashcard(
    39,
    6,
    'setState()',
    'помечает State «грязным» → build вызывается снова',
    2.5,
    12,
    DateTime(2026, 11, 11),
  ),
  Flashcard(
    40,
    6,
    'Expanded',
    'занимает оставшееся место в Row/Column по главной оси',
    2.3,
    4,
    DateTime(2026, 11, 4),
  ),
  Flashcard(
    41,
    6,
    'ListView.builder',
    'строит элементы лениво — только видимые',
    2.6,
    21,
    DateTime(2026, 11, 20),
  ),
  Flashcard(
    42,
    6,
    'context.push vs context.go',
    'push кладёт экран на стек; go заменяет стек по адресу',
    2.4,
    6,
    DateTime(2026, 11, 7),
  ),
  Flashcard(
    43,
    6,
    'Оператор ??',
    'возвращает правую часть, если левая равна null',
    2.8,
    33,
    DateTime(2026, 12, 2),
  ),
  // Физика: механика
  Flashcard(44, 7, 'Второй закон Ньютона', 'F = m · a', 2.6, 24, DateTime(2026, 11, 22)),
  Flashcard(45, 7, 'Кинетическая энергия', 'Eк = m · v² / 2', 2.2, 3, DateTime(2026, 11, 4)),
  Flashcard(46, 7, 'Импульс тела', 'p = m · v', 2.5, 8, DateTime(2026, 11, 4)),
  Flashcard(
    47,
    7,
    'Закон всемирного тяготения',
    'F = G · m₁ · m₂ / r²',
    1.9,
    1,
    DateTime(2026, 11, 4),
  ),
  Flashcard(48, 7, 'Работа силы', 'A = F · s · cos α', 2.3, 5, DateTime(2026, 11, 6)),
  Flashcard(49, 7, 'Мощность', 'N = A / t', 2.4, 6, DateTime(2026, 11, 8)),
  // Микроэкономика: основные понятия рыночного равновесия
  Flashcard(
    50,
    8,
    'Закон спроса',
    'при росте цены величина спроса снижается',
    2.7,
    28,
    DateTime(2026, 11, 28),
  ),
  Flashcard(
    51,
    8,
    'Равновесная цена',
    'цена, при которой Qd = Qs',
    2.6,
    22,
    DateTime(2026, 11, 23),
  ),
  Flashcard(
    52,
    8,
    'Эластичность спроса по цене',
    '% изменения Qd / % изменения цены',
    2.5,
    21,
    DateTime(2026, 11, 18),
  ),
  Flashcard(53, 8, 'Дефицит', 'Qd > Qs при цене ниже равновесной', 2.8, 30, DateTime(2026, 12, 1)),
  Flashcard(54, 8, 'Излишек', 'Qs > Qd при цене выше равновесной', 2.6, 25, DateTime(2026, 11, 26)),
  Flashcard(
    55,
    8,
    'Альтернативная стоимость',
    'ценность лучшей упущенной альтернативы',
    2.7,
    31,
    DateTime(2026, 11, 30),
  ),
];

/// История сессий повторения — для экранов статистики и профиля.
final mockSessions = [
  ReviewSession(1, 1, 'Английский: IT-лексика', DateTime(2026, 11, 3, 21, 40), 18, 15),
  ReviewSession(2, 5, 'Алгоритмы и структуры данных', DateTime(2026, 11, 3, 8, 15), 12, 9),
  ReviewSession(3, 3, 'Дискретная математика', DateTime(2026, 11, 2, 19, 5), 10, 7),
  ReviewSession(4, 2, 'Румынский язык: глаголы A2', DateTime(2026, 11, 2, 7, 50), 15, 14),
  ReviewSession(5, 6, 'Dart и Flutter: виджеты', DateTime(2026, 11, 1, 22, 10), 8, 8),
  ReviewSession(6, 7, 'Физика: механика', DateTime(2026, 10, 31, 18, 30), 9, 5),
  ReviewSession(7, 4, 'Матанализ: производные и интегралы', DateTime(2026, 10, 30, 20, 0), 14, 11),
  ReviewSession(8, 1, 'Английский: IT-лексика', DateTime(2026, 10, 29, 9, 20), 20, 17),
];

/// Карточек повторено по дням недели (Пн…Вс) — для графика активности.
const mockWeekActivity = [22, 35, 18, 27, 0, 14, 30];
