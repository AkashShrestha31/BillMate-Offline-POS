import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/data/models/response/create_expense_response_model.dart';
import 'package:hotel/src/features/expense/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateExpenseUseCase implements BaseUseCase<CreateExpenseRequestParams, CreateExpenseResponseModel> {
  final ExpenseRepository _repository;

  CreateExpenseUseCase(this._repository);

  @override
  Future<Either<AppError, CreateExpenseResponseModel>> execute(CreateExpenseRequestParams param) =>
      _repository.createExpense(params: param);
}
