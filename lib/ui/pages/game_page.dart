// lib/ui/pages/game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/chord_guess_level.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/models/level_state.dart';
import 'package:music_app/models/level_view_model.dart';
import 'package:music_app/models/progress.dart';
import 'package:music_app/repositories/progress_repository.dart';
import 'package:music_app/ui/pages/result_page.dart';

class GamePage extends ConsumerStatefulWidget {
  final Level level;
  const GamePage({super.key, required this.level});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  late ChordGuessLevel _level;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _level = widget.level as ChordGuessLevel;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(levelViewModelProvider);
    final state = viewModel;

    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(levelViewModelProvider.notifier).startLevel(_level);
        setState(() => _initialized = true);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.state == LevelPhase.finished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onLevelFinished(state);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_level.id),
        actions: [Text('Раунд ${state.roundIndex + 1}/${state.totalRounds}')],
      ),
      body: Center(child: _buildGameBody(state)),
    );
  }

  Widget _buildGameBody(LevelState state) {
    switch (state.state) {
      case LevelPhase.idle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Очки: ${state.correctlyAnswered}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ref.read(levelViewModelProvider.notifier).playCurrentRound();
              },
              child: const Text('Послушать аккорд'),
            ),
          ],
        );
      case LevelPhase.playing:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Воспроизведение...'),
          ],
        );
      case LevelPhase.waitingForAnswer:
        return _buildAnswers(state);
      case LevelPhase.answered:
        return const Text(
          'Правильно!',
          style: TextStyle(color: Colors.green, fontSize: 24),
        );
      default:
        return const CircularProgressIndicator();
    }
  }

  Widget _buildAnswers(LevelState state) {
    if (_level.possibleChords.isEmpty) {
      return const Text('Нет доступных аккордов');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Очки: ${state.correctlyAnswered}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(levelViewModelProvider.notifier).playCurrentRound();
          },
          child: const Text('Послушать ещё раз'),
        ),
        const SizedBox(height: 20),
        ..._level.possibleChords.map((chord) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ElevatedButton(
              onPressed: () {
                final round = state.currentRound;
                if (round is ChordGuessRound) {
                  final isCorrect = round.currentChord == chord;
                  ref
                      .read(levelViewModelProvider.notifier)
                      .evaluateAnswer(isCorrect);
                }
              },
              child: Text(chord.name ?? 'Аккорд'),
            ),
          );
        }),
      ],
    );
  }

  void _onLevelFinished(LevelState state) {
    final progress = Progress(
      levelId: _level.id,
      score: state.correctlyAnswered,
      timeSpentSeconds: state.remainingSeconds > 0
          ? (state.totalRounds * 30) - state.remainingSeconds
          : 0,
      completedAt: DateTime.now().toUtc(),
    );
    ref.read(progressRepositoryProvider).addAttempt(progress);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(
          score: state.correctlyAnswered,
          totalRounds: state.totalRounds,
          timeSpentSeconds: 0,
        ),
      ),
    );
  }
}
