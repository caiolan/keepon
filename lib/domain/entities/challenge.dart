class Challenge {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String inviteCode;
  final bool isCompleted;
  final int totalTeams;
  final double progressPercentage;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.inviteCode,
    required this.isCompleted,
    required this.totalTeams,
    required this.progressPercentage,
  });

  Challenge copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? inviteCode,
    bool? isCompleted,
    int? totalTeams,
    double? progressPercentage,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      inviteCode: inviteCode ?? this.inviteCode,
      isCompleted: isCompleted ?? this.isCompleted,
      totalTeams: totalTeams ?? this.totalTeams,
      progressPercentage: progressPercentage ?? this.progressPercentage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Challenge &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.inviteCode == inviteCode &&
        other.isCompleted == isCompleted &&
        other.totalTeams == totalTeams &&
        other.progressPercentage == progressPercentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        inviteCode.hashCode ^
        isCompleted.hashCode ^
        totalTeams.hashCode ^
        progressPercentage.hashCode;
  }

  @override
  String toString() {
    return 'Challenge(id: $id, title: $title, description: $description, startDate: $startDate, endDate: $endDate, inviteCode: $inviteCode, isCompleted: $isCompleted, totalTeams: $totalTeams, progressPercentage: $progressPercentage)';
  }
}

