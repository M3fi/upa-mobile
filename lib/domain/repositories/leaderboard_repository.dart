import '../entities/entities.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardEntry>> getLeaderboard(String gameId, {int limit = 10});
}
