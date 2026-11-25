/// Converts raw API / Dio errors into short, user-facing copy.
abstract final class ErrorMessageHelper {
  static String format(String? raw, {int? statusCode}) {
    final code = statusCode ?? _statusCodeFromText(raw);
    final trimmed = raw?.trim();

    if (trimmed == null || trimmed.isEmpty) {
      return messageForStatusCode(code);
    }

    if (_isTechnicalMessage(trimmed)) {
      return messageForStatusCode(code);
    }

    return trimmed;
  }

  static String messageForStatusCode(int? statusCode) {
    switch (statusCode) {
      case 401:
        return 'Your session has expired. Please log in again.';
      case 403:
        return 'You do not have permission to access this.';
      case 404:
        return 'The requested information was not found.';
      case 408:
      case 504:
        return 'The request timed out. Please try again.';
      case 500:
      case 502:
      case 503:
        return 'Something went wrong on our end. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  static bool _isTechnicalMessage(String message) {
    return message.contains('DioException') ||
        message.contains('status code of') ||
        message.contains('RequestOptions.validateStatus') ||
        message.contains('mdn.web.internal') ||
        message.contains('RequestOptions.');
  }

  static int? _statusCodeFromText(String? raw) {
    if (raw == null) return null;
    final match = RegExp(r'status code of (\d+)').firstMatch(raw);
    if (match == null) return null;
    return int.tryParse(match.group(1)!);
  }
}
