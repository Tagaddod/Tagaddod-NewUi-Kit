class ValidationResult {
  final bool ran;
  final bool passed;
  final List<String> errors;
  final bool repaired;

  const ValidationResult({
    required this.ran,
    required this.passed,
    required this.errors,
    required this.repaired,
  });

  factory ValidationResult.skipped({
    String? message,
    bool repaired = false,
  }) =>
      ValidationResult(
        ran: false,
        passed: false,
        errors: message == null ? const [] : [message],
        repaired: repaired,
      );

  Map<String, dynamic> toJson() => {
        'ran': ran,
        'passed': passed,
        'errors': errors,
        'repaired': repaired,
      };
}
