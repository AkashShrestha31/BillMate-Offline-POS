import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_status_update_response.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateOrderStatusUseCase implements BaseUseCase<UpdateOrderStatusRequestParams, OrderStatusUpdateResponse> {
  UpdateOrderStatusUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, OrderStatusUpdateResponse>> execute(
    UpdateOrderStatusRequestParams param,
  ) =>
      _repository.updateOrderStatus(param);
}
