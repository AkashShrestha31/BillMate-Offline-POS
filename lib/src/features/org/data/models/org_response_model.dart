class OrgResponseModel {
  const OrgResponseModel({
    required this.slug,
    this.name,
    this.code,
    this.businessType,
    this.allowedEmailDomain,
  });

  final String slug;
  final String? name;
  final String? code;
  final String? businessType;
  final String? allowedEmailDomain;

  factory OrgResponseModel.fromJson(Map<String, dynamic> json) {
    final root = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final slug = _readString(root, const [
      'slug',
      'org_slug',
      'orgSlug',
      'X-Org-Slug',
      'x_org_slug',
    ]);
    final name = _readString(root, const [
      'name',
      'full_name',
      'org_name',
      'organization_name',
      'title',
    ]);
    final code = _readString(root, const ['code', 'org_code', 'organization_code']);
    final businessType = _readString(root, const [
      'businessType',
      'business_type',
      'organization_business_type',
    ]);
    final allowedEmailDomain = _readString(root, const [
      'allowed_email_domain',
      'allowedEmailDomain',
      'email_domain',
    ]);

    if (slug == null || slug.isEmpty) {
      throw const FormatException('Organization slug missing in response');
    }

    return OrgResponseModel(
      slug: slug,
      name: name,
      code: code,
      businessType: businessType,
      allowedEmailDomain: allowedEmailDomain,
    );
  }

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;
      final text = value.toString().trim();
      if (text.isNotEmpty) return text;
    }
    return null;
  }
}
