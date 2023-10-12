import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_memory_match_game/features/game_session/controllers/gamesessions_controller.dart';

import 'package:the_memory_match_game/features/the_game/controllers/game_controller.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/game_confetti.dart';

import 'package:the_memory_match_game/features/the_game/ui/widgets/memory_card.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/mobile/game_best_time_mobile.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/mobile/game_timer_mobile.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/restart_game.dart';

class GameBoardMobile extends ConsumerStatefulWidget {
  const GameBoardMobile({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  GameBoardMobileState createState() => GameBoardMobileState();
}

class GameBoardMobileState extends ConsumerState<GameBoardMobile> {
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
    startTimer();
    getBestTime();
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
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              RestartGame(
                isGameOver: game.isGameOver,
                pauseGame: () => pauseTimer(),
                restartGame: () => _resetGame(),
                continueGame: () => startTimer(),
                color: Colors.amberAccent[700]!,
              ),
              GameTimerMobile(
                time: duration,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: game.gridSize,
                  childAspectRatio: aspectRatio * 2,
                  children: List.generate(game.cards.length, (index) {
                    return MemoryCard(
                      index: index,
                      card: game.cards[index],
                      onCardPressed: game.onCardPressed,
                    );
                  }),
                ),
              ),
              GameBestTimeMobile(
                bestTime: bestTime,
              ),
            ],
          ),
          showConfetti ? const GameConfetti() : const SizedBox(),
        ],
      ),
    );
  }
}
