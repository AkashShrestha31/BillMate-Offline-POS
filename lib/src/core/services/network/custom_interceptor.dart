import 'package:dio/dio.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/routes/app_router.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';

/// Adds [X-Org-Slug] on every authenticated Dio request.
///
/// Must be registered **before** [TalkerDioLogger] so debug logs include these headers.
class CustomInterceptors implements Interceptor {
  CustomInterceptors();

  final router = getIt<AppRouter>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response!.statusCode == 401) {
      try {} on DioException {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final data = options.data;

    final orgSlug = await OrgStorage.getOrgSlug();
    if (orgSlug != null && orgSlug.isNotEmpty) {
      options.headers['X-Org-Slug'] = orgSlug;
    }

    if (data is Map<String, dynamic>) {
      options.data = {
        ...data,
      };
    }

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
