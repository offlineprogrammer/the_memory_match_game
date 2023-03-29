import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_memory_match_game/the_memory_match_game.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TheMemoryMatchGame(),
    ),
  );
}
