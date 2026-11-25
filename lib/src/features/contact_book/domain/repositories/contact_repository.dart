import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/request/create_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/update_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart'
    show ContactListResponse, ContactModel;

abstract class ContactRepository {
  Future<Either<AppError, ContactListResponse>> getContacts({
    ContactQueryParams? params,
  });
  Future<Either<AppError, ContactModel>> getContactById(int contactId);
  Future<Either<AppError, ContactModel>> createContact(CreateContactRequest request);
  Future<Either<AppError, void>> updateContact(UpdateContactRequest request);
  Future<Either<AppError, void>> deleteContact(int contactId);
}
