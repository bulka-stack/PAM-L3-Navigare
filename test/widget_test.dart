// Дымовой тест L3: приложение стартует на экране входа, валидация не пускает пустую форму.
import 'package:flutter_test/flutter_test.dart';

import 'package:study_cards/main.dart';

void main() {
  testWidgets('старт на /login, пустая форма показывает ошибки', (tester) async {
    await tester.pumpWidget(const StudyCardsApp());
    await tester.pumpAndSettle();
    expect(find.text('StudyCards'), findsOneWidget);

    await tester.tap(find.text('ВОЙТИ'));
    await tester.pump();
    expect(find.text('Введите e-mail'), findsOneWidget);
    expect(find.text('Введите пароль'), findsOneWidget);
  });
}
