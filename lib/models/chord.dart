import 'package:music_app/models/note.dart';

class Chord {
  final List<Note> notes;
  final Duration duration;

  Chord(this.notes, this.duration);

  factory Chord.major(int root, Duration duration) {
    return Chord([Note(root), Note(root + 4), Note(root + 7)], duration);
  }

  factory Chord.minor(int root, Duration duration) {
    return Chord([Note(root), Note(root + 3), Note(root + 7)], duration);
  }

  Chord invert({int steps = 1}) {
    if (steps <= 0) return this;

    List<Note> newNotes = List<Note>.from(notes)
      ..sort((a, b) => a.tone.compareTo(b.tone));

    for (int i = 0; i < steps; i++) {
      var newNote = newNotes[0].octaveUp;
      newNotes.removeAt(0);
      newNotes.add(newNote);
    }

    return Chord(newNotes, duration);
  }
}
