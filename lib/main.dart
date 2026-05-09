import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/models/adapters/chord_adapter.dart';
import 'package:music_app/models/adapters/chord_guess_level_adapter.dart';
import 'package:music_app/models/adapters/difficulty_adapter.dart';
import 'package:music_app/models/adapters/level_adapter.dart';
import 'package:music_app/models/adapters/note_adapter.dart';
import 'package:music_app/models/adapters/progress_adapter.dart';
import 'package:music_app/ui/pages/levels_page.dart';
import 'package:music_app/ui/pages/menu_page.dart';
import 'package:music_app/ui/pages/settings_page.dart';
import 'package:music_app/ui/pages/tutorial_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ChordAdapter());
  Hive.registerAdapter(DifficultyAdapter());
  Hive.registerAdapter(ChordGuessLevelAdapter()); // конкретный адаптер
  Hive.registerAdapter(LevelAdapter()); // полиморфный адаптер для Level
  Hive.registerAdapter(ProgressAdapter());
  runApp(
    MaterialApp(
      // Объявление основных маршрутов приложения
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPage(),
        '/settings': (context) => const SettingsPage(),
        '/levels': (context) => const LevelsPage(),
        '/tutorial': (context) => const TutorialPage(),
      },
    ),
  );
}
