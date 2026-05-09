// lib/ui/pages/result_page.dart
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalRounds;
  final int timeSpentSeconds;

  const ResultPage({
    super.key,
    required this.score,
    required this.totalRounds,
    required this.timeSpentSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Результат: $score / $totalRounds',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text('Время: $timeSpentSeconds сек'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('На главную'),
            ),
          ],
        ),
      ),
    );
  }
}
