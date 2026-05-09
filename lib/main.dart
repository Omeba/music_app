import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/models/adapters/chord_adapter.dart';
import 'package:music_app/models/adapters/chord_guess_level_adapter.dart';
import 'package:music_app/models/adapters/difficulty_adapter.dart';
import 'package:music_app/models/adapters/level_adapter.dart';
import 'package:music_app/models/adapters/note_adapter.dart';
import 'package:music_app/models/adapters/progress_adapter.dart';
import 'package:music_app/models/adapters/tonality_adapter.dart';
import 'package:music_app/models/level.dart';
import 'package:music_app/models/progress.dart';
import 'package:music_app/ui/pages/auth_page.dart';
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
  Hive.registerAdapter(ChordGuessLevelAdapter());
  Hive.registerAdapter(LevelAdapter());
  Hive.registerAdapter(ProgressAdapter());
  Hive.registerAdapter(TonalityAdapter());

  await Hive.openBox('settingsBox');
  await Hive.openBox<Level>('levelBox');
  await Hive.openBox<Progress>('progressBox');
  await Hive.openBox('authBox');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тренировка слуха',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPage(),
        '/auth': (context) => const AuthPage(),
        '/levels': (context) => const LevelsPage(),
        '/settings': (context) => const SettingsPage(),
        '/tutorial': (context) => const TutorialPage(),
      },
    );
  }
}
