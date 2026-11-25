import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/data/models/response/create_expense_response_model.dart';
import 'package:hotel/src/features/expense/domain/usecases/create_expense_use_case.dart';
import 'package:injectable/injectable.dart';

part 'create_expense_state.dart';

@injectable
class CreateExpenseCubit extends Cubit<CreateExpenseState> {
  CreateExpenseCubit(this._useCase) : super(const CreateExpenseInitial());

  final CreateExpenseUseCase _useCase;

  void createExpense({required CreateExpenseRequestParams params}) async {
    emit(const CreateExpenseLoading());
    final result = await _useCase.execute(params);
    result.fold(
      (error) => emit(
        error.when(
          serverError: (msg) => CreateExpenseError(message: msg),
          noInternet: () => const CreateExpenseNoInternet(),
        ),
      ),
      (data) => emit(CreateExpenseSuccess(response: data)),
    );
  }

  void reset() {
    emit(const CreateExpenseInitial());
  }
}
