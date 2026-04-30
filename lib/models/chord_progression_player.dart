import 'package:music_app/models/chord.dart';
import 'package:music_app/models/chord_player.dart';
import 'package:music_app/models/chord_progression.dart';

class ChordProgressionPlayer {
  final ChordPlayer _chordPlayer;
  int channel;
  ChordProgression _currentProgression = [] as ChordProgression;
  int _currentIndex = 0;
  CancellationToken? _token;

  ChordProgressionPlayer(this._chordPlayer, this.channel);

  Future<void> playChordProgression(ChordProgression progression) async {
    await stopChordProgression();
    _currentProgression = progression;
    _currentIndex = 0;
    _token = CancellationToken();
    _playNextChord(_token!);
  }

  Future<void> _playNextChord(CancellationToken token) async {
    if (token.isCancelled) return;

    if (_currentIndex >= _currentProgression.chords.length) {
      await stopChordProgression();
      return;
    }

    Chord currentChord = _currentProgression.chords[_currentIndex];
    await _chordPlayer.playChord(currentChord);

    Future.delayed(currentChord.duration, () async {
      if (token.isCancelled) {
        await _chordPlayer.stopChord(currentChord);
      }
    });

    await Future.delayed(currentChord.duration);
    if (!token.isCancelled) {
      _currentIndex++;
      await _playNextChord(token);
    }
  }

  Future<void> stopChordProgression() async {
    _token?.cancel();
    _token = null;
  }
}

class CancellationToken {
  bool _isCancelled = false;
  void cancel() => _isCancelled = true;
  bool get isCancelled => _isCancelled;
}
