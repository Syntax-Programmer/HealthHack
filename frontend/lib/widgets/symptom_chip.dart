import 'package:flutter/material.dart';

class SymptomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SymptomChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
      return FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: const Color(0xFF0F1520),
        selectedColor: const Color(0xFF2DE2C5).withOpacity(0.2),
        checkmarkColor: const Color(0xFF2DE2C5),
        labelStyle: TextStyle(
          color: selected ? const Color(0xFF2DE2C5) : const Color(0xFFB8C1CC),
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selected
                ? const Color(0xFF2DE2C5)
                : const Color(0xFF2A3441),
          ),
        ),
      );
  }
}
