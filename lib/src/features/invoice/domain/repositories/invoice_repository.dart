import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
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

abstract class InvoiceRepository {
  Future<Either<AppError, ApiResponse<InvoiceSalesResponseModel>>> invoice({required InvoiceRequestParams invoiceParams});
  Future<Either<AppError, PartyResponseModel>> party({required PartyRequestParams params});
  Future<Either<AppError, CreateInvoiceResponseModel>> createInvoice({required CreateInvoiceRequestParams params});
  Future<Either<AppError, UpdateInvoiceResponseModel>> updateInvoice({required InvoiceItem params});
  Future<Either<AppError, SubmitInvoiceResponseModel>> submitInvoice({required SubmitInvoiceRequestParams params});
  Future<Either<AppError, DeleteInvoiceResponseModel>> deleteInvoice({required DeleteInvoiceRequestParams params});
  Future<Either<AppError, InvoiceDatesResponseModel>> getInvoiceDates({required InvoiceDatesRequestParams params});
}
