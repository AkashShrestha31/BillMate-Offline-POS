import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/delete_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteInvoiceUseCase implements BaseUseCase<DeleteInvoiceRequestParams, DeleteInvoiceResponseModel> {
  final InvoiceRepository _invoiceRepository;
  DeleteInvoiceUseCase(this._invoiceRepository);

  @override
  Future<Either<AppError, DeleteInvoiceResponseModel>> execute(DeleteInvoiceRequestParams param) =>
      _invoiceRepository.deleteInvoice(params: param);
}
