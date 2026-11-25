import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/create_order_request.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateOrderUseCase implements BaseUseCase<CreateOrderRequest, OrderModel> {
  CreateOrderUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, OrderModel>> execute(CreateOrderRequest param) =>
      _repository.createOrder(param);
}
