import 'package:hive/hive.dart';
import 'package:music_app/models/chord_progression.dart';

class ChordProgressionRepository {
  final Box<ChordProgression> _chordProgressionBox;

  ChordProgressionRepository(this._chordProgressionBox);

  List<ChordProgression> getAllChordProgressions() =>
      _chordProgressionBox.values.toList();
  ChordProgression? getChordProgression(String id) =>
      _chordProgressionBox.get(id);
  Future<void> saveChordProgression(ChordProgression progression) =>
      _chordProgressionBox.put(progression.id, progression);

  Future<void> deleteChordProgression(String id) =>
      _chordProgressionBox.delete(id);
}
