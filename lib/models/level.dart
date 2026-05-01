import 'package:music_app/models/question_settings.dart';

class Level {
  final String id;
  final String groupId;
  final int scoreToComplete;
  final int questions;
  final QuestionSettings questionSettings;
  int bestScore = 0;
  bool get isCompleted => bestScore >= scoreToComplete;

  Level(
    this.id,
    this.groupId,
    this.scoreToComplete,
    this.questions,
    this.questionSettings,
  );
}
