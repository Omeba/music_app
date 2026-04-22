import 'package:music_app/models/note.dart';

class MelodyNote extends Note {
  final Duration? restAfter;

  const MelodyNote(super.tone, {this.restAfter});
}
