import 'package:json_annotation/json_annotation.dart';

part 'create_party_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatePartyRequest {
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String partyType;
  final String? gstNumber;
  final String? panNumber;

  CreatePartyRequest({
    required this.name,
    required this.email,
    this.phone,
    this.address,
    required this.partyType,
    this.gstNumber,
    this.panNumber,
  });

  factory CreatePartyRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePartyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePartyRequestToJson(this);
}
