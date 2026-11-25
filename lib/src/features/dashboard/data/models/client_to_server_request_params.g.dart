// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_to_server_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientToServerRequestParams _$ClientToServerRequestParamsFromJson(
        Map<String, dynamic> json) =>
    ClientToServerRequestParams(
      requestedFile: json['requested_file'] as String,
      priority: json['priority'] as String? ?? "normal",
    );

Map<String, dynamic> _$ClientToServerRequestParamsToJson(
        ClientToServerRequestParams instance) =>
    <String, dynamic>{
      'requested_file': instance.requestedFile,
      'priority': instance.priority,
    };
