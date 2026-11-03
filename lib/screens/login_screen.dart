import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

/// Экран 1. Вход / регистрация.
/// L3: локальная валидация (Form + validator) и context.go после входа —
/// login уходит из стека, «назад» в него не ведёт.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _showPassword = false; // эфемерное состояние экрана → setState

  static final _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _emailCtrl.dispose(); // кто создаёт, тот освобождает
    _passCtrl.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Введите e-mail';
    if (!v.contains('@') || !_emailRe.hasMatch(v)) return 'Неверный формат e-mail';
    return null; // null = ВАЛИДНО
  }

  String? _validatePassword(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Введите пароль';
    if (v.length < 6) return 'Пароль — минимум 6 символов';
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return; // ошибки уже на экране
    context.go('/decks'); // go, НЕ push: login уходит из стека
  }

  @override
  Widget build(BuildContext context) {
    final duo = context.duo;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.alternate_email_rounded),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: !_showPassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    hintText: 'Пароль',
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                      tooltip: _showPassword ? 'Скрыть пароль' : 'Показать пароль',
                      icon: Icon(
                        _showPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      ),
                      onPressed: () => setState(() => _showPassword = !_showPassword),
                    ),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24),
                DuoButton(label: 'Войти', onPressed: _submit),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Регистрация появится вместе с сервером')),
                  ),
                  child: const Text('Нет аккаунта? Зарегистрируйтесь'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
