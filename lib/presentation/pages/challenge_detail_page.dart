import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/challenge_provider.dart';
import '../providers/team_provider.dart';
import '../widgets/challenge_header.dart';
import '../widgets/team_avatar_list.dart';
import '../widgets/team_ranking_list.dart';
import 'add_points_page.dart';

class ChallengeDetailPage extends StatefulWidget {
  const ChallengeDetailPage({super.key});

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final challengeProvider = context.read<ChallengeProvider>();
    final teamProvider = context.read<TeamProvider>();

    await challengeProvider.loadCurrentChallenge();
    
    if (challengeProvider.currentChallenge != null) {
      await teamProvider.loadTeamRankings(challengeProvider.currentChallenge!.id);
    }
  }

  Future<void> _navigateToAddPoints() async {
    final teamProvider = context.read<TeamProvider>();
    
    if (teamProvider.teams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma equipa disponível para adicionar pontos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => AddPointsPage(teams: teamProvider.teams),
      ),
    );

    // Se houve alteração (result == true), recarregar os dados
    if (result == true) {
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          return FloatingActionButton(
            onPressed: teamProvider.isLoading ? null : _navigateToAddPoints,
            backgroundColor: teamProvider.isLoading 
                ? Colors.grey 
                : Theme.of(context).primaryColor,
            child: teamProvider.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
          );
        },
      ),
      body: Consumer2<ChallengeProvider, TeamProvider>(
        builder: (context, challengeProvider, teamProvider, child) {
          if (challengeProvider.isLoading || teamProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (challengeProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    challengeProvider.errorMessage!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadData,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (challengeProvider.currentChallenge == null) {
            return const Center(
              child: Text('Nenhum desafio encontrado'),
            );
          }

          final challenge = challengeProvider.currentChallenge!;
          final teams = teamProvider.teams;

          return RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho do desafio
                  ChallengeHeader(challenge: challenge),
                  
                  // Lista de avatares das equipes
                  TeamAvatarList(
                    teams: teams,
                    totalTeams: challenge.totalTeams,
                  ),
                  
                  // Rankings das equipes
                  TeamRankingList(teams: teams),
                  
                  // Informação adicional (26 Rats)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '26 Rats',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 80), // Espaço para o FAB
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

