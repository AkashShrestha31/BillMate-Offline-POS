import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_payment_response.freezed.dart';
part 'update_payment_response.g.dart';

@freezed
class UpdatePaymentResponse with _$UpdatePaymentResponse {
  const factory UpdatePaymentResponse({
    required bool success,
    required String message,
  }) = _UpdatePaymentResponse;

  factory UpdatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentResponseFromJson(json);
}
