import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final Duration time;
  const GameTimer({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(40),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.red[700],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.timer,
                size: 40,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                time.toString().split('.').first.padLeft(8, "0"),
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
