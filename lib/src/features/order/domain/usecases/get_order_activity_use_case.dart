import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_activity_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_activity_response.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOrderActivityUseCase
    implements BaseUseCase<GetOrderActivityRequestParams, OrderActivityResponse> {
  GetOrderActivityUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, OrderActivityResponse>> execute(
    GetOrderActivityRequestParams param,
  ) =>
      _repository.getOrderActivity(param);
}
