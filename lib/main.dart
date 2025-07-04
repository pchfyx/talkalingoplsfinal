import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/language_selection_screen.dart';
import 'providers/user_progress_provider.dart';
import 'providers/lesson_provider.dart';

void main() {
  runApp(const TalkalingoApp());
}

class TalkalingoApp extends StatelessWidget {
  const TalkalingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProgressProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
      ],
      child: MaterialApp(
        title: 'Talkalingo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const LanguageSelectionScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}