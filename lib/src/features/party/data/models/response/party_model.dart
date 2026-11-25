/// Party entity parsed from API (`image`, `imageUrl`, `defaultAccount`, etc.).
class PartyModel {
  const PartyModel({
    this.id,
    this.image,
    this.imageUrl,
    required this.name,
    required this.role,
    this.email,
    this.phone,
    this.address,
    this.defaultAccount,
    this.currency,
    this.loyaltyProgram,
    this.loyaltyPoints,
    this.outstandingAmount,
    this.fromLead,
    this.created,
    this.modified,
    this.createdBy,
    this.modifiedBy,
    this.totalSalesInvoices,
    this.totalSalesAmount,
    this.totalPurchaseInvoices,
    this.totalPurchaseAmount,
    this.totalPayments,
    this.totalPaymentAmount,
    this.totalAdvance,
    this.employeeDetails,
  });

  final String? id;
  final String? image;
  final String? imageUrl;
  final String name;
  final String role;
  final String? email;
  final String? phone;
  final String? address;
  final String? defaultAccount;
  final String? currency;
  final String? loyaltyProgram;
  final int? loyaltyPoints;
  final double? outstandingAmount;
  final String? fromLead;
  final String? created;
  final String? modified;
  final String? createdBy;
  final String? modifiedBy;
  final int? totalSalesInvoices;
  final double? totalSalesAmount;
  final int? totalPurchaseInvoices;
  final double? totalPurchaseAmount;
  final int? totalPayments;
  final double? totalPaymentAmount;
  /// Employee-party list only; sum of [Advance salary] purchase lines this month.
  final double? totalAdvance;
  /// Nested profile when API returns `employeeDetails` (employee tab).
  final PartyEmployeeDetails? employeeDetails;

