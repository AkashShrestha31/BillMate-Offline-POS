// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_success_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommonSuccessResponseModelImpl _$$CommonSuccessResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CommonSuccessResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CommonSuccessResponseModelImplToJson(
        _$CommonSuccessResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
