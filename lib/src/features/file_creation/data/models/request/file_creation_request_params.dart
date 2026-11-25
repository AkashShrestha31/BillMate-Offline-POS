import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_creation_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FileCreationRequestParams {
  final String? filePath;
  final bool? useDefaultDb;
  final bool? includeAllTimestamps;
  final bool? formatTimestamps;
  final bool? includeFileInfo;
  final String? timezone;
  final bool? includeUtc;

  FileCreationRequestParams({
    this.filePath,
    this.useDefaultDb = false,
    this.includeAllTimestamps = true,
    this.formatTimestamps = true,
    this.includeFileInfo = true,
    this.timezone = "Asia/Kathmandu",
    this.includeUtc = false,
  });

  /// Factory method to create an instance from a JSON map
  factory FileCreationRequestParams.fromJson(Map<String, dynamic> json) =>
      _$FileCreationRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$FileCreationRequestParamsToJson(this);

  /// Convert the object into query parameters, including only non-null values
  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};
    if (filePath.isNotNullNotEmpty) queryParams['file_path'] = filePath!;
    if (useDefaultDb != null) queryParams['use_default_db'] = useDefaultDb.toString();
    if (includeAllTimestamps != null) queryParams['include_all_timestamps'] = includeAllTimestamps.toString();
    if (formatTimestamps != null) queryParams['format_timestamps'] = formatTimestamps.toString();
    if (includeFileInfo != null) queryParams['include_file_info'] = includeFileInfo.toString();
    if (timezone.isNotNullNotEmpty) queryParams['timezone'] = timezone!;
    if (includeUtc != null) queryParams['include_utc'] = includeUtc.toString();
    return queryParams;
  }

  /// Convenience factory for hotel database files
  static FileCreationRequestParams hotelDatabase({
    required String filePath,
    String timezone = "Asia/Kathmandu",
  }) {
    return FileCreationRequestParams(
      filePath: filePath,
      useDefaultDb: false,
      includeAllTimestamps: true,
      formatTimestamps: true,
      includeFileInfo: true,
      timezone: timezone,
      includeUtc: false,
    );
  }

  /// Convenience factory for minimal file info
  static FileCreationRequestParams minimal({
    required String filePath,
  }) {
    return FileCreationRequestParams(
      filePath: filePath,
      useDefaultDb: true,
      includeAllTimestamps: false,
      formatTimestamps: false,
      includeFileInfo: true,
      timezone: "Asia/Kathmandu",
      includeUtc: false,
    );
  }
}
