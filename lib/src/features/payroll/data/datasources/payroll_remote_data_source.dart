import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import '../models/request/generate_payroll_request.dart';
import '../models/request/payroll_query_params.dart';
import '../models/request/update_payment_request.dart';
import '../models/request/delete_payroll_request.dart';
import '../models/response/generate_payroll_response.dart';
import '../models/response/payroll_list_response.dart';
import '../models/response/update_payment_response.dart';
import '../models/response/delete_payroll_response.dart';

abstract class PayrollRemoteDataSource {
  Future<GeneratePayrollResponse> generatePayroll({
    required GeneratePayrollRequest request,
  });

  Future<PayrollListResponse> getPayrolls({
    required PayrollQueryParams params,
  });

  Future<UpdatePaymentResponse> updatePaymentStatus({
    required UpdatePaymentRequest request,
  });

  Future<DeletePayrollResponse> deletePayroll({
    required DeletePayrollRequest request,
  });
}

@LazySingleton(as: PayrollRemoteDataSource)
class PayrollRemoteDataSourceImpl implements PayrollRemoteDataSource {
  PayrollRemoteDataSourceImpl(
    @Named('authenticated') Dio dio,
  ) : _dio = dio;

  final Dio _dio;

  @override
  Future<GeneratePayrollResponse> generatePayroll({
    required GeneratePayrollRequest request,
  }) async {
    final options = await scaffoldKey.currentContext!.authorizedOptions;

    try {
      final response = await _dio.post(
        options: options,
        ApiEndPoints.payroll,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return GeneratePayrollResponse.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to generate payroll');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PayrollListResponse> getPayrolls({
    required PayrollQueryParams params,
  }) async {
    final options = await scaffoldKey.currentContext!.authorizedOptions;

    try {
      final queryParams = params.toJson()..removeWhere((key, value) => value == null);

      final response = await _dio.get(
        options: options,
        ApiEndPoints.payroll,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return PayrollListResponse.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to fetch payroll records');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<UpdatePaymentResponse> updatePaymentStatus({
    required UpdatePaymentRequest request,
  }) async {
    final options = await scaffoldKey.currentContext!.authorizedOptions;

    try {
      final response = await _dio.put(
        options: options,
        ApiEndPoints.payroll,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return UpdatePaymentResponse.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to update payment status');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<DeletePayrollResponse> deletePayroll({
    required DeletePayrollRequest request,
  }) async {
    final options = await scaffoldKey.currentContext!.authorizedOptions;

    try {
      final response = await _dio.delete(
        options: options,
        '${ApiEndPoints.payroll}?payroll_id=${request.payrollId}',
      );

      if (response.statusCode == 200) {
        return DeletePayrollResponse.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to delete payroll');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
