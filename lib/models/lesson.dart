class Lesson {
  final String id;
  final String title;
  final String description;
  final List<VocabularyItem> vocabulary;
  final String category;
  bool isCompleted;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.vocabulary,
    required this.category,
    this.isCompleted = false,
  });
}

class VocabularyItem {
  final String word;
  final String translation;
  final String pronunciation;

  VocabularyItem({
    required this.word,
    required this.translation,
    required this.pronunciation,
  });
}
