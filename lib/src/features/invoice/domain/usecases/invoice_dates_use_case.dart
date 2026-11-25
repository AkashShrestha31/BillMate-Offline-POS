import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_dates_response_model.dart';
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceDatesUseCase implements BaseUseCase<InvoiceDatesRequestParams, InvoiceDatesResponseModel> {
  final InvoiceRepository _invoiceRepository;
  InvoiceDatesUseCase(this._invoiceRepository);

  @override
  Future<Either<AppError, InvoiceDatesResponseModel>> execute(InvoiceDatesRequestParams param) =>
      _invoiceRepository.getInvoiceDates(params: param);
}
