import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'filter_state.dart';
part 'filter_cubit.freezed.dart';

@injectable
class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void toggleFilter(String category, String filter) {
    final newFilters = Map<String, String?>.from(state.selectedFilters);

    // If the selected filter is already chosen, unselect it
    if (newFilters[category] == filter) {
      newFilters[category] = null;
    } else {
      // Otherwise, select the new one (ensuring only one selection per category)
      newFilters[category] = filter;
    }

    emit(state.copyWith(selectedFilters: newFilters));
  }

  void clearFilters() {
    emit(state.copyWith(selectedFilters: {}));
  }
}
