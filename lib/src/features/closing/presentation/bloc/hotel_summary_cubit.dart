import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/closing/domain/usecases/create_hotel_summary_use_case.dart';
import 'package:hotel/src/features/closing/domain/usecases/delete_hotel_summary_use_case.dart';
import 'package:hotel/src/features/closing/domain/usecases/get_hotel_summaries_use_case.dart';
import 'package:hotel/src/features/closing/domain/usecases/get_hotel_summary_by_id_use_case.dart';
import 'package:hotel/src/features/closing/domain/usecases/update_hotel_summary_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';

part 'hotel_summary_state.dart';
part 'hotel_summary_cubit.freezed.dart';

@injectable
class HotelSummaryCubit extends Cubit<HotelSummaryState> {
  HotelSummaryCubit(
    this._getHotelSummariesUseCase,
    this._getHotelSummaryByIdUseCase,
    this._createHotelSummaryUseCase,
    this._updateHotelSummaryUseCase,
    this._deleteHotelSummaryUseCase,
  ) : super(const HotelSummaryState.initial());

  final GetHotelSummariesUseCase _getHotelSummariesUseCase;
  final GetHotelSummaryByIdUseCase _getHotelSummaryByIdUseCase;
  final CreateHotelSummaryUseCase _createHotelSummaryUseCase;
  final UpdateHotelSummaryUseCase _updateHotelSummaryUseCase;
  final DeleteHotelSummaryUseCase _deleteHotelSummaryUseCase;

  // READ Operations
  void getHotelSummaries({required HotelSummaryRequestParams params}) async {
    emit(const HotelSummaryState.loading());
    emit(
      (await _getHotelSummariesUseCase.execute(params)).fold(
        (error) => error.when(
            serverError: (serverError) => HotelSummaryState.error(message: serverError),
            noInternet: () => const HotelSummaryState.noInternet()),
        (data) => HotelSummaryState.loaded(hotelSummaryResponseModel: data),
      ),
    );
  }

  void getHotelSummaryById(int id) async {
    emit(const HotelSummaryState.loadingDetail());
    emit(
      (await _getHotelSummaryByIdUseCase.execute(id)).fold(
        (error) => error.when(
            serverError: (serverError) => HotelSummaryState.error(message: serverError),
            noInternet: () => const HotelSummaryState.noInternet()),
        (data) => HotelSummaryState.detailLoaded(summary: data),
      ),
    );
  }

  // CREATE Operation
  void createHotelSummary(CreateHotelSummaryRequest request) async {
    emit(const HotelSummaryState.creating());
    emit(
      (await _createHotelSummaryUseCase.execute(request)).fold(
        (error) => error.when(
            serverError: (serverError) => HotelSummaryState.error(message: serverError),
            noInternet: () => const HotelSummaryState.noInternet()),
        (data) => HotelSummaryState.created(summary: data),
      ),
    );
  }

  // UPDATE Operation
  void updateHotelSummary(int id, CreateHotelSummaryRequest request) async {
    emit(const HotelSummaryState.updating());
    final params = UpdateHotelSummaryParams(id: id, request: request);
    emit(
      (await _updateHotelSummaryUseCase.execute(params)).fold(
        (error) => error.when(
            serverError: (serverError) => HotelSummaryState.error(message: serverError),
            noInternet: () => const HotelSummaryState.noInternet()),
        (data) => HotelSummaryState.updated(summary: data),
      ),
    );
  }

  // DELETE Operation
  void deleteHotelSummary(int id) async {
    emit(const HotelSummaryState.deleting());
    emit(
      (await _deleteHotelSummaryUseCase.execute(id)).fold(
        (error) => error.when(
            serverError: (serverError) => HotelSummaryState.error(message: serverError),
            noInternet: () => const HotelSummaryState.noInternet()),
        (data) => const HotelSummaryState.deleted(),
      ),
    );
  }

  // Utility Methods
  void refreshSummaries({HotelSummaryRequestParams? params}) {
    final requestParams = params ?? HotelSummaryRequestParams();
    getHotelSummaries(params: requestParams);
  }



  void resetState() {
    emit(const HotelSummaryState.initial());
  }

  void clearErrors() {
    emit(const HotelSummaryState.initial());
  }
}
