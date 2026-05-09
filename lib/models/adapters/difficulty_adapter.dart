import 'package:hive/hive.dart';
import 'package:music_app/models/level.dart';

class DifficultyAdapter extends TypeAdapter<Difficulty> {
  @override
  final int typeId = 1;

  @override
  Difficulty read(BinaryReader reader) {
    return Difficulty.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, Difficulty obj) {
    writer.writeInt(obj.index);
  }
}
