import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/request/generate_payroll_request.dart';
import '../../data/models/request/payroll_query_params.dart';
import '../../data/models/request/update_payment_request.dart';
import '../../data/models/request/delete_payroll_request.dart';
import '../../data/models/response/generate_payroll_response.dart';
import '../../data/models/response/payroll_list_response.dart';
import '../../data/models/response/update_payment_response.dart';
import '../../data/models/response/delete_payroll_response.dart';
import '../repositories/payroll_repository.dart';

@lazySingleton
class GeneratePayrollUseCase {
  final PayrollRepository _repository;

  GeneratePayrollUseCase(this._repository);

  Future<Either<AppError, GeneratePayrollResponse>> execute({
    required GeneratePayrollRequest request,
  }) =>
      _repository.generatePayroll(request: request);
}

@lazySingleton
class GetPayrollsUseCase {
  final PayrollRepository _repository;

  GetPayrollsUseCase(this._repository);

  Future<Either<AppError, PayrollListResponse>> execute({
    required PayrollQueryParams params,
  }) =>
      _repository.getPayrolls(params: params);
}

@lazySingleton
class UpdatePaymentStatusUseCase {
  final PayrollRepository _repository;

  UpdatePaymentStatusUseCase(this._repository);

  Future<Either<AppError, UpdatePaymentResponse>> execute({
    required UpdatePaymentRequest request,
  }) =>
      _repository.updatePaymentStatus(request: request);
}

@lazySingleton
class DeletePayrollUseCase {
  final PayrollRepository _repository;

  DeletePayrollUseCase(this._repository);

  Future<Either<AppError, DeletePayrollResponse>> execute({
    required DeletePayrollRequest request,
  }) =>
      _repository.deletePayroll(request: request);
}
