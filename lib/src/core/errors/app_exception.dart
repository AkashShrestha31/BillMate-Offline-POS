import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/helpers/error_message_helper.dart';
import 'package:hotel/src/core/routes/app_router.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_exception.freezed.dart';
part 'app_exception.g.dart';

@freezed
class AppException extends FormatException with _$AppException {
  const AppException._();

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AppException({
    required String message,
    int? statusCode,
    Map<String, dynamic>? errors,
  }) = _AppException;

  factory AppException.fromJson(Map<String, dynamic> json) =>
      _$AppExceptionFromJson(json);

  factory AppException.fromDioError(DioException e) {
    final _context = getIt<AppRouter>().navigatorKey.currentContext;
    final l10n = _context!.l10n;

    try {
      if (e is SocketException) {
        return AppException(message: l10n.noInternetConnection);
      }
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return AppException(message: l10n.supportMessage);
      }

      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          return AppException(message: l10n.responseMessage404, statusCode: statusCode);
        }
        if (statusCode == 401 || statusCode == 403) {
          return AppException(
            message: ErrorMessageHelper.messageForStatusCode(statusCode),
            statusCode: statusCode,
          );
        }
        if (statusCode == 500 || statusCode == 502 || statusCode == 503) {
          return AppException(message: l10n.supportMessage, statusCode: statusCode);
        }

        final data = e.response?.data;
        String? apiMessage;
        if (data is Map) {
          final raw = data['message'];
          if (raw != null) apiMessage = raw.toString().trim();
        }

        final message = ErrorMessageHelper.format(
          apiMessage ?? e.message,
          statusCode: statusCode,
        );
        return AppException(message: message, statusCode: statusCode);
      } else if (e.message != null) {
        return AppException(
          message: ErrorMessageHelper.format(e.message),
        );
      } else {
        if (e.error is SocketException) {
          return AppException(message: l10n.noInternetConnection);
        } else {
          return AppException(
            message: ErrorMessageHelper.format(e.error?.toString()),
          );
        }
      }
    } on FormatException {
      return AppException(message: l10n.formatException);
    }
  }
}
