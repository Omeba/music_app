import 'package:hive/hive.dart';

part 'level_attempt.g.dart';

@HiveType(typeId: 2)
class Progress extends HiveObject {
  @HiveField(0)
  final String levelId;

  @HiveField(1)
  final int score;

  @HiveField(2)
  final int timeSpentSeconds;

  @HiveField(3)
  final DateTime completedAt;

  @HiveField(4)
  bool synced;

  Progress({
    required this.levelId,
    required this.score,
    required this.timeSpentSeconds,
    required this.completedAt,
    this.synced = false,
  });

  /// Сериализация для отправки на сервер
  Map<String, dynamic> toJson() => {
    'levelId': levelId,
    'score': score,
    'timeSpentSeconds': timeSpentSeconds,
    'completedAt': completedAt.toIso8601String(),
  };
}
