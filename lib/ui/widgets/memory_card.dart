import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_memory_match_game/models/card_item.dart';

class MemoryCard extends StatelessWidget {
  final CardItem card;
  final Function(int) onCardPressed;
  final int index;

  const MemoryCard({
    Key? key,
    required this.card,
    required this.index,
    required this.onCardPressed,
  }) : super(key: key);

  void handleCardTap() {
    if (card.state == CardState.hidden) {
      Timer(const Duration(milliseconds: 100), () {
        onCardPressed(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleCardTap,
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color:
            card.state == CardState.visible || card.state == CardState.guessed
                ? card.color
                : Colors.grey,
        child: Center(
          child: card.state == CardState.hidden
              ? null
              : SizedBox.expand(
                  child: FittedBox(
                    child: Icon(
                      card.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
