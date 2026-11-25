// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noInternetConnection => 'No internet connection.';

  @override
  String get formatException => 'Format exception';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get signIn => 'Sign in';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get forgetPassword => 'Forgot login info?';

  @override
  String get okay => 'Okay';

  @override
  String get success => 'Success';

  @override
  String get hotel => 'hotel';

  @override
  String get errorEncountered => 'Error encountered';

  @override
  String get serverError => 'Server error';

  @override
  String get requestFailed => 'Request failed';

  @override
  String get connectionTimedOut => 'Connection timed out';

  @override
  String get password => 'Password';

  @override
  String get keepSignIn => 'Keep sign in';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get enterValidPassword => 'Enter valid password';

  @override
  String get skip => 'SKIP';

  @override
  String get pleaseWait => 'Please Wait ....';

  @override
  String get enterValidUserName => 'Enter valid user name.';

  @override
  String get userName => 'User name';

  @override
  String get or => 'Or';

  @override
  String get retry => 'Retry';

  @override
  String get error => 'Error';

  @override
  String get supportMessage => 'Please contact admin.';

  @override
  String get responseMessage404 => '404 error';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get deleteOrganizationTitle => 'Delete organization?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'Remove $name from this device. All local data for this organization will be deleted.';
  }

  @override
  String get deleteOrganizationWarning => 'This cannot be undone.';

  @override
  String get organizationDeleted => 'Organization removed';

  @override
  String get confirm => 'Confirm';

  @override
  String get done => 'Done';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get started';

  @override
  String get walkthroughDashboardTitle => 'Your whole business, at a glance';

  @override
  String get walkthroughDashboardDescription =>
      'Today\'s sales, revenue and outstanding balances — all on one clean dashboard the moment you open the app.';

  @override
  String get walkthroughOfflineTitle => 'Works even without internet';

  @override
  String get walkthroughOfflineDescription =>
      'Create invoices, log expenses and manage stock fully offline. Everything syncs automatically once you\'re back online.';

  @override
  String get walkthroughBillingTitle => 'Bill and sell in seconds';

  @override
  String get walkthroughBillingDescription =>
      'Sales and purchase invoices, table orders with kitchen tickets, and live inventory — all from one app.';

  @override
  String get walkthroughStaffTitle => 'Staff, payroll & reports';

  @override
  String get walkthroughStaffDescription =>
      'Run attendance and payroll, then export P&L statements and payslips as PDF — no extra tools needed.';

  @override
  String get walkthroughBackupTitle => 'Your data, always safe';

  @override
  String get walkthroughBackupDescription =>
      'Bank-grade security with one-tap Google Drive backups, so your records are protected and easy to restore.';

  @override
  String get walkthroughReadyTitle => 'Ready when you are';

  @override
  String get walkthroughReadyDescription =>
      'Set up your organization in minutes and start running your business smarter today. Let\'s get you started.';

  @override
  String get back => 'Back';

  @override
  String get submit => 'Submit';

  @override
  String get continueAction => 'Continue';

  @override
  String get createAction => 'Create';

  @override
  String get connectOrganizationTitle => 'Connect your Organization';

  @override
  String get connectOrganizationSubtitle =>
      'Select an organization to sign in.';

  @override
  String get selectOrganization => 'Organizations';

  @override
  String get selectOrganizationHint => 'Tap an organization to continue';

  @override
  String get noSavedOrganizationsYet =>
      'No organizations yet. Create one or use test data below.';

  @override
  String get orgConnectOnceInfo =>
      'This links the app to your business account. You only need to set it once per device.';

  @override
  String organizationCodeLabel(String code) {
    return 'Code: $code';
  }

  @override
  String get tryAgain => 'Try again';

  @override
  String get warning => 'WARNING';

  @override
  String get loading => 'Loading…';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get required => 'Required';

  @override
  String get search => 'Search';

  @override
  String get add => 'Add';

  @override
  String get edit => 'Edit';

  @override
  String get remove => 'Remove';

  @override
  String get view => 'View';

  @override
  String get export => 'Export';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'Import';

  @override
  String get refresh => 'Refresh';

  @override
  String get select => 'Select';

  @override
  String get upload => 'Upload';

  @override
  String get download => 'Download';

  @override
  String get share => 'Share';

  @override
  String get filter => 'Filter';

  @override
  String get sort => 'Sort';

  @override
  String get apply => 'Apply';

  @override
  String get reset => 'Reset';

  @override
  String get clear => 'Clear';

  @override
  String get all => 'All';

  @override
  String get none => 'None';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get grandTotal => 'Grand Total';

  @override
  String get amount => 'Amount';

  @override
  String get quantity => 'Quantity';

  @override
  String get rate => 'Rate';

  @override
  String get discount => 'Discount';

  @override
  String get paid => 'Paid';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get credit => 'Credit';

  @override
  String get cash => 'Cash';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get notes => 'Notes';

  @override
  String get description => 'Description';

  @override
  String get status => 'Status';

  @override
  String get type => 'Type';

  @override
  String get category => 'Category';

  @override
  String get party => 'Party';

  @override
  String get item => 'Item';

  @override
  String get payment => 'Payment';

  @override
  String get settlement => 'Settlement';

  @override
  String get opening => 'Opening';

  @override
  String get closing => 'Closing';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'Expense';

  @override
  String get revenue => 'Revenue';

  @override
  String get profit => 'Profit';

  @override
  String get loss => 'Loss';

  @override
  String get sales => 'Sales';

  @override
  String get purchase => 'Purchase';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get more => 'More';

  @override
  String get profile => 'Profile';

  @override
  String get operations => 'Operations';

  @override
  String get operationManagement => 'Operation management';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'Employee management';

  @override
  String get employeeManagementSubtitle => 'Staff, payroll, and attendance';

  @override
  String get report => 'Report';

  @override
  String get reportSubtitle => 'Profit & loss, statements, and analytics';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get preferences => 'Preferences';

  @override
  String get dataAndBackup => 'Data & Backup';

  @override
  String get privacyAndPolicies => 'Privacy & Policies';

  @override
  String get faq => 'FAQ';

  @override
  String get contactSupport => 'Contact support';

  @override
  String get rateUs => 'Rate us';

  @override
  String get rateUsSubtitle =>
      'Enjoying BizTrack? Leave a review on Google Play';

  @override
  String get rateUsUnavailable => 'Could not open the store. Try again later.';

  @override
  String get reportProblem => 'Report a problem';

  @override
  String get contactUs => 'Contact us';

  @override
  String get contactUsSubtitle =>
      'Describe your issue below. You can attach photos or videos, then send directly to our support email.';

  @override
  String get contactUsMessageLabel => 'Your message';

  @override
  String get contactUsMessageHint =>
      'Describe your issue, question, or feedback…';

  @override
  String get contactUsMessageRequired => 'Please describe your issue';

  @override
  String get contactUsAttachments => 'Attachments (optional)';

  @override
  String get contactUsAddPhoto => 'Add photos';

  @override
  String contactUsAddPhotoLimit(int count) {
    return 'You can attach up to $count photos';
  }

  @override
  String get contactUsVideoLimit => 'Only 1 video is allowed';

  @override
  String get contactUsAddVideo => 'Add video';

  @override
  String get contactUsSendEmail => 'Send email';

  @override
  String get contactUsNoEmailApp =>
      'No email app found on this device. Support email copied to clipboard.';

  @override
  String contactUsEmailFailed(String error) {
    return 'Could not open email: $error';
  }

  @override
  String contactUsAttachmentTooLarge(int maxMb) {
    return 'Attachment is too large (max $maxMb MB)';
  }

  @override
  String couldNotPickVideo(String error) {
    return 'Could not pick video: $error';
  }

  @override
  String get developerLabel => 'Developer';

  @override
  String get emailCopiedToClipboard => 'Email copied to clipboard';

  @override
  String get logout => 'Log out';

  @override
  String get signOut => 'Sign out';

  @override
  String get settings => 'Settings';

  @override
  String get testData => 'Test Data';

  @override
  String get loginWithTestData => 'Login with test data';

  @override
  String get loginWithTestDataSubtitle =>
      'Load demo hotel data and sign in automatically';

  @override
  String testDataLoginFailed(String error) {
    return 'Could not load test data: $error';
  }

  @override
  String get preparingTestData => 'Preparing demo data…';

  @override
  String get regionAndCurrency => 'Region & currency';

  @override
  String get reportingCurrency => 'Reporting currency';

  @override
  String get selectCurrency => 'Select currency';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · sample $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'Currency set to $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'Could not update currency: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'Setup $appName';
  }

  @override
  String get setupSubtitle =>
      'Configure your organization and accounting — stored on this device for offline use.';

  @override
  String get setupOrganizationName => 'Organization name';

  @override
  String get setupCompanyName => 'Company name';

  @override
  String get setupBusinessType => 'Business type';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => 'Hotel';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => 'Restaurant';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => 'Hotel & Restaurant';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => 'Retail / Shop';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'Cafe / Bakery';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'Bar / Pub';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'Other';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'Type: $type';
  }

  @override
  String get organizationSettings => 'Organization';

  @override
  String get editOrganizationInfo => 'Organization info';

  @override
  String get editOrganizationInfoSubtitle =>
      'Update how this business appears in the app. The organization code cannot be changed.';

  @override
  String get organizationCode => 'Organization code';

  @override
  String get organizationCodeReadOnly => 'This code is fixed after setup.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'Organization info saved';

  @override
  String get organizationInfoLoadFailed => 'Could not load organization info';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'Could not save organization info: $error';
  }

  @override
  String get organizationTabGeneral => 'General';

  @override
  String get organizationTabRegional => 'Regional & fiscal';

  @override
  String get organizationRegionalSubtitle =>
      'Country, reporting currency, and fiscal year dates.';

  @override
  String get organizationTabAccounting => 'Accounting';

  @override
  String get organizationAccountingSubtitle =>
      'Invoice and amount display settings.';

  @override
  String get defaultTaxRate => 'Default tax rate';

  @override
  String get taxIdLabel => 'Tax ID label';

  @override
  String taxIdNumberOptional(String label) {
    return '$label number (optional)';
  }

  @override
  String taxIdNumberHint(String example) {
    return 'e.g. $example';
  }

  @override
  String get taxMode => 'Tax calculation';

  @override
  String get taxModeExclusive => 'Exclusive';

  @override
  String get taxModeInclusive => 'Inclusive';

  @override
  String get taxRateRange => 'Enter a rate between 0 and 100';

  @override
  String get applyTaxOnInvoice => 'Apply tax';

  @override
  String applyTaxOnInvoiceSubtitle(String rate) {
    return 'Add $rate tax to this invoice';
  }

  @override
  String taxAmountLine(String rate) {
    return 'Tax ($rate)';
  }

  @override
  String get taxIdLabelPickerSubtitle => 'Business tax ID labels by country';

  @override
  String get searchCountryOrLabel => 'Search country or label';

  @override
  String get noSearchResults => 'No matches found';

  @override
  String get displayPrecision => 'Display precision';

  @override
  String get displayPrecisionRange => 'Enter a number from 0 to 5';

  @override
  String get enableInvoiceReturns => 'Enable invoice returns';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'Allow creating returns from paid invoices.';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get setupFullName => 'Full name';

  @override
  String get setupConfirmPassword => 'Confirm password';

  @override
  String get setupBankName => 'Bank name';

  @override
  String get banksSettingsTitle => 'Banks';

  @override
  String get banksSettingsSubtitle => 'Add banks and view bank reports';

  @override
  String banksSettingsSelected(String name) {
    return 'Selected: $name';
  }

  @override
  String get banksAddTitle => 'New bank';

  @override
  String get banksEditTitle => 'Edit bank';

  @override
  String get banksAccountNumber => 'Account number';

  @override
  String get banksAccountHolder => 'Account holder';

  @override
  String get banksOptional => 'Optional';

  @override
  String get banksEmpty => 'No banks yet. Add the bank you use for payments.';

  @override
  String get banksSaved => 'Bank saved';

  @override
  String get banksDeleted => 'Bank deleted';

  @override
  String banksSelected(String name) {
    return '$name is now the selected bank';
  }

  @override
  String get banksSelectedBadge => 'Selected';

  @override
  String get banksUseSelected => 'Use as selected bank';

  @override
  String get banksViewReport => 'View report';

  @override
  String get banksReportIn => 'In';

  @override
  String get banksReportOut => 'Out';

  @override
  String get banksReportNet => 'Net';

  @override
  String get banksReportActivity => 'Activity';

  @override
  String get banksReportEmpty => 'No payments for this bank yet';

  @override
  String get banksAtLeastOne => 'Keep at least one bank';

  @override
  String get banksLinkedAccount => 'Bank account';

  @override
  String get banksPickBank => 'Select bank';

  @override
  String get banksNoBanksYet => 'Add a bank in Settings first';

  @override
  String get setupRegionStepTitle => 'Region & currency';

  @override
  String get setupOrganizationStepTitle => 'Organization';

  @override
  String get setupOrganizationStepSubtitle =>
      'How your business appears in the app';

  @override
  String get setupAdminStepTitle => 'Admin account';

  @override
  String get setupAdminStepSubtitle => 'Primary user for this installation';

  @override
  String get setupAccountingStepTitle => 'Accounting';

  @override
  String get setupAccountingStepSubtitle =>
      'Bank, chart of accounts, and fiscal year';

  @override
  String get setupCompleteSetup => 'Complete setup';

  @override
  String fieldRequired(String field) {
    return '$field is required';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'Enter a valid email address';

  @override
  String passwordMinLength(int min) {
    return 'Password must be at least $min characters';
  }

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get setupFixValidationErrors =>
      'Please fix the errors below to continue';

  @override
  String get setupCompleteSuccess => 'Setup completed successfully';

  @override
  String get setupCompleteWithPdfSuccess =>
      'Setup complete. Login credentials PDF saved to Downloads.';

  @override
  String setupPdfFailed(String error) {
    return 'Setup finished, but the PDF could not be saved: $error';
  }

  @override
  String get setupFailed => 'Setup could not be completed. Please try again.';

  @override
  String setupFailedWithDetails(String error) {
    return 'Setup failed: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'Locale and reporting currency.';

  @override
  String get country => 'Country';

  @override
  String get currency => 'Currency';

  @override
  String get selectCountry => 'Select country';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get languageChangeLaterHint => 'You can change it later from settings';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'Choose how you\'d like to use $appName. You can change this later in Settings.';
  }

  @override
  String get searchLanguages => 'Search languages';

  @override
  String get languageSuggestedBadge => 'SUGGESTED';

  @override
  String continueInLanguage(String languageName) {
    return 'Continue in $languageName';
  }

  @override
  String get noLanguageMatches => 'No matches';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'No language matches \"$query\"';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get darkModeSubtitle => 'Use a dark background across the app';

  @override
  String get darkModeSystemSubtitle => 'Follows your device theme';

  @override
  String languageUpdated(String name) {
    return 'Language set to $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'Could not update language: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'Welcome to $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'Please install the latest version of $appName to continue.';
  }

  @override
  String generatedByApp(String appName) {
    return 'Generated by $appName';
  }

  @override
  String whatIsApp(String appName) {
    return 'What is $appName?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName helps you manage sales and purchase invoices, parties (customers and suppliers), stock, payments, employees, and daily summaries — from your phone or tablet.';
  }

  @override
  String faqIntro(String appName) {
    return 'Answers to common questions about $appName.';
  }

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get photoLibrary => 'Photo library';

  @override
  String get addPhoto => 'Add photo';

  @override
  String couldNotPickImage(String error) {
    return 'Could not pick image: $error';
  }

  @override
  String get unpaidAmount => 'Unpaid amount';

  @override
  String get unpaidBalance => 'Unpaid balance';

  @override
  String unpaidColonAmount(String amount) {
    return 'Unpaid: $amount';
  }

  @override
  String get previousUnpaid => 'Previous unpaid';

  @override
  String get partyUnpaid => 'Party unpaid';

  @override
  String get loadingUnpaid => 'Loading unpaid…';

  @override
  String get totalUnpaid => 'Total unpaid';

  @override
  String get unpaidAmountNotYetCollected => 'Unpaid amount not yet collected.';

  @override
  String get partyUnpaidTabHint =>
      'Open Employees, select a person, then tap Party unpaid on their profile. The server needs an employee id for this search.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'Party settlement uses the unpaid total.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'Enter a settlement amount first (or select a party with unpaid).';

  @override
  String get workspace => 'Workspace';

  @override
  String get change => 'Change';

  @override
  String get addMoreOrganization => 'Add more +';

  @override
  String get connectAnotherOrganization => 'Connect another organization';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'No saved organizations yet. Use Add more + to connect one.';

  @override
  String get registerNewOrganizationTitleSignedIn =>
      'Register a new organization?';

  @override
  String get registerNewOrganizationTitle => 'Register new organization?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'You will be signed out and the setup wizard will start from the beginning so you can register a new business on this device.\n\nOrganizations you already saved stay in the list after setup.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'The setup wizard will start so you can register a new business on this device. Finish setup to create it; your saved organizations stay in the list.';

  @override
  String get startSetup => 'Start setup';

  @override
  String get enterOrganizationCode => 'Please enter your organization code';

  @override
  String get organizationNotFoundCheckCode =>
      'Organization not found. Check the code and try again.';

  @override
  String get organizationNotFound => 'Organization not found';

  @override
  String get couldNotVerifyOrganization => 'Could not verify organization';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'No local data for $name. Complete setup for this organization first.';
  }

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get enterEmail => 'Enter email';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get enterEmailLocalPartOnly => 'Enter only the part before @';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get logIn => 'LOG IN';

  @override
  String get searchCountry => 'Search country';

  @override
  String get searchCodeOrSymbol => 'Search code or symbol';

  @override
  String get saveLoginDetailsTitle => 'Save your login details?';

  @override
  String get saveLoginDetailsMessage =>
      'You are about to complete setup for this organization.\n\nWould you like to safely download a PDF with your organization code, organization name, login email, and password? Store it in a secure place — anyone with this file can sign in.';

  @override
  String get downloadPdfAndContinue => 'Download PDF & continue';

  @override
  String get continueWithoutPdf => 'Continue without PDF';

  @override
  String get legalDisplayNameHint => 'Legal / display name';

  @override
  String get chartOfAccounts => 'Chart of accounts';

  @override
  String get fiscalYearStart => 'Fiscal year start';

  @override
  String get fiscalYearEnd => 'Fiscal year end';

  @override
  String get removeTestDataTitle => 'Remove test data?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'All demo sales, purchases, contacts, parties, inventory items, staff, and liquor calculator products will be removed.\n\nYou are on a demo organization — after this you will be switched back to your first organization automatically.';

  @override
  String get removeTestDataMessageNormal =>
      'All demo sales, purchases, contacts, parties, inventory items, and staff will be removed. Your admin account and real setup data stay intact.';

  @override
  String get removeTestDataWarning =>
      'This cannot be undone except by loading test data again.';

  @override
  String get removeTestData => 'Remove test data';

  @override
  String get keepTestData => 'Keep test data';

  @override
  String get demoDataRemoved => 'Demo data removed';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'Test data removed. Switched to $name.';
  }

  @override
  String get testDataRemoved => 'Test data removed';

  @override
  String couldNotRemoveTestData(String error) {
    return 'Could not remove test data: $error';
  }

  @override
  String get loadTestDataTitle => 'Load test data?';

  @override
  String get loadTestDataMessage =>
      'This will add up to 50 demo contacts, 50 sales-only and 50 purchase-only inventory items, plus sample sales, purchases, payments, stock, closing summaries, staff, payroll, attendance for the last 15 days, and sample liquor products for the calculator.';

  @override
  String get loadTestData => 'Load test data';

  @override
  String get testDataLoaded => 'Test data loaded';

  @override
  String couldNotLoadTestData(String error) {
    return 'Could not load test data: $error';
  }

  @override
  String get demoTestData => 'Demo test data';

  @override
  String get importTestDataSubtitle => 'Import test data for all features';

  @override
  String get hideTestDataTitle => 'Hide test data for this organization?';

  @override
  String get hideTestDataMessage =>
      'If you continue, the Test Data section will be hidden everywhere in this organization (including setup). You can turn it back on only by reinstalling or clearing app data for this org.';

  @override
  String get hideTestDataWarning =>
      'Demo data already loaded will stay in the database until you remove it from settings.';

  @override
  String get okHideTestData => 'OK, hide test data';

  @override
  String get testDataHiddenForOrg => 'Test Data hidden for this organization';

  @override
  String get hideTestDataTooltip => 'Hide test data for this organization';

  @override
  String get partyRolesTitle => 'Party roles';

  @override
  String get partyRolesMoreSubtitle => 'Customer, supplier, both & more';

  @override
  String get exploreCustomizeTitle => 'Customize features';

  @override
  String get exploreCustomizeSubtitle =>
      'Show or hide shortcuts on your home screen. Only features your organization can access are listed.';

  @override
  String get exploreVisibleOnDashboard => 'Visible on dashboard';

  @override
  String get exploreHiddenOnDashboard => 'Hidden on dashboard';

  @override
  String get partiesTitle => 'Parties';

  @override
  String get partySearchByName => 'Search by name…';

  @override
  String get partySortBy => 'Sort By:';

  @override
  String get partySortLatest => 'Latest';

  @override
  String get partySortAmountHighLow => 'Amount: High to Low';

  @override
  String get partySortAmountLowHigh => 'Amount: Low to High';

  @override
  String get partySortNameAZ => 'Name: A to Z';

  @override
  String get partySortNameZA => 'Name: Z to A';

  @override
  String get partyAddNew => 'Add New Party';

  @override
  String get partyEdit => 'Edit Party';

  @override
  String get partyUpdate => 'Update Party';

  @override
  String get partyNameLabel => 'Party Name*';

  @override
  String get partyNameHint => 'Enter party name';

  @override
  String get partyNewNameLabel => 'New Party Name*';

  @override
  String get partyNewNameHint => 'Enter new party name';

  @override
  String get partyRoleLabel => 'Party Role *';

  @override
  String get partyTapToSelect => 'Tap to select';

  @override
  String get partySelectRoleValidation => 'Please select role';

  @override
  String get partyEnterNameValidation => 'Please enter party name';

  @override
  String get partyBasicInfo => 'Basic Info';

  @override
  String get partyAdditionalInfo => 'Additional Info';

  @override
  String get partyEmail => 'Party Email';

  @override
  String get partyEmailHint => 'Enter email address';

  @override
  String get partyPhone => 'Phone Number';

  @override
  String get partyPhoneHint => 'Enter phone number';

  @override
  String get partyAddress => 'Party Address';

  @override
  String get partyAddressHint => 'Enter address';

  @override
  String get partyRoleCustomer => 'Customer';

  @override
  String get partyRoleSupplier => 'Supplier';

  @override
  String get partyRoleRoom => 'Room';

  @override
  String get partyRoleCabin => 'Cabin';

  @override
  String get partyRoleEmployee => 'Employee';

  @override
  String get partyRoleBoth => 'Both';

  @override
  String get partyDefaultAccount => 'Default Account';

  @override
  String get partyLoyaltyProgram => 'Loyalty Program';

  @override
  String get partyLoyaltyPoints => 'Loyalty Points';

  @override
  String get partySelectDefaultAccount => 'Select Default Account';

  @override
  String get partySelectLoyaltyProgram => 'Select Loyalty Program';

  @override
  String get partyCreateNewProgram => 'Create new program';

  @override
  String get partySelectPartyRole => 'Select Party Role';

  @override
  String get partyAccountDebtors => 'Debtors';

  @override
  String get partyAccountCreditors => 'Creditors';

  @override
  String get partyBothRoleHint =>
      'Both means this party appears under Customer and Supplier only — not Room, Cabin, or Employee.';

  @override
  String get partyValidNumber => 'Please enter valid number';

  @override
  String get partyValidAmount => 'Please enter valid amount';

  @override
  String get searchRoles => 'Search roles';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count roles',
      one: '1 role',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'No roles yet';

  @override
  String get noRolesYetHint =>
      'Add Customer, Supplier, Both, or custom roles for contacts.';

  @override
  String get addRole => 'Add role';

  @override
  String get deleteRoleTitle => 'Delete role';

  @override
  String deleteRoleConfirm(String name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount parties',
      one: '1 party',
    );
    return '\"$name\" is used by $_temp0. Transfer those parties to another role, or hard delete and lose them.';
  }

  @override
  String get transferParties => 'Transfer parties';

  @override
  String get hardDeleteLoseParties => 'Hard delete (lose parties)';

  @override
  String get hardDeleteRoleTitle => 'Hard delete?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount parties',
      one: '1 party',
    );
    return 'This will permanently delete \"$name\" and all $_temp0 assigned to it. Party data cannot be recovered.\n\nParties linked to invoices or payments may not delete — use Transfer instead.';
  }

  @override
  String get deleteRoleAndParties => 'Delete role and parties';

  @override
  String get addAnotherRoleBeforeDelete =>
      'Add another role before deleting this one.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount parties',
      one: '1 party',
    );
    return 'Move $_temp0 from \"$fromRole\" to:';
  }

  @override
  String get transferAndDeleteRole => 'Transfer and delete role';

  @override
  String get builtInRole => 'Built-in';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 party',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'No parties yet';

  @override
  String get newRole => 'New role';

  @override
  String get editRole => 'Edit role';

  @override
  String get defaultRolesCannotEdit =>
      'Default roles cannot be renamed or deleted.';

  @override
  String get roleNameLabel => 'Role name *';

  @override
  String get roleNameHint => 'e.g. Customer';

  @override
  String get roleDescriptionLabel => 'Description';

  @override
  String get roleDescriptionHint => 'Short note for your team';

  @override
  String get roleSortOrderLabel => 'Sort order';

  @override
  String get roleSortOrderHint => 'Lower shows first in lists';

  @override
  String get roleCreated => 'Role created';

  @override
  String get roleUpdated => 'Role updated';

  @override
  String get roleDeleted => 'Role deleted';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 party',
    );
    return 'Role deleted. $_temp0 moved to $targetRole.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 party',
    );
    return 'Role and $_temp0 deleted.';
  }

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get logoutConfirmTitle => 'Logout';

  @override
  String get logoutConfirmMessage =>
      'Are you sure you want to logout from your account?';

  @override
  String get faqTapToExpand => 'Tap a question to expand.';

  @override
  String get faqSectionGettingStarted => 'Getting started';

  @override
  String get faqSectionLogin => 'Login';

  @override
  String get faqSectionNavigation => 'Navigation';

  @override
  String get faqSectionInvoices => 'Invoices';

  @override
  String get faqSectionPayments => 'Payments';

  @override
  String get faqSectionItemsStock => 'Items & stock';

  @override
  String get faqSectionProfileEmployees => 'Profile & employees';

  @override
  String get faqSectionDashboardReports => 'Dashboard & reports';

  @override
  String get faqSectionSyncTroubleshooting => 'Sync & troubleshooting';

  @override
  String get faqNeedInternetQuestion => 'Do I need internet?';

  @override
  String get faqNeedInternetAnswer =>
      'After first-time local setup, you can record invoices, items, and payments without internet. Data stays on your device. Sync with a server is optional and available from the More tab when configured.';

  @override
  String get faqFirstInstallQuestion => 'What happens on first install?';

  @override
  String get faqFirstInstallAnswer =>
      'You may see a short walkthrough, then Local setup (organization, company, your login email and password, currency, fiscal year). After that, sign in with the email and password you created.';

  @override
  String get faqSignInCredentialsQuestion => 'What do I use to sign in?';

  @override
  String get faqSignInCredentialsAnswer =>
      'Your email address and password from setup. The app keeps you signed in until you log out from More.';

  @override
  String get faqLoggedOutQuestion => 'Why was I logged out?';

  @override
  String get faqLoggedOutAnswer =>
      'You chose Logout, cleared app data, or the session expired. Sign in again with the same credentials.';

  @override
  String get faqBottomTabsQuestion => 'What do the bottom tabs do?';

  @override
  String get faqBottomTabsAnswer =>
      'Home — dashboard and overview.\nSales — sales invoices by date.\nExpenses — purchase / expense invoices.\nCenter button — Parties (customers, suppliers).\nMore — profile, reports, sync, help, logout.';

  @override
  String get faqCreateInvoiceQuestion =>
      'How do I create a sales or purchase invoice?';

  @override
  String get faqCreateInvoiceAnswer =>
      'Open Sales or Expenses, select a date on the calendar, tap the + button, add items and amounts, choose a party if needed, then save or submit.';

  @override
  String get faqInvoiceDetailsQuestion => 'How do I view full invoice details?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'Tap any invoice in the list. Transaction details shows line items, totals, discounts, and payments. You can print, share, duplicate, or pay from there.';

  @override
  String get faqZeroRateQuestion => 'Rate or amount shows zero in details';

  @override
  String get faqZeroRateAnswer =>
      'This usually means line or payment data was missing in older saves. Update the app and create or settle again if needed. New entries should show correct rate and amount.';

  @override
  String get faqPartialPaymentQuestion => 'How do I record a partial payment?';

  @override
  String get faqPartialPaymentAnswer =>
      'Open the invoice → Transaction details → Make Payment. Enter the amount, method, and date, then Process Settlement.';

  @override
  String get faqMultiplePaymentQuestion => 'How does Multiple Payment work?';

  @override
  String get faqMultiplePaymentAnswer =>
      'Turn Multiple Payment ON, tap edit, and split the total across Cash, Card, QR, etc. The split total should match what the customer paid. Each method is recorded separately.';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'Only one payment was saved from a split';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'Update to the latest app version. Older local builds sometimes saved only the first split line. Settle again if your unpaid balance is still wrong.';

  @override
  String get faqAddItemQuestion => 'How do I add an item?';

  @override
  String get faqAddItemAnswer =>
      'Use Add item from sales flow or quick add. Enter name, rate, unit, purpose, and optional photo (JPEG/PNG/GIF/WebP, max 5 MB), then Create item.';

  @override
  String get faqCustomUnitQuestion => 'How do I add a custom unit?';

  @override
  String get faqCustomUnitAnswer =>
      'On the item form, tap Unit → Create new unit at the bottom of the list, enter the name (e.g. Litre, Box), and Create.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'I changed my name but profile still shows the old name';

  @override
  String get faqProfileNameAnswer =>
      'Edit your employee record (same email as login) and save. The More tab and dashboard should update. Log out and back in only if it still looks wrong.';

  @override
  String get faqRevenueDetailsQuestion => 'What is Revenue Details?';

  @override
  String get faqRevenueDetailsAnswer =>
      'A monthly view with a daily trend chart, net profit, unpaid receivables, and a day-by-day sales vs purchase breakdown. Change month with the calendar or month chip.';

  @override
  String get faqOtherReportsQuestion => 'Where are other reports?';

  @override
  String get faqOtherReportsAnswer =>
      'Open More and look under Reports (Analytics, Profit & Loss, Statement, etc.) if your role has access.';

  @override
  String get faqWhenSyncQuestion => 'When should I sync?';

  @override
  String get faqWhenSyncAnswer =>
      'Only when your administrator asks you to, and when you have a stable connection. Sync sends or receives data between the device and the server.';

  @override
  String get faqFabPositionQuestion =>
      'The + button looks too high on Sales / Expenses';

  @override
  String get faqFabPositionAnswer =>
      'It sits above the bottom navigation bar. Scroll the list or update the app if the button overlaps content on your device.';

  @override
  String get faqHowLogoutQuestion => 'How do I log out?';

  @override
  String get faqHowLogoutAnswer =>
      'More → Logout at the bottom of the settings list.';

  @override
  String get statisticsGoodMorning => 'Good Morning';

  @override
  String get statisticsGoodAfternoon => 'Good Afternoon';

  @override
  String get statisticsGoodEvening => 'Good Evening';

  @override
  String get statisticsDefaultUser => 'User';

  @override
  String get statisticsCheckConnection =>
      'Please check your connection and try again.';

  @override
  String get statisticsCouldNotLoadProfile => 'Could not load profile';

  @override
  String get statisticsCouldNotLoadData => 'Could not load data';

  @override
  String get statisticsPeriodDay => 'Day';

  @override
  String get statisticsPeriodMonth => 'Month';

  @override
  String get statisticsPeriodYear => 'Year';

  @override
  String get statisticsSelectedPeriod => 'Selected Period';

  @override
  String get statisticsSelectMonth => 'Select Month';

  @override
  String get statisticsSelectMonthSubtitle => 'Choose a month to filter data';

  @override
  String get statisticsQuickOperations => 'Quick operations';

  @override
  String get statisticsQuickOperationsSeeAll => 'See all';

  @override
  String get statisticsQuickOperationInvoice => 'Invoice';

  @override
  String get statisticsQuickOperationReports => 'Reports';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'Cashflow';

  @override
  String get statisticsCashflowLast7Days => 'Cashflow (Last 7 Days)';

  @override
  String get statisticsCashflowLast12Months => 'Cashflow (Last 12 Months)';

  @override
  String get statisticsDaily => 'Daily';

  @override
  String get statisticsMonthly => 'Monthly';

  @override
  String get statisticsOverall => 'Overall';

  @override
  String get statisticsLast7Days => 'Last 7 days';

  @override
  String get statisticsLast12Months => 'Last 12 months';

  @override
  String get statisticsAllYears => 'All Years';

  @override
  String get statisticsNoDataAvailable => 'No data available';

  @override
  String get statisticsMoneyIn => 'Money In';

  @override
  String get statisticsMoneyOut => 'Money Out';

  @override
  String get statisticsIncome => 'Income';

  @override
  String get statisticsExpenses => 'Expenses';

  @override
  String get statisticsSalesSummary => 'Sales Summary';

  @override
  String get statisticsPurchaseSummary => 'Purchase Summary';

  @override
  String get statisticsTotalSales => 'Total Sales';

  @override
  String get statisticsTotalIncome => 'Total Income';

  @override
  String get statisticsTotalUnpaid => 'Total Unpaid';

  @override
  String get statisticsTotalPurchase => 'Total Purchase';

  @override
  String get statisticsPaidPurchase => 'Paid Purchase';

  @override
  String get statisticsUnpaidPurchase => 'Unpaid Purchase';

  @override
  String get statisticsEmployeeDashboard => 'Employee Dashboard';

  @override
  String get statisticsDefaultEmployee => 'Employee';

  @override
  String get statisticsDefaultDepartment => 'Department';

  @override
  String get statisticsDefaultPosition => 'Position';

  @override
  String get statisticsCurrentMonth => 'Current Month';

  @override
  String get statisticsStatus => 'Status';

  @override
  String get statisticsActive => 'Active';

  @override
  String get statisticsWelcome => 'Welcome';

  @override
  String get statisticsEmployeeWelcomeMessage =>
      'You are logged in as an employee. Use the navigation menu to access available features.';

  @override
  String get statisticsRevenueDetails => 'Revenue Details';

  @override
  String get statisticsEmployeeDetails => 'Employee Details';

  @override
  String get statisticsChangeMonth => 'Change month';

  @override
  String get statisticsFilterChartsSubtitle => 'Filter charts and breakdown';

  @override
  String get statisticsDailyTrend => 'Daily trend';

  @override
  String get statisticsDailyActivity => 'Daily activity';

  @override
  String get statisticsNoDataForMonth => 'No data for this month';

  @override
  String get statisticsNetProfit => 'Net profit';

  @override
  String get statisticsMonthReceivables => 'Month receivables';

  @override
  String get statisticsMonthRevenue => 'Month Revenue';

  @override
  String get statisticsMonthExpenses => 'Month Expenses';

  @override
  String get statisticsNoDailyEntries => 'No daily entries for this month';

  @override
  String get statisticsDailySalesBreakdown => 'Daily sales breakdown';

  @override
  String get statisticsDailyBreakdown => 'Daily breakdown';

  @override
  String get statisticsAdvance => 'Advance';

  @override
  String get statisticsExploreFeatures => 'Explore Features';

  @override
  String get statisticsShowOrHideFeatures => 'Show or hide features';

  @override
  String get statisticsAllFeaturesHidden => 'All explore features are hidden';

  @override
  String get statisticsNoFeaturesForOrg =>
      'No features available for your organization';

  @override
  String get statisticsTapTuneToShow =>
      'Tap the tune icon above to show shortcuts again.';

  @override
  String get statisticsMenuCheck => 'Reconciliation';

  @override
  String get statisticsMenuEmployee => 'Employee';

  @override
  String get statisticsMenuOrder => 'Order';

  @override
  String get statisticsMenuInventory => 'Items';

  @override
  String get statisticsMenuCustomers => 'Customers';

  @override
  String get statisticsMenuCalculator => 'Liquor prices';

  @override
  String get statisticsMenuQuickExpenses => 'Quick\nExpenses';

  @override
  String get statisticsMenuQuickSales => 'Quick\nSales';

  @override
  String get statisticsMenuAddEmployee => 'Add\nEmployee';

  @override
  String get statisticsMenuAddParty => 'Add\nParty';

  @override
  String get statisticsMenuAddEmployeeSingle => 'Add Employee';

  @override
  String get statisticsMenuAddPartySingle => 'Add Party';

  @override
  String statisticsGreeting(String greeting, String name) {
    return '$greeting, $name';
  }

  @override
  String statisticsEmployeeGreeting(String greeting, String name) {
    return '$greeting, $name!';
  }

  @override
  String statisticsDepartmentPosition(String department, String position) {
    return '$department • $position';
  }

  @override
  String statisticsMetricCollected(String amount) {
    return '$amount collected';
  }

  @override
  String statisticsMetricPaid(String amount) {
    return '$amount paid';
  }

  @override
  String statisticsMoneyInAmount(String amount) {
    return 'Money In: $amount';
  }

  @override
  String statisticsMoneyOutAmount(String amount) {
    return 'Money Out: $amount';
  }

  @override
  String statisticsDayTooltip(String day, String amount) {
    return 'Day $day\n$amount';
  }

  @override
  String statisticsProfitMargin(String percent) {
    return '$percent% margin';
  }

  @override
  String get invoiceCommonActions => 'Actions';

  @override
  String get invoiceCommonSearchItems => 'Search Items';

  @override
  String get invoiceCommonSearchItemsSubtitle => 'Search for specific items';

  @override
  String get invoiceCommonAddNewInvoice => 'Add New Invoice';

  @override
  String get invoiceCommonAddSalesInvoiceSubtitle =>
      'Create a new sales invoice';

  @override
  String get invoiceCommonAddPurchaseInvoiceSubtitle =>
      'Create a new purchase invoice';

  @override
  String get invoiceCommonSelectMonthYear => 'Select Month/Year';

  @override
  String get invoiceCommonSelectMonthYearSubtitle => 'Jump to a specific month';

  @override
  String get invoiceCommonSelectMonthAndYear => 'Select Month & Year';

  @override
  String get invoiceCommonFilterByDate => 'Filter by date';

  @override
  String get invoiceCommonFilterByDateRange => 'Filter by date range';

  @override
  String get invoiceCommonCloseSearch => 'Close search';

  @override
  String get invoiceCommonSelectAll => 'Select All';

  @override
  String get invoiceCommonToday => 'Today';

  @override
  String get invoiceCommonTotalQuantity => 'Total Quantity';

  @override
  String get invoiceCommonTotalAmount => 'Total Amount';

  @override
  String get invoiceCommonTotal => 'Total';

  @override
  String get invoiceCommonSearchForItems => 'Search for items';

  @override
  String get invoiceCommonNoItemsFound => 'No items found';

  @override
  String get invoiceCommonUnknownItem => 'Unknown Item';

  @override
  String get invoiceCommonNotAvailable => 'N/A';

  @override
  String get invoiceSalesCouldNotLoad => 'Could not load sales';

  @override
  String get invoiceSalesNoFound => 'No Sales found';

  @override
  String get invoiceSalesSelectDate => 'Select a date to view Sales';

  @override
  String get invoiceSalesNoInvoicesFound => 'No invoices found';

  @override
  String get invoiceSalesSelectDateLegacy => 'Select a date to view invoices';

  @override
  String get invoicePurchaseCouldNotLoad => 'Could not load expenses';

  @override
  String get invoicePurchaseNoFound => 'No purchases found';

  @override
  String get invoicePurchaseSelectDate => 'Select a date to view purchases';

  @override
  String get invoiceWeekdaySun => 'Sun';

  @override
  String get invoiceWeekdayMon => 'Mon';

  @override
  String get invoiceWeekdayTue => 'Tue';

  @override
  String get invoiceWeekdayWed => 'Wed';

  @override
  String get invoiceWeekdayThu => 'Thu';

  @override
  String get invoiceWeekdayFri => 'Fri';

  @override
  String get invoiceWeekdaySat => 'Sat';

  @override
  String invoiceCommonSelectedCount(int count) {
    return '$count Selected';
  }

  @override
  String invoiceCommonQtyLabel(String qty) {
    return 'Qty: $qty';
  }

  @override
  String invoiceCommonInvoiceLabel(String number) {
    return 'Invoice: $number';
  }

  @override
  String invoiceCommonCustomerLabel(String name) {
    return 'Customer: $name';
  }

  @override
  String invoiceCommonSupplierLabel(String name) {
    return 'Supplier: $name';
  }

  @override
  String invoiceCommonSearchingFor(String query) {
    return 'Searching for \"$query\"...';
  }

  @override
  String invoiceCommonSearchItemsHint(String scope) {
    return 'Search items in $scope...';
  }

  @override
  String invoiceCommonSalesSearchPrompt(String scope) {
    return 'Type an item name to find all sales\nin $scope';
  }

  @override
  String invoiceCommonPurchaseSearchPrompt(String scope) {
    return 'Type an item name to find all purchases\nin $scope';
  }

  @override
  String invoiceCommonSalesNoMatch(String query, String scope) {
    return 'No sales of \"$query\"\nin $scope';
  }

  @override
  String invoiceCommonPurchaseNoMatch(String query, String scope) {
    return 'No purchases of \"$query\"\nin $scope';
  }

  @override
  String invoiceCommonEmptyForDate(String date) {
    return 'for $date';
  }

  @override
  String invoiceFoundSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sales',
      one: '1 sale',
    );
    return 'Found $_temp0';
  }

  @override
  String invoiceFoundPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count purchases',
      one: '1 purchase',
    );
    return 'Found $_temp0';
  }

  @override
  String invoiceDateSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sales',
      one: '1 sale',
    );
    return '$_temp0';
  }

  @override
  String invoiceDatePurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count purchases',
      one: '1 purchase',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count invoices',
      one: '1 invoice',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count invoices',
      one: '1 invoice',
    );
    return 'Delete $_temp0';
  }

  @override
  String invoiceDeleteMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected invoices',
      one: '1 selected invoice',
    );
    return 'Are you sure you want to delete $_temp0? This action cannot be undone.';
  }

  @override
  String get contacts => 'Contacts';

  @override
  String get categories => 'Categories';

  @override
  String get manageStaff => 'Manage staff';

  @override
  String get payroll => 'Payroll';

  @override
  String get attendance => 'Attendance';

  @override
  String get profitAndLoss => 'Profit & Loss';

  @override
  String get statementReport => 'Statement';

  @override
  String get analytics => 'Analytics';

  @override
  String get loggedOut => 'Logged out';

  @override
  String organizationCodeDisplay(String code) {
    return 'Code: $code';
  }

  @override
  String get moreDataSynchronization => 'Data Synchronization';

  @override
  String get moreSendDataToClient => 'Send Data to Client';

  @override
  String get moreSendDataToClientSubtitle => 'Upload server data to client';

  @override
  String get moreSendDataToClientWarning =>
      'This action will replace the current client database with data from the server. All recent client changes may be lost.';

  @override
  String get moreSendDataToClientConfirm =>
      'Are you sure you want to send data to the client?';

  @override
  String get moreFetchDataFromClient => 'Fetch Data from Client';

  @override
  String get moreFetchDataFromClientSubtitle =>
      'Download client data to server';

  @override
  String get moreFetchDataFromClientWarning =>
      'This action will replace the current server database with data from the client. All recent server changes may be lost.';

  @override
  String get moreFetchDataFromClientConfirm =>
      'Are you sure you want to fetch data from the client?';

  @override
  String get notifications => 'Notifications';

  @override
  String get openingReminder => 'Opening reminder';

  @override
  String get closingReminder => 'Closing reminder';

  @override
  String get activityReminder => 'Sales & purchase reminder';

  @override
  String get openingTime => 'Opening time';

  @override
  String get closingTime => 'Closing time';

  @override
  String get activityReminderTime => 'Reminder time';

  @override
  String get notificationSettingsSaved => 'Notification settings saved';

  @override
  String get notificationPermissionHint =>
      'Allow notifications (and alarms on Android) so reminders work when the app is closed';

  @override
  String dailyAtTime(String time) {
    return 'Daily at $time';
  }

  @override
  String get invoiceActivityReminderTitle => 'No sales or purchases today';

  @override
  String get invoiceActivityReminderMessage =>
      'You haven\'t added a sales or purchase record yet today. Add one to keep your books up to date.';

  @override
  String get invoiceActivityReminderProceed => 'Add record';

  @override
  String get invoiceActivityReminderAddSales => 'Add sales';

  @override
  String get invoiceActivityReminderAddPurchase => 'Add purchase';

  @override
  String get invoiceActivityReminderNotificationTitle => 'Add today\'s record';

  @override
  String get invoiceActivityReminderNotificationBody =>
      'No sales or purchase yet today. Tap to add a record.';

  @override
  String get invoiceCommonYesterday => 'Yesterday';

  @override
  String invoiceCommonTodayAt(String time) {
    return 'Today, $time';
  }

  @override
  String invoiceCommonDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String invoiceReturnCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count returns',
      one: '1 return',
    );
    return '$_temp0';
  }

  @override
  String get checkoutSelectParty => 'Select Party';

  @override
  String get partyPickerSubtitle => 'Who is this sale for?';

  @override
  String partyPickerSearchHint(String role) {
    return 'Search $role...';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'Add new $role';
  }

  @override
  String get partyPickerSettled => 'Settled';

  @override
  String get partyPickerSelectedLabel => 'SELECTED';

  @override
  String get checkoutCartSummary => 'Cart summary';

  @override
  String get checkoutNoItemsInCart => 'No items in cart';

  @override
  String get checkoutSearchHere => 'Search here';

  @override
  String get checkoutCreateInvoice => 'Create Invoice';

  @override
  String get checkoutEditInvoice => 'Edit Invoice';

  @override
  String get checkoutSaveInvoice => 'Save Invoice';

  @override
  String get checkoutInvoiceSummary => 'Invoice Summary';

  @override
  String get checkoutEstimate => 'Estimate';

  @override
  String get checkoutBasicInformation => 'Basic Information';

  @override
  String get checkoutAddItems => 'Add Items';

  @override
  String get checkoutItemsSection => 'Items';

  @override
  String get checkoutPartyRequired => 'Party *';

  @override
  String get checkoutPartyInformation => 'Party Information';

  @override
  String get checkoutBillSummary => 'Bill Summary';

  @override
  String get checkoutBillSummaryHint =>
      'Tap to know more detailed calculation.';

  @override
  String get checkoutItemTotal => 'Item Total';

  @override
  String checkoutLoyaltyDiscount(String percent) {
    return 'Loyalty Discount ($percent%)';
  }

  @override
  String get checkoutLoyaltyDiscountLabel => 'Loyalty Discount';

  @override
  String get checkoutDiscountLabel => '- Discount';

  @override
  String get checkoutTaxLabel => 'Tax';

  @override
  String get checkoutEditTax => 'Edit tax';

  @override
  String get checkoutTaxType => 'Tax type';

  @override
  String get checkoutTaxCorporate => 'Corporate';

  @override
  String get checkoutTaxPersonal => 'Personal';

  @override
  String get checkoutTaxApplyHint => 'Add tax to this invoice total';

  @override
  String checkoutTaxTypeHint(String type) {
    return 'Rates for $type from your country reference — you can override below.';
  }

  @override
  String checkoutTaxPresetsForCountry(String country) {
    return 'Suggested rates for $country';
  }

  @override
  String get checkoutTaxNoTax => 'No tax';

  @override
  String checkoutSummaryPercent(String percent) {
    return '($percent%)';
  }

  @override
  String checkoutDiscountLine(String percent) {
    return '- Discount ($percent%)';
  }

  @override
  String get checkoutTapToEdit => 'Tap to Edit';

  @override
  String get checkoutTotalAmount => 'Total Amount';

  @override
  String get checkoutPaymentMode => 'Record payment';

  @override
  String get checkoutPaymentModeHint =>
      'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.';

  @override
  String get checkoutNetSalesAmount => 'Net Sales Amount';

  @override
  String get checkoutConfirmCheckout => 'Confirm Checkout';

  @override
  String get checkoutEditDiscount => 'Edit Discount';

  @override
  String get checkoutPercentage => 'Percentage';

  @override
  String get checkoutDiscard => 'Discard';

  @override
  String get checkoutPartialPayment => 'Partial Payment';

  @override
  String get checkoutPartialPaymentBanner =>
      'By activating Partial Payment the customer will be able to pay the amount less than the Total Billed Amount.';

  @override
  String get checkoutPleaseEnterAmounts => 'Please enter respective amounts:';

  @override
  String get checkoutPartialPaymentEqualHint =>
      'Since no user is assigned, the total amount should be equal to the total billed amount.';

  @override
  String checkoutOverGrandTotalBy(String amount) {
    return 'Over Grand Total by: $amount';
  }

  @override
  String checkoutRemainingUnpaid(String amount) {
    return 'Remaining (unpaid from Grand Total): $amount';
  }

  @override
  String get checkoutConfirmPayment => 'Confirm Payment';

  @override
  String get checkoutUnpaidCredit => 'Unpaid / Credit';

  @override
  String get checkoutAddAtLeastOneLine =>
      'Add at least one line item to view estimate';

  @override
  String get checkoutMultiplePayment => 'Multiple Payment';

  @override
  String get checkoutPaymentStatus => 'Payment status';

  @override
  String get checkoutPaymentMethods => 'Payment methods';

  @override
  String get checkoutPaymentMethod => 'Payment method';

  @override
  String get checkoutTenderAmount => 'Tender amount';

  @override
  String get checkoutLoadingPaymentMethods => 'Loading payment methods…';

  @override
  String get stocksTitle => 'Stock reconciliation';

  @override
  String get stockUploadTooltip => 'Opening stock';

  @override
  String get stockNoDataYet => 'No opening stock yet';

  @override
  String get stockNoDataSubtitle =>
      'Enter a physical count. With live tracking on, that count becomes In stock.';

  @override
  String get stockUploadAction => 'Opening stock';

  @override
  String get stockSearchByDateHint => 'Search by date or month…';

  @override
  String get stockNoMatches => 'No matches';

  @override
  String get stockTryDifferentSearch => 'Try a different search term';

  @override
  String get stockTryAnotherSearch => 'Try another search';

  @override
  String get liveStockTracking => 'Live stock tracking';

  @override
  String get liveStockTrackingSubtitle =>
      'Purchases add In stock, sales take it.';

  @override
  String get itemsListSubtitle => 'Item list and live In stock';

  @override
  String get stockCountsSubtitle => 'Opening stock and counts';

  @override
  String get liquorPricesSubtitle => 'Pour prices only — not item stock';

  @override
  String get stockCountsPageHint =>
      'Physical count for stock reconciliation. With live tracking on, In stock is set to the counted qty.';

  @override
  String get stockUploadPageTitle => 'Opening stock';

  @override
  String get stockEnterQuantitiesTitle => 'Enter opening stock';

  @override
  String get stockUploadSubmit => 'Save opening stock';

  @override
  String get stockEnterQuantitiesOption => 'Enter opening stock';

  @override
  String get stockEnterQuantitiesOptionSubtitle =>
      'Physical count. With live tracking on, this sets In stock.';

  @override
  String get liveStockTrackingSaved => 'Live stock tracking updated';

  @override
  String liveStockOnHand(String qty) {
    return 'In stock: $qty';
  }

  @override
  String liveStockOutOfStock(String item) {
    return '$item is out of stock';
  }

  @override
  String liveStockInsufficient(String item, String qty) {
    return '$item has only $qty in stock';
  }

  @override
  String get liveStockSetOnHand => 'Set stock';

  @override
  String get liveStockOnHandLabel => 'In stock';

  @override
  String get liveStockOnHandHint =>
      'Opening stock or stock adjustment — physical count, no purchase needed';

  @override
  String get liveStockOnHandSaved => 'Stock updated';

  @override
  String get liveStockSaveOnHand => 'Save stock';

  @override
  String stockQtyLabel(String qty) {
    return 'Qty $qty';
  }

  @override
  String stockCardSummary(String records, String items, String locations) {
    return '$records records · $items items · $locations locations';
  }

  @override
  String get stockFilterTitle => 'Filter stock reconciliation';

  @override
  String get stockBatchNumber => 'Batch number';

  @override
  String get stockLocation => 'Location';

  @override
  String get stockOptionalHint => 'Optional';

  @override
  String get stockApplyFilters => 'Apply filters';

  @override
  String get stockClearFields => 'Clear fields';

  @override
  String get stockDeleteAllTooltip => 'Delete all stock for this date';

  @override
  String get stockNoItemsFound => 'No stock items found';

  @override
  String get stockNoItemsSubtitle =>
      'Try different filters or another reporting date.';

  @override
  String get stockAdjustFilters => 'Adjust filters';

  @override
  String get stockSearchItemHint => 'Search item, batch, location…';

  @override
  String get stockEditQuantities => 'Edit quantities';

  @override
  String get stockNoChangesDetected => 'No changes detected';

  @override
  String stockErrorPreparingChanges(String error) {
    return 'Error preparing changes: $error';
  }

  @override
  String get stockUpdateSuccessful => 'Update Successful!';

  @override
  String get stockSummary => 'Summary';

  @override
  String get stockTotalRequested => 'Total Requested';

  @override
  String get stockSuccessfullyUpdated => 'Successfully Updated';

  @override
  String get stockFailed => 'Failed';

  @override
  String get stockUpdateFailed => 'Update Failed';

  @override
  String get stockClearAllQuantitiesTitle => 'Clear All Quantities?';

  @override
  String get stockClearAllQuantitiesMessage =>
      'This will reset all quantities to 0. Are you sure?';

  @override
  String get stockClearAll => 'Clear All';

  @override
  String get stockUpdatingQuantities => 'Updating stock quantities...';

  @override
  String get stockEditQuantitiesTitle => 'Edit Stock Quantities';

  @override
  String stockReportingDate(String date) {
    return 'Reporting Date: $date';
  }

  @override
  String stockTotalItemsHint(String count) {
    return 'Total items: $count • Update quantities as needed';
  }

  @override
  String get stockItemName => 'Item Name';

  @override
  String stockBatchPrefix(String batch) {
    return 'Batch: $batch';
  }

  @override
  String get stockDeleteConfirmTitle => 'Confirm Deletion';

  @override
  String get stockDeleteConfirmIntro =>
      'You are about to permanently delete all stock items for the following date:';

  @override
  String get stockDeleteConfirmWarning =>
      'This action cannot be undone. All stock records for this date will be permanently deleted.';

  @override
  String get stockNoInternetRetry =>
      'No internet connection. Please check your connection and try again.';

  @override
  String get itemsTitle => 'Items';

  @override
  String get itemAddSheetTitle => 'Add item';

  @override
  String get itemSingleAdd => 'Single add';

  @override
  String get itemBulkAdd => 'Bulk add';

  @override
  String get itemBulkAddTitle => 'Bulk add items';

  @override
  String get itemEditTitle => 'Edit Item';

  @override
  String get itemAddTitle => 'Add Item';

  @override
  String get itemCreateButton => 'Create Item';

  @override
  String get itemUpdateButton => 'Update Item';

  @override
  String get itemDeleteTitle => 'Delete Item';

  @override
  String itemDeleteConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get itemDeletedSuccess => 'Item deleted successfully';

  @override
  String get itemCreatedSuccess => 'Item created successfully';

  @override
  String get itemUpdatedSuccess => 'Item updated successfully';

  @override
  String get itemLoading => 'Loading items...';

  @override
  String get itemErrorTitle => 'Oops! Something went wrong';

  @override
  String get itemTryAgain => 'Try Again';

  @override
  String get itemSearchHint => 'Search by name or SKU';

  @override
  String get itemNoItemsFound => 'No items found';

  @override
  String get itemTryAdjustSearch => 'Try adjusting your search terms';

  @override
  String get itemNoItemsAvailable => 'No items available';

  @override
  String get itemAddToGetStarted => 'Add items to get started';

  @override
  String get itemNoMoreItems => 'No more items';

  @override
  String get itemPurposeBoth => 'Both';

  @override
  String get itemPurposePurchases => 'Purchases';

  @override
  String get itemTypeProduct => 'Product';

  @override
  String get itemTypeService => 'Service';

  @override
  String get itemTypeInventory => 'Inventory';

  @override
  String get itemPhotoTitle => 'Item photo';

  @override
  String get itemPhotoHint => 'Click here to select or upload photos';

  @override
  String get itemPhotoFormats => 'JPEG, PNG, GIF, or WebP · max 5MB';

  @override
  String get itemAddPhoto => 'Add photo';

  @override
  String get itemPhotoLibrary => 'Photo library';

  @override
  String get itemPhotoLibraryHint => 'Choose from your photos';

  @override
  String get itemTakePhoto => 'Take a photo';

  @override
  String get itemUploadGallery => 'Upload from gallery';

  @override
  String get itemUploadGalleryHint => 'Browse files on this device';

  @override
  String get itemTypeLabel => 'Type';

  @override
  String get itemTypeField => 'Item type';

  @override
  String get itemNameLabel => 'Item name';

  @override
  String get itemNameHint => 'Enter item name';

  @override
  String get itemBarcodeLabel => 'Barcode / QR Code';

  @override
  String get itemBarcodeField => 'Barcode / QR code';

  @override
  String get itemBarcodeHint => 'Scan from app bar or paste';

  @override
  String get itemSkuLabel => 'SKU (optional)';

  @override
  String get itemSkuField => 'SKU';

  @override
  String get itemSkuHint => 'Product code — optional';

  @override
  String get itemPickerSearchHint => 'Search items by name or SKU…';

  @override
  String get itemRateLabel => 'Rate';

  @override
  String get itemUnitLabel => 'Unit';

  @override
  String get itemPurposeLabel => 'Purpose';

  @override
  String get itemSelectUnit => 'Select unit';

  @override
  String get itemSelectPurpose => 'Select purpose';

  @override
  String get itemSelectCategory => 'Select category';

  @override
  String get itemSelectType => 'Select type';

  @override
  String get itemSelectItemType => 'Select item type';

  @override
  String get itemSearchUnits => 'Search units…';

  @override
  String get itemSearchPurpose => 'Search purpose…';

  @override
  String get itemSearchCategories => 'Search categories…';

  @override
  String get itemCreateCustomUnit => 'Create custom unit';

  @override
  String get itemUnitName => 'Unit name';

  @override
  String get itemUnitNameHint => 'e.g., Litre, Box, Piece';

  @override
  String get itemValidationName => 'Please enter item name';

  @override
  String get itemValidationRate => 'Please enter rate';

  @override
  String get itemValidationNumber => 'Please enter valid number';

  @override
  String get itemSelectUnitRequired => 'Please select a unit';

  @override
  String get itemSelectPurposeRequired => 'Please select a purpose';

  @override
  String get itemSelectCategoryRequired => 'Please select a category';

  @override
  String get itemImageMissing => 'Image file is missing';

  @override
  String get itemImageFormatError => 'Use JPEG, PNG, GIF, or WebP';

  @override
  String get itemImageSizeError => 'Image must be 5MB or smaller';

  @override
  String get itemScanBarcode => 'Scan barcode';

  @override
  String get posScanAlignHint => 'Align barcode or QR within the frame';

  @override
  String get posScanKeepScanning => 'Keep scanning to add more items';

  @override
  String posScanItemAdded(String name, String qty) {
    return 'Added $name × $qty';
  }

  @override
  String get posScanItemNotFound => 'No item found for this code';

  @override
  String get posScanCameraDenied =>
      'Camera permission is required to scan barcodes';

  @override
  String get posScanTorch => 'Flashlight';

  @override
  String get posScanDone => 'Done';

  @override
  String get btPrinterTitle => 'Bluetooth printer';

  @override
  String get btPrinterSettingsTitle => 'Receipt printer';

  @override
  String get btPrinterPrintTitle => 'Print receipt';

  @override
  String get btPrinterBluetooth => 'Bluetooth thermal printer';

  @override
  String btPrinterPrintOn(String name) {
    return 'Print on $name';
  }

  @override
  String get btPrinterChooseAnother => 'Choose another Bluetooth printer';

  @override
  String get btPrinterSystem => 'System printer / Save as PDF';

  @override
  String get btPrinterAirPrint => 'AirPrint / Save as PDF';

  @override
  String get btPrinterPaper58 => '58 mm';

  @override
  String get btPrinterPaper80 => '80 mm';

  @override
  String get btPrinterPairHint =>
      'Pair the printer in Bluetooth settings first, then select it here. Keep the printer on and in range.';

  @override
  String get btPrinterUse => 'Use printer';

  @override
  String get btPrinterTest => 'Test print';

  @override
  String get btPrinterForget => 'Forget printer';

  @override
  String get btPrinterSelectOne => 'Select a printer';

  @override
  String get btPrinterNonePaired =>
      'No paired Bluetooth devices. Pair your receipt printer in system settings, then try again.';

  @override
  String get btPrinterBluetoothOff => 'Turn on Bluetooth and try again.';

  @override
  String get btPrinterPermissionDenied =>
      'Bluetooth permission is required to print receipts.';

  @override
  String get btPrinterConnectFailed =>
      'Could not connect to the printer. Make sure it is on and in range.';

  @override
  String get btPrinterPrintFailed =>
      'Could not print to the Bluetooth printer.';

  @override
  String get btPrinterPrintSent => 'Receipt sent to the printer';

  @override
  String get btPrinterTestSent => 'Test page sent to the printer';

  @override
  String get btPrinterSystemFailed => 'Could not open system printer options';

  @override
  String get btPrinterOpenSettings => 'Open settings';

  @override
  String get btPrinterNotConfigured => 'Not set — tap to choose a printer';

  @override
  String get btPrinterIosHint =>
      'Turn the printer on, grant Bluetooth permission, then select it.';

  @override
  String itemNameFromCatalog(String name) {
    return 'Name filled from catalog: $name';
  }

  @override
  String get itemBarcodePasteHint =>
      'No product name found — code pasted as name. Edit if needed.';

  @override
  String get itemBulkRefillTooltip => 'Refill previous input';

  @override
  String get itemBulkAddRow => 'Add row';

  @override
  String itemBulkRowLabel(String index) {
    return 'Item $index';
  }

  @override
  String get itemBulkNameRequired => 'Name required';

  @override
  String get itemBulkInvalidNumber => 'Invalid number';

  @override
  String get itemBulkCreating => 'Creating…';

  @override
  String get itemBulkCreateItems => 'Create items';

  @override
  String itemBulkCreatedCount(String count) {
    return '$count item(s) created';
  }

  @override
  String itemBulkCreateFailed(String error) {
    return 'Failed to create items: $error';
  }

  @override
  String get itemBulkNoDraft => 'No saved draft found';

  @override
  String get itemBulkInvalidDraft => 'Saved draft format is invalid';

  @override
  String get itemBulkDraftRestored => 'Previous draft restored';

  @override
  String get itemBulkDraftRestoreFailed => 'Could not restore saved draft';

  @override
  String get itemBulkAtLeastOne => 'Add at least one item';

  @override
  String get itemBulkCategoriesLoading =>
      'Categories are loading, please try again';

  @override
  String get itemBulkLoadingCategories => 'Loading categories…';

  @override
  String get inventoryTitle => 'Inventory Analytics';

  @override
  String get inventorySubtitle => 'Real-time stock movement tracking';

  @override
  String get inventorySearchHint => 'Search items...';

  @override
  String get inventorySold => 'Sold';

  @override
  String get inventoryPurchased => 'Purchased';

  @override
  String get catNoCategories => 'No categories. Tap + to create.';

  @override
  String get catLoadCategories => 'Load categories';

  @override
  String get catCreated => 'Category created';

  @override
  String get catRenamed => 'Category renamed';

  @override
  String get catDeleted => 'Category deleted';

  @override
  String catDeletedBulk(int count) {
    return '$count categories deleted';
  }

  @override
  String get catNewTitle => 'New category';

  @override
  String get catRenameTitle => 'Rename category';

  @override
  String get catNewName => 'New name';

  @override
  String get catRename => 'Rename';

  @override
  String get catDeleteTitle => 'Delete category';

  @override
  String get catDeleteBulkTitle => 'Delete categories';

  @override
  String catDeleteBulkConfirm(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected categories',
      one: '1 selected category',
    );
    return 'Delete $_temp0?';
  }

  @override
  String catDeleteConfirm(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get catDeleteLinkedHint =>
      'Items are linked. Move them to another category before deleting.';

  @override
  String get catForceDelete => 'Force delete';

  @override
  String catDeleteHasItemsMessage(String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '\"$name\" has $_temp0. Move them to another category before deleting.';
  }

  @override
  String get catTransferItems => 'Transfer items';

  @override
  String catTransferItemsMoveMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return 'Move $_temp0 to:';
  }

  @override
  String get catTransferAndDelete => 'Transfer and delete';

  @override
  String get catAddAnotherBeforeDelete =>
      'Add another category before deleting this one.';

  @override
  String catDeletedItemsTransferred(int count, String target) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return 'Category deleted. $_temp0 moved to $target.';
  }

  @override
  String catItemsCount(String count) {
    return '$count items';
  }

  @override
  String get contactFavoritesOnly => 'Favorites only';

  @override
  String get contactShowAll => 'Show all contacts';

  @override
  String get contactSearchHint => 'Search name, phone, email…';

  @override
  String get contactNoConnection => 'No connection';

  @override
  String get contactCheckNetwork => 'Check your network and try again.';

  @override
  String get contactSomethingWrong => 'Something went wrong';

  @override
  String get contactNoContacts => 'No contacts';

  @override
  String get contactNoFavorites =>
      'No favorites match. Turn off the star filter or add favorites in a contact.';

  @override
  String get contactTrySearchOrAdd =>
      'Try a different search or tap + to add a contact.';

  @override
  String get contactEndOfList => 'End of list';

  @override
  String get contactNewTooltip => 'New contact';

  @override
  String get contactLoading => 'Loading contacts…';

  @override
  String get contactUnknown => 'Unknown';

  @override
  String get contactCallTooltip => 'Call';

  @override
  String get contactEditTitle => 'Edit contact';

  @override
  String get contactNewTitle => 'New contact';

  @override
  String get contactSelectTitle => 'Select contact';

  @override
  String get contactDeleteTitle => 'Delete contact?';

  @override
  String get contactDeleteUndo => 'This action cannot be undone.';

  @override
  String get contactNameRequired => 'Name is required';

  @override
  String get contactNameLabel => 'Name *';

  @override
  String get contactNameHint => 'Contact name';

  @override
  String get contactPhoneHint => '+977-9841234567';

  @override
  String get contactEmailHint => 'email@example.com';

  @override
  String get contactCategoryHint => 'e.g. business, general, vip';

  @override
  String get contactCompanyHint => 'Company name';

  @override
  String get contactFavorite => 'Favorite';

  @override
  String get contactCannotCall => 'Cannot make calls on this device';

  @override
  String get contactPermissionDenied =>
      'Contact permission was denied. You can enable it in Settings.';

  @override
  String get contactPermissionRequired =>
      'Contact permission is required to import from phone';

  @override
  String get contactImported => 'Contact imported from phone';

  @override
  String get contactCreated => 'Contact created';

  @override
  String get contactUpdated => 'Contact updated';

  @override
  String get contactDeleted => 'Contact deleted';

  @override
  String get contactImportSearchHint => 'Search by name, phone, email, company';

  @override
  String get contactImportNoResults => 'No contacts found';

  @override
  String get checkoutMultiplePaymentHint =>
      'Turn this ON, if customer pays via multiple payment mode.';

  @override
  String get checkoutFillRemainingBalance => 'Fill remaining balance';

  @override
  String get checkoutEnterAtLeastOnePayment =>
      'Enter at least one payment amount';

  @override
  String get checkoutPaymentsExceedTotal =>
      'Total payments cannot exceed the grand total';

  @override
  String checkoutSentAs(String api) {
    return 'Sent as: $api';
  }

  @override
  String get paymentCard => 'Card';

  @override
  String get paymentQr => 'QR';

  @override
  String get paymentBank => 'Bank';

  @override
  String get paymentTransfer => 'Transfer';

  @override
  String get paymentBankTransfer => 'Bank Transfer';

  @override
  String get paymentSettlement => 'Settlement';

  @override
  String get paymentCheque => 'Cheque';

  @override
  String get paymentDigital => 'Digital';

  @override
  String get paymentDigitalQr => 'Digital (QR)';

  @override
  String get closeSummaryTitle => 'Closing Summary';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint =>
      'Select a date and tap refresh to load data';

  @override
  String get closeLoadingDashboard => 'Loading dashboard data...';

  @override
  String get closeDataDeleted => 'Data deleted';

  @override
  String closeErrorPrefix(String message) {
    return 'Error: $message';
  }

  @override
  String get closeExtraAmount => 'Extra amount';

  @override
  String get closeExtraAmountDesc =>
      'Additional cash or adjustments recorded for this closing day.';

  @override
  String get closeLostAmount => 'Lost amount';

  @override
  String get closeLostAmountDesc =>
      'Cash shortage or variance flagged for this period.';

  @override
  String get closeTapForDetails => 'Tap for details';

  @override
  String get closeAmountLabel => 'Closing';

  @override
  String get closeAmountFormula => 'Closing Amount Formula';

  @override
  String get closeFormulaExpression =>
      'Cash Sales - Cash Expenses = Closing Amount';

  @override
  String get closeCashSales => 'Cash Sales';

  @override
  String get closeCashExpenses => 'Cash Expenses';

  @override
  String get closeClosingAmount => 'Closing Amount';

  @override
  String get closeWhatThisMeans => 'What this means:';

  @override
  String get closeClosingMeaning =>
      'This is the amount of cash that should be in your register/drawer at the end of the day. It represents all cash received minus all cash paid out.';

  @override
  String get closeQuickStats => 'Quick Stats';

  @override
  String get closeTapCardHint => 'Tap a card for a short description';

  @override
  String get closeOpeningBalance => 'Opening Balance';

  @override
  String get closeTotalSales => 'Total Sales';

  @override
  String get closeQrAmount => 'QR Amount';

  @override
  String get closeCashAmount => 'Cash Amount';

  @override
  String get closeSalesDiscount => 'Sales Discount';

  @override
  String get closeCreditQr => 'Credit QR';

  @override
  String get closeCreditCash => 'Credit Cash';

  @override
  String get closeCreditDiscount => 'Credit Discount';

  @override
  String get closePayCashGetQr => 'Pay Cash → Get QR';

  @override
  String get closePayQrGetCash => 'Pay Qr → Get Cash';

  @override
  String get closePaymentMix => 'Payment mix';

  @override
  String get closePaymentMixHint =>
      'Tap cash or digital · bar shows share of sales';

  @override
  String get closeCashVsDigitalTooltip => 'Cash vs digital share of sales';

  @override
  String closeSalesShareDesc(String label, String percent) {
    return '$label made up $percent% of total sales for this day.';
  }

  @override
  String closeSalesLabel(String label) {
    return '$label sales';
  }

  @override
  String get closeNoTransactions => 'No transactions available';

  @override
  String get closeRecentTransactions => 'Recent Transactions';

  @override
  String get closeViewAll => 'View All';

  @override
  String get closeNoPurchases => 'No purchases available';

  @override
  String get closeRecentPurchases => 'Recent Purchases';

  @override
  String get closeNoSalesDate => 'No sales for this date';

  @override
  String get closeNoSalesHint =>
      'Sales will show here after they are recorded.';

  @override
  String get closeRoomSales => 'Room sales';

  @override
  String get closeEmployeeSales => 'Employee sales';

  @override
  String get closeOtherSales => 'Other sales';

  @override
  String closeSectionCount(String title, String count) {
    return '$title ($count)';
  }

  @override
  String closeDiscountShort(String amount) {
    return 'Disc: $amount';
  }

  @override
  String closePercentOff(String percent) {
    return '$percent% off';
  }

  @override
  String get closePending => 'Pending';

  @override
  String get closeNoCreditPayments => 'No Credit Payments';

  @override
  String get closeNoCreditHint => 'Credit payments will appear here';

  @override
  String get closeViewStatistics => 'View Statistics';

  @override
  String get closeExportData => 'Export Data';

  @override
  String get closeExportComingSoon => 'Export feature will be implemented here';

  @override
  String get closeHintOpeningBalance =>
      'Cash position at the start of the selected day.';

  @override
  String get closeHintTotalSales => 'Sum of all sales recorded for this date.';

  @override
  String get closeHintQrAmount =>
      'Payments received via QR or digital methods.';

  @override
  String get closeHintCashAmount => 'Cash portion of sales for the day.';

  @override
  String get closeHintCashExpenses =>
      'Cash paid out for expenses during the day.';

  @override
  String get closeHintSalesDiscount => 'Discounts applied to sales.';

  @override
  String get closeHintCreditQr => 'Credit-related QR collections.';

  @override
  String get closeHintCreditCash => 'Credit-related cash movements.';

  @override
  String get closeHintCreditDiscount =>
      'Discounts applied on credit transactions.';

  @override
  String get closeHintPayCashGetQr =>
      'Exchange where cash was paid and QR credit received.';

  @override
  String get closeHintPayQrGetCash =>
      'Exchange where QR was paid and cash was received.';

  @override
  String get closeOpeningAmount => 'Opening Amount';

  @override
  String get closeCurrentAmount => 'Current Amount';

  @override
  String get closeSaveReport => 'Save Report';

  @override
  String get closeUpdateSummary => 'Update Summary';

  @override
  String get closeExists => 'Exists';

  @override
  String get closeExistingDataInfo => 'You can view or modify existing data';

  @override
  String get closeEnterOpeningAmount => 'Please enter an opening amount';

  @override
  String get closeEnterValidAmount => 'Please enter a valid amount';

  @override
  String get closeAmountCannotBeNegative => 'Amount cannot be negative';

  @override
  String get googleDriveBackupSectionTitle => 'Backup & Sync';

  @override
  String get googleDriveBackupTitle => 'Google Drive Backup';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Sign in to back up your organization data safely in Google Drive.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'Signed in as $email';
  }

  @override
  String get googleDriveSignIn => 'Sign in with Google';

  @override
  String get googleDriveSignOut => 'Sign out';

  @override
  String get googleDriveBackupNow => 'Backup now';

  @override
  String get googleDriveSignInSuccess => 'Signed in to Google Drive';

  @override
  String get googleDriveSignOutSuccess => 'Signed out of Google Drive';

  @override
  String get googleDriveSignInCancelled => 'Google sign-in was cancelled';

  @override
  String get googleDriveBackupStarting => 'Preparing backup…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'Backup uploaded ($tableCount tables, $recordCount records)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'Backup needs a full app restart. Stop the app, run it again, then retry.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'Last backup: $date';
  }

  @override
  String get backupSyncPageTitle => 'Backup & Sync';

  @override
  String get backupSyncGoogleAccount => 'Google account';

  @override
  String get backupSyncSignedInAs => 'Signed in as';

  @override
  String get backupSyncSignInHint =>
      'Sign in with Google to back up your organization data.';

  @override
  String get backupSyncLastSyncTitle => 'Last sync';

  @override
  String get backupSyncLastSyncDate => 'Date & time';

  @override
  String get backupSyncNeverSynced => 'No backup has been uploaded yet.';

  @override
  String get backupSyncOrganization => 'Organization';

  @override
  String get backupSyncTables => 'Tables backed up';

  @override
  String get backupSyncRecords => 'Records backed up';

  @override
  String get backupSyncStatus => 'Status';

  @override
  String get backupSyncStatusSuccess => 'Completed';

  @override
  String get backupSyncActiveOrganization => 'Current organization';

  @override
  String get backupSyncActiveOrganizationHint =>
      'Backup uploads data for the organization you are using now.';

  @override
  String get backupSyncUnknownOrganization => 'Current organization';

  @override
  String get backupSyncInProgress => 'Sync in progress';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'Step: $step';
  }

  @override
  String get backupSyncStepExport => 'Exporting local data';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'Uploading $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'Uploading $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'Last error: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'Sign out of Google Drive on this device?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Back up to Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync => 'Signed in · No backup yet';

  @override
  String get backupSyncConnected => 'Connected';

  @override
  String get backupSyncCompletedHint =>
      'Your data is safely backed up to Google Drive.';

  @override
  String get backupSyncPhaseExport => 'Export';

  @override
  String get backupSyncPhaseUpload => 'Upload';

  @override
  String get backupAutoSettingsTitle => 'GOOGLE DRIVE SETTINGS';

  @override
  String get backupAutoBackupTitle => 'Auto backup';

  @override
  String get backupAutoBackupHint =>
      'Back up automatically on app start when due';

  @override
  String get backupWifiOnlyTitle => 'Back up over Wi‑Fi only';

  @override
  String get backupWifiOnlyHint => 'Auto backup waits for Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => 'Use mobile data';

  @override
  String get backupAutoFrequencyTitle => 'Backup frequency';

  @override
  String get backupAutoFrequencyOff => 'Off';

  @override
  String get backupAutoFrequencyDaily => 'Daily';

  @override
  String get backupAutoFrequencyWeekly => 'Weekly';

  @override
  String get backupAutoFrequencyMonthly => 'Monthly';

  @override
  String get backupAutoSyncDirectionTitle => 'Auto sync';

  @override
  String get backupAutoDirectionUpload => 'Upload to cloud';

  @override
  String get backupAutoDirectionDownload => 'Download from cloud';

  @override
  String get backupAutoDirectionBoth => 'Upload & download';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'Last auto backup: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'Last auto restore: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'Last auto sync failed: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'Last auto sync skipped: $detail';
  }

  @override
  String get restoreAction => 'Restore';

  @override
  String get restoreFromGoogleDrive => 'Restore from Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'Sign in and pick a backup to restore your organization on this device.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return 'Restore \"$name\"? This replaces local data for that organization.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return 'Restored $name. You can sign in now.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'No backups found in your Google Drive.';

  @override
  String get restoreFromGoogleDriveStarting => 'Starting restore…';

  @override
  String get restoreStepDownload => 'Downloading backup';

  @override
  String get restoreStepCreateDatabase => 'Creating database';

  @override
  String get restoreStepImport => 'Importing data';

  @override
  String get restoreStepFinalize => 'Finishing restore';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'Last sync: $date';
  }

  @override
  String get security => 'Security';

  @override
  String get appLockTitle => 'App lock';

  @override
  String get appLockSubtitle =>
      'Require PIN or biometrics when reopening the app';

  @override
  String get appPin => 'App PIN';

  @override
  String appPinSubtitle(int length) {
    return 'Quick unlock with a $length-digit PIN';
  }

  @override
  String get useBiometricUnlock => 'Use biometrics';

  @override
  String get useBiometricUnlockSubtitle =>
      'Unlock with fingerprint or face recognition after setting a PIN';

  @override
  String get changeAppPin => 'Change PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'Set up PIN';

  @override
  String get confirmAppPin => 'Confirm PIN';

  @override
  String get enterAppPin => 'Enter your PIN';

  @override
  String get enterPasscode => 'Enter Passcode';

  @override
  String tapDigitsToUnlock(int length) {
    return 'Tap any $length digits to unlock.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'Choose a $length-digit passcode for this organization';
  }

  @override
  String get confirmPasscodeHint => 'Re-enter your passcode to confirm';

  @override
  String createAppPinHint(int length) {
    return 'Choose a $length-digit PIN for this organization';
  }

  @override
  String get confirmAppPinHint => 'Re-enter your PIN to confirm';

  @override
  String get appPinMismatch => 'PINs do not match. Try again.';

  @override
  String get appPinIncorrect => 'Incorrect PIN. Try again.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'Incorrect PIN. You have $remaining tries left.';
  }

  @override
  String get appPinLockoutMessage =>
      'Too many incorrect PIN attempts. Sign in with your email and password to reset your PIN.';

  @override
  String get appPinSetSuccess => 'PIN saved for this organization';

  @override
  String get appPinRemoved => 'App PIN removed';

  @override
  String get appLockSettingsSaved => 'App lock settings saved';

  @override
  String get biometricUnlockReason => 'Unlock BizTrack';

  @override
  String get biometricNotAvailable =>
      'Biometrics are not available on this device';

  @override
  String get biometricRequiresPin =>
      'Set up an app PIN before enabling biometrics';

  @override
  String get disableAppPinTitle => 'Remove app PIN?';

  @override
  String get disableAppPinMessage =>
      'Face ID / biometric unlock will also be turned off for this organization.';

  @override
  String get verifyPinToRemoveTitle => 'Enter your PIN';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'Confirm your $length-digit PIN to remove app lock';
  }

  @override
  String get unlockApp => 'Unlock app';

  @override
  String get usePinInstead => 'Use PIN instead';

  @override
  String get useBiometricInstead => 'Use biometrics';

  @override
  String get signInWithFaceId => 'Sign in with Face ID';

  @override
  String get signInWithFingerprint => 'Sign in with fingerprint';

  @override
  String get signInWithBiometric => 'Sign in with biometrics';

  @override
  String get signInWithPin => 'Sign in with PIN';

  @override
  String get setUpQuickUnlock => 'Set up PIN quick sign-in';

  @override
  String get setUpFaceIdOrPin => 'Set up Face ID or PIN';

  @override
  String get setUpFingerprintOrPin => 'Set up fingerprint or PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'Use your device biometrics or a PIN for this organization';

  @override
  String quickUnlockAsUser(String email) {
    return 'Quick sign-in as $email';
  }

  @override
  String get orContinueWithPassword => 'or sign in with password';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'Enable quick sign-in?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'Set up Face ID, fingerprint, or a PIN to sign in faster next time for this organization. You can also change this later in Settings.';

  @override
  String get notNow => 'Not now';

  @override
  String get setUpNow => 'Set up now';

  @override
  String get enableFaceIdTitle => 'Enable Face ID?';

  @override
  String get enableFingerprintTitle => 'Enable fingerprint?';

  @override
  String get enableBiometricTitle => 'Enable biometrics?';

  @override
  String get enableBiometricAfterPinMessage =>
      'Use your device biometrics together with your PIN for faster sign-in.';

  @override
  String get useFaceIdUnlock => 'Use Face ID';

  @override
  String get useFingerprintUnlock => 'Use fingerprint';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => 'Year';

  @override
  String get reportPeriodMonth => 'Month';

  @override
  String get reportPeriodRange => 'Range';

  @override
  String get reportPeriodDay => 'Day';

  @override
  String get reportPeriodFrom => 'From';

  @override
  String get reportPeriodTo => 'To';

  @override
  String get reportPeriod => 'Period';

  @override
  String get reportAllPurchases => 'All purchases';

  @override
  String get reportBeforeTax => 'Before tax';

  @override
  String get reportRevenueRetained => 'Revenue retained';

  @override
  String get reportHideDetails => 'Hide details';

  @override
  String get reportShowDetails => 'Show details';

  @override
  String get reportSalesRevenue => 'Sales revenue';

  @override
  String get reportDiscountsGiven => 'Discounts Given';

  @override
  String get reportNetRevenue => 'Net revenue';

  @override
  String get reportOperatingExpenses => 'Operating expenses';

  @override
  String get reportTotalExpenses => 'Total expenses';

  @override
  String get reportGrossProfit => 'Gross profit';

  @override
  String get reportGrossProfitChart => 'Gross Profit';

  @override
  String get reportOperatingPlDisclaimer =>
      'Tax, depreciation & payroll liabilities not yet accounted — operating-level P&L approximation.';

  @override
  String get reportContraLabel => 'contra';

  @override
  String get reportNoDataForPeriod => 'No data for selected period';

  @override
  String get reportRevenueVsExpenses => 'Revenue vs Expenses';

  @override
  String get reportExpenseBreakdown => 'Expense Breakdown';

  @override
  String get reportExpenseFallback => 'Expense';

  @override
  String get reportGrossMarginPercent => 'Gross Margin %';

  @override
  String get reportRoomVsFnB => 'Room vs F&B';

  @override
  String get reportSegmentRoom => 'Room';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'Key Metrics';

  @override
  String get reportIncomeStatement => 'Income Statement';

  @override
  String get reportChartsSection => 'Charts';

  @override
  String get reportSegmentSummary => 'Segment Summary';

  @override
  String get reportFailedToLoad => 'Failed to load report';

  @override
  String get reportOverview => 'Overview';

  @override
  String get reportOverviewCash => 'Cash';

  @override
  String get reportOverviewBank => 'Bank';

  @override
  String get reportMonthlyOpeningBalance => 'Monthly opening balance';

  @override
  String get reportOpeningBalanceHint =>
      'Cash position at the start of each month';

  @override
  String get reportCashInOut => 'Cash In / Out';

  @override
  String get reportCashIn => 'Cash In';

  @override
  String get reportCashOut => 'Cash Out';

  @override
  String get reportBankReceiptsPayments => 'Bank Receipts / Payments';

  @override
  String get reportReceipts => 'Receipts';

  @override
  String get reportPayments => 'Payments';

  @override
  String get reportDailyCashVsQr => 'Daily Cash vs QR';

  @override
  String get reportSummariesSection => 'Summaries';

  @override
  String get reportCashSummary => 'Cash summary';

  @override
  String get reportBankSummary => 'Bank summary';

  @override
  String get reportDailySummary => 'Daily summary';

  @override
  String get reportTabPurchase => 'Purchase';

  @override
  String get reportTabSales => 'Sales';

  @override
  String get reportTabDashboard => 'Dashboard';

  @override
  String get reportSingleDayTrend => 'Single day — daily trend';

  @override
  String get reportFullYearTrend => 'Full year — monthly trend charts';

  @override
  String reportYearLabel(String year) {
    return 'Year $year';
  }

  @override
  String reportJanDec(String year) {
    return 'Jan – Dec $year';
  }

  @override
  String get reportTotalPurchases => 'Total purchases';

  @override
  String get reportTotalSales => 'Total sales';

  @override
  String get reportTotalInvoices => 'Total invoices';

  @override
  String get reportUnpaidBalance => 'Unpaid balance';

  @override
  String get reportAvgPerInvoice => 'Avg per invoice';

  @override
  String get reportPerTransaction => 'Per transaction';

  @override
  String reportMonthlySpend(String symbol) {
    return 'Monthly Spend ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'Monthly Sales ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'Invoice Count by Month';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'Top items by spend ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'Spend by category';

  @override
  String get reportOtherCategory => 'Other';

  @override
  String get reportSuppliers => 'Suppliers';

  @override
  String get reportTableSupplier => 'Supplier';

  @override
  String get reportTableAmount => 'Amount';

  @override
  String get reportTableBills => 'Bills';

  @override
  String get reportSalesTotal => 'Sales total';

  @override
  String get reportPurchaseTotal => 'Purchase total';

  @override
  String get reportPositiveMargin => 'Positive margin';

  @override
  String get reportNegativeMargin => 'Negative margin';

  @override
  String get reportGrossMargin => 'Gross margin';

  @override
  String get reportOfTotalSales => 'Of total sales';

  @override
  String get reportFailedToLoadAnalytics => 'Failed to load analytics';

  @override
  String get reportMarginKpi => 'Margin';

  @override
  String get reportExpensesKpi => 'Expenses';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'No $role parties found';
  }

  @override
  String get partyPickerLoadParties => 'Load parties';

  @override
  String get invoiceCashCustomer => 'Cash Customer';

  @override
  String get invoiceQuickAddItemsTitle => 'Quick add items';

  @override
  String get invoiceQuickLoadingMenu => 'Loading menu…';

  @override
  String get invoiceQuickInvoiceCreated => 'Invoice created';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'Add at least one item';

  @override
  String get invoiceQuickNoResults => 'No Result Found!';

  @override
  String get invoiceQuickNoItemsInCategory => 'No items in this category';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'Add item';

  @override
  String get invoiceQuickLoadMore => 'Load more';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'Scroll to load more ($count per page)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'Supplier / Employee';

  @override
  String get invoiceQuickEditItem => 'Edit Item';

  @override
  String get invoiceQuickFavorites => 'Favorites';

  @override
  String get invoiceQuickManageFavorites => 'Manage';

  @override
  String get invoiceQuickRepeated => 'Repeated';

  @override
  String get invoiceQuickRepeatedHint => 'Items you sell most often';

  @override
  String get invoiceQuickAddFavorite => 'Add to favorites';

  @override
  String get invoiceQuickRemoveFavorite => 'Remove from favorites';

  @override
  String get invoiceQuickFavoriteAdded => 'Added to favorites';

  @override
  String get invoiceQuickFavoriteRemoved => 'Removed from favorites';

  @override
  String get invoiceQuickNoFavorites => 'No favorite items yet';

  @override
  String get invoiceQuickNoFavoritesSubtitle =>
      'Tap the star on a dish you sell often so it shows up here.';

  @override
  String get invoiceQuickNoRepeated => 'No repeated sales yet';

  @override
  String get invoiceQuickNoRepeatedSubtitle =>
      'Items you sell more than once will appear here automatically.';

  @override
  String get closeSelectDateRange => 'Select Date Range';

  @override
  String get closeStartDate => 'Start Date';

  @override
  String get closeEndDate => 'End Date';

  @override
  String get closeSelectBothDates => 'Please select both start and end dates';

  @override
  String get closeDeleteSummary => 'Delete Summary';

  @override
  String get closeDeleteSummaryConfirm =>
      'Are you sure you want to delete this summary?';

  @override
  String get closeSelectDate => 'Select date';

  @override
  String get closeNoDataToExport => 'No data to export';

  @override
  String get closeNoDataToShare => 'No data to share';

  @override
  String get closeNoDataToPrint => 'No data to print';

  @override
  String closePdfGenerateError(String error) {
    return 'Error generating PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'Error sharing PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'Error printing PDF: $error';
  }

  @override
  String get closeExportPdf => 'Export as PDF';

  @override
  String get closeSharePdf => 'Share PDF';

  @override
  String get closePrint => 'Print';

  @override
  String get closeExportOptions => 'Export Options';

  @override
  String get closeExportPdfSubtitle => 'Save or view as PDF document';

  @override
  String get closeSharePdfSubtitle => 'Share via apps or email';

  @override
  String get closePrintSubtitle => 'Print the report';

  @override
  String get closeDailyCashSummaryTitle => 'Daily Cash Summary';

  @override
  String get closeDailyCashSummaryReport => 'Daily Cash Summary Report';

  @override
  String closeGeneratedAt(String date) {
    return 'Generated: $date';
  }

  @override
  String get closeTotalRecords => 'Total Records';

  @override
  String get closeSummaryOverview => 'Summary Overview';

  @override
  String get closeAllRecords => 'All Records';

  @override
  String closePeriodRange(String start, String end) {
    return 'Period: $start to $end';
  }

  @override
  String get closeDetails => 'Details';

  @override
  String closePageN(int n) {
    return 'Page $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'Showing $shown of $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'Loaded: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'Room / Cabin / Employee';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent% of revenue';
  }

  @override
  String get reportParties => 'Parties';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — daily trend charts';
  }

  @override
  String get invoiceQuickCart => 'Cart';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'Cart ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'Clear search';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'Add Summary';

  @override
  String get closeSalesAmount => 'Sales Amount';

  @override
  String get closeClosingBalance => 'Closing Balance';

  @override
  String get closeLostMoney => 'Lost Money';

  @override
  String get closeDiscount => 'Discount';

  @override
  String get closeExpenses => 'Expenses';

  @override
  String get closeUnpaid => 'Unpaid';

  @override
  String get closeTotalOpeningBalance => 'Total Opening Balance';

  @override
  String get closeTotalSalesAmount => 'Total Sales Amount';

  @override
  String get closeTotalCashAmount => 'Total Cash Amount';

  @override
  String get closeTotalQrAmount => 'Total QR Amount';

  @override
  String get closeTotalDiscount => 'Total Discount';

  @override
  String get closeTotalExpenses => 'Total Expenses';

  @override
  String get closeTotalClosingBalance => 'Total Closing Balance';

  @override
  String get closeTotalLostMoney => 'Total Lost Money';

  @override
  String get closeTotalExtraAmount => 'Total Extra Amount';

  @override
  String get closeShowingCurrentMonth => 'Showing current month data';

  @override
  String get closeNoSummariesFound => 'No summaries found';

  @override
  String get closeNoSummariesAvailable => 'No summaries available';

  @override
  String get closeTryAdjustingDateRange => 'Try adjusting your date range';

  @override
  String get closeCreateFirstSummary =>
      'Create your first summary to get started';

  @override
  String get closeClearFilter => 'Clear Filter';

  @override
  String get closeFiltered => 'Filtered';

  @override
  String closeFilteredWithRange(String range) {
    return 'Filtered: $range';
  }

  @override
  String get closeSummarySingular => 'Summary';

  @override
  String get closeSummariesPlural => 'Summaries';

  @override
  String get closeSummaryUpdatedSuccess => 'Summary updated successfully';

  @override
  String get closeSummaryDeletedSuccess => 'Summary deleted successfully';

  @override
  String premiumUnlockTitle(String appName) {
    return 'Unlock $appName Premium';
  }

  @override
  String get premiumTagline =>
      'Full offline POS, invoicing, inventory, and reports — one subscription for your business.';

  @override
  String get premiumFeatureUnlimitedInvoices => 'Unlimited invoices & receipts';

  @override
  String get premiumFeatureInventoryStock => 'Inventory & stock tracking';

  @override
  String get premiumFeatureReportsAnalytics => 'Sales reports & analytics';

  @override
  String get premiumFeatureOfflineLocal =>
      'Works offline — your data stays local';

  @override
  String premiumContinueWith(String plan) {
    return 'Continue with $plan';
  }

  @override
  String get premiumRestorePurchases => 'Restore purchases';

  @override
  String get premiumRestorePreviousPurchase => 'Restore previous purchase';

  @override
  String get premiumPaywallSubscriptionLegal =>
      'Payment is charged to your Apple ID or Google Play account at confirmation. Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period.';

  @override
  String get premiumPaywallLifetimeLegal =>
      'One-time purchase. Payment is charged to your Apple ID or Google Play account at confirmation. Lifetime access does not renew.';

  @override
  String get premiumPaywallAgreePrefix => 'By subscribing you agree to our ';

  @override
  String get premiumPaywallAgreeConjunction => ' and ';

  @override
  String get premiumPaywallTermsOfUse => 'Terms of Use';

  @override
  String get premiumPaywallPrivacyPolicy => 'Privacy Policy';

  @override
  String get premiumSubscriptionLegal =>
      'Payment charged to your Apple ID. Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period.';

  @override
  String get premiumPurchaseRestored => 'Purchase restored.';

  @override
  String get premiumNoActiveSubscription => 'No active subscription found.';

  @override
  String get premiumPlanMonthly => 'Monthly';

  @override
  String get premiumPlanMonthlySubtitle => 'Flexible — cancel anytime';

  @override
  String get premiumPlanYearly => 'Yearly';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'Best value — save $percent%';
  }

  @override
  String get premiumPlanLifetime => 'Lifetime';

  @override
  String get premiumPlanLifetimeSubtitle => 'Pay once, keep forever';

  @override
  String get premiumPlanPopular => 'Popular';

  @override
  String get premiumOneTimePurchase => 'One-time purchase';

  @override
  String get subscriptionSectionTitle => 'Subscription';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Upgrade to Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'Monthly $monthly · Yearly $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan active until $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan active';
  }

  @override
  String get premiumRequired => 'Premium required';

  @override
  String get upgradeToPremiumContinue => 'Upgrade to Premium to continue.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'Free plan allows up to $limit $label. Upgrade to Premium for unlimited access.';
  }

  @override
  String get freemiumPartyRoleRequired => 'Party role is required.';

  @override
  String get freemiumLabelSalesInvoices => 'sales invoices';

  @override
  String get freemiumLabelPurchaseInvoices => 'purchase invoices';

  @override
  String get freemiumLabelEmployees => 'employees';

  @override
  String get freemiumLabelItems => 'items';

  @override
  String get freemiumLabelCategories => 'categories';

  @override
  String get freemiumLabelPaymentMethods => 'payment methods';

  @override
  String get freemiumLabelCustomPartyRoles => 'custom party roles';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'parties for $role';
  }

  @override
  String get freemiumLabelOrganizations => 'organizations';

  @override
  String get freemiumPremiumReports => 'Reports are available with Premium.';

  @override
  String get freemiumPremiumBackupSync => 'Backup & sync requires Premium.';

  @override
  String get freemiumPremiumPayroll => 'Payroll requires Premium.';

  @override
  String get freemiumPremiumAttendance => 'Attendance requires Premium.';

  @override
  String get freemiumPremiumStock => 'Stock management requires Premium.';

  @override
  String get freemiumPremiumInvoiceExport =>
      'Download and print requires Premium.';

  @override
  String get shiftReminderOpeningTitle => 'Opening reminder';

  @override
  String get shiftReminderOpeningMessage =>
      'Did you open the register for today?';

  @override
  String get shiftReminderOpeningProceed => 'Yes, open now';

  @override
  String get shiftReminderClosingTitle => 'Closing reminder';

  @override
  String get shiftReminderClosingMessage =>
      'Did you close the register for today?';

  @override
  String get shiftReminderClosingProceed => 'Yes, close now';

  @override
  String get shiftReminderSkipToday => 'Skip for today';

  @override
  String get shiftReminderOpeningNotificationTitle => 'Opening reminder';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'Did you open the register for today? Tap here if you still need to open.';

  @override
  String get shiftReminderClosingNotificationTitle => 'Closing reminder';

  @override
  String get shiftReminderClosingNotificationBody =>
      'Did you close the register for today? Tap here if you still need to close.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business pays QR to the customer; the customer provides cash.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business pays cash to the customer; the customer provides QR payment.';
  }

  @override
  String get closePaymentExchange => 'Payment exchange';

  @override
  String get closePayQrGetCashExchangeLabel => 'Pay QR → Get cash exchange';

  @override
  String get closePayCashGetQrExchangeLabel => 'Pay cash → Get QR exchange';

  @override
  String get closePayQrGetCashDetail => 'Pay QR get cash';

  @override
  String get closePayCashGetQrDetail => 'Pay cash get QR';

  @override
  String get faqSectionPremium => 'Premium & billing';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'What does Premium include?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium unlocks unlimited invoices, full reports (P&L, statement, analytics), backup & sync, payroll, attendance, stock tools, invoice export/print, and additional organizations. The free tier still lets you use core POS features within fair limits.';

  @override
  String get faqPremiumFreeTierQuestion => 'What is included in the free tier?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'You can create up to 10 sales and 10 purchase invoices, 4 employees, 30 items, and other limits shown when you reach them. Opening, closing, calculator, and browsing your data stay free.';

  @override
  String get faqPremiumRestoreQuestion => 'How do I restore my purchase?';

  @override
  String get faqPremiumRestoreAnswer =>
      'Open More → Upgrade to Premium (or the paywall) and tap Restore purchases. Use the same Apple ID you used to subscribe.';

  @override
  String get faqPremiumCancelQuestion => 'How do I cancel my subscription?';

  @override
  String get faqPremiumCancelAnswer =>
      'Manage or cancel in iPhone Settings → Apple ID → Subscriptions. You keep access until the end of the paid period.';

  @override
  String get faqDarkModeQuestion => 'How do I turn on dark mode?';

  @override
  String get faqDarkModeAnswer =>
      'Open More → Appearance and enable Dark mode. When your device uses system theme, the app follows it automatically.';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'What are opening and closing reminders?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName can remind you to open or close the daily cash register. You can proceed, skip for today, or dismiss the reminder.';
  }

  @override
  String get faqPartyRolesQuestion => 'What are party roles?';

  @override
  String get faqPartyRolesAnswer =>
      'Party roles classify contacts such as customers, suppliers, rooms, or employees. Customize roles under Operations → Party roles and add a short description for your team.';

  @override
  String faqRateAppQuestion(String appName) {
    return 'How do I rate $appName?';
  }

  @override
  String get faqRateAppAnswer =>
      'Open More → Rate us to leave a review on the App Store. Your feedback helps us improve offline billing for your business.';
}
