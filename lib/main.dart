import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/api_client.dart';
import 'data/datasources/auth_storage.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/game_repository_impl.dart';
import 'data/repositories/leaderboard_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/game_repository.dart';
import 'domain/repositories/leaderboard_repository.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/game_list/game_list_bloc.dart';
import 'presentation/blocs/play_game/play_game_bloc.dart';
import 'presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/game_list_page.dart';
import 'presentation/pages/play_game_page.dart';
import 'presentation/pages/leaderboard_page.dart';

final sl = GetIt.instance;

void main() {
  _initDependencies();
  runApp(const UpaApp());
}

void _initDependencies() {
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<AuthStorage>(() => AuthStorage());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<ApiClient>(), sl<AuthStorage>()),
  );
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(sl<ApiClient>()),
  );

  // BLoCs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));
  sl.registerFactory<GameListBloc>(() => GameListBloc(sl<GameRepository>()));
  sl.registerFactory<PlayGameBloc>(() => PlayGameBloc(sl<GameRepository>()));
  sl.registerFactory<LeaderboardBloc>(
    () => LeaderboardBloc(sl<LeaderboardRepository>()),
  );
}

class UpaApp extends StatelessWidget {
  const UpaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<GameListBloc>()),
        BlocProvider(create: (_) => sl<PlayGameBloc>()),
        BlocProvider(create: (_) => sl<LeaderboardBloc>()),
      ],
      child: MaterialApp(
        title: 'Upa! Estudiante',
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
