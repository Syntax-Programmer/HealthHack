import 'package:flutter/material.dart';
import 'assessment/assessment_page.dart';
import 'home/landing_page.dart';

void main() {
  runApp(const PharmaGuardApp());
}

class PharmaGuardApp extends StatelessWidget {
  const PharmaGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharma-Guard',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/assessment': (context) => const AssessmentPage(),
      },
    );
  }
}
