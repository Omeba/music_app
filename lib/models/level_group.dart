import 'package:music_app/models/level.dart';

class LevelGroup {
  final String id;
  String? _previousGroupId;
  String? _nextGroupId;
  List<Level> levels = [];

  LevelGroup(this.id);

  void setNextGroup(LevelGroup next) {
    _nextGroupId = next.id;
    next._previousGroupId = id;
  }

  void setPreviousGroup(LevelGroup prev) {
    _previousGroupId = prev.id;
    prev._nextGroupId = id;
  }

  static void connectGroups(LevelGroup prev, LevelGroup next) {
    prev._nextGroupId = next.id;
    next._previousGroupId = prev.id;
  }
}
