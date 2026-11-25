import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/update_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/submit_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/create_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/update_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/delete_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/submit_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_dates_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImp implements InvoiceRepository {
  InvoiceRepositoryImp(this._dataSource);
  final InvoiceRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, ApiResponse<InvoiceSalesResponseModel>>> invoice({
    required InvoiceRequestParams invoiceParams,
  }) async {
    try {
      return right(await _dataSource.invoice(invoiceParams: invoiceParams));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, PartyResponseModel>> party({
    required PartyRequestParams params,
  }) async {
    try {
      return right(await _dataSource.party(params: params));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CreateInvoiceResponseModel>> createInvoice({
    required CreateInvoiceRequestParams params,
  }) async {
    try {
      return right(await _dataSource.createInvoice(params: params));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, UpdateInvoiceResponseModel>> updateInvoice({
    required InvoiceItem params,
  }) async {
    try {
      return right(await _dataSource.updateInvoice(params: params));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, SubmitInvoiceResponseModel>> submitInvoice({
    required SubmitInvoiceRequestParams params,
  }) async {
    try {
      return right(await _dataSource.submitInvoice(params: params));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, DeleteInvoiceResponseModel>> deleteInvoice({
    required DeleteInvoiceRequestParams params,
  }) async {
    try {
      return right(await _dataSource.deleteInvoice(params: params));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, InvoiceDatesResponseModel>> getInvoiceDates({
    required InvoiceDatesRequestParams params,
  }) async {
    try {
      return right(await _dataSource.getInvoiceDates(params: params));
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
