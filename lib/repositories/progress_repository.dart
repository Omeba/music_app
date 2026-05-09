import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:music_app/models/progress.dart';
import 'package:music_app/models/sync_service.dart';

final progressRepositoryProvider = Provider((ref) {
  final Box<Progress> progressBox = Hive.box('progressBox');
  final syncService = ref.watch(syncServiceProvider);
  return ProgressRepository(progressBox, syncService);
});

class ProgressRepository {
  final Box<Progress> _progressBox;
  final SyncService _syncService;

  ProgressRepository(this._progressBox, this._syncService);

  Future<void> addAttempt(Progress attempt) => _progressBox.add(attempt);

  Future<bool> syncProgress() async {
    final unsynced = _progressBox.values.where((a) => !a.synced).toList();
    if (unsynced.isEmpty) return true;

    try {
      final count = await _syncService.pushProgress(unsynced);
      if (count == unsynced.length) {
        for (var attempt in unsynced) {
          attempt.synced = true;
          await attempt.save();
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  List<Progress> getAllAttempts() => _progressBox.values.toList();
}
