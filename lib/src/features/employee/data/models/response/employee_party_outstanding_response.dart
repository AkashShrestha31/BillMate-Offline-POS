/// API: `GET …/parties/search?employee_id=…` with `mode: employee_id_lookup`.
class EmployeePartyOutstandingResponse {
  EmployeePartyOutstandingResponse({
    required this.success,
    this.mode,
    required this.employeeDetails,
    required this.partyDetails,
    required this.purchaseInvoices,
    required this.salesInvoices,
    required this.summary,
  });

  factory EmployeePartyOutstandingResponse.fromJson(Map<String, dynamic> json) {
    final summaryRaw = json['summary'];
    return EmployeePartyOutstandingResponse(
      success: json['success'] as bool? ?? true,
      mode: json['mode'] as String?,
      employeeDetails: EmployeePartyOutstandingEmployeeDetails.fromJson(
        Map<String, dynamic>.from(json['employee_details'] as Map),
      ),
      partyDetails: EmployeePartyOutstandingPartyDetails.fromJson(
        Map<String, dynamic>.from(json['party_details'] as Map),
      ),
      purchaseInvoices: (json['purchase_invoices'] as List<dynamic>? ?? const [])
          .map((e) => EmployeePartyOutstandingInvoiceRow.fromJson(
                Map<String, dynamic>.from(e as Map),
              ))
          .toList(),
      salesInvoices: (json['sales_invoices'] as List<dynamic>? ?? const [])
          .map((e) => EmployeePartyOutstandingInvoiceRow.fromJson(
                Map<String, dynamic>.from(e as Map),
              ))
          .toList(),
      summary: summaryRaw is Map
          ? EmployeePartyOutstandingSummary.fromJson(
              Map<String, dynamic>.from(summaryRaw as Map),
            )
          : EmployeePartyOutstandingSummary.empty(),
    );
  }

  final bool success;
  final String? mode;
  final EmployeePartyOutstandingEmployeeDetails employeeDetails;
  final EmployeePartyOutstandingPartyDetails partyDetails;
  final List<EmployeePartyOutstandingInvoiceRow> purchaseInvoices;
  /// Sales (e.g. SINV) lines when API returns `sales_invoices` instead of / in addition to purchases.
  final List<EmployeePartyOutstandingInvoiceRow> salesInvoices;
  final EmployeePartyOutstandingSummary summary;
}

double _parseDouble(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString().trim()) ?? 0;
}

class EmployeePartyOutstandingEmployeeDetails {
  EmployeePartyOutstandingEmployeeDetails({
    required this.employeeId,
    this.employeeCode,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.hireDate,
    this.department,
    this.position,
    this.employmentType,
    this.employmentStatus,
    this.basicSalary = 0,
    this.hourlyRate = 0,
    this.workingHoursPerDay = 0,
    this.workingDaysPerWeek,
    this.managerId,
    this.partyId,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.bankAccountNumber,
    this.bankName,
    this.nationalId,
    this.taxId,
    this.profileImage,
    this.notes,
    this.isActive = true,
    this.created,
    this.modified,
  });

  factory EmployeePartyOutstandingEmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeePartyOutstandingEmployeeDetails(
      employeeId: (json['employee_id'] as num).toInt(),
      employeeCode: json['employee_code'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      hireDate: json['hire_date'] as String?,
      department: json['department'] as String?,
      position: json['position'] as String?,
      employmentType: json['employment_type'] as String?,
      employmentStatus: json['employment_status'] as String?,
      basicSalary: _parseDouble(json['basic_salary']),
      hourlyRate: _parseDouble(json['hourly_rate']),
      workingHoursPerDay: _parseDouble(json['working_hours_per_day']),
      workingDaysPerWeek: (json['working_days_per_week'] as num?)?.toInt(),
      managerId: (json['manager_id'] as num?)?.toInt(),
      partyId: json['party_id'] as String?,
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      bankAccountNumber: json['bank_account_number'] as String?,
      bankName: json['bank_name'] as String?,
      nationalId: json['national_id'] as String?,
      taxId: json['tax_id'] as String?,
      profileImage: json['profile_image'] as String?,
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
    );
  }

  final int employeeId;
  final String? employeeCode;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? address;
  final String? dateOfBirth;
  final String? hireDate;
  final String? department;
  final String? position;
  final String? employmentType;
  final String? employmentStatus;
  final double basicSalary;
  final double hourlyRate;
  final double workingHoursPerDay;
  final int? workingDaysPerWeek;
  final int? managerId;
  final String? partyId;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? bankAccountNumber;
  final String? bankName;
  final String? nationalId;
  final String? taxId;
  final String? profileImage;
  final String? notes;
  final bool isActive;
  final String? created;
  final String? modified;
}

class EmployeePartyOutstandingPartyDetails {
  EmployeePartyOutstandingPartyDetails({
    required this.name,
    required this.role,
    this.email,
    this.phone,
    this.address,
    this.defaultAccount,
    required this.currency,
    this.loyaltyProgram,
    this.loyaltyPoints = 0,
    this.outstandingAmount = 0,
    this.fromLead,
    this.image,
    required this.created,
    required this.modified,
    this.createdBy,
    this.modifiedBy,
  });

