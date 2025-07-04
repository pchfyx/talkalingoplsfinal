import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_progress_provider.dart';
import 'home_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange, Colors.deepOrangeAccent],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            children: [
              const Center(
                child: Text(
                  'Talkalingo',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Choose your language',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              _buildLanguageCard(
                  context, 'Japanese', '日本語', '🇯🇵', Colors.red),
              const SizedBox(height: 30),
              _buildLanguageCard(
                  context, 'Spanish', 'Español', '🇪🇸', Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context,
    String language,
    String nativeName,
    String flag,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Provider.of<UserProgressProvider>(context, listen: false)
            .selectLanguage(language);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomeScreen(selectedLanguage: language)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              language,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              nativeName,
              style: TextStyle(fontSize: 18, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
