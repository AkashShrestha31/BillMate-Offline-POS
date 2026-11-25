import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_return_check_model.dart';
import 'package:injectable/injectable.dart';

abstract class InvoiceReturnRemoteDataSource {
  Future<InvoiceReturnCheckData> checkReturn({
    required InvoiceType invoiceType,
    required String invoiceName,
  });

  Future<String?> createReturn({
    required InvoiceType invoiceType,
    required CreateInvoiceReturnRequest body,
  });

  Future<String?> cancelReturn({
    required InvoiceType invoiceType,
    required String returnInvoiceName,
    required String cancelledBy,
  });
}

// @LazySingleton(as: InvoiceReturnRemoteDataSource) — replaced by InvoiceReturnLocalDataSource
class InvoiceReturnRemoteDataSourceImpl implements InvoiceReturnRemoteDataSource {
  InvoiceReturnRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  String _checkPath(InvoiceType type, String invoiceName) {
    final base = dotenv.env['BASE_URL'] ?? '';
    final path = type == InvoiceType.sales
        ? ApiEndPoints.salesReturnCheck(invoiceName)
        : ApiEndPoints.purchaseReturnCheck(invoiceName);
    return '$base$path';
  }

  String _createPath(InvoiceType type) {
    final base = dotenv.env['BASE_URL'] ?? '';
    return '$base${type == InvoiceType.sales ? ApiEndPoints.salesReturn : ApiEndPoints.purchaseReturn}';
  }

  String _cancelPath(InvoiceType type) {
    final base = dotenv.env['BASE_URL'] ?? '';
    return '$base${type == InvoiceType.sales ? ApiEndPoints.salesReturnCancel : ApiEndPoints.purchaseReturnCancel}';
  }

  @override
  Future<InvoiceReturnCheckData> checkReturn({
    required InvoiceType invoiceType,
    required String invoiceName,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        _checkPath(invoiceType, invoiceName),
        options: options,
      );
      if (response.statusCode != 200 || response.data is! Map) {
        throw AppException(message: parseInvoiceReturnApiError(response.data));
      }
      final data = InvoiceReturnCheckData.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
      if (!data.success) {
        throw AppException(message: data.message?.isNotEmpty == true ? data.message! : 'Could not load return');
      }
      data.validateReturnable();
      return data;
    } on InvoiceReturnValidationException catch (e) {
      throw AppException(message: e.message);
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<String?> createReturn({
    required InvoiceType invoiceType,
    required CreateInvoiceReturnRequest body,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        _createPath(invoiceType),
        data: body.toJson(),
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code < 200 || code >= 300) {
        throw AppException(message: parseInvoiceReturnApiError(response.data));
      }
      if (response.data is Map) {
        final map = Map<String, dynamic>.from(response.data as Map);
        if (map['success'] == false) {
          throw AppException(message: parseInvoiceReturnApiError(map));
        }
        final msg = map['message'];
        if (msg is String && msg.isNotEmpty) return msg;
      }
      return null;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<String?> cancelReturn({
    required InvoiceType invoiceType,
    required String returnInvoiceName,
    required String cancelledBy,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        _cancelPath(invoiceType),
        data: {
          'return_invoice_name': returnInvoiceName,
          'cancelled_by': cancelledBy,
        },
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code < 200 || code >= 300) {
        throw AppException(message: parseInvoiceReturnApiError(response.data));
      }
      if (response.data is Map) {
        final map = Map<String, dynamic>.from(response.data as Map);
        if (map['success'] == false) {
          throw AppException(message: parseInvoiceReturnApiError(map));
        }
        final msg = map['message'];
        if (msg is String && msg.isNotEmpty) return msg;
      }
      return null;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
