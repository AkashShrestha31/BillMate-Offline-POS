import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/action/data/models/request/party_update_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/action/domain/usecases/party_use_cases.dart';
import 'package:injectable/injectable.dart';

part 'party_state.dart';
part 'party_cubit.freezed.dart';

@injectable
class PartyCubit extends Cubit<PartyState> {
  PartyCubit(
    this._getPartiesUseCase,
    this._getPartyByIdUseCase,
    this._createPartyUseCase,
    this._updatePartyUseCase,
    this._deletePartyUseCase,
  ) : super(const PartyState.initial());

  final GetPartiesUseCase _getPartiesUseCase;
  final GetPartyByIdUseCase _getPartyByIdUseCase;
  final CreatePartyUseCase _createPartyUseCase;
  final UpdatePartyUseCase _updatePartyUseCase;
  final DeletePartyUseCase _deletePartyUseCase;

  List<PartyItem> _allParties = [];
  int _currentPage = 1;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;
  PartyRequestParams? _lastParams;

  void getParties({
    required PartyRequestParams params,
    bool isLoadMore = false,
  }) async {
    if (isLoadMore && _isLoadingMore) return;
    if (isLoadMore && !_hasMoreData) return;

    if (!isLoadMore) {
      _allParties = [];
      _currentPage = 1;
      _hasMoreData = true;
      _isLoadingMore = false;
      _lastParams = params;
      emit(const PartyState.loading());
    } else {
      _isLoadingMore = true;
    }

    final requestParams = PartyRequestParams(
      page: _currentPage,
      perPage: params.perPage ?? 20,
      partyType: params.partyType,
      partyRoles: params.partyRoles,
      status: params.status,
      search: params.search,
      sortBy: params.sortBy,
      sortOrder: params.sortOrder,
    );

    final result = await _getPartiesUseCase.execute(requestParams);

    result.fold(
      (error) {
        _isLoadingMore = false;
        emit(
          error.when(
            serverError: (serverError) =>
                PartyState.error(message: serverError),
            noInternet: () => const PartyState.noInternet(),
          ),
        );
      },
      (apiResponse) {
        final responseModel = apiResponse.data;
        final list = responseModel.data ?? [];
        final pagination = responseModel.pagination;

        if (isLoadMore) {
          _allParties.addAll(list);
        } else {
          _allParties = List.from(list);
        }

        _hasMoreData = (pagination.current_page ?? 1) <
            (pagination.total_pages ?? 1);
        if (_hasMoreData) _currentPage++;
        _isLoadingMore = false;

        final mergedResponse = ApiResponse<PartyResponseModel>(
          success: apiResponse.success,
          data: PartyResponseModel(
            data: _allParties,
            pagination: pagination,
          ),
          message: apiResponse.message,
        );
        emit(PartyState.success(response: mergedResponse));
      },
    );
  }

  void loadMoreParties() {
    if (_lastParams != null && _hasMoreData && !_isLoadingMore) {
      getParties(params: _lastParams!, isLoadMore: true);
    }
  }

  bool get hasMore => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

  void getPartyById({required String id}) async {
    emit(const PartyState.loading());
    emit(
      (await _getPartyByIdUseCase.execute(id)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.detailSuccess(response: data),
      ),
    );
  }

  void createParty({required CreatePartyRequest request}) async {
    emit(const PartyState.loading());
    emit(
      (await _createPartyUseCase.execute(request)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.created(response: data),
      ),
    );
  }

  void updateParty({required PartyUpdateRequestParams request}) async {
    emit(const PartyState.loading());
    emit(
      (await _updatePartyUseCase.execute(request: request)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.updated(response: data),
      ),
    );
  }

  void deleteParty({required String id}) async {
    emit(const PartyState.loading());
    emit(
      (await _deletePartyUseCase.execute(id)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => const PartyState.deleted(),
      ),
    );
  }

  void resetState() {
    emit(const PartyState.initial());
  }
}
