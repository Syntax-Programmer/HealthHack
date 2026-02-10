import 'package:flutter/material.dart';
import 'assessment/assessment_page.dart';

void main() {
  runApp(const HealthHackApp());
}

class HealthHackApp extends StatelessWidget {
  const HealthHackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthHack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F14),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2DE2C5), // teal accent
          secondary: Color(0xFF1AAE9F),
          surface: Color(0xFF121821),
          background: Color(0xFF0B0F14),
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFFB8C1CC),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF9AA4AE),
          ),
        ),
      ),
      home: const AssessmentPage(),
    );
  }
}
