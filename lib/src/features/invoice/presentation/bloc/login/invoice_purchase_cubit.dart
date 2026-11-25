import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/invoice_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';

part 'invoice_purchase_state.dart';
part 'invoice_purchase_cubit.freezed.dart';

@injectable
class InvoicePurchaseCubit extends Cubit<InvoicePurchaseState> {
  InvoicePurchaseCubit(this._useCase)
      : super(const InvoicePurchaseState.initial());

  final InvoiceUseCase _useCase;

  void invoice({required InvoiceRequestParams invoiceRequestParam}) async {
    emit(const InvoicePurchaseState.loading());
    emit(
      (await _useCase.execute(invoiceRequestParam)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                InvoicePurchaseState.error(message: serverError),
            noInternet: () => const InvoicePurchaseState.noInternet()),
        (data) {
          return InvoicePurchaseState.success(invoiceResponseModel: data);
        },
      ),
    );
  }
}
