// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashRegisterModelImpl _$$CashRegisterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CashRegisterModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      shiftDate: json['shift_date'] as String?,
      openingTime: json['opening_time'] as String?,
      closingTime: json['closing_time'] as String?,
      openingAmount: (json['opening_amount'] as num?)?.toDouble(),
      closingAmount: (json['closing_amount'] as num?)?.toDouble(),
      expectedAmount: (json['expected_amount'] as num?)?.toDouble(),
      difference: (json['difference'] as num?)?.toDouble(),
      totalSales: (json['total_sales'] as num?)?.toDouble(),
      totalCashIn: (json['total_cash_in'] as num?)?.toDouble(),
      totalCashOut: (json['total_cash_out'] as num?)?.toDouble(),
      openingNote: json['opening_note'] as String?,
      closingNote: json['closing_note'] as String?,
      openedBy: json['opened_by'] as String?,
      closedBy: json['closed_by'] as String?,
      openingDenominations: (json['opening_denominations'] as List<dynamic>?)
          ?.map((e) => DenominationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      closingDenominations: (json['closing_denominations'] as List<dynamic>?)
          ?.map((e) => DenominationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDenominations: (json['total_denominations'] as num?)?.toDouble(),
      varianceNote: json['variance_note'] as String?,
      cashMovements: (json['cash_movements'] as List<dynamic>?)
          ?.map((e) => CashMovementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CashRegisterModelImplToJson(
        _$CashRegisterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'shift_date': instance.shiftDate,
      'opening_time': instance.openingTime,
      'closing_time': instance.closingTime,
      'opening_amount': instance.openingAmount,
      'closing_amount': instance.closingAmount,
      'expected_amount': instance.expectedAmount,
      'difference': instance.difference,
      'total_sales': instance.totalSales,
      'total_cash_in': instance.totalCashIn,
      'total_cash_out': instance.totalCashOut,
      'opening_note': instance.openingNote,
      'closing_note': instance.closingNote,
      'opened_by': instance.openedBy,
      'closed_by': instance.closedBy,
      'opening_denominations': instance.openingDenominations,
      'closing_denominations': instance.closingDenominations,
      'total_denominations': instance.totalDenominations,
      'variance_note': instance.varianceNote,
      'cash_movements': instance.cashMovements,
    };
