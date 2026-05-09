import 'package:hive/hive.dart';
import 'package:music_app/models/tonality.dart';

class TonalityAdapter extends TypeAdapter<Tonality> {
  @override
  final int typeId = 6;

  @override
  Tonality read(BinaryReader reader) {
    final rootMidi = reader.readInt();
    final modeIndex = reader.readByte();
    final mode = TonalityMode.values[modeIndex];
    return Tonality(rootMidi, mode);
  }

  @override
  void write(BinaryWriter writer, Tonality obj) {
    writer.writeInt(obj.rootMidi);
    writer.writeByte(obj.mode.index);
  }
}
