import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/game_repository.dart';

part 'play_game_event.dart';
part 'play_game_state.dart';

class PlayGameBloc extends Bloc<PlayGameEvent, PlayGameState> {
  final GameRepository _gameRepo;

  PlayGameBloc(this._gameRepo) : super(PlayGameInitial()) {
    on<LoadGameEvent>(_onLoadGame);
    on<SubmitAnswerEvent>(_onSubmitAnswer);
  }

  Future<void> _onLoadGame(LoadGameEvent event, Emitter<PlayGameState> emit) async {
    emit(PlayGameLoading());
    try {
      final renderData = await _gameRepo.getGameRenderData(event.gameId);
      emit(PlayGameLoaded(
        renderData: renderData,
        currentIndex: 0,
        score: 0,
        results: [],
      ));
    } catch (e) {
      emit(PlayGameError(e.toString()));
    }
  }

  Future<void> _onSubmitAnswer(SubmitAnswerEvent event, Emitter<PlayGameState> emit) async {
    final current = state;
    if (current is! PlayGameLoaded) return;

    emit(PlayGameSubmitting(current.renderData, current.currentIndex, current.score, current.results));

    try {
      final result = await _gameRepo.submitAnswer(
        gameId: current.renderData.gameId,
        questionIndex: current.currentIndex,
        answer: event.answer,
        elapsedMs: event.elapsedMs,
      );

      final updatedResults = [...current.results, result];
      final nextIndex = current.currentIndex + 1;
      final isLastQuestion = nextIndex >= current.renderData.questions.length;

      if (isLastQuestion) {
        emit(PlayGameFinished(
          renderData: current.renderData,
          results: updatedResults,
          totalScore: result.totalScore,
        ));
      } else {
        emit(PlayGameLoaded(
          renderData: current.renderData,
          currentIndex: nextIndex,
          score: result.totalScore,
          results: updatedResults,
        ));
      }
    } catch (e) {
      emit(PlayGameError(e.toString()));
    }
  }
}
