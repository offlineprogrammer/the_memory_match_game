import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  final int time;
  final VoidCallback onPlayAgainPressed;

  const GameOverDialog({
    Key? key,
    required this.time,
    required this.onPlayAgainPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Well done'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('$time seconds'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPlayAgainPressed,
          child: const Text('Try Again'),
        ),
      ],
    );
  }
}
