import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/game_repository.dart';

part 'game_list_event.dart';
part 'game_list_state.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  final GameRepository _gameRepo;

  GameListBloc(this._gameRepo) : super(GameListInitial()) {
    on<LoadAssignmentsEvent>(_onLoadAssignments);
  }

  Future<void> _onLoadAssignments(
    LoadAssignmentsEvent event,
    Emitter<GameListState> emit,
  ) async {
    emit(GameListLoading());
    try {
      final assignments = await _gameRepo.getAssignments();
      emit(GameListLoaded(assignments));
    } catch (e) {
      emit(GameListError(e.toString()));
    }
  }
}
