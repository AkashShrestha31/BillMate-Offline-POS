import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconcile_party_request_params.freezed.dart';
part 'reconcile_party_request_params.g.dart';

@freezed
class ReconcilePartyRequestParams with _$ReconcilePartyRequestParams {
  const factory ReconcilePartyRequestParams({
    @JsonKey(name: 'party_name') required String partyName,
    @JsonKey(name: 'party_type') required String partyType,
    @JsonKey(name: 'auto_fix') required bool autoFix,
  }) = _ReconcilePartyRequestParams;

  factory ReconcilePartyRequestParams.fromJson(Map<String, dynamic> json) =>
      _$ReconcilePartyRequestParamsFromJson(json);
}
