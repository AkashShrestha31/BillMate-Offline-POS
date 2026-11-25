import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/reconcile_party_request_params.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/reconcile_party_response.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_detail_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_delete_response_model.dart';
import 'package:hotel/src/features/party/domain/party_list_pagination.dart';
import 'package:hotel/src/features/party/domain/usecases/party_use_cases.dart';

part 'party_state.dart';
part 'party_cubit.freezed.dart';

@injectable
class PartyCubit extends Cubit<PartyState> {
  PartyCubit(
    this._getPartyListUseCase,
    this._getPartyDetailUseCase,
    this._createPartyUseCase,
    this._updatePartyUseCase,
    this._deletePartyUseCase,
    this._reconcilePartyUseCase,
  ) : super(const PartyState.initial());

  final GetPartyListUseCase _getPartyListUseCase;
  final GetPartyDetailUseCase _getPartyDetailUseCase;
  final UpdatePartyUseCase _updatePartyUseCase;
  final DeletePartyUseCase _deletePartyUseCase;
  final CreatePartyUseCase _createPartyUseCase;
  final ReconcilePartyUseCase _reconcilePartyUseCase;

  PartyRequestParams? _lastListParams;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  String? _inFlightListKey;

  bool get hasMoreParties => _hasMore;
  bool get isLoadingMoreParties => _isLoadingMore;
  int get currentPartiesPage => _currentPage;

  String _listRequestKey(PartyRequestParams params) {
    return [
      params.page,
      params.pageSize,
      params.role,
      params.status,
      params.search,
      params.sortBy,
      params.sortOrder,
    ].join('|');
  }

  bool _alreadyHasListPage(PartyRequestParams params) {
    return state.maybeWhen(
      listSuccess: (response) {
        if (_lastListParams == null) return false;
        return _listRequestKey(_lastListParams!) == _listRequestKey(params) &&
            response.pagination.currentPage == (params.page ?? 1);
      },
      orElse: () => false,
    );
  }

  /// Fetches a page from `/api/hotel/api/parties/`. Set [isLoadMore] to append the next page.
  /// Pass [forceRefresh] after mutations (e.g. pay advance) to bypass the in-memory page cache.
  Future<void> getPartyList({
    required PartyRequestParams params,
    bool isLoadMore = false,
    bool forceRefresh = false,
  }) async {
    final page = isLoadMore ? _currentPage + 1 : (params.page ?? 1);
    final requestParams = (isLoadMore ? _lastListParams! : params).copyWith(
      page: page,
      pageSize: params.pageSize ?? _lastListParams?.pageSize ?? kPartyListPageSize,
    );
    final requestKey = _listRequestKey(requestParams);

    if (isLoadMore) {
      if (_isLoadingMore || !_hasMore || _lastListParams == null) return;
      _isLoadingMore = true;
    } else {
      if (_inFlightListKey == requestKey ||
          (!forceRefresh && _alreadyHasListPage(requestParams))) {
        return;
      }
      _lastListParams = params;
      _currentPage = params.page ?? 1;
      _hasMore = true;
      _isLoadingMore = false;
      _inFlightListKey = requestKey;
      emit(const PartyState.loading());
    }

    try {
      final result = await _getPartyListUseCase.execute(params: requestParams);

      emit(
        result.fold(
          (error) => error.when(
            serverError: (serverError) => PartyState.error(message: serverError),
            noInternet: () => const PartyState.noInternet(),
          ),
          (data) {
            _currentPage = data.pagination.currentPage;
            _hasMore = _currentPage < data.pagination.totalPages;
            return PartyState.listSuccess(response: data);
          },
        ),
      );
    } finally {
      _isLoadingMore = false;
      if (_inFlightListKey == requestKey) {
        _inFlightListKey = null;
      }
    }
  }

  void loadMorePartyList() {
    if (_lastListParams == null || !_hasMore || _isLoadingMore) return;
    getPartyList(params: _lastListParams!, isLoadMore: true);
  }

  void createParty({
    required CreatePartyRequest request,
    String? imagePath,
  }) async {
    emit(const PartyState.loading());

    emit(
      (await _createPartyUseCase.execute(request: request, imagePath: imagePath))
          .fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.created(response: data),
      ),
    );
  }

  void getPartyDetail({required String name}) async {
    emit(const PartyState.loading());

    emit(
      (await _getPartyDetailUseCase.execute(name: name)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.detailSuccess(response: data),
      ),
    );
  }

  void updateParty({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  }) async {
    emit(const PartyState.loading());

    emit(
      (await _updatePartyUseCase.execute(
        request: request,
        imagePath: imagePath,
        clearPartyImage: clearPartyImage,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.updated(response: data),
      ),
    );
  }

  void deleteParty({required DeletePartyRequest request}) async {
    emit(const PartyState.loading());

    emit(
      (await _deletePartyUseCase.execute(request: request)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.deleted(response: data),
      ),
    );
  }

  void reconcileParty({
    required ReconcilePartyRequestParams params,
  }) async {
    emit(const PartyState.loading());

    emit(
      (await _reconcilePartyUseCase(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) => PartyState.error(message: serverError),
          noInternet: () => const PartyState.noInternet(),
        ),
        (data) => PartyState.reconcile(response: data),
      ),
    );
  }

  void reset() {
    _lastListParams = null;
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    _inFlightListKey = null;
    emit(const PartyState.initial());
  }
}
