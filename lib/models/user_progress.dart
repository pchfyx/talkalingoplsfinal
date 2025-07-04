class UserProgress {
  int totalPoints;
  int currentStreak;
  int lessonsCompleted;
  String selectedLanguage;
  Map<String, bool> completedLessons;

  UserProgress({
    this.totalPoints = 0,
    this.currentStreak = 0,
    this.lessonsCompleted = 0,
    this.selectedLanguage = '',
    this.completedLessons = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'currentStreak': currentStreak,
      'lessonsCompleted': lessonsCompleted,
      'selectedLanguage': selectedLanguage,
      'completedLessons': completedLessons,
    };
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      totalPoints: json['totalPoints'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      lessonsCompleted: json['lessonsCompleted'] ?? 0,
      selectedLanguage: json['selectedLanguage'] ?? '',
      completedLessons: Map<String, bool>.from(json['completedLessons'] ?? {}),
    );
  }
}