import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/update_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/submit_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_item_update_json.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/create_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/update_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/delete_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/submit_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_dates_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class InvoiceRemoteDataSource {
  Future<ApiResponse<InvoiceSalesResponseModel>> invoice({required InvoiceRequestParams invoiceParams});
  Future<PartyResponseModel> party({required PartyRequestParams params});
  Future<CreateInvoiceResponseModel> createInvoice({required CreateInvoiceRequestParams params});
  Future<UpdateInvoiceResponseModel> updateInvoice({required InvoiceItem params});
  Future<SubmitInvoiceResponseModel> submitInvoice({required SubmitInvoiceRequestParams params});
  Future<DeleteInvoiceResponseModel> deleteInvoice({required DeleteInvoiceRequestParams params});
  Future<InvoiceDatesResponseModel> getInvoiceDates({required InvoiceDatesRequestParams params});
  Future<InvoiceItem?> getInvoiceByName({
    required String invoiceName,
    required InvoiceType invoiceType,
  });
}

// @LazySingleton(as: InvoiceRemoteDataSource) — replaced by InvoiceLocalDataSource
class InvoiceRemoteSourceImpl implements InvoiceRemoteDataSource {
  InvoiceRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<InvoiceSalesResponseModel>> invoice({required InvoiceRequestParams invoiceParams}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${invoiceParams.invoiceType == InvoiceType.purchase ? ApiEndPoints.invoicePurchase : ApiEndPoints.invoiceSales}",
        queryParameters: invoiceParams.toQueryParams(),
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: InvoiceSalesResponseModel.fromJson(response.data),
          message: '',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<PartyResponseModel> party({required PartyRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.party}",
        queryParameters: params.toQueryParams(),
      );
      if (response.statusCode == 200) {
        return PartyResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CreateInvoiceResponseModel> createInvoice({required CreateInvoiceRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${params.invoiceType == InvoiceType.purchase ? ApiEndPoints.createInvoicePurchase : ApiEndPoints.createInvoiceSales}",
        data: params.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return CreateInvoiceResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<UpdateInvoiceResponseModel> updateInvoice({required InvoiceItem params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final payload = params.invoiceType == InvoiceType.sales
          ? params.toSalesUpdateJson(
              paymentMode: params.paymentModeForUpdate,
              paymentLines: params.updatePaymentLines,
            )
          : params.toJson();
      final response = await _dio.put(
        options: options,
        "${dotenv.env['BASE_URL']}${params.invoiceType == InvoiceType.purchase ? ApiEndPoints.createInvoicePurchase : ApiEndPoints.updateInvoiceSales}",
        data: payload,
      );
      if (response.statusCode == 200) {
        return UpdateInvoiceResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<SubmitInvoiceResponseModel> submitInvoice({required SubmitInvoiceRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.invoiceSales}",
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return SubmitInvoiceResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<DeleteInvoiceResponseModel> deleteInvoice({required DeleteInvoiceRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      late Response response;
      String url =
          "${dotenv.env['BASE_URL']}${params.invoiceType == InvoiceType.purchase ? ApiEndPoints.createInvoicePurchase : ApiEndPoints.updateInvoiceSales}";
      response = await _dio.delete(
        options: options,
        data: params.toJson(),
        url,
      );

      if (response.statusCode == 200) {
        return DeleteInvoiceResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<InvoiceDatesResponseModel> getInvoiceDates({required InvoiceDatesRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.invoiceDates}",
        queryParameters: params.toQueryParams(),
      );
      if (response.statusCode == 200) {
        return InvoiceDatesResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<InvoiceItem?> getInvoiceByName({
    required String invoiceName,
    required InvoiceType invoiceType,
  }) async =>
      null;
}
