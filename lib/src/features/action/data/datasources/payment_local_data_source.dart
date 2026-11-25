import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/action/data/datasources/payment_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/payment_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentRemoteDataSource)
class PaymentLocalDataSource implements PaymentRemoteDataSource {
  PaymentLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<PaymentResponseModel> updatePayment(PaymentRequestModel request) async {
    try {
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      if (request.paymentName != null) {
        await db.update('Payment', {
          if (request.date != null) 'date': request.date,
          if (request.paymentMethod != null) 'paymentMethod': request.paymentMethod,
          if (request.amount != null) 'amount': request.amount,
          'modified': now,
        }, where: 'name = ?', whereArgs: [request.paymentName]);
      }
      return PaymentResponseModel(
        message: 'Payment updated successfully',
        updatedPayment: UpdatedPayment(
          name: request.paymentName ?? '',
          date: request.date ?? now,
          paymentType: request.paymentType ?? '',
          paymentMethod: request.paymentMethod ?? '',
        ),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
