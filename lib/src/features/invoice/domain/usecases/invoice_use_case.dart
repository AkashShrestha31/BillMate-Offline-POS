import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceUseCase
    implements
        BaseUseCase<InvoiceRequestParams,
            ApiResponse<InvoiceSalesResponseModel>> {
  final InvoiceRepository _invoiceRepository;
  InvoiceUseCase(this._invoiceRepository);

  @override
  Future<Either<AppError, ApiResponse<InvoiceSalesResponseModel>>> execute(
          InvoiceRequestParams param) =>
      _invoiceRepository.invoice(invoiceParams: param);
}
