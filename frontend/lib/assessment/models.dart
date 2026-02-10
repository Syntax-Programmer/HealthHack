enum AssessmentState {
  selecting,
  thinking,
  result,
}

class AssessmentResult {
  final String severity;
  final String message;
  final bool doctorRequired;

  AssessmentResult({
    required this.severity,
    required this.message,
    required this.doctorRequired,
  });
}
