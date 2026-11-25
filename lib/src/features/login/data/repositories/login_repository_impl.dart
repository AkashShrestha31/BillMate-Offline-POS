import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/login/data/datasources/login_remote_data_source.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/login/data/models/login_response_model.dart';
import 'package:hotel/src/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._dataSource, this._internetInfo);

  final LoginRemoteDataSource _dataSource;
  // Kept for constructor compatibility with generated DI wiring.
  // ignore: unused_field
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, ApiResponse<LoginResponseModel>>> postLoginToken({
    required LoginRequestParams params,
  }) async {
    try {
      final response = await _dataSource.postLoginToken(params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
