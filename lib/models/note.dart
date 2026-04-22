class Note {
  final int tone;
  final Duration? duration;

  const Note(this.tone, {this.duration});

  Note interval(int steps) {
    return Note(tone + steps, duration: duration);
  }

  Note get octaveUp => interval(12);
  Note get octaveDown => interval(-12);
}
