import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/leaderboard_repository.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final LeaderboardRepository _repo;

  LeaderboardBloc(this._repo) : super(LeaderboardInitial()) {
    on<LoadLeaderboardEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadLeaderboardEvent event, Emitter<LeaderboardState> emit) async {
    emit(LeaderboardLoading());
    try {
      final entries = await _repo.getLeaderboard(event.gameId);
      emit(LeaderboardLoaded(entries));
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }
}
