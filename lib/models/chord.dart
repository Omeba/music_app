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

  factory Chord.diminished(int root, Duration duration) {
    return Chord([Note(root), Note(root + 3), Note(root + 6)], duration);
  }

  factory Chord.augmented(int root, Duration duration) {
    return Chord([Note(root), Note(root + 4), Note(root + 8)], duration);
  }

  factory Chord.fromRootAndQuality(
    String root,
    String quality, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    const noteToTone = {
      'C': 0,
      'C#': 1,
      'Db': 1,
      'D': 2,
      'D#': 3,
      'Eb': 3,
      'E': 4,
      'Fb': 4,
      'E#': 5,
      'F': 5,
      'F#': 6,
      'Gb': 6,
      'G': 7,
      'G#': 8,
      'Ab': 8,
      'A': 9,
      'A#': 10,
      'Bb': 10,
      'B': 11,
      'Cb': 11,
      'B#': 0,
    };
    final rootTone = noteToTone[root] ?? 0;

    switch (quality) {
      case '':
        return Chord.major(rootTone, duration);
      case 'm':
        return Chord.minor(rootTone, duration);
      case 'dim':
        return Chord.diminished(rootTone, duration);
      case 'aug':
        return Chord.augmented(rootTone, duration);
      default:
        return Chord.major(rootTone, duration);
    }
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
