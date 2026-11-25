import 'package:flutter_test/flutter_test.dart';
import 'package:hotel/src/features/file_creation/data/models/request/file_creation_request_params.dart';
import 'package:hotel/src/features/file_creation/data/models/response/file_creation_details.dart';

void main() {
  group('FileCreationRequestParams', () {
    test('should create valid query parameters', () {
      final params = FileCreationRequestParams(
        filePath: 'test.db',
        useDefaultDb: false,
        includeAllTimestamps: true,
        formatTimestamps: true,
        includeFileInfo: true,
        timezone: 'Asia/Kathmandu',
        includeUtc: false,
      );

      final queryParams = params.toQueryParams();

      expect(queryParams['file_path'], 'test.db');
      expect(queryParams['use_default_db'], 'false');
      expect(queryParams['include_all_timestamps'], 'true');
      expect(queryParams['format_timestamps'], 'true');
      expect(queryParams['include_file_info'], 'true');
      expect(queryParams['timezone'], 'Asia/Kathmandu');
      expect(queryParams['include_utc'], 'false');
    });

    test('should create hotel database params correctly', () {
      final params = FileCreationRequestParams.hotelDatabase(
        filePath: 'hotel.db',
      );

      expect(params.filePath, 'hotel.db');
      expect(params.useDefaultDb, false);
      expect(params.includeAllTimestamps, true);
      expect(params.formatTimestamps, true);
      expect(params.includeFileInfo, true);
      expect(params.timezone, 'Asia/Kathmandu');
      expect(params.includeUtc, false);
    });

    test('should create minimal params correctly', () {
      final params = FileCreationRequestParams.minimal(
        filePath: 'simple.txt',
      );

      expect(params.filePath, 'simple.txt');
      expect(params.useDefaultDb, true);
      expect(params.includeAllTimestamps, false);
      expect(params.formatTimestamps, false);
      expect(params.includeFileInfo, true);
    });
  });

  group('FileCreationDetails', () {
    test('should correctly identify file properties', () {
      final mockDetails = _createMockFileCreationDetails();

      expect(mockDetails.isSuccessful, true);
      expect(mockDetails.isDatabase, true);
      expect(mockDetails.fileName, 'test.db');
    });

    test('should correctly format file size', () {
      final mockDetails = _createMockFileCreationDetails();

      expect(mockDetails.formattedSize, '3.47 MB');
      expect(mockDetails.isLargeFile, true);
    });
  });
}

FileCreationDetails _createMockFileCreationDetails() {
  return FileCreationDetails(
    success: true,
    method: 'POST',
    fileInfo: FileInfo(
      filePath: '/path/to/test.db',
      fileName: 'test.db',
      fileExtension: '.db',
      exists: true,
      isFile: true,
      isDirectory: false,
    ),
    creationInfo: CreationInfo(
      createdDatetime: '2025-07-26T10:19:34.931829+05:45',
      timezone: 'Asia/Kathmandu',
      systemType: 'Darwin',
      note: 'Test file',
      createdDatetimeFormatted: '2025-07-26 10:19:34 +0545',
    ),
    timestamps: Timestamps(
      lastModified: '2025-07-26T23:25:34.533744+05:45',
      lastAccessed: '2025-07-27T10:33:21.642902+05:45',
      created: '2025-07-26T10:19:34.931829+05:45',
      timezone: 'Asia/Kathmandu',
      formatted: FormattedTimestamps(
        lastModified: '2025-07-26 23:25:34 +0545',
        lastAccessed: '2025-07-27 10:33:21 +0545',
        created: '2025-07-26 10:19:34 +0545',
      ),
    ),
    fileDetails: FileDetails(
      sizeBytes: 3637248,
      sizeHumanReadable: '3.47 MB',
      permissions: '0o100644',
      readable: true,
      writable: true,
    ),
  );
}
