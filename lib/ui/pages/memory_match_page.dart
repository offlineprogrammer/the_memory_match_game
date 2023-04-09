import 'dart:async';

import 'package:flutter/material.dart';

import 'package:the_memory_match_game/models/game.dart';
import 'package:the_memory_match_game/ui/widgets/game_timer.dart';
import 'package:the_memory_match_game/ui/widgets/restart_game.dart';
import 'package:the_memory_match_game/utils/constants.dart';

import '../widgets/memory_card.dart';

class MemoryMatchPage extends StatefulWidget {
  const MemoryMatchPage({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  State<MemoryMatchPage> createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  late Timer timer;
  late Game game;
  late Duration duration;
  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });

      if (game.isGameOver) {
        timer.cancel();
      }
    });
  }

  pauseTimer() {
    timer.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(gameTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: GameTimer(
                time: duration,
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: game.gridSize,
                children: List.generate(game.cards.length, (index) {
                  return MemoryCard(
                    index: index,
                    card: game.cards[index],
                    onCardPressed: game.onCardPressed,
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: RestartGame(
                isGameOver: game.isGameOver,
                pauseGame: () => pauseTimer(),
                restartGame: () => _resetGame(),
                continueGame: () => startTimer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
