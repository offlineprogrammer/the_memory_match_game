import 'dart:async';

import 'package:flutter/material.dart';

import 'package:the_memory_match_game/models/game.dart';
import 'package:the_memory_match_game/ui/widgets/game_timer.dart';

import '../widgets/memory_card.dart';

class MemoryMatchPage extends StatefulWidget {
  const MemoryMatchPage({
    super.key,
  });
  @override
  State<MemoryMatchPage> createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  Timer? timer;
  Game? game;

  @override
  void initState() {
    super.initState();
    game = Game(4);
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        game!.time = game!.time + 1;
      });

      if (game!.isGameOver) {
        timer!.cancel();
      }
    });
  }

  void _resetGame() {
    game!.resetGame();
    setState(() {
      timer!.cancel();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
      ),
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameTimer(
              time: game!.time,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisCount: game!.gridSize,
                children: List.generate(game!.cards.length, (index) {
                  return MemoryCard(
                    index: index,
                    cardItem: game!.cards[index],
                    onCardPressed: game!.onCardPressed,
                  );
                }),
              ),
            ),
            if (game!.isGameOver)
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent[700],
                      textStyle: const TextStyle(fontSize: 18),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    onPressed: () => _resetGame(),
                    child: const Text('TRY AGAIN'),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}