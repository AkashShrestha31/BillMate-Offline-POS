import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/analytics_report_response.dart';
import 'package:hotel/src/features/reports/domain/usecases/get_analytics_report_use_case.dart';
import 'package:injectable/injectable.dart';

part 'analytics_report_state.dart';
part 'analytics_report_cubit.freezed.dart';

@injectable
class AnalyticsReportCubit extends Cubit<AnalyticsReportState> {
  AnalyticsReportCubit(this._useCase) : super(const AnalyticsReportState.initial());

  final GetAnalyticsReportUseCase _useCase;

  Future<void> load(AnalyticsReportRequest request) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.reportAnalytics);
    } on AppException catch (e) {
      emit(AnalyticsReportState.error(message: e.message));
      return;
    }
    emit(const AnalyticsReportState.loading());
    emit(
      (await _useCase.execute(request)).fold(
        (error) => error.when(
          serverError: (message) => AnalyticsReportState.error(message: message),
          noInternet: () => const AnalyticsReportState.noInternet(),
        ),
        (data) => AnalyticsReportState.success(response: data),
      ),
    );
  }

  void resetToInitial() {
    emit(const AnalyticsReportState.initial());
  }
}
