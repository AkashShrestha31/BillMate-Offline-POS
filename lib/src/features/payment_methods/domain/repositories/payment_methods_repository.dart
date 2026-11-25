import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_request.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_response.dart';

abstract class PaymentMethodsRepository {
  Future<Either<AppError, PaymentMethodsResponse>> getPaymentMethods(PaymentMethodsQuery query);
  Future<Either<AppError, PaymentMethodItem>> getPaymentMethod(String name);
  Future<Either<AppError, PaymentMethodItem>> createPaymentMethod(PaymentMethodRequest request);
  Future<Either<AppError, PaymentMethodItem>> updatePaymentMethod({
    required String name,
    required PaymentMethodRequest request,
  });
  Future<Either<AppError, void>> deletePaymentMethod(String name);
}
