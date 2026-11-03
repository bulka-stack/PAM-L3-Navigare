// Дымовой тест L3: приложение стартует на экране входа.
import 'package:flutter_test/flutter_test.dart';

import 'package:study_cards/main.dart';

void main() {
  testWidgets('старт на /login', (tester) async {
    await tester.pumpWidget(const StudyCardsApp());
    await tester.pumpAndSettle();
    expect(find.text('StudyCards'), findsOneWidget);

  });
}
