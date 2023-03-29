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
      margin: const EdgeInsets.all(26.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.timer,
          ),
          const SizedBox(
            height: 6.0,
          ),
          Text(
            '$time',
            style: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
