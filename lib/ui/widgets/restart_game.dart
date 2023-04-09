import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_memory_match_game/ui/pages/startup_page.dart';
import 'package:the_memory_match_game/ui/widgets/game_button.dart';
import 'package:the_memory_match_game/ui/widgets/game_controls_bottomsheet.dart';

class RestartGame extends StatelessWidget {
  final bool isGameOver;
  final VoidCallback pauseGame;
  final VoidCallback restartGame;
  final VoidCallback continueGame;

  const RestartGame({
    Key? key,
    required this.isGameOver,
    required this.pauseGame,
    required this.restartGame,
    required this.continueGame,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    if (isGameOver) {
      return GameButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return const StartUpPage();
          }));
        },
        title: 'TRY AGAIN',
        color: Colors.amberAccent[700]!,
      );
    } else {
      return GameButton(
        onPressed: () => showGameControls(context),
        title: 'PAUSE',
        color: Colors.amberAccent[700]!,
      );
    }
  }
}
