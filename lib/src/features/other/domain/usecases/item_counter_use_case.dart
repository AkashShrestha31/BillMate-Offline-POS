import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/other/data/models/item_counter_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_response_model.dart';
import 'package:hotel/src/features/other/domain/repositories/other_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ItemCounterUseCase extends BaseUseCase<ItemCounterRequestParams,
    ApiResponse<ItemCounterResponseModel>> {
  ItemCounterUseCase(this._repository);

  final OtherRepository _repository;

  @override
  Future<Either<AppError, ApiResponse<ItemCounterResponseModel>>> execute(
          ItemCounterRequestParams param) =>
      _repository.getItemCounter(params: param);
}
