import 'package:hive/hive.dart';
import 'package:music_app/models/level.dart';

class LevelRepository {
  final Box<Level> _levelBox;

  LevelRepository(this._levelBox);

  List<Level> getAllLevels() => _levelBox.values.toList();
  Level? getLevel(String id) => _levelBox.get(id);
  Future<void> saveLevel(Level level) => _levelBox.put(level.id, level);
  Future<void> deleteLevel(String id) => _levelBox.delete(id);
}
