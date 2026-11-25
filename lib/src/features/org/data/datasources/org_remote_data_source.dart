import 'package:dio/dio.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/org/data/models/org_response_model.dart';
import 'package:hotel/src/features/org/domain/org_code_utils.dart';
import 'package:injectable/injectable.dart';

/// Resolves organization by code (no `X-Org-Slug` — tenant not chosen yet).
@lazySingleton
class OrgRemoteDataSource {
  OrgRemoteDataSource(@Named('authenticated') this._dio);

  final Dio _dio;

  Future<OrgResponseModel> fetchOrganization(String code) async {
    final trimmed = normalizeOrganizationCode(code);
    if (trimmed.isEmpty) {
      throw AppException(message: defaultL10n.enterOrganizationCode);
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndPoints.orgByCode(trimmed),
      );

      if (response.statusCode == 200 && response.data != null) {
        return OrgResponseModel.fromJson(response.data!);
      }
      throw AppException(message: defaultL10n.organizationNotFound);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 404) {
        throw AppException(message: defaultL10n.organizationNotFound);
      }
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        throw AppException(message: data['message'].toString());
      }
      throw AppException(
        message: e.message ?? defaultL10n.couldNotVerifyOrganization,
        statusCode: status,
      );
    } on FormatException {
      // API returned 200 but no slug field — use entered code as slug.
      return OrgResponseModel(slug: trimmed, code: trimmed);
    }
  }
}
