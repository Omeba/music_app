import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/audio_player_facade.dart';

import 'package:music_app/models/level.dart';
import 'package:music_app/models/level_state.dart';
import 'package:music_app/models/round.dart';

final levelViewModelProvider = NotifierProvider<LevelViewModel, LevelState>(
  () => LevelViewModel(),
);

class LevelViewModel extends Notifier<LevelState> {
  Level? _level;
  Timer? _timer;

  @override
  LevelState build() {
    return LevelState.initial();
  }

  void startLevel(Level level) {
    state = state.copyWith(
      totalRounds: level.rounds,
      correctlyAnswered: 0,
      roundIndex: 0,
      state: LevelPhase.idle,
    );
    _level = level;
    _nextRound();
  }

  void _nextRound() {
    if (_level == null || state.roundIndex >= state.totalRounds) {
      state = state.copyWith(state: LevelPhase.finished);
      return;
    }
    final round = _level!.getRound();
    final tonality = _level!.getTonalityForRound(state.roundIndex);
    state = state.copyWith(
      currentRound: round,
      state: LevelPhase.idle,
      tonality: tonality,
    );
  }

  Future<void> playCurrentRound() async {
    final round = state.currentRound;
    if (_level == null || round == null) return;

    state = state.copyWith(state: LevelPhase.playing);
    final audioPlayer = ref.read(audioPlayerProvider);
    await _level!.playRound(round, audioPlayer);

    startTimerIfNeeded(round);
    state = state.copyWith(state: LevelPhase.waitingForAnswer);
  }

  void startTimerIfNeeded(Round round) {
    _timer?.cancel();
    final limit = round.duration;
    if (limit != null) {
      state = state.copyWith(remainingSeconds: limit.inSeconds);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
        if (state.remainingSeconds <= 0) {
          timer.cancel();
          _evaluateAnswer(null);
        }
      });
    }
  }

  void _evaluateAnswer(bool? isCorrect) {
    if (isCorrect == true) {
      state = state.copyWith(correctlyAnswered: state.correctlyAnswered + 1);
    }
    state = state.copyWith(state: LevelPhase.answered);

    Future.delayed(Duration(seconds: 1), () {
      state = state.copyWith(state: LevelPhase.idle);
    });
    state = state.copyWith(roundIndex: state.roundIndex);
    _nextRound();
  }
}
