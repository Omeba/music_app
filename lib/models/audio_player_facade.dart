import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/chord.dart';
import 'package:music_app/models/chord_player.dart';
import 'package:music_app/models/chord_progression.dart';
import 'package:music_app/models/chord_progression_player.dart';
import 'package:music_app/models/melody.dart';
import 'package:music_app/models/melody_player.dart';

final audioPlayerProvider = Provider((ref) {
  final chordPlayer = ref.watch(chordPlayerProvider);
  final melodyPlayer = ref.watch(melodyPlayerProvider);
  final chordProgressionPlayer = ref.watch(chordProgressionPlayerProvider);
  return AudioPlayerFacade(chordPlayer, melodyPlayer, chordProgressionPlayer);
});

class AudioPlayerFacade {
  final ChordPlayer _chordPlayer;
  final MelodyPlayer _melodyPlayer;
  final ChordProgressionPlayer _chordProgressionPlayer;

  AudioPlayerFacade(
    this._chordPlayer,
    this._melodyPlayer,
    this._chordProgressionPlayer,
  );

  Future<void> playChord(Chord chord) async {
    await _chordPlayer.playChord(chord);
  }

  Future<void> playMelody(Melody melody) async {
    await _melodyPlayer.playMelody(melody);
  }

  Future<void> playChordProgression(ChordProgression progression) async {
    await _chordProgressionPlayer.playChordProgression(progression);
  }
}
