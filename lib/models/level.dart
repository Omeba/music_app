import 'package:music_app/models/audio_player_facade.dart';
import 'package:music_app/models/round.dart';
import 'package:music_app/models/tonality.dart';

enum Difficulty { easy, medium, hard }

abstract class Level {
  final String id;
  final String? previousId;
  final String? nextId;
  final int scoreToComplete;
  final int rounds;
  final Difficulty difficulty;
  Tonality? currentTonality;
  int bestScore = 0;
  bool get isCompleted => bestScore >= scoreToComplete;

  Level(
    this.id,
    this.scoreToComplete,
    this.rounds,
    this.difficulty,
    this.currentTonality, {
    this.previousId,
    this.nextId,
  });

  Round getRound();

  Tonality getTonalityForRound(int roundIndex);

  Future<void> playRound(Round round, AudioPlayerFacade player);
}
