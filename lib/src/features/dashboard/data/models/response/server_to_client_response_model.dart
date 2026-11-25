import 'package:json_annotation/json_annotation.dart';

part 'server_to_client_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerToClientResponseModel {
  final bool success;
  final String message;
  final String fileName;
  final int originalSize;
  final String contentType;
  final String fileUrl;
  final String status;
  final String firebaseKey;

  const ServerToClientResponseModel({
    required this.success,
    required this.message,
    required this.fileName,
    required this.originalSize,
    required this.contentType,
    required this.fileUrl,
    required this.status,
    required this.firebaseKey,
  });

  /// Factory method to create an instance from a JSON map
  factory ServerToClientResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServerToClientResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$ServerToClientResponseModelToJson(this);
}
