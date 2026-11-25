import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/expense/data/datasources/expense_remote_data_source.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/data/models/response/create_expense_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExpenseRemoteDataSource)
class ExpenseLocalDataSource implements ExpenseRemoteDataSource {
  ExpenseLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<CreateExpenseResponseModel> createExpense({
    required CreateExpenseRequestParams params,
  }) async {
    try {
      // Store as a PurchaseInvoice for local tracking
      final now = DateTime.now().toIso8601String();
      await _db.upsert('PurchaseInvoice', {
        'name': params.expenseNumber,
        'numberSeries': 'EXP-',
        'party': 'Expense',
        'date': params.date,
        'grandTotal': params.totalAmount.toString(),
        'netTotal': params.totalAmount.toString(),
        'baseGrandTotal': params.totalAmount.toString(),
        'outstandingAmount': '0',
        'terms': params.notes,
        'createdBy': '',
        'modifiedBy': '',
        'created': now,
        'modified': now,
        'submitted': 1,
        'cancelled': 0,
      });
      return CreateExpenseResponseModel(
        message: 'Expense recorded successfully',
        expenseNumber: params.expenseNumber,
        totalAmount: params.totalAmount,
        status: 'Submitted',
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
