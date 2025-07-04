import '../../core/usecases/usecase.dart';
import '../entities/team.dart';
import '../repositories/team_repository.dart';

class GetTeamRankings implements UseCase<List<Team>, String> {
  final TeamRepository repository;

  GetTeamRankings(this.repository);

  @override
  Future<List<Team>> call(String challengeId) async {
    return await repository.getTeamRankings(challengeId);
  }
}

