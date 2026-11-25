// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeesListResponseModelImpl _$$EmployeesListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeesListResponseModelImpl(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
      employees: (json['employees'] as List<dynamic>)
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EmployeesListResponseModelImplToJson(
        _$EmployeesListResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'filters_applied': instance.filtersApplied,
      'employees': instance.employees,
    };
