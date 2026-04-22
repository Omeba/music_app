import 'package:flutter_riverpod/legacy.dart';

final levelViewModelProvider =
    StateNotifierProvider<LevelViewModel, LevelState>((ref) {});

class LevelState {
  late int scoreToComplete;
  late double timer;
  late int questions;
  late int finishedQuestions;
}

class LevelViewModel extends StateNotifier<LevelState> {
  final _melodyGenerator;
  final _chordGenerator;
  late String name;

  LevelViewModel(super.state);
}
