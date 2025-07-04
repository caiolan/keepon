import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:fitness_friendzy_clone/data/datasources/local/mock_data_source.dart';
import 'package:fitness_friendzy_clone/data/repositories/challenge_repository_impl.dart';
import 'package:fitness_friendzy_clone/data/repositories/team_repository_impl.dart';
import 'package:fitness_friendzy_clone/domain/usecases/get_current_challenge.dart';
import 'package:fitness_friendzy_clone/domain/usecases/get_team_rankings.dart';
import 'package:fitness_friendzy_clone/domain/usecases/update_team_points.dart';
import 'package:fitness_friendzy_clone/presentation/providers/challenge_provider.dart';
import 'package:fitness_friendzy_clone/presentation/providers/team_provider.dart';
import 'package:fitness_friendzy_clone/presentation/pages/challenge_detail_page.dart';
import 'package:fitness_friendzy_clone/presentation/theme/app_theme.dart';

void main() {
  testWidgets('Challenge detail page loads correctly', (WidgetTester tester) async {
    // Configuração das dependências para teste
    final mockDataSource = MockDataSource();
    final challengeRepository = ChallengeRepositoryImpl(mockDataSource);
    final teamRepository = TeamRepositoryImpl(mockDataSource);
    
    final getCurrentChallenge = GetCurrentChallenge(challengeRepository);
    final getTeamRankings = GetTeamRankings(teamRepository);
    final updateTeamPoints = UpdateTeamPoints(teamRepository);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ChallengeProvider(getCurrentChallenge),
          ),
          ChangeNotifierProvider(
            create: (_) => TeamProvider(getTeamRankings, updateTeamPoints),
          ),
        ],
        child: MaterialApp(
          title: 'Fitness Friendzy Clone Test',
          theme: AppTheme.lightTheme,
          home: const ChallengeDetailPage(),
        ),
      ),
    );

    // Aguarda o carregamento inicial
    await tester.pump();

    // Verifica se o indicador de carregamento está presente
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Aguarda o carregamento dos dados
    await tester.pumpAndSettle();

    // Verifica se o título do desafio está presente
    expect(find.text('Fitness friendzy'), findsOneWidget);

    // Verifica se a descrição está presente
    expect(find.text('This is a pairs challenge. Find a partner and get ready to crush the month.'), findsOneWidget);

    // Verifica se o código de convite está presente
    expect(find.text('QJFG14'), findsOneWidget);

    // Verifica se o botão de convite está presente
    expect(find.text('Invite'), findsOneWidget);

    // Verifica se a seção de teams está presente
    expect(find.text('12 Teams'), findsOneWidget);

    // Verifica se a seção de rankings está presente
    expect(find.text('Team rankings'), findsOneWidget);

    // Verifica se pelo menos uma equipe está listada
    expect(find.text("World's finest"), findsOneWidget);
    expect(find.text('917 points'), findsOneWidget);

    // Verifica se o FloatingActionButton está presente
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Challenge provider handles loading state', (WidgetTester tester) async {
    final mockDataSource = MockDataSource();
    final challengeRepository = ChallengeRepositoryImpl(mockDataSource);
    final getCurrentChallenge = GetCurrentChallenge(challengeRepository);
    
    final challengeProvider = ChallengeProvider(getCurrentChallenge);

    // Testa estado inicial
    expect(challengeProvider.isLoading, false);
    expect(challengeProvider.currentChallenge, null);
    expect(challengeProvider.errorMessage, null);

    // Testa carregamento
    final loadFuture = challengeProvider.loadCurrentChallenge();
    expect(challengeProvider.isLoading, true);

    await loadFuture;
    expect(challengeProvider.isLoading, false);
    expect(challengeProvider.currentChallenge, isNotNull);
    expect(challengeProvider.currentChallenge?.title, 'Fitness friendzy');
  });

  testWidgets('Team provider can update points', (WidgetTester tester) async {
    final mockDataSource = MockDataSource();
    final teamRepository = TeamRepositoryImpl(mockDataSource);
    final getTeamRankings = GetTeamRankings(teamRepository);
    final updateTeamPoints = UpdateTeamPoints(teamRepository);
    
    final teamProvider = TeamProvider(getTeamRankings, updateTeamPoints);

    // Carrega os rankings iniciais
    await teamProvider.loadTeamRankings('1');
    expect(teamProvider.teams.isNotEmpty, true);

    final initialTeam = teamProvider.teams.first;
    final initialPoints = initialTeam.points;

    // Atualiza pontos
    final success = await teamProvider.updateTeamPoints(initialTeam.id, 50);
    expect(success, true);

    // Verifica se os pontos foram atualizados
    final updatedTeam = teamProvider.teams.firstWhere((team) => team.id == initialTeam.id);
    expect(updatedTeam.points, initialPoints + 50);
  });
}

