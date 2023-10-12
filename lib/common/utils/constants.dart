import 'package:flutter/material.dart';

const Color continueButtonColor = Color.fromRGBO(235, 32, 93, 1);
const Color restartButtonColor = Color.fromRGBO(243, 181, 45, 1);
const Color quitButtonColor = Color.fromRGBO(39, 162, 149, 1);

const List<Map<String, dynamic>> gameLevels = [
  {'title': '4 x 4', 'level': 4, 'color': Colors.amberAccent},
  {'title': '6 x 6', 'level': 6, 'color': Colors.blueAccent},
  {'title': '8 x 8', 'level': 8, 'color': Colors.cyanAccent},
];

const String gameTitle = 'MEMORY MATCH';
