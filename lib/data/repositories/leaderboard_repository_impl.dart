import '../datasources/api_client.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final ApiClient _api;

  LeaderboardRepositoryImpl(this._api);

  @override
  Future<List<LeaderboardEntry>> getLeaderboard(String gameId, {int limit = 10}) async {
    final response = await _api.get('/leaderboard/$gameId', queryParams: {'limit': limit});
    final data = response.data as List;
    return data.map((json) => LeaderboardEntry(
      studentId: json['studentId'],
      displayName: json['displayName'],
      score: json['score'],
      rank: json['rank'],
    )).toList();
  }
}
