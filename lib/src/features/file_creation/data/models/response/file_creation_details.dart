import 'package:json_annotation/json_annotation.dart';

part 'file_creation_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FileCreationDetails {
  final bool success;
  final String method;
  final FileInfo fileInfo;
  final CreationInfo creationInfo;
  final Timestamps timestamps;
  final FileDetails fileDetails;

  FileCreationDetails({
    required this.success,
    required this.method,
    required this.fileInfo,
    required this.creationInfo,
    required this.timestamps,
    required this.fileDetails,
  });

  /// Factory method to create an instance from a JSON map
  factory FileCreationDetails.fromJson(Map<String, dynamic> json) =>
      _$FileCreationDetailsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$FileCreationDetailsToJson(this);

  /// Convenience getters
  bool get isSuccessful => success;
  bool get isDatabase => fileInfo.fileExtension == '.db';
  bool get isLargeFile => fileDetails.sizeBytes > 1024 * 1024; // > 1MB
  String get formattedSize => fileDetails.sizeHumanReadable;
  String get fileName => fileInfo.fileName;

  /// Check if file was created today
  bool get isCreatedToday {
    final now = DateTime.now();
    final created = DateTime.parse(creationInfo.createdDatetime);
    return now.year == created.year &&
           now.month == created.month &&
           now.day == created.day;
  }

  /// Check if file was modified recently (within last hour)
  bool get isRecentlyModified {
    final now = DateTime.now();
    final modified = DateTime.parse(timestamps.lastModified);
    return now.difference(modified).inHours < 1;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FileInfo {
  final String filePath;
  final String fileName;
  final String fileExtension;
  final bool exists;
  final bool isFile;
  final bool isDirectory;

  FileInfo({
    required this.filePath,
    required this.fileName,
    required this.fileExtension,
    required this.exists,
    required this.isFile,
    required this.isDirectory,
  });

  factory FileInfo.fromJson(Map<String, dynamic> json) =>
      _$FileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FileInfoToJson(this);

  /// Convenience getters
  bool get isDatabase => fileExtension == '.db';
  bool get isValidFile => exists && isFile && !isDirectory;
  String get fileTypeDescription {
    switch (fileExtension.toLowerCase()) {
      case '.db':
        return 'Database File';
      case '.json':
        return 'JSON File';
      case '.txt':
        return 'Text File';
      case '.csv':
        return 'CSV File';
      default:
        return 'Unknown File Type';
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreationInfo {
  final String createdDatetime;
  final String timezone;
  final String systemType;
  final String note;
  final String createdDatetimeFormatted;

  CreationInfo({
    required this.createdDatetime,
    required this.timezone,
    required this.systemType,
    required this.note,
    required this.createdDatetimeFormatted,
  });

  factory CreationInfo.fromJson(Map<String, dynamic> json) =>
      _$CreationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CreationInfoToJson(this);

  /// Convenience getters
  bool get isMacOS => systemType == 'Darwin';
  bool get isWindows => systemType == 'Windows';
  bool get isLinux => systemType == 'Linux';
  DateTime get createdDate => DateTime.parse(createdDatetime);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Timestamps {
  final String lastModified;
  final String lastAccessed;
  final String created;
  final String timezone;
  final FormattedTimestamps formatted;

  Timestamps({
    required this.lastModified,
    required this.lastAccessed,
    required this.created,
    required this.timezone,
    required this.formatted,
  });

  factory Timestamps.fromJson(Map<String, dynamic> json) =>
      _$TimestampsFromJson(json);

  Map<String, dynamic> toJson() => _$TimestampsToJson(this);

  /// Convenience getters for DateTime objects
  DateTime get lastModifiedDate => DateTime.parse(lastModified);
  DateTime get lastAccessedDate => DateTime.parse(lastAccessed);
  DateTime get createdDate => DateTime.parse(created);

  /// Check if file was modified after creation
  bool get wasModifiedAfterCreation => lastModifiedDate.isAfter(createdDate);

  /// Get time since last modification
  Duration get timeSinceLastModification => DateTime.now().difference(lastModifiedDate);

  /// Get time since creation
  Duration get timeSinceCreation => DateTime.now().difference(createdDate);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FormattedTimestamps {
  final String lastModified;
  final String lastAccessed;
  final String created;

  FormattedTimestamps({
    required this.lastModified,
    required this.lastAccessed,
    required this.created,
  });

  factory FormattedTimestamps.fromJson(Map<String, dynamic> json) =>
      _$FormattedTimestampsFromJson(json);

  Map<String, dynamic> toJson() => _$FormattedTimestampsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FileDetails {
  final int sizeBytes;
  final String sizeHumanReadable;
  final String permissions;
  final bool readable;
  final bool writable;

  FileDetails({
    required this.sizeBytes,
    required this.sizeHumanReadable,
    required this.permissions,
    required this.readable,
    required this.writable,
  });

  factory FileDetails.fromJson(Map<String, dynamic> json) =>
      _$FileDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FileDetailsToJson(this);

  /// Convenience getters
  bool get isLargeFile => sizeBytes > 1024 * 1024; // > 1MB
  bool get isSmallFile => sizeBytes < 1024; // < 1KB
  bool get isReadOnly => readable && !writable;
  bool get hasFullAccess => readable && writable;

  /// Get file size category
  String get sizeCategory {
    if (sizeBytes < 1024) return 'Small';
    if (sizeBytes < 1024 * 1024) return 'Medium';
    if (sizeBytes < 1024 * 1024 * 10) return 'Large';
    return 'Very Large';
  }

  /// Get size in different units
  double get sizeInKB => sizeBytes / 1024;
  double get sizeInMB => sizeBytes / (1024 * 1024);
  double get sizeInGB => sizeBytes / (1024 * 1024 * 1024);
}
