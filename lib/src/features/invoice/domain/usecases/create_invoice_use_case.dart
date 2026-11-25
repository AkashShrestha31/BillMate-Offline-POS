import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/create_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateInvoiceUseCase implements BaseUseCase<CreateInvoiceRequestParams, CreateInvoiceResponseModel> {
  final InvoiceRepository _invoiceRepository;
  CreateInvoiceUseCase(this._invoiceRepository);

  @override
  Future<Either<AppError, CreateInvoiceResponseModel>> execute(CreateInvoiceRequestParams param) =>
      _invoiceRepository.createInvoice(params: param);
}
