// hotel/lib/src/features/party/data/models/request/create_party_request.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_party_request.freezed.dart';
part 'create_party_request.g.dart';

@freezed
class CreatePartyRequest with _$CreatePartyRequest {
  const factory CreatePartyRequest({
    required String name,
    required String role,
    String? email,
    String? phone,
    String? address,
    String? currency,
    @JsonKey(name: 'loyaltyProgram') String? loyaltyProgram,
    @JsonKey(name: 'loyaltyPoints') int? loyaltyPoints,
    @JsonKey(name: 'outstandingAmount') String? outstandingAmount,
    @JsonKey(name: 'defaultAccount') String? defaultAccount,
    @JsonKey(name: 'fromLead') String? fromLead,
    @JsonKey(name: 'createdBy') String? createdBy,
  }) = _CreatePartyRequest;

  factory CreatePartyRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePartyRequestFromJson(json);
}