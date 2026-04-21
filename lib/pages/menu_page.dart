import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/levels'),
          child: Text('Levels'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/settings'),
          child: Text('Settings'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/tutorial'),
          child: Text('tutorial'),
        ),
      ],
    );
  }
}
