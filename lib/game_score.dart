import 'package:flutter/material.dart';

class GameScore extends StatelessWidget {
  final int score;
  const GameScore({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(26.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Text(
              'Score',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              '$score',
              style:
                  const TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
