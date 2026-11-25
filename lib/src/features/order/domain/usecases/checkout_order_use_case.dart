import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/order_checkout_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_checkout_response.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckoutOrderUseCase implements BaseUseCase<OrderCheckoutRequestParams, OrderCheckoutResponse> {
  CheckoutOrderUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, OrderCheckoutResponse>> execute(OrderCheckoutRequestParams param) =>
      _repository.checkoutOrder(param);
}
