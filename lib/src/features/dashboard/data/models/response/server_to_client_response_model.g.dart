// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_to_client_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerToClientResponseModel _$ServerToClientResponseModelFromJson(
        Map<String, dynamic> json) =>
    ServerToClientResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      fileName: json['file_name'] as String,
      originalSize: (json['original_size'] as num).toInt(),
      contentType: json['content_type'] as String,
      fileUrl: json['file_url'] as String,
      status: json['status'] as String,
      firebaseKey: json['firebase_key'] as String,
    );

Map<String, dynamic> _$ServerToClientResponseModelToJson(
        ServerToClientResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'file_name': instance.fileName,
      'original_size': instance.originalSize,
      'content_type': instance.contentType,
      'file_url': instance.fileUrl,
      'status': instance.status,
      'firebase_key': instance.firebaseKey,
    };
