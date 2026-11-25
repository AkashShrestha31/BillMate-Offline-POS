import 'package:json_annotation/json_annotation.dart';

part 'create_expense_request_params.g.dart';

enum ExpenseCategory { food, medicine, inventory, others }

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class CreateExpenseRequestParams {
  final String expenseNumber;
  final String date;
  final String category; // food, medicine, inventory, others
  final List<CreateExpenseItemParams> items;
  final double totalAmount;
  final String paymentMode;
  final String? notes;
  final List<String>? imageUrls;

  CreateExpenseRequestParams({
    required this.expenseNumber,
    required this.date,
    required this.category,
    required this.items,
    required this.totalAmount,
    required this.paymentMode,
    this.notes,
    this.imageUrls,
  });

  factory CreateExpenseRequestParams.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExpenseRequestParamsToJson(this);
}

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class CreateExpenseItemParams {
  final String description;
  final double amount;

  CreateExpenseItemParams({
    required this.description,
    required this.amount,
  });

  factory CreateExpenseItemParams.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseItemParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExpenseItemParamsToJson(this);
}
