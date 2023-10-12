import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_memory_match_game/features/game_session/data/gamesessions_repository.dart';
import 'package:the_memory_match_game/models/ModelProvider.dart';
part 'gamesessions_controller.g.dart';

@riverpod
class GameSessionsController extends _$GameSessionsController {
  Future<List<GameSession>> _fetchGameSessions() async {
    final gameSessionsRepository = ref.read(gameSessionsRepositoryProvider);
    final gameSessions = await gameSessionsRepository.getGameSessions();
    return gameSessions;
  }

  @override
  FutureOr<List<GameSession>> build() async {
    return _fetchGameSessions();
  }

  Future<void> addGameSession({
    required int durationInSeconds,
    required int level,
  }) async {
    final gameSession = GameSession(
      durationInSeconds: durationInSeconds,
      level: level,
    );

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final gameSessionsRepository = ref.read(gameSessionsRepositoryProvider);
      await gameSessionsRepository.add(gameSession);
      return _fetchGameSessions();
    });
  }

  Future<GameSession> getBestTimeGameSession(int level) async {
    final gameSessions = await _fetchGameSessions();
    final highestScoreGameSession = gameSessions
        .where((element) => element.level == level)
        .reduce((currentGameSession, nextGameSession) =>
            currentGameSession.durationInSeconds <
                    nextGameSession.durationInSeconds
                ? currentGameSession
                : nextGameSession);

    return highestScoreGameSession;
  }
}
