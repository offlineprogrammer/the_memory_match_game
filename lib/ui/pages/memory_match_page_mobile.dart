import 'package:flutter/material.dart';
import 'package:the_memory_match_game/ui/widgets/game_board.dart';
import 'package:the_memory_match_game/utils/constants.dart';

class MemoryMatchPageMobile extends StatelessWidget {
  const MemoryMatchPageMobile({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(gameTitle),
      ),
      body: GameBoard(
        gameLevel: gameLevel,
      ),
    );
  }
}
