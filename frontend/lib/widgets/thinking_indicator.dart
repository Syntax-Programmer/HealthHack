import 'package:flutter/material.dart';

class ThinkingIndicator extends StatelessWidget {
  const ThinkingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text(
          "Analyzing your symptoms...",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
