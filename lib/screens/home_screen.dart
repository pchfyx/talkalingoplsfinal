// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_progress_provider.dart';
import '../providers/lesson_provider.dart';
import 'lesson_screen.dart';
import 'language_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  final String selectedLanguage;

  const HomeScreen({super.key, required this.selectedLanguage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LessonProvider>(context, listen: false)
          .loadLessons(widget.selectedLanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn ${widget.selectedLanguage}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LanguageSelectionScreen(),
              ),
            );
          },
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          Consumer<UserProgressProvider>(
            builder: (context, progress, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox(width: 4),
                    Text(
                      '${progress.userProgress.totalPoints}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer2<LessonProvider, UserProgressProvider>(
        builder: (context, lessonProvider, progressProvider, child) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.orange.shade50,
                child: Column(
                  children: [
                    Text(
                      'Current Streak: ${progressProvider.userProgress.currentStreak} days',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lessons Completed: ${progressProvider.userProgress.lessonsCompleted}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: lessonProvider.lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessonProvider.lessons[index];
                    final isCompleted = progressProvider
                            .userProgress.completedLessons[lesson.id] ??
                        false;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              isCompleted ? Colors.orange : Colors.grey,
                          child: Icon(
                            isCompleted ? Icons.check : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          lesson.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lesson.description),
                            const SizedBox(height: 4),
                            Text(
                              '${lesson.vocabulary.length} words • ${lesson.category}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: isCompleted
                            ? const Icon(Icons.star, color: Colors.yellow)
                            : const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LessonScreen(lesson: lesson),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
