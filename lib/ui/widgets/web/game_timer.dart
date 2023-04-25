import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final Duration time;
  const GameTimer({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      time.toString().split('.').first.padLeft(8, "0"),
      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }
}
