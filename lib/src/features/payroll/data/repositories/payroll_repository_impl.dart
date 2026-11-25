import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/payroll/data/datasources/payroll_local_data_source.dart';
import '../models/request/generate_payroll_request.dart';
import '../models/request/payroll_query_params.dart';
import '../models/request/update_payment_request.dart';
import '../models/request/delete_payroll_request.dart';
import '../models/response/generate_payroll_response.dart';
import '../models/response/payroll_list_response.dart';
import '../models/response/update_payment_response.dart';
import '../models/response/delete_payroll_response.dart';
import '../../domain/repositories/payroll_repository.dart';

@LazySingleton(as: PayrollRepository)
class PayrollRepositoryImpl implements PayrollRepository {
  PayrollRepositoryImpl(LocalDb db)
      : _localDataSource = PayrollLocalDataSource(db);

  final PayrollLocalDataSource _localDataSource;

  @override
  Future<Either<AppError, GeneratePayrollResponse>> generatePayroll({
    required GeneratePayrollRequest request,
  }) async {
    try {
      final response =
          await _localDataSource.generatePayroll(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    } catch (e) {
      return left(AppError.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, PayrollListResponse>> getPayrolls({
    required PayrollQueryParams params,
  }) async {
    try {
      final response = await _localDataSource.getPayrolls(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    } catch (e) {
      return left(AppError.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, UpdatePaymentResponse>> updatePaymentStatus({
    required UpdatePaymentRequest request,
  }) async {
    try {
      final response =
          await _localDataSource.updatePaymentStatus(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    } catch (e) {
      return left(AppError.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, DeletePayrollResponse>> deletePayroll({
    required DeletePayrollRequest request,
  }) async {
    try {
      final response =
          await _localDataSource.deletePayroll(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    } catch (e) {
      return left(AppError.serverError(message: e.toString()));
    }
  }
}
