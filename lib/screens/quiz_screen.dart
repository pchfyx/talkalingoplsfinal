// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../providers/user_progress_provider.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  List<VocabularyItem> _shuffledVocab = [];
  String? _selectedAnswer;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _shuffledVocab = List.from(widget.lesson.vocabulary)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (_shuffledVocab.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No vocabulary to quiz!')),
      );
    }

    if (_currentQuestion >= _shuffledVocab.length) return _buildResultScreen();

    final currentVocab = _shuffledVocab[_currentQuestion];
    final options = _generateOptions(currentVocab);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.lesson.title}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: (_currentQuestion + 1) / _shuffledVocab.length,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Question ${_currentQuestion + 1} of ${_shuffledVocab.length}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text('What does this mean?',
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 10),
                            Text(
                              currentVocab.word,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...options.map((option) =>
                        _buildOptionButton(option, currentVocab.translation)),
                    const SizedBox(height: 20),
                    if (_answered)
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        ),
                        child: Text(
                          _currentQuestion < _shuffledVocab.length - 1 ? 'Next' : 'Finish',
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option, String correctAnswer) {
    Color? color;
    if (_answered) {
      if (option == correctAnswer) color = Colors.green;
      else if (option == _selectedAnswer) color = Colors.red;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: _answered ? null : () => _selectAnswer(option, correctAnswer),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: color != null ? Colors.white : null,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          option,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  List<String> _generateOptions(VocabularyItem vocab) {
    final options = <String>[vocab.translation];
    final others = widget.lesson.vocabulary
        .where((item) => item.translation != vocab.translation)
        .map((item) => item.translation)
        .toList();
    others.shuffle();
    options.addAll(others.take(3));
    options.shuffle();
    return options;
  }

  void _selectAnswer(String selected, String correct) {
    setState(() {
      _selectedAnswer = selected;
      _answered = true;
      if (selected == correct) _score++;
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestion++;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  Widget _buildResultScreen() {
    final percentage = (_score / _shuffledVocab.length * 100).round();
    final points = _score * 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Complete!'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 100, color: Colors.orange),
              const SizedBox(height: 30),
              const Text('Quiz Complete!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange)),
              const SizedBox(height: 20),
              Text('Score: $_score/${_shuffledVocab.length}', style: const TextStyle(fontSize: 24)),
              Text('$percentage%', style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 20),
              Text('Points Earned: $points',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Provider.of<UserProgressProvider>(context, listen: false)
                      .completeLesson(widget.lesson.id, points);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Continue Learning'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
