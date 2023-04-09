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
      onCardPressed(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleCardTap,
      child: Card(
        margin: const EdgeInsets.all(4),
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
              : LayoutBuilder(builder: (context, constraint) {
                  return Icon(
                    card.icon,
                    size: constraint.biggest.height * 0.8,
                    color: Colors.white,
                  );
                }),
        ),
      ),
    );
  }
}
