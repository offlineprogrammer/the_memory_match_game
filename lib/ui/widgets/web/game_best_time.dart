import 'package:flutter/material.dart';

class GameBestTime extends StatelessWidget {
  final int bestTime;
  const GameBestTime({
    Key? key,
    required this.bestTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      'Best: ${Duration(seconds: bestTime).toString().split('.').first.padLeft(8, "0")}',
      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }
}
