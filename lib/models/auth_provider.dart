// lib/providers/auth_provider.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/auth_service.dart';
import 'package:music_app/repositories/level_repository.dart';
import 'package:music_app/repositories/progress_repository.dart';

// Состояние аутентификации
enum AuthStatus { loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? email; // сохраняем email для UI (опционально)

  const AuthState({required this.status, this.errorMessage, this.email});

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      email: email ?? this.email,
    );
  }
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() async {
    // Инициализация: проверяем, есть ли сохранённый токен и действителен ли он
    final authService = ref.read(authServiceProvider);
    final isValid = await authService.hasValidToken();
    if (isValid) {
      // Токен валиден – можно считать, что пользователь авторизован
      return AuthState(status: AuthStatus.authenticated);
    } else {
      // Токена нет или просрочен – состояние "неавторизован"
      return AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> sendCode(String email) async {
    // Перед отправкой можно обновить UI, показав загрузку
    state = AsyncValue.data(
      AuthState(status: AuthStatus.loading, email: email),
    );
    try {
      await ref.read(authServiceProvider).sendVerificationCode(email);
      // Код отправлен, остаёмся в состоянии "ожидания кода"
      state = AsyncValue.data(
        AuthState(status: AuthStatus.unauthenticated, email: email),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> verifyCode(String email, String code) async {
    state = AsyncValue.data(
      AuthState(status: AuthStatus.loading, email: email),
    );
    try {
      await ref.read(authServiceProvider).verifyCode(email, code);
      // Успешно – статус "авторизован"
      state = AsyncValue.data(
        AuthState(status: AuthStatus.authenticated, email: email),
      );

      // Запускаем синхронизацию уровней после входа
      await ref.read(levelRepositoryProvider).syncIfNeeded();
      // Опционально: синхронизация прогресса
      await ref.read(progressRepositoryProvider).syncProgress();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    try {
      await ref.read(authServiceProvider).logout();
      state = AsyncValue.data(AuthState(status: AuthStatus.unauthenticated));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Провайдер
final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
