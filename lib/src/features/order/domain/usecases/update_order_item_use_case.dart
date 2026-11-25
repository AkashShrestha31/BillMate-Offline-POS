import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_line_request_params.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateOrderItemUseCase implements BaseUseCase<UpdateOrderItemLineRequestParams, Unit> {
  UpdateOrderItemUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, Unit>> execute(UpdateOrderItemLineRequestParams param) =>
      _repository.updateOrderItem(param);
}
