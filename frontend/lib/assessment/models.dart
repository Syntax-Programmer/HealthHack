enum AssessmentState {
  selecting,
  thinking,
  result,
}

class AssessmentResult {
  final String advice;
  final List<String> suggestedMeds;
  final int docRange; // 0–100
  final int severity; // 0–100

  AssessmentResult({
    required this.advice,
    required this.suggestedMeds,
    required this.docRange,
    required this.severity,
  });

  factory AssessmentResult.fromJson(Map<String, dynamic> json) {
    return AssessmentResult(
      advice: json['advice'] ?? 'No advice available',
      suggestedMeds:
          List<String>.from(json['suggested_meds'] ?? const []),
      docRange: json['doc_range'] ?? 0,
      severity: json['severity'] ?? 0,
    );
  }
}
