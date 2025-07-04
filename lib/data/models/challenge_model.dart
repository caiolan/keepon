import '../../domain/entities/challenge.dart';

class ChallengeModel extends Challenge {
  const ChallengeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.startDate,
    required super.endDate,
    required super.inviteCode,
    required super.isCompleted,
    required super.totalTeams,
    required super.progressPercentage,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      inviteCode: json['inviteCode'] as String,
      isCompleted: json['isCompleted'] as bool,
      totalTeams: json['totalTeams'] as int,
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'inviteCode': inviteCode,
      'isCompleted': isCompleted,
      'totalTeams': totalTeams,
      'progressPercentage': progressPercentage,
    };
  }

  factory ChallengeModel.fromEntity(Challenge challenge) {
    return ChallengeModel(
      id: challenge.id,
      title: challenge.title,
      description: challenge.description,
      startDate: challenge.startDate,
      endDate: challenge.endDate,
      inviteCode: challenge.inviteCode,
      isCompleted: challenge.isCompleted,
      totalTeams: challenge.totalTeams,
      progressPercentage: challenge.progressPercentage,
    );
  }
}

