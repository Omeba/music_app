import 'package:hive/hive.dart';
import 'package:music_app/models/chord_guess_level.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/models/sync_service.dart';

class LevelRepository {
  final Box<Level> _levelBox;
  final Box _settingsBox;
  final SyncService _syncService;

  static const _lastSyncKey = '__last_sync_timestamp__';

  LevelRepository(this._levelBox, this._settingsBox, this._syncService);

  DateTime? get _lastSyncTimestamp {
    final raw = _settingsBox.get(_lastSyncKey);
    if (raw is String) return DateTime.tryParse(raw);
    return null;
  }

  Future<void> _setLastSyncTimestamp(DateTime dt) async {
    await _settingsBox.put(_lastSyncKey, dt.toUtc().toIso8601String());
  }

  Future<bool> syncIfNeeded({bool forceFullSync = false}) async {
    try {
      final lastSync = _lastSyncTimestamp;

      final serverLastModified = await _syncService.fetchLastModified();
      if (serverLastModified == null) {
        return true;
      }

      if (!forceFullSync &&
          lastSync != null &&
          !serverLastModified.isAfter(lastSync)) {
        return true;
      }

      List<Map<String, dynamic>> changedLevels;
      if (forceFullSync || lastSync == null) {
        changedLevels = await _syncService.fetchAllLevels();
      } else {
        changedLevels = await _syncService.fetchLevelsSince(lastSync);
      }

      for (final levelData in changedLevels) {
        await _applyLevelUpdate(levelData);
      }

      await _setLastSyncTimestamp(serverLastModified);
      return true;
    } catch (e) {
      print('Ошибка синхронизации уровней: $e');
      return false;
    }
  }

  Future<void> _applyLevelUpdate(Map<String, dynamic> levelData) async {
    final id = levelData['id'] as String;
    final localRaw = _levelBox.get(id);
    Level? localLevel;
    if (localRaw is Level) {
      localLevel = localRaw;
    }

    final serverUpdatedAt = levelData['updated_at'] != null
        ? DateTime.tryParse(levelData['updated_at'] as String)
        : null;

    if (localLevel == null) {
      final newLevel = _createLevelFromMap(levelData);
      if (newLevel != null) {
        await _levelBox.put(id, newLevel);
      }
    } else if (serverUpdatedAt != null &&
        (localLevel.updatedAt == null ||
            serverUpdatedAt.isAfter(localLevel.updatedAt!))) {
      final updatedLevel = _createLevelFromMap(levelData);
      if (updatedLevel != null) {
        updatedLevel.bestScore = localLevel.bestScore;
        updatedLevel.currentTonality = localLevel.currentTonality;
        await _levelBox.put(id, updatedLevel);
      }
    }
  }

  Level? _createLevelFromMap(Map<String, dynamic> map) {
    final type = map['type'] as String?;
    if (type == 'chord_guess') {
      return ChordGuessLevel.fromJson(map);
    }
    return null;
  }

  List<Level> getAllLevels() => _levelBox.values.toList();
  Level? getLevel(String id) => _levelBox.get(id);
  Future<void> saveLevel(Level level) => _levelBox.put(level.id, level);
  Future<void> deleteLevel(String id) => _levelBox.delete(id);
}
