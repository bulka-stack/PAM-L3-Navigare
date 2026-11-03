import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

void main() => runApp(const StudyCardsApp());

class StudyCardsApp extends StatelessWidget {
  const StudyCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyCards',
      debugShowCheckedModeBanner: false,
      // ColorScheme.fromSeed(seedColor: studySeed) — см. theme/app_theme.dart
      theme: buildAppTheme(),
      home: const Scaffold(body: Center(child: Text('StudyCards'))),
    );
  }
}
