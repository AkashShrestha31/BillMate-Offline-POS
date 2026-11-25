import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/other/data/datasources/other_remote_data_source.dart';
import 'package:hotel/src/features/other/data/models/item_counter_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_response_model.dart';
import 'package:hotel/src/features/other/domain/repositories/other_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtherRepository)
class OtherRepositoryImpl implements OtherRepository {
  OtherRepositoryImpl(this._otherRemoteDataSource);

  final OtherRemoteDataSource _otherRemoteDataSource;

  @override
  Future<Either<AppError, ApiResponse<ItemCounterResponseModel>>>
      getItemCounter({required ItemCounterRequestParams params}) async {
          try {
        final response = await _otherRemoteDataSource.getItemCounter(params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
