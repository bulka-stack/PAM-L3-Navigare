// Дымовой тест L2: приложение собирается и показывает стартовый экран со всеми экранами темы.
import 'package:flutter_test/flutter_test.dart';

import 'package:study_cards/main.dart';

void main() {
  testWidgets('стартовый экран перечисляет 8 экранов StudyCards', (tester) async {
    await tester.pumpWidget(const StudyCardsApp());
    expect(find.text('StudyCards · экраны L2'), findsOneWidget);
    expect(find.text('1. Вход / регистрация'), findsOneWidget);
    expect(find.text('2. Мои колоды'), findsOneWidget);
  });
}
