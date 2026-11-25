import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_party_request.freezed.dart';
part 'update_party_request.g.dart';

@freezed
class UpdatePartyRequest with _$UpdatePartyRequest {
  const factory UpdatePartyRequest({
    required String name,
    @JsonKey(name: 'new_name') String? newName,
    String? role,
    String? email,
    String? phone,
    String? address,
    String? currency,
    String? loyaltyProgram,
    int? loyaltyPoints,
    String? outstandingAmount,
    String? defaultAccount,
    String? fromLead,
    String? modifiedBy,
  }) = _UpdatePartyRequest;

  factory UpdatePartyRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePartyRequestFromJson(json);
}
