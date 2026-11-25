import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:hotel/src/features/contact_book/domain/repositories/contact_repository.dart';

@lazySingleton
class GetContactByIdUseCase {
  GetContactByIdUseCase(this._repository);

  final ContactRepository _repository;

  Future<Either<AppError, ContactModel>> call(int contactId) =>
      _repository.getContactById(contactId);
}
