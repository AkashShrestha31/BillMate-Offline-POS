import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/request/create_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/update_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';

abstract class ContactRemoteDataSource {
  Future<ContactListResponse> getContacts({ContactQueryParams? params});
  Future<ContactSingleResponse> getContactById(int contactId);
  Future<CreateContactResponse> createContact(CreateContactRequest request);
  Future<UpdateContactResponse> updateContact(UpdateContactRequest request);
  Future<DeleteContactResponse> deleteContact(int contactId);
}

// @LazySingleton(as: ContactRemoteDataSource)
class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  ContactRemoteDataSourceImpl(@Named('authenticated') this._dio);

  final Dio _dio;

  String get _baseUrl => '${dotenv.env['BASE_URL']}${ApiEndPoints.contactBook}';

  @override
  Future<ContactListResponse> getContacts({ContactQueryParams? params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        _baseUrl,
        queryParameters: params?.toQueryParams(),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['contact'] != null) {
          return ContactListResponse(
            success: data['success'] as bool? ?? true,
            count: 1,
            contacts: [
              ContactModel.fromJson(data['contact'] as Map<String, dynamic>),
            ],
          );
        }
        return ContactListResponse.fromJson(data);
      }
      throw const AppException(message: 'Failed to fetch contacts');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ContactSingleResponse> getContactById(int contactId) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        _baseUrl,
        queryParameters: {'contact_id': contactId.toString()},
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return ContactSingleResponse(
          success: data['success'] as bool? ?? true,
          contact: ContactModel.fromJson(
            data['contact'] as Map<String, dynamic>,
          ),
        );
      }
      throw const AppException(message: 'Failed to fetch contact');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CreateContactResponse> createContact(CreateContactRequest request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        _baseUrl,
        data: request.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return CreateContactResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      throw const AppException(message: 'Failed to create contact');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<UpdateContactResponse> updateContact(UpdateContactRequest request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        _baseUrl,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return UpdateContactResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      throw const AppException(message: 'Failed to update contact');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<DeleteContactResponse> deleteContact(int contactId) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        options: options,
        _baseUrl,
        queryParameters: {'contact_id': contactId.toString()},
      );
      if (response.statusCode == 200) {
        return DeleteContactResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      throw const AppException(message: 'Failed to delete contact');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}

