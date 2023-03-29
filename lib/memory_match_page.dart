import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_memory_match_game/card_item.dart';
import 'package:the_memory_match_game/game_score.dart';
import 'package:the_memory_match_game/game_timer.dart';

import 'memory_card.dart';

class MemoryMatchPage extends StatefulWidget {
  final int gridSize;
  const MemoryMatchPage({
    required this.gridSize,
    super.key,
  });

  @override
  _MemoryMatchPageState createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  int? _gridSize;
  List<CardItem>? _cards;
  int score = 0;
  int time = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _gridSize = widget.gridSize;
    _cards = _generateCards(_gridSize!);
    startTimer();
  }

  List<CardItem> _generateCards(int gridSize) {
    List<CardItem> cards = [];

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
    return cards;
  }

  List<int> _getSelectedCardIndexes() {
    List<int> selectedCardIndexes = [];

    for (int i = 0; i < _cards!.length; i++) {
      if (_cards![i].state == CardState.visible) {
        selectedCardIndexes.add(i);
      }
    }

    return selectedCardIndexes;
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  void _onCardPressed(int index) {
    setState(() {
      _cards![index].state = CardState.visible;
      List<int> selectedCardIndexes = _getSelectedCardIndexes();

      if (selectedCardIndexes.length == 2) {
        CardItem card1 = _cards![selectedCardIndexes[0]];
        CardItem card2 = _cards![selectedCardIndexes[1]];

        if (card1.value == card2.value) {
          card1.state = CardState.guessed;
          card2.state = CardState.guessed;
          score += 10;
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              card1.state = CardState.hidden;
              card2.state = CardState.hidden;
            });
          });
        }
      }
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
              time: time,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisCount: _gridSize!,
                children: List.generate(_cards!.length, (index) {
                  return MemoryCard(
                    index: index,
                    cardItem: _cards![index],
                    onCardPressed: _onCardPressed,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
