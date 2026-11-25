import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/submit_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/submit_invoice_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/submit_invoice_use_case.dart';
import 'package:injectable/injectable.dart';

part 'submit_invoice_state.dart';
part 'submit_invoice_cubit.freezed.dart';

@injectable
class SubmitInvoiceCubit extends Cubit<SubmitInvoiceState> {
  SubmitInvoiceCubit(this._useCase) : super(const SubmitInvoiceState.initial());

  final SubmitInvoiceUseCase _useCase;

  void submitInvoice({required SubmitInvoiceRequestParams params}) async {
    emit(const SubmitInvoiceState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => SubmitInvoiceState.error(message: serverError),
          noInternet: () => const SubmitInvoiceState.noInternet(),
        ),
        (data) => SubmitInvoiceState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const SubmitInvoiceState.initial());
  }
}
