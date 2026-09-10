import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game_list/game_list_bloc.dart';
import 'play_game_page.dart';

class GameListPage extends StatelessWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis juegos')),
      body: BlocProvider.value(
        value: context.read<GameListBloc>()..add(const LoadAssignmentsEvent()),
        child: BlocBuilder<GameListBloc, GameListState>(
          builder: (context, state) {
            if (state is GameListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GameListError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is GameListLoaded) {
              if (state.assignments.isEmpty) {
                return const Center(child: Text('No tienes juegos asignados'));
              }
              return ListView.builder(
                itemCount: state.assignments.length,
                itemBuilder: (_, i) {
                  final a = state.assignments[i];
                  return ListTile(
                    leading: const Icon(Icons.videogame_asset),
                    title: Text('Juego ${a.gameId.substring(0, 8)}'),
                    subtitle: Text('Salón: ${a.classroomId.substring(0, 8)}'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlayGamePage(gameId: a.gameId),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
