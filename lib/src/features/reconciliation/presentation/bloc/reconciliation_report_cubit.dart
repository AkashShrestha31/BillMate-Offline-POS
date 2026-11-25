import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/generate_reconciliation_report_use_case.dart';
import 'package:injectable/injectable.dart';

part 'reconciliation_report_state.dart';
part 'reconciliation_report_cubit.freezed.dart';

@injectable
class ReconciliationReportCubit extends Cubit<ReconciliationReportState> {
  ReconciliationReportCubit(this._useCase)
      : super(const ReconciliationReportState.initial());

  final GenerateReconciliationReportUseCase _useCase;

  Future<void> generateReconciliationReport(
      {required ReconciliationReportRequest request}) async {
    emit(const ReconciliationReportState.loading());
    emit((await _useCase.call(request: request)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                ReconciliationReportState.error(message: serverError),
            noInternet: () => const ReconciliationReportState.noInternet()),
        (data) => ReconciliationReportState.success(
            reconciliationReportResponse: data)));
  }

  void resetToInitial() {
    emit(const ReconciliationReportState.initial());
  }
}
