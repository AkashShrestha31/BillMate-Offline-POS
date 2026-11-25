/// Outcome of a Remote Config force-update check.
class ForceUpdateResult {
  const ForceUpdateResult._({
    required this.isForceUpdateRequired,
    required this.currentVersion,
    this.minimumVersion,
    this.title,
    this.message,
    this.storeUrl,
  });

  const ForceUpdateResult.notRequired({required String currentVersion})
      : this._(
          isForceUpdateRequired: false,
          currentVersion: currentVersion,
        );

  const ForceUpdateResult.required({
    required String currentVersion,
    required String minimumVersion,
    required String title,
    required String message,
    required String storeUrl,
  }) : this._(
          isForceUpdateRequired: true,
          currentVersion: currentVersion,
          minimumVersion: minimumVersion,
          title: title,
          message: message,
          storeUrl: storeUrl,
        );

  final bool isForceUpdateRequired;
  final String currentVersion;
  final String? minimumVersion;
  final String? title;
  final String? message;
  final String? storeUrl;
}
