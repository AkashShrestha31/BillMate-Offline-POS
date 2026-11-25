import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/hotel_summary/domain/usecases/create_daily_summary_use_case.dart';
import 'package:hotel/src/features/hotel_summary/domain/usecases/get_daily_summaries_use_case.dart';
import 'package:hotel/src/features/hotel_summary/domain/usecases/update_daily_summary_use_case.dart';
import 'package:hotel/src/features/hotel_summary/domain/usecases/delete_daily_summary_use_case.dart';
import 'package:injectable/injectable.dart';

part 'daily_cash_summary_state.dart';
part 'daily_cash_summary_cubit.freezed.dart';

@injectable
class DailyCashSummaryCubit extends Cubit<DailyCashSummaryState> {
  DailyCashSummaryCubit(
    this._createDailySummaryUseCase,
    this._getDailySummariesUseCase,
    this._updateDailySummaryUseCase,
    this._deleteDailySummaryUseCase,
  ) : super(const DailyCashSummaryState.initial());

  final CreateDailySummaryUseCase _createDailySummaryUseCase;
  final GetDailySummariesUseCase _getDailySummariesUseCase;
  final UpdateDailySummaryUseCase _updateDailySummaryUseCase;
  final DeleteDailySummaryUseCase _deleteDailySummaryUseCase;

  // Create Daily Summary
  void createDailySummary({required DailyCashSummaryRequestParams params}) async {
    emit(const DailyCashSummaryState.loading());
    emit(
      (await _createDailySummaryUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => DailyCashSummaryState.error(message: serverError),
          noInternet: () => const DailyCashSummaryState.noInternet(),
        ),
        (data) => DailyCashSummaryState.summaryCreated(response: data),
      ),
    );
  }

  // Get Daily Summaries
  void getDailySummaries({required DailyCashSummaryQueryParams params}) async {
    emit(const DailyCashSummaryState.loading());
    emit(
      (await _getDailySummariesUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => DailyCashSummaryState.error(message: serverError),
          noInternet: () => const DailyCashSummaryState.noInternet(),
        ),
        (data) => DailyCashSummaryState.summariesLoaded(response: data),
      ),
    );
  }

  // Update Daily Summary
  void updateDailySummary({required DailyCashSummaryRequestParams params}) async {
    emit(const DailyCashSummaryState.loading());
    emit(
      (await _updateDailySummaryUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => DailyCashSummaryState.error(message: serverError),
          noInternet: () => const DailyCashSummaryState.noInternet(),
        ),
        (data) => DailyCashSummaryState.summaryUpdated(response: data),
      ),
    );
  }

  // Delete Daily Summary
  void deleteDailySummary({required int id}) async {
    emit(const DailyCashSummaryState.loading());
    emit(
      (await _deleteDailySummaryUseCase.execute(id)).fold(
        (error) => error.when(
          serverError: (serverError) => DailyCashSummaryState.error(message: serverError),
          noInternet: () => const DailyCashSummaryState.noInternet(),
        ),
        (data) => DailyCashSummaryState.summaryDeleted(response: data),
      ),
    );
  }

  // Reset state to initial
  void resetState() {
    emit(const DailyCashSummaryState.initial());
  }
}
