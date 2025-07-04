class Team {
  final String id;
  final String name;
  final String avatarUrl;
  final int points;
  final int ranking;
  final List<String> memberIds;

  const Team({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.points,
    required this.ranking,
    required this.memberIds,
  });

  Team copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    int? points,
    int? ranking,
    List<String>? memberIds,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      points: points ?? this.points,
      ranking: ranking ?? this.ranking,
      memberIds: memberIds ?? this.memberIds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Team &&
        other.id == id &&
        other.name == name &&
        other.avatarUrl == avatarUrl &&
        other.points == points &&
        other.ranking == ranking &&
        _listEquals(other.memberIds, memberIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        avatarUrl.hashCode ^
        points.hashCode ^
        ranking.hashCode ^
        memberIds.hashCode;
  }

  @override
  String toString() {
    return 'Team(id: $id, name: $name, avatarUrl: $avatarUrl, points: $points, ranking: $ranking, memberIds: $memberIds)';
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    if (identical(a, b)) return true;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}

