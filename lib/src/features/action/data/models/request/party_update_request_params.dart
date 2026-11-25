import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_update_request_params.freezed.dart';
part 'party_update_request_params.g.dart';

// Request Model
@freezed
class PartyUpdateRequestParams with _$PartyUpdateRequestParams {
  const factory PartyUpdateRequestParams({
    @JsonKey(name: 'old_name') required String oldName,
    @JsonKey(name: 'new_name') required String newName,
    @JsonKey(name: 'update_all_references') required bool updateAllReferences,
    required String modifiedBy,
  }) = _PartyUpdateRequestParams;

  factory PartyUpdateRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PartyUpdateRequestParamsFromJson(json);
}
