import 'package:music_app/models/chord.dart';
import 'package:music_app/models/music_engine.dart';

class ChordPlayer {
  final MusicEngine _engine;
  int channel;

  ChordPlayer(this._engine, this.channel);

  Future<void> playChord(Chord chord) async {
    for (var i in chord.notes) {
      await _engine.playNote(i.tone, channel: channel);
    }
    if (chord.duration != null) {
      Future.delayed(chord.duration!, () => stopChord(chord));
    }
  }

  Future<void> stopChord(Chord chord) async {
    for (var i in chord.notes) {
      await _engine.stopNote(i.tone, channel: channel);
    }
  }
}
