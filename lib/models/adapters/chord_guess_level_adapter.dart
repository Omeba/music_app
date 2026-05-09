import 'package:hive/hive.dart';
import 'package:music_app/models/chord_guess_level.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/models/chord.dart';
import 'package:music_app/models/tonality.dart';

class ChordGuessLevelAdapter extends TypeAdapter<ChordGuessLevel> {
  @override
  final int typeId = 2;

  @override
  ChordGuessLevel read(BinaryReader reader) {
    final id = reader.readString();
    final scoreToComplete = reader.readInt();
    final rounds = reader.readInt();
    final difficulty = reader.read() as Difficulty;
    final currentTonality = reader.read() as Tonality?;
    final possibleChords = reader.read() as List<Chord>;
    final previousId = reader.readString();

    // Читаем дату как long (millisecondsSinceEpoch), -1 означает null
    final updatedAtMillis = reader.readInt();
    final updatedAt = updatedAtMillis == -1
        ? null
        : DateTime.fromMillisecondsSinceEpoch(updatedAtMillis);

    final bestScore = reader.readInt();

    final level = ChordGuessLevel(
      id,
      scoreToComplete,
      rounds,
      difficulty,
      currentTonality,
      possibleChords,
      previousId: previousId.isEmpty ? null : previousId,
      updatedAt: updatedAt,
    );
    level.bestScore = bestScore;
    return level;
  }

  @override
  void write(BinaryWriter writer, ChordGuessLevel obj) {
    writer.writeString(obj.id);
    writer.writeInt(obj.scoreToComplete);
    writer.writeInt(obj.rounds);
    writer.write(obj.difficulty);
    writer.write(obj.currentTonality);
    writer.write(obj.possibleChords);
    writer.writeString(obj.previousId ?? '');
    // Пишем -1 если null, иначе миллисекунды
    writer.writeInt(obj.updatedAt?.millisecondsSinceEpoch ?? -1);
    writer.writeInt(obj.bestScore);
  }
}
