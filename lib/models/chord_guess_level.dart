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
    this.possibleChords, {
    super.previousId,
    super.updatedAt,
  });

  factory ChordGuessLevel.fromJson(Map<String, dynamic> json) {
    final chordsData = json['chords'] as List<dynamic>? ?? [];
    final possibleChords = chordsData.map((c) {
      final root = c['root_note'] as String;
      final quality = c['quality'] as String? ?? '';
      return Chord.fromRootAndQuality(root, quality);
    }).toList();

    return ChordGuessLevel(
      json['id'] as String,
      json['score_to_complete'] as int? ?? 5,
      json['rounds'] as int? ?? 10,
      _parseDifficulty(json['difficulty']),
      Tonality(1, TonalityMode.major),
      possibleChords,
      previousId: json['prev_level_id'] as String?,
    );
  }

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

  static Difficulty _parseDifficulty(dynamic value) {
    if (value is int) {
      return switch (value) {
        1 => Difficulty.easy,
        2 => Difficulty.medium,
        3 => Difficulty.hard,
        _ => Difficulty.medium,
      };
    }
    // fallback, если сервер пришлёт строку (на будущее)
    final str = value.toString().toLowerCase();
    return switch (str) {
      'easy' => Difficulty.easy,
      'medium' => Difficulty.medium,
      'hard' => Difficulty.hard,
      _ => Difficulty.medium,
    };
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
