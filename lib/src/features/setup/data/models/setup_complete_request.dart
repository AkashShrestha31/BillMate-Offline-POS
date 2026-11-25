import 'package:hotel/src/features/org/domain/organization_business_type.dart';

/// Payload aligned with POST `/api/setup/complete/`.
class SetupCompleteRequest {
  const SetupCompleteRequest({
    required this.organizationName,
    required this.companyName,
    required this.fullName,
    required this.email,
    required this.password,
    required this.country,
    required this.currency,
    required this.bankName,
    required this.chartOfAccounts,
    required this.fiscalYearStart,
    required this.fiscalYearEnd,
    required this.organizationCode,
    this.businessType = OrganizationBusinessType.defaultCode,
    this.defaultTaxRate = 13,
    this.taxMode = 'exclusive',
    this.taxKind = 'vat',
    this.taxIdLabel,
    this.taxIdNumber,
    this.logo,
  });

  final String organizationName;
  /// 6-character code shown on PDF and used on the organization connect screen.
  final String organizationCode;
  final String companyName;
  final String businessType;
  final String fullName;
  final String email;
  final String password;
  final String country;
  final String currency;
  final String bankName;
  final String chartOfAccounts;
  final String fiscalYearStart;
  final String fiscalYearEnd;
  final double defaultTaxRate;
  final String taxMode;
  final String taxKind;
  final String? taxIdLabel;
  final String? taxIdNumber;
  /// Optional organization profile image (`data:image/...;base64,...`).
  final String? logo;

  String get organizationSlug =>
      organizationName.replaceAll(RegExp(r'\s+'), '').trim();

  Map<String, dynamic> toJson() => {
        'organizationCode': organizationCode,
        'organizationName': organizationName,
        'companyName': companyName,
        'businessType': businessType,
        'business_type': businessType,
        'fullName': fullName,
        'email': email,
        'password': password,
        'country': country,
        'currency': currency,
        'bankName': bankName,
        'chartOfAccounts': chartOfAccounts,
        'fiscalYearStart': fiscalYearStart,
        'fiscalYearEnd': fiscalYearEnd,
      };

  static const defaultCountries = ['Nepal', 'India', 'United States'];
  static const defaultCurrencies = ['NPR', 'USD', 'INR', 'EUR', 'GBP'];
  static const chartOfAccountsOptions = ['Standard'];
}
