part of 'game_list_bloc.dart';

abstract class GameListState extends Equatable {
  const GameListState();
  @override
  List<Object?> get props => [];
}

class GameListInitial extends GameListState {}

class GameListLoading extends GameListState {}

class GameListLoaded extends GameListState {
  final List<Assignment> assignments;
  const GameListLoaded(this.assignments);
  @override
  List<Object?> get props => [assignments];
}

class GameListError extends GameListState {
  final String message;
  const GameListError(this.message);
  @override
  List<Object?> get props => [message];
}
