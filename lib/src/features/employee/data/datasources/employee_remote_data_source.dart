// employee_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_party_outstanding_response.dart';

import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EmployeeRemoteDataSource {
  Future<ApiResponse<EmployeeOutstandingResult>> getEmployeeOutstanding(
      {required EmployeeOutstandingRequestParams params});

  Future<ApiResponse<AdvanceAnalysisResponse>> getEmployeeAdvance(
      {required EmployeeAdvanceRequestParams params});
}

bool _isEmployeePartyLookupPayload(Map<String, dynamic> json) {
  return json['employee_details'] != null &&
      json['party_details'] != null &&
      json['search_details'] == null;
}

// @LazySingleton(as: EmployeeRemoteDataSource)
class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  EmployeeRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<EmployeeOutstandingResult>> getEmployeeOutstanding(
      {required EmployeeOutstandingRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.employeeOutstanding}",
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid parties/search response');
        }
        final json = Map<String, dynamic>.from(raw);
        final EmployeeOutstandingResult data;
        if (_isEmployeePartyLookupPayload(json)) {
          data = EmployeeOutstandingEmployeePartyLookupResult(
            EmployeePartyOutstandingResponse.fromJson(json),
          );
        } else {
          data = EmployeeOutstandingSearchResult(
            EmployeeOutstandingResponse.fromJson(json),
          );
        }
        return ApiResponse(
          data: data,
          message: '',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<AdvanceAnalysisResponse>> getEmployeeAdvance(
      {required EmployeeAdvanceRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.employeeAdvance}",
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          data: AdvanceAnalysisResponse.fromJson(response.data),
          message: '',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
