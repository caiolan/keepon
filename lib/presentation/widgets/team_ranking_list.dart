import 'package:flutter/material.dart';
import '../../domain/entities/team.dart';

class TeamRankingList extends StatelessWidget {
  final List<Team> teams;

  const TeamRankingList({
    super.key,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Team rankings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teams.length > 5 ? 5 : teams.length, // Mostra apenas os top 5
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final team = teams[index];
                return _buildTeamRankingItem(context, team);
              },
            ),
            if (teams.length > 5) ...[
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  // TODO: Navegar para tela com todos os rankings
                },
                child: Row(
                  children: [
                    Text(
                      'All team rankings',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTeamRankingItem(BuildContext context, Team team) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Avatar da equipe
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            child: team.avatarUrl.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      team.avatarUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderAvatar(team.name);
                      },
                    ),
                  )
                : _buildPlaceholderAvatar(team.name),
          ),
          
          const SizedBox(width: 16),
          
          // Nome e pontos da equipe
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${team.points} points',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          
          // Posição no ranking
          Text(
            _getRankingText(team.ranking),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderAvatar(String teamName) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          teamName.isNotEmpty ? teamName[0].toUpperCase() : 'T',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  String _getRankingText(int ranking) {
    switch (ranking) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
      default:
        return '${ranking}th';
    }
  }
}

