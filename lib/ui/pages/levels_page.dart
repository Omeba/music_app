// lib/ui/pages/levels_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/repositories/level_repository.dart';
import 'package:music_app/ui/pages/game_page.dart';

final levelsProvider = FutureProvider<List<Level>>((ref) {
  final repo = ref.read(levelRepositoryProvider);
  return repo.getAllLevels();
});

class LevelsPage extends ConsumerWidget {
  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsAsync = ref.watch(levelsProvider);
    final repository = ref.read(levelRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Уровни'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () async {
              await repository.syncIfNeeded(forceFullSync: true);
              ref.invalidate(levelsProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Синхронизация завершена')),
                );
              }
            },
          ),
        ],
      ),
      body: levelsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Ошибка: $err')),
        data: (levels) {
          if (levels.isEmpty) {
            return const Center(child: Text('Нет уровней'));
          }
          return ListView.builder(
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index];
              return ListTile(
                title: Text(level.id),
                subtitle: Text('Сложность: ${level.difficulty}'),
                trailing: level.isCompleted
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GamePage(level: level)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
