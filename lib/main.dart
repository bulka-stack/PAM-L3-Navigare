import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

void main() => runApp(const StudyCardsApp());

class StudyCardsApp extends StatelessWidget {
  const StudyCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // L3: MaterialApp.router — навигацию принимает router, параметр home: исчез.
    return MaterialApp.router(
      title: 'StudyCards',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(), // тема из L2 — без изменений
      routerConfig: router,
    );
  }
}
