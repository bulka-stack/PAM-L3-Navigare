# StudyCards — флеш-карточки с интервальным повторением

Проект дисциплины PAM, тема **T13 StudyCards** (сложность: повышенная).
Автор: Andrii Kostin, группа TI-235. Преподаватель: унив. лектор Ionel Antohi.

**Этап L2 — статический UI.** Все 8 обязательных экранов из ТЗ темы построены в
Material 3 с зашитыми в код данными; навигация — временные «леса» (стартовый экран
со списком экранов и `Navigator.push`).

## Запуск

```bash
flutter pub get
flutter run            # эмулятор Android / телефон по USB
flutter run -d windows # или desktop-окно Windows (если нет эмулятора)
```

> Путь проекта содержит кириллицу (`Рабочий стол`). Если сборка Android падает,
> подключите папку как диск и собирайте оттуда:
> `subst P: "C:\Users\<user>\OneDrive\Рабочий стол\PAM"` → `cd /d P:\L2_UI_static_al_aplicatiei`.

## Структура `lib/`

```text
lib/
├── main.dart            MaterialApp + тема + стартовый экран
├── theme/app_theme.dart ColorScheme.fromSeed(зелёный) + DuoPalette (акценты в стиле Duolingo)
├── data/mock_data.dart  зашитые данные: колоды, карточки, сессии, пользователь
├── utils/formatters.dart склонения («5 карточек»), форматы дат
├── screens/             по одному файлу на экран (8 экранов ТЗ + home_screen — леса L2)
└── widgets/             переиспользуемые компоненты
```

## Экраны (по списку ТЗ)

| № | Экран ТЗ | Файл |
|---|---|---|
| 1 | Вход / регистрация | `screens/login_screen.dart` |
| 2 | Мои колоды (поиск + к повторению сегодня) | `screens/decks_screen.dart` |
| 3 | Карточка колоды (список карточек, статистика) | `screens/deck_detail_screen.dart` |
| 4 | Форма новой колоды / редактирования | `screens/deck_form_screen.dart` |
| 5 | Форма новой карточки (лицевая и обратная сторона) | `screens/card_form_screen.dart` |
| 6 | Сессия повторения (переворот + снова / хорошо / легко) | `screens/review_session_screen.dart` |
| 7 | Статистика (история сессий, % правильных) | `screens/stats_screen.dart` |
| 8 | Профиль пользователя | `screens/profile_screen.dart` |

## Переиспользуемые widget-ы

`DuoButton`, `DuoProgressBar`, `SubjectAvatar`, `DeckCard`, `FlashcardTile`, `StatTile`,
`SessionTile`, `SectionTitle`, `StreakChip`, `WeekActivityChart` — каждый используется
на нескольких экранах (см. комментарий в начале файла).

Шрифт: Nunito (SIL Open Font License, `assets/fonts/OFL.txt`).
