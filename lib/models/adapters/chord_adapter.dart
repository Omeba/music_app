import 'package:hive/hive.dart';
import 'package:music_app/models/chord.dart';
import 'package:music_app/models/note.dart';

class ChordAdapter extends TypeAdapter<Chord> {
  @override
  final int typeId = 4;

  @override
  Chord read(BinaryReader reader) {
    final notesLength = reader.readInt();
    final notes = List<Note>.generate(
      notesLength,
      (_) => reader.read() as Note,
    );
    final duration = Duration(microseconds: reader.readInt());
    return Chord(notes, duration);
  }

  @override
  void write(BinaryWriter writer, Chord obj) {
    writer.writeInt(obj.notes.length);
    for (final note in obj.notes) {
      writer.write(note);
    }
    writer.writeInt(obj.duration.inMicroseconds);
  }
}
