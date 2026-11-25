class BackupManifest {
  const BackupManifest({
    required this.formatVersion,
    required this.tables,
    required this.recordCounts,
    required this.checksum,
    required this.exportedAt,
    this.delta = false,
    this.sinceChangeLogId,
    this.maxChangeLogId,
    this.deletes = const {},
  });

  static const int currentFormatVersion = 1;
  static const int deltaFormatVersion = 2;

  final int formatVersion;
  final List<String> tables;
  final Map<String, int> recordCounts;
  final String checksum;
  final String exportedAt;
  final bool delta;
  final int? sinceChangeLogId;
  final int? maxChangeLogId;
  final Map<String, List<String>> deletes;

  Map<String, dynamic> toJson() => {
        'formatVersion': formatVersion,
        'tables': tables,
        'recordCounts': recordCounts,
        'checksum': checksum,
        'exportedAt': exportedAt,
        if (delta) 'delta': true,
        if (sinceChangeLogId != null) 'sinceChangeLogId': sinceChangeLogId,
        if (maxChangeLogId != null) 'maxChangeLogId': maxChangeLogId,
        if (deletes.isNotEmpty)
          'deletes': deletes.map(
            (key, value) => MapEntry(key, value),
          ),
      };

  factory BackupManifest.fromJson(Map<String, dynamic> json) {
    final countsRaw = json['recordCounts'];
    final counts = <String, int>{};
    if (countsRaw is Map) {
      countsRaw.forEach((key, value) {
        counts[key.toString()] = value is int ? value : int.tryParse('$value') ?? 0;
      });
    }

    final tablesRaw = json['tables'];
    final tables = <String>[];
    if (tablesRaw is List) {
      for (final entry in tablesRaw) {
        tables.add(entry.toString());
      }
    }

    final deletesRaw = json['deletes'];
    final deletes = <String, List<String>>{};
    if (deletesRaw is Map) {
      deletesRaw.forEach((key, value) {
        if (value is List) {
          deletes[key.toString()] = value.map((e) => e.toString()).toList(growable: false);
        }
      });
    }

    return BackupManifest(
      formatVersion: json['formatVersion'] as int? ?? 1,
      tables: tables,
      recordCounts: counts,
      checksum: json['checksum']?.toString() ?? '',
      exportedAt: json['exportedAt']?.toString() ?? '',
      delta: json['delta'] == true,
      sinceChangeLogId: json['sinceChangeLogId'] as int?,
      maxChangeLogId: json['maxChangeLogId'] as int?,
      deletes: deletes,
    );
  }
}
