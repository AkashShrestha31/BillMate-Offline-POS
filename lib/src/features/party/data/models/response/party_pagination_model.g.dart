// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyPaginationModelImpl _$$PartyPaginationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyPaginationModelImpl(
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalRows: (json['total_rows'] as num).toInt(),
    );

Map<String, dynamic> _$$PartyPaginationModelImplToJson(
        _$PartyPaginationModelImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_pages': instance.totalPages,
      'total_rows': instance.totalRows,
    };
