import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_progress.dart';

class UserProgressProvider extends ChangeNotifier {
  UserProgress _userProgress = UserProgress();
  UserProgress get userProgress => _userProgress;

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString('user_progress');
    if (progressJson != null) {
      _userProgress = UserProgress.fromJson(jsonDecode(progressJson));
      notifyListeners();
    }
  }

  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_progress', jsonEncode(_userProgress.toJson()));
  }

  void selectLanguage(String language) {
    _userProgress.selectedLanguage = language;
    saveProgress();
    notifyListeners();
  }

  void completeLesson(String lessonId, int points) {
    _userProgress.completedLessons[lessonId] = true;
    _userProgress.totalPoints += points;
    _userProgress.lessonsCompleted++;
    _userProgress.currentStreak++;
    saveProgress();
    notifyListeners();
  }

  void addPoints(int points) {
    _userProgress.totalPoints += points;
    saveProgress();
    notifyListeners();
  }
}