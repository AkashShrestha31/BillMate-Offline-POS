import 'package:json_annotation/json_annotation.dart';

part 'client_to_server_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClientToServerRequestParams {
  final String requestedFile;
  final String priority;

  ClientToServerRequestParams({
    required this.requestedFile,
    this.priority = "normal",
  });

  /// Factory method to create an instance from a JSON map
  factory ClientToServerRequestParams.fromJson(Map<String, dynamic> json) =>
      _$ClientToServerRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$ClientToServerRequestParamsToJson(this);
}
