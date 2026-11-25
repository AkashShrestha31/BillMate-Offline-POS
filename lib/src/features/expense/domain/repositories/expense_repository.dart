import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/data/models/response/create_expense_response_model.dart';

abstract class ExpenseRepository {
  Future<Either<AppError, CreateExpenseResponseModel>> createExpense({required CreateExpenseRequestParams params});
}
