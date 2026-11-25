import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/profit_loss_report_response.dart';
import 'package:hotel/src/features/reports/domain/usecases/get_profit_loss_report_use_case.dart';
import 'package:injectable/injectable.dart';

part 'profit_loss_report_state.dart';
part 'profit_loss_report_cubit.freezed.dart';

@injectable
class ProfitLossReportCubit extends Cubit<ProfitLossReportState> {
  ProfitLossReportCubit(this._getProfitLossReportUseCase)
      : super(const ProfitLossReportState.initial());

  final GetProfitLossReportUseCase _getProfitLossReportUseCase;

  Future<void> load(ProfitLossReportRequest request) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.reportProfitLoss);
    } on AppException catch (e) {
      emit(ProfitLossReportState.error(message: e.message));
      return;
    }
    emit(const ProfitLossReportState.loading());
    emit(
      (await _getProfitLossReportUseCase.execute(request)).fold(
        (error) => error.when(
          serverError: (message) =>
              ProfitLossReportState.error(message: message),
          noInternet: () => const ProfitLossReportState.noInternet(),
        ),
        (data) => ProfitLossReportState.success(response: data),
      ),
    );
  }

  void resetToInitial() {
    emit(const ProfitLossReportState.initial());
  }
}
