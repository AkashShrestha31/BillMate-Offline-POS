import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/invoice/data/models/request/update_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/update_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateInvoiceUseCase implements BaseUseCase<InvoiceItem, UpdateInvoiceResponseModel> {
  final InvoiceRepository _invoiceRepository;
  UpdateInvoiceUseCase(this._invoiceRepository);

  @override
  Future<Either<AppError, UpdateInvoiceResponseModel>> execute(InvoiceItem param) =>
      _invoiceRepository.updateInvoice(params: param);
}
