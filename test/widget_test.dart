// Дымовой тест: приложение собирается и рисует MaterialApp.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:study_cards/main.dart';

void main() {
  testWidgets('приложение запускается', (tester) async {
    await tester.pumpWidget(const StudyCardsApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
