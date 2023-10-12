import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_memory_match_game/features/game_session/services/gamesessions_api_service.dart';
import 'package:the_memory_match_game/models/ModelProvider.dart';

final gameSessionsRepositoryProvider = Provider<GameSessionsRepository>((ref) {
  final gameSessionsAPIService = ref.read(gameSessionsAPIServiceProvider);
  return GameSessionsRepository(gameSessionsAPIService);
});

class GameSessionsRepository {
  GameSessionsRepository(this.gameSessionsAPIService);

  final GameSessionsAPIService gameSessionsAPIService;

  Future<List<GameSession>> getGameSessions() {
    return gameSessionsAPIService.getGameSessions();
  }

  Future<void> add(GameSession gameSession) async {
    return gameSessionsAPIService.addGameSession(gameSession);
  }
}