  factory PartyModel.fromJson(Map<String, dynamic> json) {
    final edRaw = json['employeeDetails'];
    return PartyModel(
      id: _nullablePartyIdFromJson(json['id']),
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String? ?? json['imageUrl'] as String?,
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      defaultAccount: json['defaultAccount'] as String?,
      currency: json['currency'] as String?,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      loyaltyPoints: _nullableIntFromJson(json['loyaltyPoints']),
      outstandingAmount: _nullableDoubleFromJson(json['outstandingAmount']),
      fromLead: json['fromLead'] as String?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      createdBy: json['createdBy'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      totalSalesInvoices: (json['totalSalesInvoices'] as num?)?.toInt(),
      totalSalesAmount: (json['totalSalesAmount'] as num?)?.toDouble(),
      totalPurchaseInvoices: (json['totalPurchaseInvoices'] as num?)?.toInt(),
      totalPurchaseAmount: (json['totalPurchaseAmount'] as num?)?.toDouble(),
      totalPayments: (json['totalPayments'] as num?)?.toInt(),
      totalPaymentAmount: (json['totalPaymentAmount'] as num?)?.toDouble(),
      totalAdvance: _nullableDoubleFromJson(json['totalAdvance']),
      employeeDetails: edRaw is Map
          ? PartyEmployeeDetails.fromJson(Map<String, dynamic>.from(edRaw))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'image_url': imageUrl,
        'name': name,
        'role': role,
        'email': email,
        'phone': phone,
        'address': address,
        'defaultAccount': defaultAccount,
        'currency': currency,
        'loyaltyProgram': loyaltyProgram,
        'loyaltyPoints': loyaltyPoints,
        'outstandingAmount': outstandingAmount,
        'fromLead': fromLead,
        'created': created,
        'modified': modified,
        'createdBy': createdBy,
        'modifiedBy': modifiedBy,
        'totalSalesInvoices': totalSalesInvoices,
        'totalSalesAmount': totalSalesAmount,
        'totalPurchaseInvoices': totalPurchaseInvoices,
        'totalPurchaseAmount': totalPurchaseAmount,
        'totalPayments': totalPayments,
        'totalPaymentAmount': totalPaymentAmount,
        'totalAdvance': totalAdvance,
        'employeeDetails': employeeDetails?.toJson(),
      };

  PartyModel copyWith({
    String? id,
    String? image,
    String? imageUrl,
    String? name,
    String? role,
    String? email,
    String? phone,
    String? address,
    String? defaultAccount,
    String? currency,
    String? loyaltyProgram,
    int? loyaltyPoints,
    double? outstandingAmount,
    String? fromLead,
    String? created,
    String? modified,
    String? createdBy,
    String? modifiedBy,
    int? totalSalesInvoices,
    double? totalSalesAmount,
    int? totalPurchaseInvoices,
    double? totalPurchaseAmount,
    int? totalPayments,
    double? totalPaymentAmount,
    double? totalAdvance,
    PartyEmployeeDetails? employeeDetails,
  }) {
    return PartyModel(
      id: id ?? this.id,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      defaultAccount: defaultAccount ?? this.defaultAccount,
      currency: currency ?? this.currency,
      loyaltyProgram: loyaltyProgram ?? this.loyaltyProgram,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      outstandingAmount: outstandingAmount ?? this.outstandingAmount,
      fromLead: fromLead ?? this.fromLead,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      totalSalesInvoices: totalSalesInvoices ?? this.totalSalesInvoices,
      totalSalesAmount: totalSalesAmount ?? this.totalSalesAmount,
      totalPurchaseInvoices:
          totalPurchaseInvoices ?? this.totalPurchaseInvoices,
      totalPurchaseAmount: totalPurchaseAmount ?? this.totalPurchaseAmount,
      totalPayments: totalPayments ?? this.totalPayments,
      totalPaymentAmount: totalPaymentAmount ?? this.totalPaymentAmount,
      totalAdvance: totalAdvance ?? this.totalAdvance,
      employeeDetails: employeeDetails ?? this.employeeDetails,
    );
  }
}

/// Optional nested object on employee-linked parties (`role=employee` list).
class PartyEmployeeDetails {
  const PartyEmployeeDetails({
    this.employeeId,
    this.employeeCode,
    this.firstName,
    this.lastName,
    this.fullName,
    this.department,
    this.position,
    this.employmentType,
    this.employmentStatus,
    this.basicSalary,
    this.hireDate,
    this.isActive,
  });

  final int? employeeId;
  final String? employeeCode;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? department;
  final String? position;
  final String? employmentType;
  final String? employmentStatus;
  final double? basicSalary;
  final String? hireDate;
  final bool? isActive;

  factory PartyEmployeeDetails.fromJson(Map<String, dynamic> json) {
    return PartyEmployeeDetails(
      employeeId: (json['employee_id'] as num?)?.toInt(),
      employeeCode: json['employee_code'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fullName: json['full_name'] as String?,
      department: json['department'] as String?,
      position: json['position'] as String?,
      employmentType: json['employment_type'] as String?,
      employmentStatus: json['employment_status'] as String?,
      basicSalary: _nullableDoubleFromJson(json['basic_salary']),
      hireDate: json['hire_date'] as String?,
      isActive: _nullableBoolFromJson(json['is_active']),
    );
  }

  Map<String, dynamic> toJson() => {
        'employee_id': employeeId,
        'employee_code': employeeCode,
        'first_name': firstName,
        'last_name': lastName,
        'full_name': fullName,
        'department': department,
        'position': position,
        'employment_type': employmentType,
        'employment_status': employmentStatus,
        'basic_salary': basicSalary,
        'hire_date': hireDate,
        'is_active': isActive,
      };
}

/// API may send party `id` as int, string, or num.
String? _nullablePartyIdFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) {
    final t = value.trim();
    return t.isEmpty ? null : t;
  }
  if (value is num) return value.toString();
  return value.toString();
}

int? _nullableIntFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _nullableDoubleFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

bool? _nullableBoolFromJson(dynamic value) {
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

extension PartyModelDisplayX on PartyModel {
  /// Prefer full [imageUrl]; then absolute http(s) [image] (DB path / URL).
  String? get displayImageUrl {
    final url = imageUrl?.trim();
    if (url != null && url.isNotEmpty) return url;
    final raw = image?.trim();
    if (raw != null &&
        raw.isNotEmpty &&
        (raw.startsWith('http://') || raw.startsWith('https://'))) {
      return raw;
    }
    return null;
  }
}
