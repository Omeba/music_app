import 'dart:math';

class Tonality {
  final int rootMidi;
  final TonalityMode mode;

  const Tonality(this.rootMidi, this.mode);

  factory Tonality.random() {
    Random random = Random();
    return Tonality(
      random.nextInt(12) + 1,
      TonalityMode.values[random.nextInt(TonalityMode.values.length)],
    );
  }
}

enum TonalityMode { major, minor }
