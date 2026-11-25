import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/invoice/data/models/request/submit_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/submit_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitInvoiceUseCase implements BaseUseCase<SubmitInvoiceRequestParams, SubmitInvoiceResponseModel> {
  final InvoiceRepository _invoiceRepository;
  SubmitInvoiceUseCase(this._invoiceRepository);

  @override
  Future<Either<AppError, SubmitInvoiceResponseModel>> execute(SubmitInvoiceRequestParams param) =>
      _invoiceRepository.submitInvoice(params: param);
}
