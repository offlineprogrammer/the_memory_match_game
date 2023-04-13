import 'package:flutter/material.dart';
import 'package:the_memory_match_game/ui/widgets/game_board.dart';

import 'package:the_memory_match_game/utils/constants.dart';

class MemoryMatchPageWeb extends StatelessWidget {
  const MemoryMatchPageWeb({
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
      body: LayoutBuilder(builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: constraints.maxWidth < 500
              ? EdgeInsets.zero
              : const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: GameBoard(
                gameLevel: gameLevel,
              ),
            ),
          ),
        );
      }),
    );
  }
}
