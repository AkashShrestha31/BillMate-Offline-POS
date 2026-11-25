import 'package:json_annotation/json_annotation.dart';

part 'client_to_server_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClientToServerResponseModel {
  final bool success;
  final String message;
  final String requestId;
  final bool firebaseStored;

  ClientToServerResponseModel({
    required this.success,
    required this.message,
    required this.requestId,
    required this.firebaseStored,
  });

  /// Factory method to create an instance from a JSON map
  factory ClientToServerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ClientToServerResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$ClientToServerResponseModelToJson(this);
}
