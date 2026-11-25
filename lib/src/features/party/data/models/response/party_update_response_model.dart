import 'package:freezed_annotation/freezed_annotation.dart';
import 'party_model.dart';

part 'party_update_response_model.freezed.dart';
part 'party_update_response_model.g.dart';

@freezed
class PartyTableUpdatesModel with _$PartyTableUpdatesModel {
  const factory PartyTableUpdatesModel({
    @JsonKey(name: 'fields_updated') List<String>? fieldsUpdated,
    @JsonKey(name: 'updated_values') Map<String, dynamic>? updatedValues,
  }) = _PartyTableUpdatesModel;

  factory PartyTableUpdatesModel.fromJson(Map<String, dynamic> json) =>
      _$PartyTableUpdatesModelFromJson(json);
}

@freezed
class ChangeDetailModel with _$ChangeDetailModel {
  const factory ChangeDetailModel({
    dynamic old,
    @JsonKey(name: 'new') dynamic newValue,
  }) = _ChangeDetailModel;

  factory ChangeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeDetailModelFromJson(json);
}

@freezed
class SearchSummaryModel with _$SearchSummaryModel {
  const factory SearchSummaryModel({
    @JsonKey(name: 'total_tables_searched') int? totalTablesSearched,
    @JsonKey(name: 'total_columns_searched') int? totalColumnsSearched,
    @JsonKey(name: 'total_rows_updated') int? totalRowsUpdated,
    @JsonKey(name: 'tables_with_updates') int? tablesWithUpdates,
  }) = _SearchSummaryModel;

  factory SearchSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SearchSummaryModelFromJson(json);
}

@freezed
class UpdateResultModel with _$UpdateResultModel {
  const factory UpdateResultModel({
    required String table,
    required String column,
    @JsonKey(name: 'column_type') required String columnType,
    @JsonKey(name: 'rows_affected') int? rowsAffected,
    @JsonKey(name: 'update_type') required String updateType,
    String? error,
  }) = _UpdateResultModel;

  factory UpdateResultModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateResultModelFromJson(json);
}

@freezed
class PartyUpdateResponseModel with _$PartyUpdateResponseModel {
  const factory PartyUpdateResponseModel({
    required bool success,
    required String message,
    required PartyModel party,
    @JsonKey(name: 'party_table_updates') PartyTableUpdatesModel? partyTableUpdates,
    Map<String, ChangeDetailModel>? changes,
    @JsonKey(name: 'modified_at') String? modifiedAt,
    @JsonKey(name: 'modified_by') String? modifiedBy,
    @JsonKey(name: 'search_summary') SearchSummaryModel? searchSummary,
    List<UpdateResultModel>? updates,
  }) = _PartyUpdateResponseModel;

  factory PartyUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartyUpdateResponseModelFromJson(json);
}
