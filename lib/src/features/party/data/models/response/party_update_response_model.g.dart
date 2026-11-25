// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyTableUpdatesModelImpl _$$PartyTableUpdatesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyTableUpdatesModelImpl(
      fieldsUpdated: (json['fields_updated'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      updatedValues: json['updated_values'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PartyTableUpdatesModelImplToJson(
        _$PartyTableUpdatesModelImpl instance) =>
    <String, dynamic>{
      'fields_updated': instance.fieldsUpdated,
      'updated_values': instance.updatedValues,
    };

_$ChangeDetailModelImpl _$$ChangeDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeDetailModelImpl(
      old: json['old'],
      newValue: json['new'],
    );

Map<String, dynamic> _$$ChangeDetailModelImplToJson(
        _$ChangeDetailModelImpl instance) =>
    <String, dynamic>{
      'old': instance.old,
      'new': instance.newValue,
    };

_$SearchSummaryModelImpl _$$SearchSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchSummaryModelImpl(
      totalTablesSearched: (json['total_tables_searched'] as num?)?.toInt(),
      totalColumnsSearched: (json['total_columns_searched'] as num?)?.toInt(),
      totalRowsUpdated: (json['total_rows_updated'] as num?)?.toInt(),
      tablesWithUpdates: (json['tables_with_updates'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SearchSummaryModelImplToJson(
        _$SearchSummaryModelImpl instance) =>
    <String, dynamic>{
      'total_tables_searched': instance.totalTablesSearched,
      'total_columns_searched': instance.totalColumnsSearched,
      'total_rows_updated': instance.totalRowsUpdated,
      'tables_with_updates': instance.tablesWithUpdates,
    };

_$UpdateResultModelImpl _$$UpdateResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateResultModelImpl(
      table: json['table'] as String,
      column: json['column'] as String,
      columnType: json['column_type'] as String,
      rowsAffected: (json['rows_affected'] as num?)?.toInt(),
      updateType: json['update_type'] as String,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$UpdateResultModelImplToJson(
        _$UpdateResultModelImpl instance) =>
    <String, dynamic>{
      'table': instance.table,
      'column': instance.column,
      'column_type': instance.columnType,
      'rows_affected': instance.rowsAffected,
      'update_type': instance.updateType,
      'error': instance.error,
    };

_$PartyUpdateResponseModelImpl _$$PartyUpdateResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyUpdateResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      party: PartyModel.fromJson(json['party'] as Map<String, dynamic>),
      partyTableUpdates: json['party_table_updates'] == null
          ? null
          : PartyTableUpdatesModel.fromJson(
              json['party_table_updates'] as Map<String, dynamic>),
      changes: (json['changes'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, ChangeDetailModel.fromJson(e as Map<String, dynamic>)),
      ),
      modifiedAt: json['modified_at'] as String?,
      modifiedBy: json['modified_by'] as String?,
      searchSummary: json['search_summary'] == null
          ? null
          : SearchSummaryModel.fromJson(
              json['search_summary'] as Map<String, dynamic>),
      updates: (json['updates'] as List<dynamic>?)
          ?.map((e) => UpdateResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PartyUpdateResponseModelImplToJson(
        _$PartyUpdateResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'party': instance.party,
      'party_table_updates': instance.partyTableUpdates,
      'changes': instance.changes,
      'modified_at': instance.modifiedAt,
      'modified_by': instance.modifiedBy,
      'search_summary': instance.searchSummary,
      'updates': instance.updates,
    };
