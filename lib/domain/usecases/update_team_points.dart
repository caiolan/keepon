import '../../core/usecases/usecase.dart';
import '../entities/team.dart';
import '../repositories/team_repository.dart';

class UpdateTeamPoints implements UseCase<Team, UpdateTeamPointsParams> {
  final TeamRepository repository;

  UpdateTeamPoints(this.repository);

  @override
  Future<Team> call(UpdateTeamPointsParams params) async {
    return await repository.updateTeamPoints(params.teamId, params.points);
  }
}

class UpdateTeamPointsParams {
  final String teamId;
  final int points;

  const UpdateTeamPointsParams({
    required this.teamId,
    required this.points,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UpdateTeamPointsParams &&
        other.teamId == teamId &&
        other.points == points;
  }

  @override
  int get hashCode => teamId.hashCode ^ points.hashCode;

  @override
  String toString() => 'UpdateTeamPointsParams(teamId: $teamId, points: $points)';
}

