import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/symptom_chip.dart';
import '../widgets/primary_button.dart';
import '../widgets/thinking_indicator.dart';
import '../api/assessment_api.dart';
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

  final Map<String, List<Map<String, String>>> symptomCategories = {
    "General": [
      {"key": "fever", "label": "Fever"},
      {"key": "fatigue", "label": "Fatigue"},
      {"key": "chills", "label": "Chills"},
      {"key": "weakness", "label": "Weakness"},
      {"key": "loss_of_appetite", "label": "Loss of Appetite"},
      {"key": "sleep_disturbance", "label": "Sleep Disturbance"},
    ],

    "Neurological": [
      {"key": "headache", "label": "Headache"},
      {"key": "dizziness", "label": "Dizziness"},
      {"key": "confusion", "label": "Confusion"},
      {"key": "fainting", "label": "Fainting"},
      {
        "key": "difficulty_concentrating",
        "label": "Difficulty Concentrating"
      },
      {"key": "blurred_vision", "label": "Blurred Vision"},
      {"key": "eye_pain", "label": "Eye Pain"},
      {"key": "light_sensitivity", "label": "Light Sensitivity"},
    ],

    "Respiratory & Chest": [
      {"key": "cough", "label": "Cough"},
      {
        "key": "shortness_of_breath",
        "label": "Breathlessness"
      },
      {"key": "chest_tightness", "label": "Chest Tightness"},
      {"key": "wheezing", "label": "Wheezing"},
      {"key": "sore_throat", "label": "Sore Throat"},
      {"key": "chest_pain", "label": "Chest Pain"},
      {"key": "palpitations", "label": "Heart Palpitations"},
      {"key": "leg_swelling", "label": "Leg Swelling"},
    ],

    "Gastrointestinal": [
      {"key": "nausea", "label": "Nausea"},
      {"key": "vomiting", "label": "Vomiting"},
      {"key": "diarrhea", "label": "Diarrhea"},
      {"key": "abdominal_pain", "label": "Abdominal Pain"},
      {"key": "bloating", "label": "Bloating"},
      {"key": "acid_reflux", "label": "Acid Reflux"},
    ],

    "Musculoskeletal": [
      {"key": "muscle_pain", "label": "Muscle Pain"},
      {"key": "joint_pain", "label": "Joint Pain"},
      {"key": "back_pain", "label": "Back Pain"},
    ],

    "ENT (Ear, Nose, Throat)": [
      {"key": "runny_nose", "label": "Runny Nose"},
      {"key": "nasal_congestion", "label": "Nasal Congestion"},
      {
        "key": "loss_of_taste_smell",
        "label": "Loss of Taste / Smell"
      },
      {"key": "ear_pain", "label": "Ear Pain"},
    ],

    "Skin & Allergies": [
      {"key": "skin_rash", "label": "Skin Rash"},
      {"key": "itching", "label": "Itching"},
      {"key": "swelling", "label": "Swelling"},
      {"key": "redness", "label": "Redness"},
    ],

    "Urinary": [
      {
        "key": "frequent_urination",
        "label": "Frequent Urination"
      },
      {
        "key": "painful_urination",
        "label": "Painful Urination"
      },
      {
        "key": "burning_sensation",
        "label": "Burning Sensation"
      },
    ],

    "Mental Health": [
      {"key": "anxiety", "label": "Anxiety"},
      {"key": "low_mood", "label": "Low Mood"},
    ],
  };

  void _startAssessment() async {
    setState(() {
      _state = AssessmentState.thinking;
    });

    try {
      final response = await AssessmentApi.assess(
        _selectedSymptoms.toList(),
      );

      setState(() {
        _result = AssessmentResult.fromJson(response);
        _state = AssessmentState.result;
      });
    } catch (e) {
      debugPrint("Assessment error: $e");
      setState(() {
        _result = null;
        _state = AssessmentState.result;
      });
    }
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
          // ⬅ Back button
          Positioned(
            top: 32,
            left: 24,
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF2DE2C5),
                size: 20,
              ),
              label: const Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFF2DE2C5),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2DE2C5),
              ),
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
          // ⚠️ Bottom disclaimer (outside the card)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Disclaimer: This assessment is for informational purposes only and may not be fully accurate. "
                  "It is not a medical diagnosis. Always consult a qualified healthcare professional.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF9AA4AE),
                  ),
                ),
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
                                      final key = symptom["key"]!;
                                      final label = symptom["label"]!;

                                      return SymptomChip(
                                        label: label,
                                        selected: _selectedSymptoms.contains(key),
                                        onTap: () {
                                          setState(() {
                                            _selectedSymptoms.contains(key)
                                                ? _selectedSymptoms.remove(key)
                                                : _selectedSymptoms.add(key);
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

  void _resetAssessment() {
    setState(() {
      _selectedSymptoms.clear();
      _result = null;
      _state = AssessmentState.selecting;
    });
  }

  Widget _buildResult() {
    if (_result == null) {
      return _buildError();
    }

    final severityColor = _result!.severity >= 70
        ? Colors.redAccent
        : _result!.severity >= 40
            ? Colors.orangeAccent
            : Colors.greenAccent;

    return Card(
      elevation: 20,
      color: const Color(0xFF121821),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.health_and_safety,
                size: 80, color: severityColor),

            const SizedBox(height: 20),

            Text(
              "Severity: ${_result!.severity}%",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: severityColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Doctor Visit Likelihood: ${_result!.docRange}%",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF9AA4AE),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              _result!.advice,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            if (_result!.suggestedMeds.isNotEmpty) ...[
              const Text(
                "Suggested Medicines",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2DE2C5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _result!.suggestedMeds.map((med) {
                  return Chip(
                    label: Text(med),
                    backgroundColor:
                        const Color(0xFF2DE2C5).withOpacity(0.2),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 32),

            PrimaryButton(
              text: "Start Over",
              onPressed: _resetAssessment,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildError() {
    return Card(
      color: const Color(0xFF121821),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            const Text(
              "Severity: Error",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Failed to connect to the server.",
              style: TextStyle(color: Color(0xFF9AA4AE)),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: "Start Over",
              onPressed: _resetAssessment,
            ),
          ],
        ),
      ),
    );
  }
}
