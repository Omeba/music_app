import 'package:hive/hive.dart';
import 'package:music_app/models/note.dart';

@HiveType(typeId: 4)
class Chord {
  @HiveField(0)
  final List<Note> notes;
  @HiveField(1)
  final Duration duration;
  @HiveField(2)
  final String? name;

  Chord(this.notes, this.duration, {this.name});

  factory Chord.major(int root, Duration duration, {String? name}) {
    return Chord(
      [Note(root), Note(root + 4), Note(root + 7)],
      duration,
      name: name,
    );
  }

  factory Chord.minor(int root, Duration duration, {String? name}) {
    return Chord(
      [Note(root), Note(root + 3), Note(root + 7)],
      duration,
      name: name,
    );
  }

  factory Chord.diminished(int root, Duration duration, {String? name}) {
    return Chord(
      [Note(root), Note(root + 3), Note(root + 6)],
      duration,
      name: name,
    );
  }

  factory Chord.augmented(int root, Duration duration, {String? name}) {
    return Chord(
      [Note(root), Note(root + 4), Note(root + 8)],
      duration,
      name: name,
    );
  }

  factory Chord.fromRootAndQuality(
    String root,
    String quality, {
    Duration duration = const Duration(milliseconds: 1000),
    String? name,
  }) {
    const noteToTone = {
      'C': 36,
      'C#': 37,
      'Db': 37,
      'D': 38,
      'D#': 39,
      'Eb': 39,
      'E': 40,
      'Fb': 40,
      'E#': 41,
      'F': 41,
      'F#': 42,
      'Gb': 42,
      'G': 43,
      'G#': 44,
      'Ab': 44,
      'A': 45,
      'A#': 46,
      'Bb': 46,
      'B': 47,
      'Cb': 47,
      'B#': 36,
    };
    final rootTone = noteToTone[root] ?? 0;

    switch (quality) {
      case '':
        return Chord.major(rootTone, duration, name: name);
      case 'm':
        return Chord.minor(rootTone, duration, name: name);
      case 'dim':
        return Chord.diminished(rootTone, duration, name: name);
      case 'aug':
        return Chord.augmented(rootTone, duration, name: name);
      default:
        return Chord.major(rootTone, duration, name: name);
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
