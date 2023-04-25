import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameConfetti extends StatelessWidget {
  final ConfettiController controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  GameConfetti({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controllerCenter.play();
    return Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          confettiController: controllerCenter,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          gravity: 0.5,
          emissionFrequency: 0.05,
          numberOfParticles: 20,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ));
  }
}
