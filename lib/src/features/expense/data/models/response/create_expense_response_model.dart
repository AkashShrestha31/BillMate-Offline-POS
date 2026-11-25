import 'package:json_annotation/json_annotation.dart';

part 'create_expense_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateExpenseResponseModel {
  final String message;
  final String? expenseNumber;
  final double? totalAmount;
  final String? status;

  CreateExpenseResponseModel({
    required this.message,
    this.expenseNumber,
    this.totalAmount,
    this.status,
  });

  factory CreateExpenseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExpenseResponseModelToJson(this);
}
