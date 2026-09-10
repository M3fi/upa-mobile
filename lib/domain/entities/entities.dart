class User {
  final String id;
  final String email;
  final String displayName;
  final String role;

  const User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
  });
}

class Game {
  final String id;
  final String templateType;
  final String title;

  const Game({
    required this.id,
    required this.templateType,
    required this.title,
  });
}

class Assignment {
  final String id;
  final String gameId;
  final String classroomId;
  final String? dueAt;

  const Assignment({
    required this.id,
    required this.gameId,
    required this.classroomId,
    this.dueAt,
  });
}

class SiONoQuestion {
  final String prompt;
  final bool answer;

  const SiONoQuestion({required this.prompt, required this.answer});
}

class GameRenderData {
  final String gameId;
  final String templateType;
  final List<SiONoQuestion> questions;
  final Map<String, dynamic> rules;

  const GameRenderData({
    required this.gameId,
    required this.templateType,
    required this.questions,
    required this.rules,
  });
}

class SubmitAnswerResult {
  final bool isCorrect;
  final int scoreDelta;
  final int totalScore;

  const SubmitAnswerResult({
    required this.isCorrect,
    required this.scoreDelta,
    required this.totalScore,
  });
}

class LeaderboardEntry {
  final String studentId;
  final String displayName;
  final int score;
  final int rank;

  const LeaderboardEntry({
    required this.studentId,
    required this.displayName,
    required this.score,
    required this.rank,
  });
}
