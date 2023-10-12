import 'package:flutter/material.dart';

class GameBestTimeMobile extends StatelessWidget {
  const GameBestTimeMobile({
    required this.bestTime,
    super.key,
  });

  final int bestTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 60,
      ),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.greenAccent[700],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.celebration,
                size: 40,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                textAlign: TextAlign.center,
                Duration(seconds: bestTime)
                    .toString()
                    .split('.')
                    .first
                    .padLeft(8, "0"),
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
