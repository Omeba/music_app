import 'dart:math';

import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Tonality {
  @HiveField(0)
  final int rootMidi;
  @HiveField(1)
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
