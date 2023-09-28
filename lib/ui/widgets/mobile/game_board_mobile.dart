import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:the_memory_match_game/models/game.dart';
import 'package:the_memory_match_game/ui/widgets/game_confetti.dart';

import 'package:the_memory_match_game/ui/widgets/memory_card.dart';
import 'package:the_memory_match_game/ui/widgets/mobile/game_best_time_mobile.dart';
import 'package:the_memory_match_game/ui/widgets/mobile/game_timer_mobile.dart';
import 'package:the_memory_match_game/ui/widgets/restart_game.dart';

class GameBoardMobile extends StatefulWidget {
  const GameBoardMobile({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  State<GameBoardMobile> createState() => _GameBoardMobileState();
}

class _GameBoardMobileState extends State<GameBoardMobile> {
  late Timer timer;
  late Game game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    startTimer();
    getBestTime();
  }

  void getBestTime() async {
    SharedPreferences gameSP = await SharedPreferences.getInstance();
    if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
      bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
    }
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
        SharedPreferences gameSP = await SharedPreferences.getInstance();
        if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
            gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
                duration.inSeconds) {
          gameSP.setInt(
              '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
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
