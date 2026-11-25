import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/payment_methods/data/datasources/payment_methods_remote_data_source.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_request.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_response.dart';
import 'package:hotel/src/features/payment_methods/domain/repositories/payment_methods_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentMethodsRepository)
class PaymentMethodsRepositoryImpl implements PaymentMethodsRepository {
  PaymentMethodsRepositoryImpl(this._remoteDataSource);

  final PaymentMethodsRemoteDataSource _remoteDataSource;

  Future<Either<AppError, T>> _guard<T>(Future<T> Function() call) async {
    try {
      return right(await call());
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, PaymentMethodsResponse>> getPaymentMethods(PaymentMethodsQuery query) {
    return _guard(() => _remoteDataSource.getPaymentMethods(query));
  }

  @override
  Future<Either<AppError, PaymentMethodItem>> getPaymentMethod(String name) {
    return _guard(() => _remoteDataSource.getPaymentMethod(name));
  }

  @override
  Future<Either<AppError, PaymentMethodItem>> createPaymentMethod(PaymentMethodRequest request) {
    return _guard(() => _remoteDataSource.createPaymentMethod(request));
  }

  @override
  Future<Either<AppError, PaymentMethodItem>> updatePaymentMethod({
    required String name,
    required PaymentMethodRequest request,
  }) {
    return _guard(() => _remoteDataSource.updatePaymentMethod(name: name, request: request));
  }

  @override
  Future<Either<AppError, void>> deletePaymentMethod(String name) {
    return _guard(() => _remoteDataSource.deletePaymentMethod(name));
  }
}
