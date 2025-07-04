import '../../domain/entities/team.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.points,
    required super.ranking,
    required super.memberIds,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      points: json['points'] as int,
      ranking: json['ranking'] as int,
      memberIds: List<String>.from(json['memberIds'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'points': points,
      'ranking': ranking,
      'memberIds': memberIds,
    };
  }

  factory TeamModel.fromEntity(Team team) {
    return TeamModel(
      id: team.id,
      name: team.name,
      avatarUrl: team.avatarUrl,
      points: team.points,
      ranking: team.ranking,
      memberIds: team.memberIds,
    );
  }
}

