import 'party_available_filters_model.dart';
import 'party_filters_applied_model.dart';
import 'party_model.dart';
import 'party_pagination_model.dart';
import 'party_summary_model.dart';

/// Parties list API returns `success`, `data`, `pagination`; nested
/// `filters_applied`, `summary`, and `available_filters` are optional.
class PartyListResponseModel {
  const PartyListResponseModel({
    required this.success,
    required this.data,
    required this.pagination,
    this.filtersApplied,
    this.summary,
    this.availableFilters,
  });

  final bool success;
  final List<PartyModel> data;
  final PartyPaginationModel pagination;
  final PartyFiltersAppliedModel? filtersApplied;
  final PartySummaryModel? summary;
  final PartyAvailableFiltersModel? availableFilters;

  factory PartyListResponseModel.fromJson(Map<String, dynamic> json) {
    final dataRaw = json['data'];
    if (dataRaw is! List<dynamic>) {
      throw const FormatException(
        'PartyListResponseModel: expected List for data',
      );
    }
    final paginationRaw = json['pagination'];
    if (paginationRaw is! Map<String, dynamic>) {
      throw const FormatException(
        'PartyListResponseModel: expected Map for pagination',
      );
    }
    return PartyListResponseModel(
      success: json['success'] as bool,
      data: dataRaw
          .map((e) => PartyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PartyPaginationModel.fromJson(paginationRaw),
      filtersApplied: _filtersAppliedFromJson(json['filters_applied']),
      summary: _summaryFromJson(json['summary']),
      availableFilters: _availableFiltersFromJson(json['available_filters']),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.map((e) => e.toJson()).toList(),
        'pagination': pagination.toJson(),
        if (filtersApplied != null) 'filters_applied': filtersApplied!.toJson(),
        if (summary != null) 'summary': summary!.toJson(),
        if (availableFilters != null)
          'available_filters': availableFilters!.toJson(),
      };
}

PartyFiltersAppliedModel? _filtersAppliedFromJson(Object? json) {
  if (json is Map<String, dynamic>) {
    return PartyFiltersAppliedModel.fromJson(json);
  }
  return null;
}

PartySummaryModel? _summaryFromJson(Object? json) {
  if (json is Map<String, dynamic>) {
    return PartySummaryModel.fromJson(json);
  }
  return null;
}

PartyAvailableFiltersModel? _availableFiltersFromJson(Object? json) {
  if (json is Map<String, dynamic>) {
    return PartyAvailableFiltersModel.fromJson(json);
  }
  return null;
}
