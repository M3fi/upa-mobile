part of 'play_game_bloc.dart';

abstract class PlayGameEvent extends Equatable {
  const PlayGameEvent();
  @override
  List<Object?> get props => [];
}

class LoadGameEvent extends PlayGameEvent {
  final String gameId;
  const LoadGameEvent(this.gameId);
  @override
  List<Object?> get props => [gameId];
}

class SubmitAnswerEvent extends PlayGameEvent {
  final bool answer;
  final int elapsedMs;
  const SubmitAnswerEvent({required this.answer, required this.elapsedMs});
  @override
  List<Object?> get props => [answer, elapsedMs];
}
