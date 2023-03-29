import 'package:flutter/material.dart';
import 'package:the_memory_match_game/features/startup/ui/startup_page.dart';

class TheMemoryMatchGame extends StatelessWidget {
  const TheMemoryMatchGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartUpPage(),
      title: 'The MemoryMatch Game',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
