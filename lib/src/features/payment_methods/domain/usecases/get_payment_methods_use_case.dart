import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_response.dart';
import 'package:hotel/src/features/payment_methods/domain/repositories/payment_methods_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPaymentMethodsUseCase implements BaseUseCase<PaymentMethodsQuery, PaymentMethodsResponse> {
  GetPaymentMethodsUseCase(this._repository);

  final PaymentMethodsRepository _repository;

  @override
  Future<Either<AppError, PaymentMethodsResponse>> execute(PaymentMethodsQuery param) =>
      _repository.getPaymentMethods(param);
}
