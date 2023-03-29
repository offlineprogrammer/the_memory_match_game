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
        return Icons.ac_unit;
      case 2:
        return Icons.access_alarm;
      case 3:
        return Icons.accessibility;
      case 4:
        return Icons.account_balance;
      case 5:
        return Icons.account_box;
      case 6:
        return Icons.account_circle;
      case 7:
        return Icons.add_alarm;
      case 8:
        return Icons.add_alert;
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
