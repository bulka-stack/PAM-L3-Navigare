import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import 'decks_screen.dart';

/// Экран 1. Вход / регистрация — строго статический (L2):
/// два TextField-а, FilledButton «Войти», ссылка на регистрацию; без Form и validator.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(28),
                    border: Border(bottom: BorderSide(color: duo.greenShadow, width: 6)),
                  ),
                  child: Icon(Icons.style_rounded, size: 56, color: scheme.onPrimary),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'StudyCards',
                textAlign: TextAlign.center,
                style: text.headlineMedium?.copyWith(color: scheme.primary),
              ),
              const SizedBox(height: 6),
              Text(
                'Запоминай термины и формулы по 5 минут в день',
                textAlign: TextAlign.center,
                style: text.bodyLarge?.copyWith(color: duo.muted),
              ),
              const SizedBox(height: 32),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Пароль',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
              ),
              const SizedBox(height: 24),
              DuoButton(
                label: 'Войти',
                // L2: без проверки полей — только переход на стартовый экран,
                // чтобы не блокировать демонстрацию.
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DecksScreen())),
              ),
              const SizedBox(height: 12),
              TextButton(onPressed: () {}, child: const Text('Нет аккаунта? Зарегистрируйтесь')),
            ],
          ),
        ),
      ),
    );
  }
}
