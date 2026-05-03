import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/chord.dart';
import 'package:music_app/models/music_engine.dart';

final chordPlayerProvider = Provider((ref) {
  final engine = ref.watch(musicEngineProvider);
  return ChordPlayer(engine, 1);
});

class ChordPlayer {
  final MusicEngine _engine;
  int channel;

  ChordPlayer(this._engine, this.channel);

  Future<void> playChord(Chord chord) async {
    for (var i in chord.notes) {
      await _engine.playNote(i.tone, channel: channel);
    }
    Future.delayed(chord.duration, () => stopChord(chord));
  }

  Future<void> stopChord(Chord chord) async {
    for (var i in chord.notes) {
      await _engine.stopNote(i.tone, channel: channel);
    }
  }
}
