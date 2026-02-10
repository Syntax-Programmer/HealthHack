import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/symptom_chip.dart';
import '../widgets/primary_button.dart';
import '../widgets/thinking_indicator.dart';
import 'models.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  AssessmentState _state = AssessmentState.selecting;
  final Set<String> _selectedSymptoms = {};
  AssessmentResult? _result;

  final Map<String, List<String>> symptomCategories = {
    "General": [
      "Fever",
      "Fatigue",
      "Chills",
      "Body Ache",
      "Weakness",
    ],
    "Respiratory": [
      "Cough",
      "Chest Pain",
      "Breathlessness",
      "Sore Throat",
      "Runny Nose",
    ],
    "Neurological": [
      "Headache",
      "Dizziness",
      "Confusion",
      "Blurred Vision",
    ],
    "Gastrointestinal": [
      "Nausea",
      "Vomiting",
      "Diarrhea",
      "Abdominal Pain",
      "Loss of Appetite",
    ],
  };

  void _startAssessment() {
    setState(() {
      _state = AssessmentState.thinking;
    });

    // Simulate backend / ML delay
    Timer(const Duration(seconds: 2), () {
      final severe = _selectedSymptoms.contains("Chest Pain") ||
          _selectedSymptoms.contains("Breathlessness");

      setState(() {
        _result = AssessmentResult(
          severity: severe ? "High" : "Low",
          message: severe
              ? "We strongly recommend visiting a doctor."
              : "Over-the-counter medication should be sufficient.",
          doctorRequired: severe,
        );
        _state = AssessmentState.result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌈 Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B0F14),
                  Color(0xFF101826),
                  Color(0xFF0B0F14),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Top brand header
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Pharma-Guard",
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Color(0xFF2DE2C5),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "AI-powered health & medicine safety",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9AA4AE),
                  ),
                ),
              ],
            ),
          ),
          // 📦 Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80), // 👈 pushes card down
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildCurrentState(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentState() {
    switch (_state) {
      case AssessmentState.selecting:
        return _buildSymptomSelection();
      case AssessmentState.thinking:
        return const ThinkingIndicator();
      case AssessmentState.result:
        return _buildResult();
    }
  }

  Widget _buildSymptomSelection() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 760),
      child: Card(
        elevation: 40,
        shadowColor: const Color(0xFF2DE2C5).withOpacity(0.2),
        color: const Color(0xFF121821),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF141B26),
                Color(0xFF0F1520),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2DE2C5),
              width: 0.6,
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 36),
              child: Column(
                children: [
                  // SAFETY TAG
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2DE2C5).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "SAFETY FIRST",
                      style: TextStyle(
                        color: Color(0xFF2DE2C5),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Select your symptoms",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Choose all symptoms that apply to you",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9AA4AE),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 70,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2DE2C5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Flexible(
                    fit: FlexFit.loose, // 👈 THIS fixes the dead space
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B111B),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF2DE2C5).withOpacity(0.25),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: symptomCategories.entries.map((entry) {
                            final category = entry.key;
                            final items = entry.value;

                            return Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                                childrenPadding: const EdgeInsets.only(bottom: 20),
                                iconColor: const Color(0xFF2DE2C5),
                                collapsedIconColor: const Color(0xFF2DE2C5),
                                title: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2DE2C5),
                                      ),
                                    ),
                                  ),
                                ),
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: items.map((symptom) {
                                      return SymptomChip(
                                        label: symptom,
                                        selected:
                                            _selectedSymptoms.contains(symptom),
                                        onTap: () {
                                          setState(() {
                                            _selectedSymptoms.contains(symptom)
                                                ? _selectedSymptoms.remove(symptom)
                                                : _selectedSymptoms.add(symptom);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Analyze button ALWAYS visible
                  PrimaryButton(
                    text: "Analyze",
                    enabled: _selectedSymptoms.isNotEmpty,
                    onPressed: _startAssessment,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _result!.doctorRequired
                  ? Icons.warning_amber
                  : Icons.check_circle,
              size: 80,
              color: _result!.doctorRequired ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 20),
            Text(
              "Severity: ${_result!.severity}",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _result!.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: "Start Over",
              onPressed: () {
                setState(() {
                  _selectedSymptoms.clear();
                  _state = AssessmentState.selecting;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
