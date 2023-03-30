import 'package:flutter/material.dart';

enum CardState { hidden, visible, guessed }

class CardItem {
  final int value;
  CardState state;

  CardItem(
    this.value, {
    this.state = CardState.hidden,
  });

  IconData get icon {
    switch (value) {
      case 1:
        return Icons.celebration;
      case 2:
        return Icons.directions_car_filled;
      case 3:
        return Icons.directions_bike;
      case 4:
        return Icons.house;
      case 5:
        return Icons.local_shipping;
      case 6:
        return Icons.fastfood;
      case 7:
        return Icons.local_airport;
      case 8:
        return Icons.forest;
      default:
        return Icons.warning;
    }
  }

  Color get color {
    switch (value) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.purple;
      case 6:
        return Colors.teal;
      case 7:
        return Colors.yellow;
      case 8:
        return Colors.cyan;
      default:
        return Colors.black;
    }
  }
}
