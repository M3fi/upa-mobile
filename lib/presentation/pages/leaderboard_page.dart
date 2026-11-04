import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/leaderboard/leaderboard_bloc.dart';

class LeaderboardPage extends StatelessWidget {
  final String gameId;
  const LeaderboardPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: BlocProvider(
        create: (_) => context.read<LeaderboardBloc>()
          ..add(LoadLeaderboardEvent(gameId)),
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LeaderboardError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is LeaderboardLoaded) {
              return ListView.builder(
                itemCount: state.entries.length,
                itemBuilder: (_, i) {
                  final e = state.entries[i];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${e.rank}'),
                    ),
                    title: Text(e.displayName),
                    trailing: Text('${e.score} pts', style: const TextStyle(fontWeight: FontWeight.bold)),
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
