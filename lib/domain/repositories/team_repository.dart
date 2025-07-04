import '../entities/team.dart';

abstract class TeamRepository {
  Future<List<Team>> getTeamsByChallenge(String challengeId);
  Future<List<Team>> getTeamRankings(String challengeId);
  Future<Team> createTeam(Team team);
  Future<Team> updateTeam(Team team);
  Future<Team> updateTeamPoints(String teamId, int pointsToAdd);
  Future<void> deleteTeam(String teamId);
  Future<Team?> getTeamById(String teamId);
  Future<Team?> getUserTeam(String userId, String challengeId);
}

