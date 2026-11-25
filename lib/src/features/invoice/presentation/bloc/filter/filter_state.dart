part of 'filter_cubit.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    @Default({}) Map<String, String?> selectedFilters,
  }) = _FilterState;
}
