import 'package:music_app/models/note.dart';

class Melody {
  final String id;
  final List<Note> notes;

  const Melody(this.id, this.notes);
}
