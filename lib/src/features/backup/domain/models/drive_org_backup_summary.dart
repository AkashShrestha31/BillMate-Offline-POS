class DriveOrgBackupSummary {
  const DriveOrgBackupSummary({
    required this.slug,
    required this.name,
    required this.code,
    this.businessType,
    this.exportedAt,
  });

  final String slug;
  final String name;
  final String code;
  final String? businessType;
  final DateTime? exportedAt;
}
