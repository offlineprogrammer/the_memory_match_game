import 'dart:async';
import 'dart:math';

import 'package:the_memory_match_game/features/game/models/card_item.dart';

class Game {
  int gridSize;
  List<CardItem> cards = [];

  int time = 0;

  Game(this.gridSize) {
    generateCards();
  }

  void generateCards() {
    cards = [];
    for (int i = 0; i < (gridSize * gridSize / 2); i++) {
      int cardValue = i + 1;
      cards.add(CardItem(
        cardValue,
        state: CardState.hidden,
      ));
      cards.add(CardItem(
        cardValue,
        state: CardState.hidden,
      ));
    }

    cards.shuffle(Random());
  }

  void resetGame() {
    generateCards();
    time = 0;
  }

  void onCardPressed(int index) {
    cards[index].state = CardState.visible;
    List<int> selectedCardIndexes = _getSelectedCardIndexes();

    if (selectedCardIndexes.length == 2) {
      CardItem card1 = cards[selectedCardIndexes[0]];
      CardItem card2 = cards[selectedCardIndexes[1]];

      if (card1.value == card2.value) {
        card1.state = CardState.guessed;
        card2.state = CardState.guessed;

        // if (isGameOver()) {
        //   _isGameOver = true;
        // }
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          card1.state = CardState.hidden;
          card2.state = CardState.hidden;
        });
      }
    }
  }

  List<int> _getSelectedCardIndexes() {
    List<int> selectedCardIndexes = [];

    for (int i = 0; i < cards.length; i++) {
      if (cards[i].state == CardState.visible) {
        selectedCardIndexes.add(i);
      }
    }

    return selectedCardIndexes;
  }

  bool isGameOver() {
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].state == CardState.hidden) {
        return false;
      }
    }

    return true;
  }
}
