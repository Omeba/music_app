import 'package:hive/hive.dart';
import 'package:music_app/models/melody.dart';

class MelodyRepository {
  final Box<Melody> _melodyBox;

  MelodyRepository(this._melodyBox);

  List<Melody> getAllMelodies() => _melodyBox.values.toList();
  Melody? getMelody(String id) => _melodyBox.get(id);
  Future<void> saveMelody(Melody melody) => _melodyBox.put(melody.id, melody);
  Future<void> deleteMelody(String id) => _melodyBox.delete(id);
}
