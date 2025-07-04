import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Data layer
import 'data/datasources/local/mock_data_source.dart';
import 'data/repositories/challenge_repository_impl.dart';
import 'data/repositories/team_repository_impl.dart';

// Domain layer
import 'domain/usecases/get_current_challenge.dart';
import 'domain/usecases/get_team_rankings.dart';
import 'domain/usecases/update_team_points.dart';

// Presentation layer
import 'presentation/providers/challenge_provider.dart';
import 'presentation/providers/team_provider.dart';
import 'presentation/pages/challenge_detail_page.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuração das dependências
    final mockDataSource = MockDataSource();
    final challengeRepository = ChallengeRepositoryImpl(mockDataSource);
    final teamRepository = TeamRepositoryImpl(mockDataSource);
    
    final getCurrentChallenge = GetCurrentChallenge(challengeRepository);
    final getTeamRankings = GetTeamRankings(teamRepository);
    final updateTeamPoints = UpdateTeamPoints(teamRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChallengeProvider(getCurrentChallenge),
        ),
        ChangeNotifierProvider(
          create: (_) => TeamProvider(getTeamRankings, updateTeamPoints),
        ),
      ],
      child: MaterialApp(
        title: 'Fitness Friendzy Clone',
        theme: AppTheme.lightTheme,
        home: const ChallengeDetailPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

