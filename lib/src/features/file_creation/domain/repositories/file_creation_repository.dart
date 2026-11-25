import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/file_creation/data/models/request/file_creation_request_params.dart';
import 'package:hotel/src/features/file_creation/data/models/response/file_creation_details.dart';

abstract class FileCreationRepository {
  Future<Either<AppError, FileCreationDetails>> getFileCreationDetails(
      {required FileCreationRequestParams params});
}
