import '../entities/challenge.dart';

abstract class ChallengeRepository {
  Future<Challenge?> getCurrentChallenge();
  Future<List<Challenge>> getAllChallenges();
  Future<Challenge> createChallenge(Challenge challenge);
  Future<Challenge> updateChallenge(Challenge challenge);
  Future<void> deleteChallenge(String challengeId);
  Future<Challenge?> getChallengeByInviteCode(String inviteCode);
}

