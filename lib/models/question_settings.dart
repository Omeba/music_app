import 'package:music_app/models/chord_progression.dart';
import 'package:music_app/models/melody.dart';

class QuestionSettings {
  final List<ChordProgression> _possibleProgressions;
  final List<Melody> _possibleMelodies;

  QuestionSettings(this._possibleProgressions, this._possibleMelodies);
}
