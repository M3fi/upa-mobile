part of 'play_game_bloc.dart';

abstract class PlayGameState extends Equatable {
  const PlayGameState();
  @override
  List<Object?> get props => [];
}

class PlayGameInitial extends PlayGameState {}

class PlayGameLoading extends PlayGameState {}

class PlayGameLoaded extends PlayGameState {
  final GameRenderData renderData;
  final int currentIndex;
  final int score;
  final List<SubmitAnswerResult> results;

  const PlayGameLoaded({
    required this.renderData,
    required this.currentIndex,
    required this.score,
    required this.results,
  });

  @override
  List<Object?> get props => [renderData, currentIndex, score, results];
}

class PlayGameSubmitting extends PlayGameState {
  final GameRenderData renderData;
  final int currentIndex;
  final int score;
  final List<SubmitAnswerResult> results;

  const PlayGameSubmitting(this.renderData, this.currentIndex, this.score, this.results);

  @override
  List<Object?> get props => [renderData, currentIndex, score, results];
}

class PlayGameFinished extends PlayGameState {
  final GameRenderData renderData;
  final List<SubmitAnswerResult> results;
  final int totalScore;

  const PlayGameFinished({
    required this.renderData,
    required this.results,
    required this.totalScore,
  });

  @override
  List<Object?> get props => [renderData, results, totalScore];
}

class PlayGameError extends PlayGameState {
  final String message;
  const PlayGameError(this.message);
  @override
  List<Object?> get props => [message];
}
