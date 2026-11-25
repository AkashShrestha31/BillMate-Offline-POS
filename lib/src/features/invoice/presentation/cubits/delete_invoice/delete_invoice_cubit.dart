import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/delete_invoice_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/delete_invoice_use_case.dart';
import 'package:injectable/injectable.dart';

part 'delete_invoice_state.dart';
part 'delete_invoice_cubit.freezed.dart';

@injectable
class DeleteInvoiceCubit extends Cubit<DeleteInvoiceState> {
  DeleteInvoiceCubit(this._useCase) : super(const DeleteInvoiceState.initial());

  final DeleteInvoiceUseCase _useCase;

  void deleteInvoice({required DeleteInvoiceRequestParams params}) async {
    emit(const DeleteInvoiceState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => DeleteInvoiceState.error(message: serverError),
          noInternet: () => const DeleteInvoiceState.noInternet(),
        ),
        (data) => DeleteInvoiceState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const DeleteInvoiceState.initial());
  }
}
