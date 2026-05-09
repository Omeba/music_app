import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/auth_provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Center(
        child: authState.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => _buildError(err.toString()),
          data: (state) {
            if (state.status == AuthStatus.authenticated) {
              // Перенаправляем на главный экран после успешной авторизации
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/');
              });
              return const CircularProgressIndicator();
            }
            if (!codeSent) {
              return _buildEmailForm(state);
            } else {
              return _buildCodeForm(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmailForm(AuthState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Введите email для входа',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: state.status == AuthStatus.loading
                ? null
                : () async {
                    await ref
                        .read(authProvider.notifier)
                        .sendCode(emailController.text);
                    setState(() => codeSent = true);
                  },
            child: const Text('Отправить код'),
          ),
          if (state.status == AuthStatus.loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildCodeForm(AuthState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Введите код из письма',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: codeController,
            decoration: const InputDecoration(
              labelText: 'Код',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: state.status == AuthStatus.loading
                ? null
                : () async {
                    await ref
                        .read(authProvider.notifier)
                        .verifyCode(emailController.text, codeController.text);
                  },
            child: const Text('Подтвердить'),
          ),
          if (state.status == AuthStatus.loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ошибка: $message'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() => codeSent = false);
              ref.invalidate(authProvider);
            },
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }
}
