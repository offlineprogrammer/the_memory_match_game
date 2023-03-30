import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final int time;
  const GameTimer({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 20),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
      decoration: BoxDecoration(
        color: Colors.red[700],
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.timer,
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              '$time',
              style:
                  const TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
