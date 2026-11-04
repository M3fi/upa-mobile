part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();
  @override
  List<Object?> get props => [];
}

class LoadLeaderboardEvent extends LeaderboardEvent {
  final String gameId;
  const LoadLeaderboardEvent(this.gameId);
  @override
  List<Object?> get props => [gameId];
}
