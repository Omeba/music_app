import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class Note {
  @HiveField(0)
  final int tone;
  @HiveField(1)
  final Duration duration;

  const Note(this.tone, {this.duration = const Duration(milliseconds: 250)});

  Note interval(int steps) {
    return Note(tone + steps, duration: duration);
  }

  Note get octaveUp => interval(12);
  Note get octaveDown => interval(-12);
}
