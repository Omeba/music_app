import 'package:hive/hive.dart';
import 'package:music_app/models/audio_player_facade.dart';
import 'package:music_app/models/round.dart';
import 'package:music_app/models/tonality.dart';

@HiveType(typeId: 1)
enum Difficulty { easy, medium, hard }

@HiveType(typeId: 0)
abstract class Level {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? previousId;
  @HiveField(2)
  final int scoreToComplete;
  @HiveField(3)
  final int rounds;
  @HiveField(4)
  final Difficulty difficulty;
  @HiveField(5)
  final DateTime? updatedAt;
  Tonality? currentTonality;
  @HiveField(6)
  int bestScore = 0;
  bool get isCompleted => bestScore >= scoreToComplete;

  Level(
    this.id,
    this.scoreToComplete,
    this.rounds,
    this.difficulty,
    this.currentTonality, {
    this.previousId,
    this.updatedAt,
  });

  Round getRound();

  Tonality getTonalityForRound(int roundIndex);

  Future<void> playRound(Round round, AudioPlayerFacade player);
}
