import '../../domain/entities/team.dart';
import '../../domain/repositories/team_repository.dart';
import '../datasources/local/mock_data_source.dart';
import '../models/team_model.dart';

class TeamRepositoryImpl implements TeamRepository {
  final MockDataSource _dataSource;

  TeamRepositoryImpl(this._dataSource);

  @override
  Future<List<Team>> getTeamsByChallenge(String challengeId) async {
    try {
      final teams = await _dataSource.getTeamsByChallenge(challengeId);
      return teams;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Team>> getTeamRankings(String challengeId) async {
    try {
      final teams = await _dataSource.getTeamRankings(challengeId);
      return teams;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Team> createTeam(Team team) async {
    final teamModel = TeamModel.fromEntity(team);
    return await _dataSource.createTeam(teamModel);
  }

  @override
  Future<Team> updateTeam(Team team) async {
    final teamModel = TeamModel.fromEntity(team);
    return await _dataSource.updateTeam(teamModel);
  }

  @override
  Future<Team> updateTeamPoints(String teamId, int pointsToAdd) async {
    return await _dataSource.updateTeamPoints(teamId, pointsToAdd);
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    await _dataSource.deleteTeam(teamId);
  }

  @override
  Future<Team?> getTeamById(String teamId) async {
    try {
      return await _dataSource.getTeamById(teamId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Team?> getUserTeam(String userId, String challengeId) async {
    try {
      final teams = await _dataSource.getTeamsByChallenge(challengeId);
      for (final team in teams) {
        if (team.memberIds.contains(userId)) {
          return team;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

