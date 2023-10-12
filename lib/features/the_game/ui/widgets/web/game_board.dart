import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_memory_match_game/features/game_session/controllers/gamesessions_controller.dart';

import 'package:the_memory_match_game/features/the_game/controllers/game_controller.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/game_confetti.dart';

import 'package:the_memory_match_game/features/the_game/ui/widgets/memory_card.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/restart_game.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/web/game_best_time.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/web/game_timer.dart';

class GameBoard extends ConsumerStatefulWidget {
  const GameBoard({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  GameBoardState createState() => GameBoardState();
}

class GameBoardState extends ConsumerState<GameBoard> {
  late Timer timer;
  late GameController game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  @override
  void initState() {
    super.initState();
    game = GameController(widget.gameLevel);
    duration = const Duration();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      startTimer();
      getBestTime();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void getBestTime() async {
    ref
        .watch(gameSessionsControllerProvider.notifier)
        .getBestTimeGameSession(widget.gameLevel)
        .then((value) {
      bestTime = value.durationInSeconds;
    });

    setState(() {});
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });

      if (game.isGameOver) {
        timer.cancel();
        ref.watch(gameSessionsControllerProvider.notifier).addGameSession(
              durationInSeconds: duration.inSeconds,
              level: widget.gameLevel,
            );

        if (bestTime != 0 && duration.inSeconds < bestTime) {
          setState(() {
            showConfetti = true;
            bestTime = duration.inSeconds;
          });
        }
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
    final responsiveSpacing = sqrt(MediaQuery.of(context).size.width) *
        sqrt(MediaQuery.of(context).size.height);

    return Stack(
      children: [
        GridView.count(
          padding: const EdgeInsets.fromLTRB(8.0, 80.0, 8.0, 8.0),
          childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.2,
          mainAxisSpacing: responsiveSpacing / 100,
          crossAxisSpacing: responsiveSpacing / 100,
          crossAxisCount: game.gridSize,
          children: List.generate(game.cards.length, (index) {
            return MemoryCard(
              index: index,
              card: game.cards[index],
              onCardPressed: game.onCardPressed,
            );
          }),
        ),
        Positioned(
          top: 12.0,
          right: 24.0,
          child: RestartGame(
            isGameOver: game.isGameOver,
            pauseGame: () => pauseTimer(),
            restartGame: () => _resetGame(),
            continueGame: () => startTimer(),
          ),
        ),
        Positioned(
          bottom: 12.0,
          right: 24.0,
          child: GameTimer(
            time: duration,
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 24.0,
          child: GameBestTime(
            bestTime: bestTime,
          ),
        ),
        showConfetti ? const GameConfetti() : const SizedBox(),
      ],
    );
  }
}
