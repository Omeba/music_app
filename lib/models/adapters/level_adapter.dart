import 'package:hive/hive.dart';
import 'package:music_app/models/adapters/chord_guess_level_adapter.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/models/chord_guess_level.dart';

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 0; // совпадает с @HiveType(typeId: 0) у Level

  @override
  void write(BinaryWriter writer, Level obj) {
    if (obj is ChordGuessLevel) {
      writer.writeByte(2); // пишем идентификатор типа наследника
      final adapter = ChordGuessLevelAdapter();
      adapter.write(writer, obj);
    } else {
      throw UnsupportedError('Unknown Level subtype: ${obj.runtimeType}');
    }
    // в будущем добавьте другие наследники
  }

  @override
  Level read(BinaryReader reader) {
    final subtypeId = reader.readByte();
    switch (subtypeId) {
      case 2:
        final adapter = ChordGuessLevelAdapter();
        return adapter.read(reader);
      default:
        throw UnsupportedError('Unknown Level subtype ID: $subtypeId');
    }
  }
}
