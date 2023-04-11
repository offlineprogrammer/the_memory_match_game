import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_memory_match_game/ui/pages/memory_match_page_mobile.dart';
import 'package:the_memory_match_game/ui/pages/memory_match_page_web.dart';
import 'package:the_memory_match_game/ui/widgets/game_button.dart';
import 'package:the_memory_match_game/utils/constants.dart';

class GameOptions extends StatelessWidget {
  const GameOptions({Key? key}) : super(key: key);

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        if (kIsWeb) {
          return MemoryMatchPageWeb(gameLevel: gameLevel);
        } else {
          return MemoryMatchPageMobile(gameLevel: gameLevel);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.map((level) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GameButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                _routeBuilder(context, level['level']),
                (Route<dynamic> route) => false),
            title: level['title'],
            color: level['color']![700]!,
            width: 250,
          ),
        );
      }).toList(),
    );
  }
}
