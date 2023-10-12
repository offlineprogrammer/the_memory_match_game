import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_memory_match_game/common/navigation/routes.dart';
import 'package:the_memory_match_game/features/the_game/ui/pages/memory_match_page.dart';
import 'package:the_memory_match_game/features/the_game/ui/pages/startup_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const StartUpPage(),
    ),
    GoRoute(
      path: '/game/:gameLevel',
      name: AppRoute.game.name,
      builder: (context, state) {
        final gameLevel = int.parse(state.pathParameters['gameLevel']!);
        return MemoryMatchPage(gameLevel: gameLevel);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
