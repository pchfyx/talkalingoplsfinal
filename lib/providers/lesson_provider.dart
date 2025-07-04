import 'package:flutter/foundation.dart';
import '../models/lesson.dart';

class LessonProvider extends ChangeNotifier {
  List<Lesson> _lessons = [];
  List<Lesson> get lessons => _lessons;

  void loadLessons(String language) {
    _lessons = _getLessonsForLanguage(language);
    notifyListeners();
  }

  List<Lesson> _getLessonsForLanguage(String language) {
    if (language == 'Japanese') {
      return [
        Lesson(
          id: 'jp_greetings',
          title: 'Greetings',
          description: 'Learn basic Japanese greetings',
          category: 'Basics',
          vocabulary: [
            VocabularyItem(word: 'こんにちは', translation: 'Hello', pronunciation: 'Konnichiwa'),
            VocabularyItem(word: 'おはよう', translation: 'Good morning', pronunciation: 'Ohayou'),
            VocabularyItem(word: 'こんばんは', translation: 'Good evening', pronunciation: 'Konbanwa'),
            VocabularyItem(word: 'さようなら', translation: 'Goodbye', pronunciation: 'Sayounara'),
            VocabularyItem(word: 'ありがとう', translation: 'Thank you', pronunciation: 'Arigatou'),
          ],
        ),
        Lesson(
          id: 'jp_numbers',
          title: 'Numbers 1-10',
          description: 'Learn numbers from 1 to 10',
          category: 'Numbers',
          vocabulary: [
            VocabularyItem(word: '一', translation: 'One', pronunciation: 'Ichi'),
            VocabularyItem(word: '二', translation: 'Two', pronunciation: 'Ni'),
            VocabularyItem(word: '三', translation: 'Three', pronunciation: 'San'),
            VocabularyItem(word: '四', translation: 'Four', pronunciation: 'Shi'),
            VocabularyItem(word: '五', translation: 'Five', pronunciation: 'Go'),
          ],
        ),
        Lesson(
          id: 'jp_family',
          title: 'Family',
          description: 'Learn family member names',
          category: 'Family',
          vocabulary: [
            VocabularyItem(word: '家族', translation: 'Family', pronunciation: 'Kazoku'),
            VocabularyItem(word: '父', translation: 'Father', pronunciation: 'Chichi'),
            VocabularyItem(word: '母', translation: 'Mother', pronunciation: 'Haha'),
            VocabularyItem(word: '兄', translation: 'Older brother', pronunciation: 'Ani'),
            VocabularyItem(word: '姉', translation: 'Older sister', pronunciation: 'Ane'),
          ],
        ),
      ];
    } else if (language == 'Spanish') {
      return [
        Lesson(
          id: 'es_greetings',
          title: 'Saludos',
          description: 'Learn basic Spanish greetings',
          category: 'Basics',
          vocabulary: [
            VocabularyItem(word: 'Hola', translation: 'Hello', pronunciation: 'OH-lah'),
            VocabularyItem(word: 'Buenos días', translation: 'Good morning', pronunciation: 'BWAY-nohs DEE-ahs'),
            VocabularyItem(word: 'Buenas tardes', translation: 'Good afternoon', pronunciation: 'BWAY-nahs TAR-dehs'),
            VocabularyItem(word: 'Buenas noches', translation: 'Good evening', pronunciation: 'BWAY-nahs NOH-chehs'),
            VocabularyItem(word: 'Adiós', translation: 'Goodbye', pronunciation: 'ah-dee-OHS'),
          ],
        ),
        Lesson(
          id: 'es_numbers',
          title: 'Números 1-10',
          description: 'Learn numbers from 1 to 10',
          category: 'Numbers',
          vocabulary: [
            VocabularyItem(word: 'Uno', translation: 'One', pronunciation: 'OO-noh'),
            VocabularyItem(word: 'Dos', translation: 'Two', pronunciation: 'dohs'),
            VocabularyItem(word: 'Tres', translation: 'Three', pronunciation: 'trehs'),
            VocabularyItem(word: 'Cuatro', translation: 'Four', pronunciation: 'KWAH-troh'),
            VocabularyItem(word: 'Cinco', translation: 'Five', pronunciation: 'SEEN-koh'),
          ],
        ),
        Lesson(
          id: 'es_family',
          title: 'Familia',
          description: 'Learn family member names',
          category: 'Family',
          vocabulary: [
            VocabularyItem(word: 'Familia', translation: 'Family', pronunciation: 'fah-MEE-lee-ah'),
            VocabularyItem(word: 'Padre', translation: 'Father', pronunciation: 'PAH-dreh'),
            VocabularyItem(word: 'Madre', translation: 'Mother', pronunciation: 'MAH-dreh'),
            VocabularyItem(word: 'Hermano', translation: 'Brother', pronunciation: 'ehr-MAH-noh'),
            VocabularyItem(word: 'Hermana', translation: 'Sister', pronunciation: 'ehr-MAH-nah'),
          ],
        ),
      ];
    }
    return [];
  }
}