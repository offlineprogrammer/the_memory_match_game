import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_memory_match_game/ui/pages/memory_match_page.dart';
import 'package:the_memory_match_game/ui/widgets/game_button.dart';

class StartUpPage extends ConsumerWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'MEMORY MATCH',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              GameButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const MemoryMatchPage();
                  }));
                },
                title: 'START',
              ),
            ]),
      ),
    );
  }
}
