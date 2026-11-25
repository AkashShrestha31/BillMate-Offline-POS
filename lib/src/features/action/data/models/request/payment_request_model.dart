import 'package:json_annotation/json_annotation.dart';

part 'payment_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake,includeIfNull: false)
class PaymentRequestModel {
  final String? paymentName;
  final String? party;
  final String? date;
  final String? paymentType;
  final String? account;
  final String? paymentAccount;
  final String? paymentMethod;
  final String? clearanceDate;
  final String? referenceId;
  final String? referenceDate;
  final double? amount;
  final String? writeoff;
  final String? attachment;
  final String? referenceType;
  final String? modifiedBy;

  const PaymentRequestModel({
     this.paymentName,
     this.party,
     this.date,
     this.paymentType,
     this.account,
     this.paymentAccount,
     this.paymentMethod,
     this.clearanceDate,
    this.referenceId,
    this.referenceDate,
     this.amount,
    this.writeoff,
    this.attachment,
    this.referenceType,
    this.modifiedBy,
  });

  /// Factory method to create an instance from a JSON map
  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PaymentRequestModelToJson(this);

  /// Copy with method for creating modified instances
  PaymentRequestModel copyWith({
    String? paymentName,
    String? party,
    String? date,
    String? paymentType,
    String? account,
    String? paymentAccount,
    String? paymentMethod,
    String? clearanceDate,
    String? referenceId,
    String? referenceDate,
    double? amount,
    String? writeoff,
    String? attachment,
    String? referenceType,
    String? modifiedBy,
  }) {
    return PaymentRequestModel(
      paymentName: paymentName ?? this.paymentName,
      party: party ?? this.party,
      date: date ?? this.date,
      paymentType: paymentType ?? this.paymentType,
      account: account ?? this.account,
      paymentAccount: paymentAccount ?? this.paymentAccount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      clearanceDate: clearanceDate ?? this.clearanceDate,
      referenceId: referenceId ?? this.referenceId,
      referenceDate: referenceDate ?? this.referenceDate,
      amount: amount ?? this.amount,
      writeoff: writeoff ?? this.writeoff,
      attachment: attachment ?? this.attachment,
      referenceType: referenceType ?? this.referenceType,
      modifiedBy: modifiedBy ?? this.modifiedBy,
    );
  }
}
