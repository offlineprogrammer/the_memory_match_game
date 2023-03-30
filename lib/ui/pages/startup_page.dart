import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_memory_match_game/ui/pages/memory_match_page.dart';

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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent[700],
                      textStyle: const TextStyle(fontSize: 18),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const MemoryMatchPage();
                      }));
                    },
                    child: const Text('START'),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
