import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/request/generate_payroll_request.dart';
import '../../data/models/request/payroll_query_params.dart';
import '../../data/models/request/update_payment_request.dart';
import '../../data/models/request/delete_payroll_request.dart';
import '../../data/models/response/generate_payroll_response.dart';
import '../../data/models/response/payroll_list_response.dart';
import '../../data/models/response/update_payment_response.dart';
import '../../data/models/response/delete_payroll_response.dart';

abstract class PayrollRepository {
  Future<Either<AppError, GeneratePayrollResponse>> generatePayroll({
    required GeneratePayrollRequest request,
  });

  Future<Either<AppError, PayrollListResponse>> getPayrolls({
    required PayrollQueryParams params,
  });

  Future<Either<AppError, UpdatePaymentResponse>> updatePaymentStatus({
    required UpdatePaymentRequest request,
  });

  Future<Either<AppError, DeletePayrollResponse>> deletePayroll({
    required DeletePayrollRequest request,
  });
}
