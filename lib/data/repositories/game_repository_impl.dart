import '../datasources/api_client.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final ApiClient _api;

  GameRepositoryImpl(this._api);

  @override
  Future<List<Assignment>> getAssignments() async {
    final response = await _api.get('/assignments');
    final data = response.data as List;
    return data.map((json) => Assignment(
      id: json['id'],
      gameId: json['gameId'],
      classroomId: json['classroomId'],
      dueAt: json['dueAt'],
    )).toList();
  }

  @override
  Future<GameRenderData> getGameRenderData(String gameId) async {
    final response = await _api.get('/games/$gameId/render');
    final data = response.data;
    final questions = (data['content']['questions'] as List).map((q) =>
      SiONoQuestion(prompt: q['prompt'], answer: q['answer']),
    ).toList();
    return GameRenderData(
      gameId: data['gameId'],
      templateType: data['templateType'],
      questions: questions,
      rules: Map<String, dynamic>.from(data['rules']),
    );
  }

  @override
  Future<SubmitAnswerResult> submitAnswer({
    required String gameId,
    required int questionIndex,
    required bool answer,
    required int elapsedMs,
  }) async {
    final response = await _api.post('/sessions/$gameId/answer', data: {
      'questionIndex': questionIndex,
      'answer': answer,
      'elapsedMs': elapsedMs,
    });
    return SubmitAnswerResult(
      isCorrect: response.data['isCorrect'],
      scoreDelta: response.data['scoreDelta'],
      totalScore: response.data['totalScore'],
    );
  }
}
