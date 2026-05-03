import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/models/round.dart';
import 'package:music_app/models/tonality.dart';

part 'level_state.freezed.dart';

enum LevelPhase { idle, playing, waitingForAnswer, answered, finished }

@freezed
abstract class LevelState with _$LevelState {
  const factory LevelState({
    required Round? currentRound,
    required int roundIndex,
    required int correctlyAnswered,
    required int totalRounds,
    required LevelPhase state,
    required int remainingSeconds,
    Tonality? tonality,
  }) = _LevelState;

  factory LevelState.initial() => const LevelState(
    currentRound: null,
    roundIndex: 0,
    correctlyAnswered: 0,
    totalRounds: 0,
    state: LevelPhase.idle,
    remainingSeconds: 0,
    tonality: null,
  );
}
