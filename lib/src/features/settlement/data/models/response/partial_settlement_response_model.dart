import 'package:json_annotation/json_annotation.dart';

part 'partial_settlement_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PartialSettlementResponseModel {
  final bool success;
  final String message;
  final PartialSettlementSummary summary;
  final List<PartialSettlementPayment> payments;
  final List<PartialSettlementInvoice> settledInvoices;
  final PartialSettlementDetails settlementDetails;

  PartialSettlementResponseModel({
    required this.success,
    required this.message,
    required this.summary,
    required this.payments,
    required this.settledInvoices,
    required this.settlementDetails,
  });

  /// Factory method to create an instance from a JSON map
  factory PartialSettlementResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartialSettlementResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PartialSettlementResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PartialSettlementSummary {
  final double requestedAmount;
  final double totalAmountSettled;
  final double remainingAmount;
  final int paymentsCreated;
  final int invoicesAffected;
  final int fullySettledInvoices;
  final int partiallySettledInvoices;

  PartialSettlementSummary({
    required this.requestedAmount,
    required this.totalAmountSettled,
    required this.remainingAmount,
    required this.paymentsCreated,
    required this.invoicesAffected,
    required this.fullySettledInvoices,
    required this.partiallySettledInvoices,
  });

  /// Factory method to create an instance from a JSON map
  factory PartialSettlementSummary.fromJson(Map<String, dynamic> json) =>
      _$PartialSettlementSummaryFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PartialSettlementSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PartialSettlementPayment {
  final String paymentName;
  final String type;
  final double amount;
  final String invoice;

  PartialSettlementPayment({
    required this.paymentName,
    required this.type,
    required this.amount,
    required this.invoice,
  });

  /// Factory method to create an instance from a JSON map
  factory PartialSettlementPayment.fromJson(Map<String, dynamic> json) =>
      _$PartialSettlementPaymentFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PartialSettlementPaymentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PartialSettlementInvoice {
  final String type;
  final String invoice;

  /// Omitted in some party-wide settlement responses; treat as unknown / zero.
  final double? originalOutstanding;

  final double settledAmount;
  final double remainingOutstanding;
  final bool fullySettled;

  PartialSettlementInvoice({
    required this.type,
    required this.invoice,
    this.originalOutstanding,
    required this.settledAmount,
    required this.remainingOutstanding,
    required this.fullySettled,
  });

  /// Factory method to create an instance from a JSON map
  factory PartialSettlementInvoice.fromJson(Map<String, dynamic> json) =>
      _$PartialSettlementInvoiceFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PartialSettlementInvoiceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class PartialSettlementDetails {
  final String party;
  final String paymentMethod;
  final String paymentDate;
  final String paymentAccount;
  final String? referenceId;
  final String? referenceDate;
  final String? clearanceDate;
  final String? notes;
  final String invoiceType;
  final String createdBy;
  final String createdAt;

  PartialSettlementDetails({
    required this.party,
    required this.paymentMethod,
    required this.paymentDate,
    required this.paymentAccount,
    this.referenceId,
    this.referenceDate,
    this.clearanceDate,
    this.notes,
    required this.invoiceType,
    required this.createdBy,
    required this.createdAt,
  });

  /// Party-wide API may use [party_account] and nest method/account under [payments][0].
  factory PartialSettlementDetails.fromJson(Map<String, dynamic> json) {
    final payments = json['payments'];
    var paymentMethod = json['payment_method'] as String? ?? '';
    var paymentAccount =
        json['payment_account'] as String? ?? json['party_account'] as String? ?? '';
    if (paymentMethod.isEmpty && payments is List && payments.isNotEmpty) {
      final p0 = payments.first;
      if (p0 is Map<String, dynamic>) {
        paymentMethod = p0['payment_method'] as String? ?? paymentMethod;
        if (paymentAccount.isEmpty) {
          paymentAccount =
              p0['account'] as String? ?? p0['payment_account'] as String? ?? paymentAccount;
        }
      }
    }
    return PartialSettlementDetails(
      party: json['party'] as String,
      paymentMethod: paymentMethod,
      paymentDate: json['payment_date'] as String,
      paymentAccount: paymentAccount,
      referenceId: json['reference_id'] as String?,
      referenceDate: json['reference_date'] as String?,
      clearanceDate: json['clearance_date'] as String?,
      notes: json['notes'] as String?,
      invoiceType: json['invoice_type'] as String,
      createdBy: json['created_by'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PartialSettlementDetailsToJson(this);
}
