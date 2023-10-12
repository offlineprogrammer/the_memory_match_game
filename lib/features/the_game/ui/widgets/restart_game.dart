import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_memory_match_game/common/navigation/routes.dart';
import 'package:the_memory_match_game/features/the_game/ui/widgets/game_controls_bottomsheet.dart';

class RestartGame extends StatelessWidget {
  const RestartGame({
    required this.isGameOver,
    required this.pauseGame,
    required this.restartGame,
    required this.continueGame,
    this.color = Colors.white,
    super.key,
  });

  final VoidCallback pauseGame;
  final VoidCallback restartGame;
  final VoidCallback continueGame;
  final bool isGameOver;
  final Color color;

  Future<void> showGameControls(BuildContext context) async {
    pauseGame();
    var value = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (sheetContext) {
        return const GameControlsBottomSheet();
      },
    );

    value ??= false;

    if (value) {
      restartGame();
    } else {
      continueGame();
    }
  }

  void navigateback(BuildContext context) {
    context.goNamed(
      AppRoute.home.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      icon: (isGameOver)
          ? const Icon(Icons.replay_circle_filled)
          : const Icon(Icons.pause_circle_filled),
      iconSize: 40,
      onPressed: () =>
          isGameOver ? navigateback(context) : showGameControls(context),
    );
  }
}
