import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/contact_book/data/datasources/contact_remote_data_source.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/request/create_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/update_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:hotel/src/features/contact_book/domain/repositories/contact_repository.dart';

@LazySingleton(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl(this._remote);

  final ContactRemoteDataSource _remote;

  @override
  Future<Either<AppError, ContactListResponse>> getContacts({
    ContactQueryParams? params,
  }) async {
    try {
      final res = await _remote.getContacts(params: params);
      return right(res);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ContactModel>> getContactById(int contactId) async {
    try {
      final res = await _remote.getContactById(contactId);
      return right(res.contact);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ContactModel>> createContact(
    CreateContactRequest request,
  ) async {
    try {
      final res = await _remote.createContact(request);
      return right(res.contact);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, void>> updateContact(
    UpdateContactRequest request,
  ) async {
    try {
      await _remote.updateContact(request);
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, void>> deleteContact(int contactId) async {
    try {
      await _remote.deleteContact(contactId);
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
