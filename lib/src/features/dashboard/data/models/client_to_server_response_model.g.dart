// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_to_server_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientToServerResponseModel _$ClientToServerResponseModelFromJson(
        Map<String, dynamic> json) =>
    ClientToServerResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      requestId: json['request_id'] as String,
      firebaseStored: json['firebase_stored'] as bool,
    );

Map<String, dynamic> _$ClientToServerResponseModelToJson(
        ClientToServerResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'request_id': instance.requestId,
      'firebase_stored': instance.firebaseStored,
    };
