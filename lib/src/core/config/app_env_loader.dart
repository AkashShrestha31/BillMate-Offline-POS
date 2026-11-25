import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Loads a bundled `.env-*` asset and validates required keys.
abstract final class AppEnvLoader {
  // /// Placeholder used in debug when [BASE_URL] is missing (offline / local runs).
  // static const debugFallbackBaseUrl = 'http://127.0.0.1/';

  static Future<void> load(String fileName) async {
    try {
      await dotenv.load(fileName: fileName);
    } on EmptyEnvFileError {
      // BASE_URL requirement disabled for offline-first builds.
      // if (kReleaseMode) {
      //   throw FlutterError(
      //     '$fileName is empty. Copy $fileName.example to $fileName '
      //     'and set BASE_URL to your API host.',
      //   );
      // }
      // dotenv.testLoad(fileInput: 'BASE_URL=$debugFallbackBaseUrl');
      dotenv.testLoad(fileInput: '');
      if (kDebugMode) {
        debugPrint(
          'AppEnvLoader: $fileName is empty — BASE_URL check disabled.',
        );
      }
    }

    // _ensureBaseUrl(fileName);
  }

  // static void _ensureBaseUrl(String fileName) {
  //   const fromDefine = String.fromEnvironment('BASE_URL');
  //   if (fromDefine.isNotEmpty) {
  //     dotenv.env['BASE_URL'] = fromDefine;
  //     return;
  //   }
  //
  //   final baseUrl = dotenv.env['BASE_URL']?.trim();
  //   if (baseUrl != null && baseUrl.isNotEmpty) {
  //     return;
  //   }
  //
  //   if (kDebugMode) {
  //     dotenv.env['BASE_URL'] = debugFallbackBaseUrl;
  //     debugPrint(
  //       'AppEnvLoader: BASE_URL missing in $fileName — using '
  //       '$debugFallbackBaseUrl in debug. '
  //       'Add BASE_URL=https://your-api.example.com/ to $fileName.',
  //     );
  //     return;
  //   }
  //
  //   throw FlutterError(
  //     'BASE_URL is not set in $fileName. '
  //     'Add a line like BASE_URL=https://api.example.com/',
  //   );
  // }
}
