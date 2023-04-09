import 'package:flutter/material.dart';

enum CardState { hidden, visible, guessed }

class CardItem {
  final int value;
  CardState state = CardState.hidden;
  IconData icon;
  Color color;
  CardItem(
    this.value,
    this.state,
    this.icon,
    this.color,
  );
}
