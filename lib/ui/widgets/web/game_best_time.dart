import 'package:flutter/material.dart';

class GameBestTime extends StatelessWidget {
  const GameBestTime({
    required this.bestTime,
    super.key,
  });

  final int bestTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Best: ${Duration(seconds: bestTime).toString().split('.').first.padLeft(8, "0")}',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }
}
