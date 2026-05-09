import 'package:hive/hive.dart';
import 'package:music_app/models/note.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 5;

  @override
  Note read(BinaryReader reader) {
    final tone = reader.readInt();
    final duration = Duration(microseconds: reader.readInt());
    return Note(tone, duration: duration);
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeInt(obj.tone);
    writer.writeInt(obj.duration.inMicroseconds);
  }
}