  factory EmployeePartyOutstandingPartyDetails.fromJson(Map<String, dynamic> json) {
    return EmployeePartyOutstandingPartyDetails(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      defaultAccount: json['defaultAccount'] as String?,
      currency: json['currency'] as String? ?? 'NPR',
      loyaltyProgram: json['loyaltyProgram'] as String?,
      loyaltyPoints: json['loyaltyPoints'] as num? ?? 0,
      outstandingAmount: _parseDouble(json['outstandingAmount'] ?? json['outstanding_amount']),
      fromLead: json['fromLead'] as String?,
      image: json['image'] as String?,
      created: json['created'] as String? ?? '',
      modified: json['modified'] as String? ?? '',
      createdBy: json['createdBy'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
    );
  }

  final String name;
  final String role;
  final String? email;
  final String? phone;
  final String? address;
  final String? defaultAccount;
  final String currency;
  final String? loyaltyProgram;
  final num loyaltyPoints;
  final double outstandingAmount;
  final String? fromLead;
  final String? image;
  final String created;
  final String modified;
  final String? createdBy;
  final String? modifiedBy;
}

class EmployeePartyOutstandingInvoiceRow {
  EmployeePartyOutstandingInvoiceRow({
    required this.invoiceName,
    required this.party,
    this.grandTotal = 0,
    required this.date,
    required this.status,
    this.outstandingAmount = 0,
    required this.currency,
    required this.created,
    this.items = const [],
    this.itemsSummary,
  });

  factory EmployeePartyOutstandingInvoiceRow.fromJson(Map<String, dynamic> json) {
    return EmployeePartyOutstandingInvoiceRow(
      invoiceName: json['invoice_name'] as String? ?? '',
      party: json['party'] as String? ?? '',
      grandTotal: _parseDouble(json['grand_total']),
      date: json['date'] as String? ?? '',
      status: json['status'] as String? ?? '',
      outstandingAmount: _parseDouble(json['outstanding_amount']),
      currency: json['currency'] as String? ?? 'NPR',
      created: json['created'] as String? ?? '',
      items: (json['items'] as List<dynamic>? ?? const [])
          .map((e) => EmployeePartyOutstandingInvoiceItem.fromJson(
                Map<String, dynamic>.from(e as Map),
              ))
          .toList(),
      itemsSummary: json['items_summary'] is Map<String, dynamic>
          ? EmployeePartyOutstandingItemsSummary.fromJson(
              Map<String, dynamic>.from(json['items_summary'] as Map),
            )
          : null,
    );
  }

  final String invoiceName;
  final String party;
  final double grandTotal;
  final String date;
  final String status;
  final double outstandingAmount;
  final String currency;
  final String created;
  final List<EmployeePartyOutstandingInvoiceItem> items;
  final EmployeePartyOutstandingItemsSummary? itemsSummary;
}

class EmployeePartyOutstandingInvoiceItem {
  EmployeePartyOutstandingInvoiceItem({
    required this.item,
    this.quantity = 0,
    this.amount = 0,
  });

  factory EmployeePartyOutstandingInvoiceItem.fromJson(Map<String, dynamic> json) {
    return EmployeePartyOutstandingInvoiceItem(
      item: json['item'] as String? ?? '',
      quantity: _parseDouble(json['quantity']),
      amount: _parseDouble(json['amount']),
    );
  }

  final String item;
  final double quantity;
  final double amount;
}

class EmployeePartyOutstandingItemsSummary {
  EmployeePartyOutstandingItemsSummary({
    this.totalItems = 0,
    this.totalQuantity = 0,
    this.totalAmount = 0,
  });

  factory EmployeePartyOutstandingItemsSummary.fromJson(Map<String, dynamic> json) {
    return EmployeePartyOutstandingItemsSummary(
      totalItems: (json['total_items'] as num?)?.toInt() ?? 0,
      totalQuantity: _parseDouble(json['total_quantity']),
      totalAmount: _parseDouble(json['total_amount']),
    );
  }

  final int totalItems;
  final double totalQuantity;
  final double totalAmount;
}

class EmployeePartyOutstandingSummary {
  EmployeePartyOutstandingSummary({
    this.totalPurchaseInvoices = 0,
    this.totalPurchaseAmount = 0,
    this.totalSalesInvoices = 0,
    this.totalSalesAmount = 0,
    this.totalOutstandingAmount = 0,
    this.totalItems = 0,
    this.totalItemsQuantity = 0,
    this.totalItemsAmount = 0,
  });

  factory EmployeePartyOutstandingSummary.empty() => EmployeePartyOutstandingSummary();

  factory EmployeePartyOutstandingSummary.fromJson(Map<String, dynamic> json) {
    return EmployeePartyOutstandingSummary(
      totalPurchaseInvoices: (json['total_purchase_invoices'] as num?)?.toInt() ?? 0,
      totalPurchaseAmount: _parseDouble(json['total_purchase_amount']),
      totalSalesInvoices: (json['total_sales_invoices'] as num?)?.toInt() ?? 0,
      totalSalesAmount: _parseDouble(json['total_sales_amount']),
      totalOutstandingAmount: _parseDouble(json['total_outstanding_amount']),
      totalItems: (json['total_items'] as num?)?.toInt() ?? 0,
      totalItemsQuantity: _parseDouble(json['total_items_quantity']),
      totalItemsAmount: _parseDouble(json['total_items_amount']),
    );
  }

  final int totalPurchaseInvoices;
  final double totalPurchaseAmount;
  final int totalSalesInvoices;
  final double totalSalesAmount;
  final double totalOutstandingAmount;
  final int totalItems;
  final double totalItemsQuantity;
  final double totalItemsAmount;
}
