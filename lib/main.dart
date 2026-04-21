import 'package:flutter/material.dart';
import 'package:music_app/pages/levels_page.dart';
import 'package:music_app/pages/menu_page.dart';
import 'package:music_app/pages/settings_page.dart';
import 'package:music_app/pages/tutorial_page.dart';

void main() {
  runApp(
    MaterialApp(
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
