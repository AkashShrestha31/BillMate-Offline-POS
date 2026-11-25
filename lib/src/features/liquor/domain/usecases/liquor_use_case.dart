import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';
import 'package:hotel/src/features/liquor/domain/repositories/liquor_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LiquorUseCase implements BaseUseCase<LiquorRequestParams, ApiResponse<LiquorResponseModel>> {
  final LiquorRepository _liquorRepository;
  LiquorUseCase(this._liquorRepository);

  @override
  Future<Either<AppError, ApiResponse<LiquorResponseModel>>> execute(LiquorRequestParams param) =>
      _liquorRepository.getLiquorItems(params: param);
}
