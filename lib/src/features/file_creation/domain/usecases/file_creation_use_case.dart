import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/file_creation/data/models/request/file_creation_request_params.dart';
import 'package:hotel/src/features/file_creation/data/models/response/file_creation_details.dart';
import 'package:hotel/src/features/file_creation/domain/repositories/file_creation_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FileCreationUseCase
    implements BaseUseCase<FileCreationRequestParams, FileCreationDetails> {
  final FileCreationRepository _fileCreationRepository;
  FileCreationUseCase(this._fileCreationRepository);

  @override
  Future<Either<AppError, FileCreationDetails>> execute(
          FileCreationRequestParams param) =>
      _fileCreationRepository.getFileCreationDetails(params: param);
}
