import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/ui/pages/levels_page.dart';
import 'package:music_app/ui/pages/menu_page.dart';
import 'package:music_app/ui/pages/settings_page.dart';
import 'package:music_app/ui/pages/tutorial_page.dart';

void main() {
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
