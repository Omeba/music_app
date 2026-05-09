import 'package:hive/hive.dart';
import 'package:music_app/models/progress.dart';

class ProgressAdapter extends TypeAdapter<Progress> {
  @override
  final int typeId = 3; // убедитесь, что typeId уникален (не 2, т.к. 2 уже у ChordGuessLevel)

  @override
  Progress read(BinaryReader reader) {
    final levelId = reader.readString();
    final score = reader.readInt();
    final timeSpentSeconds = reader.readInt();
    final completedAtMillis = reader.readInt();
    final completedAt = DateTime.fromMillisecondsSinceEpoch(completedAtMillis);
    final synced = reader.readBool();
    return Progress(
      levelId: levelId,
      score: score,
      timeSpentSeconds: timeSpentSeconds,
      completedAt: completedAt,
      synced: synced,
    );
  }

  @override
  void write(BinaryWriter writer, Progress obj) {
    writer.writeString(obj.levelId);
    writer.writeInt(obj.score);
    writer.writeInt(obj.timeSpentSeconds);
    writer.writeInt(obj.completedAt.millisecondsSinceEpoch);
    writer.writeBool(obj.synced);
  }
}
