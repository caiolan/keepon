import '../../core/usecases/usecase.dart';
import '../entities/challenge.dart';
import '../repositories/challenge_repository.dart';

class GetCurrentChallenge implements UseCaseNoParams<Challenge?> {
  final ChallengeRepository repository;

  GetCurrentChallenge(this.repository);

  @override
  Future<Challenge?> call() async {
    return await repository.getCurrentChallenge();
  }
}

