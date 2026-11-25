import 'package:json_annotation/json_annotation.dart';

part 'update_party_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePartyRequest {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? partyType;
  final String? gstNumber;
  final String? panNumber;

  UpdatePartyRequest({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.partyType,
    this.gstNumber,
    this.panNumber,
  });

  factory UpdatePartyRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePartyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePartyRequestToJson(this);
}
