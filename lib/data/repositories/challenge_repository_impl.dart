import '../../domain/entities/challenge.dart';
import '../../domain/repositories/challenge_repository.dart';
import '../datasources/local/mock_data_source.dart';
import '../models/challenge_model.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  final MockDataSource _dataSource;

  ChallengeRepositoryImpl(this._dataSource);

  @override
  Future<Challenge?> getCurrentChallenge() async {
    try {
      final challengeModel = await _dataSource.getCurrentChallenge();
      return challengeModel;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Challenge>> getAllChallenges() async {
    try {
      // Por enquanto, retorna apenas o desafio atual
      final currentChallenge = await _dataSource.getCurrentChallenge();
      return [currentChallenge];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Challenge> createChallenge(Challenge challenge) async {
    final challengeModel = ChallengeModel.fromEntity(challenge);
    // Mock implementation - em uma implementação real, isso seria persistido
    return challengeModel;
  }

  @override
  Future<Challenge> updateChallenge(Challenge challenge) async {
    final challengeModel = ChallengeModel.fromEntity(challenge);
    // Mock implementation - em uma implementação real, isso seria atualizado na fonte de dados
    return challengeModel;
  }

  @override
  Future<void> deleteChallenge(String challengeId) async {
    // Mock implementation - em uma implementação real, isso seria removido da fonte de dados
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<Challenge?> getChallengeByInviteCode(String inviteCode) async {
    try {
      final currentChallenge = await _dataSource.getCurrentChallenge();
      if (currentChallenge.inviteCode == inviteCode) {
        return currentChallenge;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

