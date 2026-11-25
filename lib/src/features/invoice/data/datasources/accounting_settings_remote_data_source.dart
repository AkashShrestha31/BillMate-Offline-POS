import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/invoice/data/models/response/accounting_settings_model.dart';
import 'package:injectable/injectable.dart';

abstract class AccountingSettingsRemoteDataSource {
  Future<AccountingSettingsModel> fetchSettings();
}

// @LazySingleton(as: AccountingSettingsRemoteDataSource) — replaced by AccountingSettingsLocalDataSource
class AccountingSettingsRemoteDataSourceImpl implements AccountingSettingsRemoteDataSource {
  AccountingSettingsRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<AccountingSettingsModel> fetchSettings() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.accountingSettings}',
        options: options,
      );
      if (response.statusCode == 200 && response.data is Map) {
        return AccountingSettingsModel.fromJson(
          Map<String, dynamic>.from(response.data as Map),
        );
      }
      return const AccountingSettingsModel();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const AccountingSettingsModel();
      }
      throw AppException.fromDioError(e);
    }
  }
}
