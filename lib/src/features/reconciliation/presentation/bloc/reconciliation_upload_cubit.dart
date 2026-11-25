import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_upload_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_upload_response.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/upload_reconciliation_usecase.dart';
import 'package:injectable/injectable.dart';

part 'reconciliation_upload_state.dart';
part 'reconciliation_upload_cubit.freezed.dart';

@injectable
class ReconciliationUploadCubit extends Cubit<ReconciliationUploadState> {
  ReconciliationUploadCubit(this._useCase)
      : super(const ReconciliationUploadState.initial());

  final UploadReconciliationDataUseCase _useCase;

  Future<void> uploadReconciliationData(
      {required ReconciliationUploadRequest request}) async {
    emit(const ReconciliationUploadState.loading());
    emit((await _useCase.call(request: request)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                ReconciliationUploadState.error(message: serverError),
            noInternet: () => const ReconciliationUploadState.noInternet()),
        (data) => ReconciliationUploadState.success(
            reconciliationUploadResponse: data)));
  }

  void resetToInitial() {
    emit(const ReconciliationUploadState.initial());
  }
}
