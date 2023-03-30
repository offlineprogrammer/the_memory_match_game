import 'package:flutter/material.dart';
import 'package:the_memory_match_game/models/card_item.dart';

class MemoryCard extends StatelessWidget {
  final CardItem cardItem;
  final Function(int) onCardPressed;
  final int index;
  const MemoryCard({
    Key? key,
    required this.cardItem,
    required this.index,
    required this.onCardPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cardItem.state == CardState.hidden) {
          onCardPressed(index);
        }
      },
      child: Card(
        margin: const EdgeInsets.all(4),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: cardItem.state == CardState.visible ||
                cardItem.state == CardState.guessed
            ? cardItem.color
            : Colors.grey,
        child: Center(
          child: cardItem.state == CardState.hidden
              ? null
              : Icon(
                  cardItem.icon,
                  size: 50,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
