import 'package:flutter_midi_engine/flutter_midi_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicEngineProvider = Provider<MusicEngine>((ref) => MusicEngine());

class MusicEngine {
  late final FlutterMidiEngine _engine;
  bool isInitialized = false;

  Future<void> init() async {
    if (isInitialized) return;
    _engine = FlutterMidiEngine();
    await _engine.unmute();
    await _engine.loadSoundfontFromAsset("assetPath");
    isInitialized = true;
  }

  Future<void> playNote(int midiNote, {int channel = 0}) async {
    if (!isInitialized) await init();
    await _engine.playNote(note: midiNote, channel: channel);
  }

  Future<void> stopNote(int midiNote, {int channel = 0}) async {
    if (!isInitialized) await init();
    await _engine.stopNote(note: midiNote, channel: channel);
  }

  Future<void> setInstrument(int instrument, {int channel = 0}) async {
    if (!isInitialized) await init();
    await _engine.changeProgram(program: instrument);
  }
}
