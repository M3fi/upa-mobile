import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/play_game/play_game_bloc.dart';
import 'leaderboard_page.dart';

class PlayGamePage extends StatelessWidget {
  final String gameId;
  const PlayGamePage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<PlayGameBloc>()..add(LoadGameEvent(gameId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Jugar')),
        body: BlocBuilder<PlayGameBloc, PlayGameState>(
          builder: (context, state) {
            if (state is PlayGameLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlayGameError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is PlayGameLoaded) {
              final q = state.renderData.questions[state.currentIndex];
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pregunta ${state.currentIndex + 1}/${state.renderData.questions.length}',
                      style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 32),
                    Text(q.prompt, style: const TextStyle(fontSize: 24), textAlign: TextAlign.center),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _submit(context, true),
                          icon: const Icon(Icons.check, color: Colors.green),
                          label: const Text('Verdadero'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _submit(context, false),
                          icon: const Icon(Icons.close, color: Colors.red),
                          label: const Text('Falso'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Puntuación: ${state.score}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }
            if (state is PlayGameSubmitting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlayGameFinished) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
                      const SizedBox(height: 16),
                      Text('¡Juego completado!', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text('Puntuación final: ${state.totalScore}',
                        style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LeaderboardPage(gameId: gameId),
                            ),
                          );
                        },
                        child: const Text('Ver leaderboard'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _submit(BuildContext context, bool answer) {
    context.read<PlayGameBloc>().add(
      SubmitAnswerEvent(answer: answer, elapsedMs: 3000),
    );
  }
}
