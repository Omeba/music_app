import 'dart:math';

import 'package:music_app/models/audio_player_facade.dart';
import 'package:music_app/models/chord.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/models/round.dart';
import 'package:music_app/models/tonality.dart';

class ChordGuessLevel extends Level {
  final List<Chord> possibleChords;
  final Random _random = Random();

  ChordGuessLevel(
    super.id,
    super.scoreToComplete,
    super.rounds,
    super.difficulty,
    super.currentTonality,
    this.possibleChords,
  );

  Duration? get timeLimit {
    switch (difficulty) {
      case Difficulty.easy:
        return null;
      case Difficulty.medium:
        return Duration(seconds: 10);
      case Difficulty.hard:
        return Duration(seconds: 5);
    }
  }

  @override
  ChordGuessRound getRound() {
    return ChordGuessRound(
      timeLimit,
      possibleChords[_random.nextInt(possibleChords.length)],
      currentTonality!,
    );
  }

  @override
  Future<void> playRound(Round round, AudioPlayerFacade player) async {
    round as ChordGuessRound;
    await player.playChord(round.currentChord);
  }

  @override
  Tonality getTonalityForRound(int roundIndex) {
    if (currentTonality == null || roundIndex % 5 == 0) {
      currentTonality = Tonality.random();
    }
    return currentTonality!;
  }
}

class ChordGuessRound extends Round {
  final Chord currentChord;
  final Tonality tonality;

  ChordGuessRound(super.duration, this.currentChord, this.tonality);
}
