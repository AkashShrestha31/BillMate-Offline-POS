import 'package:freezed_annotation/freezed_annotation.dart';

import 'denomination_request_item.dart';

part 'close_register_request.freezed.dart';
part 'close_register_request.g.dart';

@freezed
class CloseRegisterRequest with _$CloseRegisterRequest {
  const factory CloseRegisterRequest({
    @JsonKey(name: 'register_id') required int registerId,
    @JsonKey(name: 'shift_date') required String shiftDate,
    @JsonKey(name: 'closing_amount') required double closingAmount,
    @JsonKey(name: 'closing_note') String? closingNote,
    @JsonKey(name: 'closed_by') required String closedBy,
    @JsonKey(name: 'denominations', includeIfNull: false) List<DenominationRequestItem>? denominations,
  }) = _CloseRegisterRequest;

  factory CloseRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$CloseRegisterRequestFromJson(json);
}
