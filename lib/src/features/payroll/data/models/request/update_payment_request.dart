import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_payment_request.freezed.dart';
part 'update_payment_request.g.dart';

@freezed
class UpdatePaymentRequest with _$UpdatePaymentRequest {
  const factory UpdatePaymentRequest({
    @JsonKey(name: 'payroll_id') required int payrollId,
    @JsonKey(name: 'payment_date') required String paymentDate,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'bank_reference') String? bankReference,
    String? notes,
  }) = _UpdatePaymentRequest;

  factory UpdatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentRequestFromJson(json);
}
