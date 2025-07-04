import '../../models/challenge_model.dart';
import '../../models/team_model.dart';

class MockDataSource {
  static final MockDataSource _instance = MockDataSource._internal();
  factory MockDataSource() => _instance;
  MockDataSource._internal();

  // Mock data para demonstração
  final ChallengeModel _currentChallenge = ChallengeModel(
    id: '1',
    title: 'Fitness friendzy',
    description:
        'This is a pairs challenge. Find a partner and get ready to crush the month.',
    startDate: DateTime(2023, 3, 1),
    endDate: DateTime(2023, 3, 31),
    inviteCode: 'QJFG14',
    isCompleted: true,
    totalTeams: 12,
    progressPercentage: 100.0,
  );

  final List<TeamModel> _teams = [
    const TeamModel(
      id: '1',
      name: "World's finest",
      avatarUrl: 'https://via.placeholder.com/50',
      points: 917,
      ranking: 1,
      memberIds: ['user1', 'user2'],
    ),
    const TeamModel(
      id: '2',
      name: 'Big Al & Lil Bill',
      avatarUrl: 'https://via.placeholder.com/50',
      points: 907,
      ranking: 2,
      memberIds: ['user3', 'user4'],
    ),
    const TeamModel(
      id: '3',
      name: 'Queen City Witches',
      avatarUrl: 'https://via.placeholder.com/50',
      points: 882,
      ranking: 3,
      memberIds: ['user5', 'user6'],
    ),
    const TeamModel(
      id: '4',
      name: 'Age & The Better Hart Sib',
      avatarUrl: 'https://via.placeholder.com/50',
      points: 856,
      ranking: 4,
      memberIds: ['user7', 'user8'],
    ),
    const TeamModel(
      id: '5',
      name: 'OPC',
      avatarUrl: 'https://via.placeholder.com/50',
      points: 488,
      ranking: 5,
      memberIds: ['user9', 'user10'],
    ),
  ];

  Future<ChallengeModel> getCurrentChallenge() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentChallenge;
  }

  Future<List<TeamModel>> getTeamsByChallenge(String challengeId) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));
    return _teams;
  }

  Future<List<TeamModel>> getTeamRankings(String challengeId) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));
    // Retorna as equipes ordenadas por pontuação
    final sortedTeams = List<TeamModel>.from(_teams);
    sortedTeams.sort((a, b) => b.points.compareTo(a.points));
    return sortedTeams;
  }

  Future<TeamModel?> getTeamById(String teamId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _teams.firstWhere((team) => team.id == teamId);
    } catch (e) {
      return null;
    }
  }

  Future<TeamModel> createTeam(TeamModel team) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _teams.add(team);
    return team;
  }

  Future<TeamModel> updateTeam(TeamModel team) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _teams.indexWhere((t) => t.id == team.id);
    if (index != -1) {
      _teams[index] = team;
    }
    return team;
  }

  Future<TeamModel> updateTeamPoints(String teamId, int pointsToAdd) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final teamIndex = _teams.indexWhere((team) => team.id == teamId);
    if (teamIndex == -1) {
      throw Exception('Team not found');
    }

    final currentTeam = _teams[teamIndex];
    final updatedTeam = TeamModel(
      id: currentTeam.id,
      name: currentTeam.name,
      avatarUrl: currentTeam.avatarUrl,
      points: currentTeam.points + pointsToAdd,
      ranking: currentTeam.ranking, // Será recalculado
      memberIds: currentTeam.memberIds,
    );

    _teams[teamIndex] = updatedTeam;

    // Reordenar as equipes por pontuação e atualizar rankings
    _teams.sort((a, b) => b.points.compareTo(a.points));

    // Atualizar rankings
    for (int i = 0; i < _teams.length; i++) {
      final team = _teams[i];
      _teams[i] = TeamModel(
        id: team.id,
        name: team.name,
        avatarUrl: team.avatarUrl,
        points: team.points,
        ranking: i + 1,
        memberIds: team.memberIds,
      );
    }

    return _teams.firstWhere((team) => team.id == teamId);
  }

  Future<void> deleteTeam(String teamId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _teams.removeWhere((team) => team.id == teamId);
  }
}
