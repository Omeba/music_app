import 'package:music_app/models/melody.dart';
import 'package:music_app/models/music_engine.dart';
import 'package:music_app/models/note.dart';

class MelodyPlayer {
  final MusicEngine _engine;
  int channel;
  Melody _currentMelody = [] as Melody;
  int _currentIndex = 0;
  CancellationToken? _token;

  MelodyPlayer(this._engine, this.channel);

  Future<void> playMelody(Melody melody) async {
    await stopMelody();
    _currentMelody = melody;
    _currentIndex = 0;
    _token = CancellationToken();
    _playNextNote(_token!);
  }

  Future<void> _playNextNote(CancellationToken token) async {
    if (token.isCancelled) return;

    if (_currentIndex >= _currentMelody.notes.length) {
      await stopMelody();
      return;
    }

    Note currentNote = _currentMelody.notes[_currentIndex];
    await _engine.playNote(currentNote.tone, channel: channel);

    Future.delayed(currentNote.duration, () async {
      if (token.isCancelled) {
        await _engine.stopNote(currentNote.tone, channel: channel);
      }
    });

    await Future.delayed(currentNote.duration);
    if (!token.isCancelled) {
      _currentIndex++;
      await _playNextNote(token);
    }
  }

  Future<void> stopMelody() async {
    _token?.cancel();
    _token = null;
  }
}

class CancellationToken {
  bool _isCancelled = false;
  void cancel() => _isCancelled = true;
  bool get isCancelled => _isCancelled;
}
