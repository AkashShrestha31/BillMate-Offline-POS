class FreemiumCheckResult {
  const FreemiumCheckResult._({
    required this.allowed,
    this.message,
    this.limit,
    this.current,
  });

  const FreemiumCheckResult.allowed()
      : allowed = true,
        message = null,
        limit = null,
        current = null;

  const FreemiumCheckResult.blocked({
    required this.message,
    this.limit,
    this.current,
  }) : allowed = false;

  final bool allowed;
  final String? message;
  final int? limit;
  final int? current;
}
