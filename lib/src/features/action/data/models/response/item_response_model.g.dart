// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponseModel _$ItemResponseModelFromJson(Map<String, dynamic> json) =>
    ItemResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
      filtersApplied: FiltersAppliedModel.fromJson(
          json['filters_applied'] as Map<String, dynamic>),
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      availableFilters: AvailableFiltersModel.fromJson(
          json['available_filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemResponseModelToJson(ItemResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'filters_applied': instance.filtersApplied,
      'summary': instance.summary,
      'available_filters': instance.availableFilters,
    };

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      newName: json['newName'] as String?,
      itemType: json['itemType'] as String?,
      forFilter: json['for'] as String,
      unit: json['unit'] as String,
      rate: _doubleFromJson(json['rate']),
      totalSales: _intNullableFromJson(json['totalSales']),
      description: json['description'] as String?,
      hsnCode: json['hsnCode'] as String?,
      barcode: json['barcode'] as String?,
      incomeAccount: json['incomeAccount'] as String?,
      expenseAccount: json['expenseAccount'] as String?,
      tax: json['tax'] as String?,
      trackItem: _intNullableFromJson(json['trackItem']),
      hasBatch: _intNullableFromJson(json['hasBatch']),
      hasSerialNumber: _intNullableFromJson(json['hasSerialNumber']),
      image: json['image'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      category: json['category'] as String?,
      isFavorite: _boolFromJson(json['isFavorite'] ?? json['is_favorite']),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'name': instance.name,
      if (instance.newName case final value?) 'newName': value,
      if (instance.itemType case final value?) 'itemType': value,
      'for': instance.forFilter,
      'unit': instance.unit,
      'rate': instance.rate,
      if (instance.totalSales case final value?) 'totalSales': value,
      if (instance.description case final value?) 'description': value,
      if (instance.hsnCode case final value?) 'hsnCode': value,
      if (instance.barcode case final value?) 'barcode': value,
      if (instance.incomeAccount case final value?) 'incomeAccount': value,
      if (instance.expenseAccount case final value?) 'expenseAccount': value,
      if (instance.tax case final value?) 'tax': value,
      if (instance.trackItem case final value?) 'trackItem': value,
      if (instance.hasBatch case final value?) 'hasBatch': value,
      if (instance.hasSerialNumber case final value?) 'hasSerialNumber': value,
      if (instance.image case final value?) 'image': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.updatedAt case final value?) 'updatedAt': value,
      if (instance.category case final value?) 'category': value,
      if (instance.isFavorite) 'isFavorite': true,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalRows: (json['total_rows'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_pages': instance.totalPages,
      'total_rows': instance.totalRows,
    };

FiltersAppliedModel _$FiltersAppliedModelFromJson(Map<String, dynamic> json) =>
    FiltersAppliedModel(
      search: json['search'] as String?,
      itemType: json['item_type'] as String?,
      forFilter: json['for'] as String?,
      excludeZeroSales: json['exclude_zero_sales'] as bool,
      sortBy: json['sort_by'] as String,
      sortOrder: json['sort_order'] as String,
    );

Map<String, dynamic> _$FiltersAppliedModelToJson(
        FiltersAppliedModel instance) =>
    <String, dynamic>{
      'search': instance.search,
      'item_type': instance.itemType,
      'for': instance.forFilter,
      'exclude_zero_sales': instance.excludeZeroSales,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
    };

SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) => SummaryModel(
      totalItems: (json['total_items'] as num).toInt(),
      itemsWithSales: (json['items_with_sales'] as num).toInt(),
      totalSalesQuantity: (json['total_sales_quantity'] as num).toInt(),
      averageSalesPerItem: (json['average_sales_per_item'] as num).toDouble(),
    );

Map<String, dynamic> _$SummaryModelToJson(SummaryModel instance) =>
    <String, dynamic>{
      'total_items': instance.totalItems,
      'items_with_sales': instance.itemsWithSales,
      'total_sales_quantity': instance.totalSalesQuantity,
      'average_sales_per_item': instance.averageSalesPerItem,
    };

AvailableFiltersModel _$AvailableFiltersModelFromJson(
        Map<String, dynamic> json) =>
    AvailableFiltersModel(
      forOptions: (json['for_options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AvailableFiltersModelToJson(
        AvailableFiltersModel instance) =>
    <String, dynamic>{
      'for_options': instance.forOptions,
    };
