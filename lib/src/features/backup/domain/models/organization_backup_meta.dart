class OrganizationBackupMeta {
  const OrganizationBackupMeta({
    required this.formatVersion,
    required this.appVersion,
    required this.slug,
    required this.code,
    required this.name,
    this.businessType,
    required this.exportedAt,
    required this.deviceId,
    required this.recordCounts,
    required this.checksum,
    this.adminEmail,
    this.adminPassword,
  });

  final int formatVersion;
  final String appVersion;
  final String slug;
  final String code;
  final String name;
  final String? businessType;
  final String exportedAt;
  final String deviceId;
  final Map<String, int> recordCounts;
  final String checksum;

  /// Offline login email (device prefs are not in SQLite).
  final String? adminEmail;

  /// Offline login password stored with the backup for restore on a new device.
  final String? adminPassword;

  factory OrganizationBackupMeta.fromJson(Map<String, dynamic> json) {
    final org = json['organization'];
    final orgMap = org is Map ? Map<String, dynamic>.from(org) : <String, dynamic>{};

    final countsRaw = json['recordCounts'];
    final counts = <String, int>{};
    if (countsRaw is Map) {
      countsRaw.forEach((key, value) {
        counts[key.toString()] = value is int ? value : int.tryParse('$value') ?? 0;
      });
    }

    final login = json['login'];
    final loginMap = login is Map ? Map<String, dynamic>.from(login) : <String, dynamic>{};

    return OrganizationBackupMeta(
      formatVersion: json['formatVersion'] as int? ?? 1,
      appVersion: json['appVersion']?.toString() ?? '',
      slug: orgMap['slug']?.toString() ?? '',
      code: orgMap['code']?.toString() ?? '',
      name: orgMap['name']?.toString() ?? '',
      businessType: orgMap['businessType']?.toString(),
      exportedAt: json['exportedAt']?.toString() ?? '',
      deviceId: json['deviceId']?.toString() ?? '',
      recordCounts: counts,
      checksum: json['checksum']?.toString() ?? '',
      adminEmail: loginMap['email']?.toString(),
      adminPassword: loginMap['password']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'formatVersion': formatVersion,
        'appVersion': appVersion,
        'organization': {
          'slug': slug,
          'code': code,
          'name': name,
          if (businessType != null && businessType!.isNotEmpty)
            'businessType': businessType,
        },
        if (adminEmail != null &&
            adminEmail!.isNotEmpty &&
            adminPassword != null &&
            adminPassword!.isNotEmpty)
          'login': {
            'email': adminEmail,
            'password': adminPassword,
          },
        'exportedAt': exportedAt,
        'deviceId': deviceId,
        'recordCounts': recordCounts,
        'checksum': checksum,
      };
}
