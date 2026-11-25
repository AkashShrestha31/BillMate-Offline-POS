import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/expense/data/datasources/expense_remote_data_source.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/data/models/response/create_expense_response_model.dart';
import 'package:hotel/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExpenseRepository)
class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._remoteDataSource);

  final ExpenseRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, CreateExpenseResponseModel>> createExpense({
    required CreateExpenseRequestParams params,
  }) async {
          try {
        final response = await _remoteDataSource.createExpense(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
