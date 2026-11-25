import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:hotel/src/features/contact_book/domain/repositories/contact_repository.dart';

@lazySingleton
class GetContactsUseCase {
  GetContactsUseCase(this._repository);

  final ContactRepository _repository;

  Future<Either<AppError, ContactListResponse>> call({
    ContactQueryParams? params,
  }) =>
      _repository.getContacts(params: params);
}
