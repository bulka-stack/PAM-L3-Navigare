import 'package:go_router/go_router.dart';

import 'screens/card_form_screen.dart';
import 'screens/deck_detail_screen.dart';
import 'screens/deck_form_screen.dart';
import 'screens/decks_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/review_session_screen.dart';
import 'screens/stats_screen.dart';

/// Карта маршрутов: ВСЕ экраны ТЗ получают адрес.
final router = GoRouter(
  initialLocation: '/login', // приложение стартует в аутентификации
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/decks', builder: (context, state) => const DecksScreen()),
    // ФИКСИРОВАННЫЕ адреса стоят перед '/decks/:id', иначе int.parse('new') упадёт
    GoRoute(path: '/decks/new', builder: (context, state) => const DeckFormScreen()),
    GoRoute(path: '/decks/review', builder: (context, state) => const ReviewSessionScreen()),
    GoRoute(
      path: '/decks/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DeckDetailScreen(id: id);
      },
    ),
    GoRoute(
      path: '/decks/:id/edit',
      builder: (context, state) => DeckFormScreen(deckId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/decks/:id/review',
      builder: (context, state) =>
          ReviewSessionScreen(deckId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/decks/:id/cards/new',
      builder: (context, state) => CardFormScreen(deckId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/decks/:id/cards/:cardId',
      builder: (context, state) => CardFormScreen(
        deckId: int.parse(state.pathParameters['id']!),
        cardId: int.parse(state.pathParameters['cardId']!),
      ),
    ),
    GoRoute(path: '/stats', builder: (context, state) => const StatsScreen()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  ],
);
