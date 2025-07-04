import 'package:flutter/foundation.dart';
import '../../domain/entities/team.dart';
import '../../domain/usecases/get_team_rankings.dart';
import '../../domain/usecases/update_team_points.dart';

class TeamProvider with ChangeNotifier {
  final GetTeamRankings _getTeamRankings;
  final UpdateTeamPoints _updateTeamPoints;

  TeamProvider(this._getTeamRankings, this._updateTeamPoints);

  List<Team> _teams = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Team> get teams => _teams;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadTeamRankings(String challengeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _teams = await _getTeamRankings(challengeId);
    } catch (e) {
      _errorMessage = 'Erro ao carregar rankings: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTeamPoints(String teamId, int points) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final params = UpdateTeamPointsParams(teamId: teamId, points: points);
      await _updateTeamPoints(params);
      
      // Recarregar os rankings após atualização
      if (_teams.isNotEmpty) {
        // Assumindo que temos o challengeId do primeiro team (em uma implementação real, isso seria gerenciado melhor)
        await loadTeamRankings('1'); // ID do desafio atual
      }
      
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao atualizar pontos: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

