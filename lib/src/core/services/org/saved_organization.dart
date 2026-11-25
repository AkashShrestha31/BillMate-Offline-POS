/// A hotel organization saved on this device for quick switching.
class SavedOrganization {
  const SavedOrganization({
    required this.slug,
    required this.code,
    required this.name,
    this.businessType,
  });

  final String slug;
  final String code;
  final String name;
  final String? businessType;

  Map<String, dynamic> toJson() => {
        'slug': slug,
        'code': code,
        'name': name,
        if (businessType != null && businessType!.isNotEmpty)
          'businessType': businessType,
      };

  factory SavedOrganization.fromJson(Map<String, dynamic> json) {
    return SavedOrganization(
      slug: json['slug']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      businessType: json['businessType']?.toString(),
    );
  }

  bool get isValid => slug.isNotEmpty && code.isNotEmpty;
}
