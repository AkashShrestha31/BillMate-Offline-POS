class OrganizationSettings {
  const OrganizationSettings({
    required this.organizationName,
    required this.companyName,
    required this.businessType,
    required this.organizationCode,
    required this.organizationSlug,
    this.logo,
  });

  final String organizationName;
  final String companyName;
  final String businessType;
  final String organizationCode;
  final String organizationSlug;
  final String? logo;
}
