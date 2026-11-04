import '../entities/entities.dart';

abstract class GameRepository {
  Future<List<Assignment>> getAssignments();
  Future<GameRenderData> getGameRenderData(String gameId);
  Future<SubmitAnswerResult> submitAnswer({
    required String gameId,
    required int questionIndex,
    required bool answer,
    required int elapsedMs,
  });
}
