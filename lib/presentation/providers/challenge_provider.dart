import 'package:flutter/foundation.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/usecases/get_current_challenge.dart';

class ChallengeProvider with ChangeNotifier {
  final GetCurrentChallenge _getCurrentChallenge;

  ChallengeProvider(this._getCurrentChallenge);

  Challenge? _currentChallenge;
  bool _isLoading = false;
  String? _errorMessage;

  Challenge? get currentChallenge => _currentChallenge;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCurrentChallenge() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentChallenge = await _getCurrentChallenge();
    } catch (e) {
      _errorMessage = 'Erro ao carregar desafio: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

