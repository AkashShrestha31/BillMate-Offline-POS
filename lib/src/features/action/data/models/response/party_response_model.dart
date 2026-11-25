import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_response_model.freezed.dart';
part 'party_response_model.g.dart';

@freezed
class PartyResponseModel with _$PartyResponseModel {
  const factory PartyResponseModel({
    required List<PartyItem>? data,
    required Pagination pagination,
  }) = _PartyResponseModel;

  factory PartyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartyResponseModelFromJson(json);
}

/// Nested on employee parties when the list API returns `employeeDetails`.
class PartyItemEmployeeDetails {
  const PartyItemEmployeeDetails({
    this.employeeId,
    this.employmentStatus,
    this.isActive,
  });

  final int? employeeId;
  final String? employmentStatus;
  final bool? isActive;

  factory PartyItemEmployeeDetails.fromJson(Map<String, dynamic> json) {
    return PartyItemEmployeeDetails(
      employeeId: (json['employee_id'] as num?)?.toInt(),
      employmentStatus: json['employment_status'] as String?,
      isActive: _partyItemNullableBoolFromJson(json['is_active']),
    );
  }
}

PartyItemEmployeeDetails? _partyItemEmployeeDetailsFromJson(dynamic value) {
  if (value is! Map) return null;
  return PartyItemEmployeeDetails.fromJson(Map<String, dynamic>.from(value));
}

bool? _partyItemNullableBoolFromJson(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized.isEmpty) return null;
    if (normalized == 'true' ||
        normalized == '1' ||
        normalized == 'yes' ||
        normalized == 'y' ||
        normalized == 'active') {
      return true;
    }
    if (normalized == 'false' ||
        normalized == '0' ||
        normalized == 'no' ||
        normalized == 'n' ||
        normalized == 'inactive' ||
        normalized == 'terminated') {
      return false;
    }
  }
  return null;
}

@freezed
class PartyItem with _$PartyItem {
  const factory PartyItem({
    int? id,
    required String? name,
    String? phone,
    @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
    required double? outstandingAmount,
    required String? role,
    String? currency,
    @JsonKey(
      name: 'employeeDetails',
      fromJson: _partyItemEmployeeDetailsFromJson,
      includeToJson: false,
    )
    PartyItemEmployeeDetails? employeeDetails,
  }) = _PartyItem;

  factory PartyItem.fromJson(Map<String, dynamic> json) =>
      _$PartyItemFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    required int? current_page,
    required int? per_page,
    required int? total_pages,
    required int? total_rows,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

// Helper function for type conversion
double _stringToDouble(dynamic value) {
  if (value == null) return 0.0;
  return double.tryParse(value.toString()) ?? 0.0;
}

int? _partyItemIdFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}
