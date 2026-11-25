import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/login/data/models/login_response_model.dart';
import 'package:hotel/src/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/response/api_response.dart';

@lazySingleton
class LoginUseCase
    extends BaseUseCase<LoginRequestParams, ApiResponse<LoginResponseModel>> {
  LoginUseCase(this._repository);

  final LoginRepository _repository;

  @override
  Future<Either<AppError, ApiResponse<LoginResponseModel>>> execute(
          LoginRequestParams param) =>
      _repository.postLoginToken(params: param);
}
