part of 'create_expense_cubit.dart';

sealed class CreateExpenseState {
  const CreateExpenseState();
}

class CreateExpenseInitial extends CreateExpenseState {
  const CreateExpenseInitial();
}

class CreateExpenseLoading extends CreateExpenseState {
  const CreateExpenseLoading();
}

class CreateExpenseNoInternet extends CreateExpenseState {
  const CreateExpenseNoInternet();
}

class CreateExpenseError extends CreateExpenseState {
  const CreateExpenseError({required this.message});
  final String message;
}

class CreateExpenseSuccess extends CreateExpenseState {
  const CreateExpenseSuccess({required this.response});
  final CreateExpenseResponseModel response;
}
