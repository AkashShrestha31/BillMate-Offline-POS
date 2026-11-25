// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get noInternetConnection => 'इन्टरनेट जडान छैन।';

  @override
  String get formatException => 'ढाँचा अपवाद';

  @override
  String get rememberMe => 'मलाई सम्झनुस्';

  @override
  String get signIn => 'साइन इन गर्नुस्';

  @override
  String get passwordHint => 'पासवर्ड प्रविष्ट गर्नुस्';

  @override
  String get forgetPassword => 'लगइन जानकारी बिर्सनुभयो?';

  @override
  String get okay => 'ठीक छ';

  @override
  String get success => 'सफल';

  @override
  String get hotel => 'होटल';

  @override
  String get errorEncountered => 'त्रुटि भेटियो';

  @override
  String get serverError => 'सर्भर त्रुटि';

  @override
  String get requestFailed => 'अनुरोध असफल';

  @override
  String get connectionTimedOut => 'जडान समय समाप्त';

  @override
  String get password => 'पासवर्ड';

  @override
  String get keepSignIn => 'साइन इन रहनुस्';

  @override
  String get enterPassword => 'पासवर्ड प्रविष्ट गर्नुस्';

  @override
  String get enterValidPassword => 'मान्य पासवर्ड प्रविष्ट गर्नुस्';

  @override
  String get skip => 'छोड्नुस्';

  @override
  String get pleaseWait => 'कृपया प्रतीक्षा गर्नुस् ....';

  @override
  String get enterValidUserName => 'मान्य प्रयोगकर्ता नाम प्रविष्ट गर्नुस्।';

  @override
  String get userName => 'प्रयोगकर्ता नाम';

  @override
  String get or => 'वा';

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get error => 'त्रुटि';

  @override
  String get supportMessage => 'कृपया प्रशासकलाई सम्पर्क गर्नुस्।';

  @override
  String get responseMessage404 => '४०४ त्रुटि';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'संस्करण $version';
  }

  @override
  String get cancel => 'रद्द गर्नुहोस्';

  @override
  String get yes => 'हो';

  @override
  String get no => 'होइन';

  @override
  String get close => 'बन्द गर्नुस्';

  @override
  String get save => 'सुरक्षित गर्नुस्';

  @override
  String get delete => 'मेटाउनुहोस्';

  @override
  String get deleteOrganizationTitle => 'संगठन हटाउने?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'यस डिभाइसबाट $name हटाउनुस्। यस संगठनका सबै स्थानीय डेटा मेटिनेछ।';
  }

  @override
  String get deleteOrganizationWarning => 'यो पूर्ववत गर्न सकिँदैन।';

  @override
  String get organizationDeleted => 'संगठन हटाइयो';

  @override
  String get confirm => 'पुष्टि गर्नुस्';

  @override
  String get done => 'भयो';

  @override
  String get next => 'अर्को';

  @override
  String get getStarted => 'सुरु गर्नुस्';

  @override
  String get walkthroughDashboardTitle => 'तपाईंको पूरा व्यवसाय, एक नजरमा';

  @override
  String get walkthroughDashboardDescription =>
      'आजको बिक्री, आम्दानी र बाँकी ब्यालेन्स — एप खोल्दै एक सफा ड्यासबोर्डमा।';

  @override
  String get walkthroughOfflineTitle => 'इन्टरनेट बिना पनि काम गर्छ';

  @override
  String get walkthroughOfflineDescription =>
      'पूर्ण अफलाइनमा इनभ्वाइस बनाउनुहोस्, खर्च लग गर्नुहोस् र स्टक व्यवस्थापन गर्नुहोस्। अनलाइन हुँदा सबै स्वचालित सिङ्क।';

  @override
  String get walkthroughBillingTitle => 'केही सेकेन्डमा बिल र बिक्री';

  @override
  String get walkthroughBillingDescription =>
      'बिक्री र खरिद इनभ्वाइस, किचन टिकट सहित टेबल अर्डर, र लाइभ इनभेन्टरी — सबै एउटै एपमा।';

  @override
  String get walkthroughStaffTitle => 'कर्मचारी, तलब र प्रतिवेदन';

  @override
  String get walkthroughStaffDescription =>
      'उपस्थिति र तलब चलाउनुहोस्, त्यसपछि P&L र पे-स्लिप PDF निर्यात गर्नुहोस् — अतिरिक्त उपकरण चाहिँदैन।';

  @override
  String get walkthroughBackupTitle => 'तपाईंको डेटा, सधैं सुरक्षित';

  @override
  String get walkthroughBackupDescription =>
      'एक-ट्याप Google Drive ब्याकअपसँग बैंक-स्तरको सुरक्षा — तपाईंका रेकर्ड सुरक्षित र सजिलै पुनर्स्थापना।';

  @override
  String get walkthroughReadyTitle => 'तपाईं तयार हुँदा तयार';

  @override
  String get walkthroughReadyDescription =>
      'केही मिनेटमा संगठन सेटअप गर्नुहोस् र आजै स्मार्ट तरिकाले व्यवसाय चलाउनुहोस्। सुरु गरौं।';

  @override
  String get back => 'पछाडि';

  @override
  String get submit => 'पेश गर्नुस्';

  @override
  String get continueAction => 'जारी राख्नुस्';

  @override
  String get createAction => 'सिर्जना गर्नुस्';

  @override
  String get connectOrganizationTitle => 'आफ्नो संगठन जोड्नुस्';

  @override
  String get connectOrganizationSubtitle => 'साइन इन गर्न संगठन छान्नुस्।';

  @override
  String get selectOrganization => 'संगठनहरू';

  @override
  String get selectOrganizationHint => 'जारी राख्न संगठनमा ट्याप गर्नुस्';

  @override
  String get noSavedOrganizationsYet =>
      'अझै कुनै संगठन छैन। एउटा बनाउनुस् वा तलको परीक्षण डेटा प्रयोग गर्नुस्।';

  @override
  String get orgConnectOnceInfo =>
      'यसले एपलाई तपाईंको व्यवसाय खातासँग जोड्छ। तपाईंले यसलाई प्रति डिभाइस एक पटक मात्र सेट गर्न पर्छ।';

  @override
  String organizationCodeLabel(String code) {
    return 'कोड: $code';
  }

  @override
  String get tryAgain => 'पुनः प्रयास गर्नुस्';

  @override
  String get warning => 'चेतावनी';

  @override
  String get loading => 'लोड हुँदै…';

  @override
  String get comingSoon => 'चाँडै आउँदैछ';

  @override
  String get required => 'आवश्यक';

  @override
  String get search => 'खोज';

  @override
  String get add => 'थप्नुस्';

  @override
  String get edit => 'सम्पादन गर्नुस्';

  @override
  String get remove => 'हटाउनुस्';

  @override
  String get view => 'हेर्नुस्';

  @override
  String get export => 'निर्यात';

  @override
  String get exportAsPdf => 'PDF को रूपमा निर्यात गर्नुहोस्';

  @override
  String get sharePdf => 'PDF साझा गर्नुहोस्';

  @override
  String get partyExportPdfTooltip => 'PDF निर्यात';

  @override
  String get import => 'आयात गर्नुस्';

  @override
  String get refresh => 'रिफ्रेश गर्नुस्';

  @override
  String get select => 'छान्नुस्';

  @override
  String get upload => 'अपलोड गर्नुस्';

  @override
  String get download => 'डाउनलोड गर्नुस्';

  @override
  String get share => 'साझा गर्नुस्';

  @override
  String get filter => 'फिल्टर';

  @override
  String get sort => 'क्रमबद्ध गर्नुस्';

  @override
  String get apply => 'लागू गर्नुस्';

  @override
  String get reset => 'रिसेट गर्नुस्';

  @override
  String get clear => 'खाली गर्नुहोस्';

  @override
  String get all => 'सबै';

  @override
  String get none => 'कुनै पनि होइन';

  @override
  String get total => 'कुल';

  @override
  String get subtotal => 'उप-जम्मा';

  @override
  String get grandTotal => 'कुल जम्मा';

  @override
  String get amount => 'रकम';

  @override
  String get quantity => 'मात्रा';

  @override
  String get rate => 'दर';

  @override
  String get discount => 'छुट';

  @override
  String get paid => 'भुक्तानी गरिएको';

  @override
  String get unpaid => 'नतिरेको';

  @override
  String get credit => 'उधारो';

  @override
  String get cash => 'नगद';

  @override
  String get date => 'मिति';

  @override
  String get time => 'समय';

  @override
  String get name => 'नाम';

  @override
  String get email => 'इमेल';

  @override
  String get phone => 'फोन';

  @override
  String get address => 'ठेगाना';

  @override
  String get notes => 'नोटहरू';

  @override
  String get description => 'विवरण';

  @override
  String get status => 'स्थिति';

  @override
  String get type => 'प्रकार';

  @override
  String get category => 'श्रेणी';

  @override
  String get party => 'पक्ष';

  @override
  String get item => 'वस्तु';

  @override
  String get payment => 'भुक्तानी';

  @override
  String get settlement => 'फर्छ्योट';

  @override
  String get opening => 'प्रारम्भिक';

  @override
  String get closing => 'अन्तिम';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'खर्च';

  @override
  String get revenue => 'राजस्व';

  @override
  String get profit => 'नाफा';

  @override
  String get loss => 'नोक्सान';

  @override
  String get sales => 'बिक्री';

  @override
  String get purchase => 'खरिद';

  @override
  String get monthJan => 'जन';

  @override
  String get monthFeb => 'फेब';

  @override
  String get monthMar => 'मार्च';

  @override
  String get monthApr => 'अप्र';

  @override
  String get monthMay => 'मे';

  @override
  String get monthJun => 'जुन';

  @override
  String get monthJul => 'जुल';

  @override
  String get monthAug => 'अग';

  @override
  String get monthSep => 'सेप';

  @override
  String get monthOct => 'अक्ट';

  @override
  String get monthNov => 'नोभ';

  @override
  String get monthDec => 'डिस';

  @override
  String get more => 'थप';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String get operations => 'सञ्चालन';

  @override
  String get operationManagement => 'सञ्चालन व्यवस्थापन';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'कर्मचारी व्यवस्थापन';

  @override
  String get employeeManagementSubtitle => 'कर्मचारी, तलब र उपस्थिति';

  @override
  String get report => 'प्रतिवेदन';

  @override
  String get reportSubtitle => 'नाफा-नोक्सान, विवरण र विश्लेषण';

  @override
  String get helpAndSupport => 'सहायता र समर्थन';

  @override
  String get preferences => 'प्राथमिकताहरू';

  @override
  String get dataAndBackup => 'डेटा र ब्याकअप';

  @override
  String get privacyAndPolicies => 'गोपनीयता र नीतिहरू';

  @override
  String get faq => 'बारम्बार सोधिने प्रश्नहरू';

  @override
  String get contactSupport => 'समर्थनमा सम्पर्क गर्नुस्';

  @override
  String get rateUs => 'हामीलाई मूल्याङ्कन गर्नुहोस्';

  @override
  String get rateUsSubtitle =>
      'BizTrack मन पर्यो? Google Play मा समीक्षा छोड्नुहोस्';

  @override
  String get rateUsUnavailable =>
      'स्टोर खोल्न सकिएन। पछि पुनः प्रयास गर्नुहोस्।';

  @override
  String get reportProblem => 'समस्या रिपोर्ट';

  @override
  String get contactUs => 'सम्पर्क गर्नुहोस्';

  @override
  String get contactUsSubtitle =>
      'सहयोग, प्रतिक्रिया वा एप सम्बन्धी प्रश्नका लागि सम्पर्क गर्नुहोस्।';

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
  String get developerLabel => 'विकासकर्ता';

  @override
  String get emailCopiedToClipboard => 'इमेल क्लिपबोर्डमा प्रतिलिपि भयो';

  @override
  String get logout => 'लग आउट';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get settings => 'सेटिङहरू';

  @override
  String get testData => 'परीक्षण डेटा';

  @override
  String get loginWithTestData => 'परीक्षण डेटासँग लगइन गर्नुस्';

  @override
  String get loginWithTestDataSubtitle =>
      'डेमो होटल डेटा लोड गर्नुस् र स्वचालित रूपमा साइन इन गर्नुस्';

  @override
  String testDataLoginFailed(String error) {
    return 'परीक्षण डेटा लोड गर्न सकिएन: $error';
  }

  @override
  String get preparingTestData => 'डेमो डेटा तयार हुँदैछ…';

  @override
  String get regionAndCurrency => 'क्षेत्र र मुद्रा';

  @override
  String get reportingCurrency => 'प्रतिवेदन मुद्रा';

  @override
  String get selectCurrency => 'मुद्रा छान्नुस्';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · नमूना $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'मुद्रा $code ($symbol) मा सेट गरियो';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'मुद्रा अद्यावधिक गर्न सकिएन: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return '$appName सेटअप गर्नुस्';
  }

  @override
  String get setupSubtitle =>
      'आफ्नो संगठन र लेखा कन्फिगर गर्नुस् — अफलाइन प्रयोगका लागि यस उपकरणमा भण्डारण गरिएको।';

  @override
  String get setupOrganizationName => 'संगठनको नाम';

  @override
  String get setupCompanyName => 'कम्पनीको नाम';

  @override
  String get setupBusinessType => 'व्यापारको प्रकार';

  @override
  String get selectBusinessType => 'व्यापारको प्रकार छान्नुहोस्';

  @override
  String get businessTypeHotel => 'होटल';

  @override
  String get businessTypeHotelSubtitle => 'कोठा, पाहुना र फ्रन्ट डेस्क';

  @override
  String get businessTypeRestaurant => 'रेस्टुरेन्ट';

  @override
  String get businessTypeRestaurantSubtitle => 'डाइन-इन, भान्सा र टेबल अर्डर';

  @override
  String get businessTypeHotelRestaurant => 'होटल र रेस्टुरेन्ट';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'होटल कोठा र रेस्टुरेन्ट एकैसाथ';

  @override
  String get businessTypeRetail => 'खुद्रा / पसल';

  @override
  String get businessTypeRetailSubtitle => 'सामान, स्टक र चेकआउट';

  @override
  String get businessTypeCafe => 'क्याफे / बेकरी';

  @override
  String get businessTypeCafeSubtitle => 'कफी, पेस्ट्री र हल्का खाजा';

  @override
  String get businessTypeBar => 'बार / पब';

  @override
  String get businessTypeBarSubtitle => 'पेय पदार्थ, ट्याब र बार बिक्री';

  @override
  String get businessTypeOther => 'अन्य';

  @override
  String get businessTypeOtherSubtitle =>
      'कुनै पनि व्यापारको लागि अनुकूल सेटअप';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'प्रकार: $type';
  }

  @override
  String get organizationSettings => 'संस्था';

  @override
  String get editOrganizationInfo => 'संस्थाको जानकारी';

  @override
  String get editOrganizationInfoSubtitle =>
      'यो व्यापार एपमा कसरी देखिन्छ भनी अपडेट गर्नुहोस्। संस्थाको कोड परिवर्तन गर्न सकिँदैन।';

  @override
  String get organizationCode => 'संस्थाको कोड';

  @override
  String get organizationCodeReadOnly => 'यो कोड सेटअप पछि स्थिर छ।';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'संस्थाको जानकारी सुरक्षित भयो';

  @override
  String get organizationInfoLoadFailed => 'संस्थाको जानकारी लोड गर्न सकिएन';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'संस्थाको जानकारी सुरक्षित गर्न सकिएन: $error';
  }

  @override
  String get organizationTabGeneral => 'सामान्य';

  @override
  String get organizationTabRegional => 'क्षेत्रीय र आर्थिक';

  @override
  String get organizationRegionalSubtitle =>
      'देश, रिपोर्टिङ मुद्रा र आर्थिक वर्ष मितिहरू।';

  @override
  String get organizationTabAccounting => 'लेखा';

  @override
  String get organizationAccountingSubtitle =>
      'इनभ्वाइस र रकम प्रदर्शन सेटिङहरू।';

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
  String get displayPrecision => 'प्रदर्शन शुद्धता';

  @override
  String get displayPrecisionRange =>
      '० देखि ५ सम्मको संख्या प्रविष्ट गर्नुहोस्';

  @override
  String get enableInvoiceReturns => 'इनभ्वाइस रिटर्न सक्षम गर्नुहोस्';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'भुक्तानी भएका इनभ्वाइसबाट रिटर्न बनाउन अनुमति दिनुहोस्।';

  @override
  String get saveChanges => 'परिवर्तनहरू सुरक्षित गर्नुहोस्';

  @override
  String get setupFullName => 'पूरा नाम';

  @override
  String get setupConfirmPassword => 'पासवर्ड पुष्टि गर्नुस्';

  @override
  String get setupBankName => 'बैंकको नाम';

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
  String get setupRegionStepTitle => 'क्षेत्र र मुद्रा';

  @override
  String get setupOrganizationStepTitle => 'संगठन';

  @override
  String get setupOrganizationStepSubtitle =>
      'तपाईंको व्यवसाय एपमा कसरी देखिन्छ';

  @override
  String get setupAdminStepTitle => 'प्रशासक खाता';

  @override
  String get setupAdminStepSubtitle => 'यस स्थापनाको प्राथमिक प्रयोगकर्ता';

  @override
  String get setupAccountingStepTitle => 'लेखाँकन';

  @override
  String get setupAccountingStepSubtitle => 'बैंक, खाता चार्ट र वित्तीय वर्ष';

  @override
  String get setupCompleteSetup => 'सेटअप पूर्ण गर्नुस्';

  @override
  String fieldRequired(String field) {
    return '$field आवश्यक छ';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'मान्य इमेल ठेगाना प्रविष्ट गर्नुस्';

  @override
  String passwordMinLength(int min) {
    return 'पासवर्ड कम्तीमा $min अक्षरको हुनुपर्छ';
  }

  @override
  String get passwordsDoNotMatch => 'पासवर्डहरू मेल खाँदैनन्';

  @override
  String get setupFixValidationErrors => 'जारी राख्न तलका त्रुटिहरू सुधार्नुस्';

  @override
  String get setupCompleteSuccess => 'सेटअप सफलतापूर्वक पूर्ण भयो';

  @override
  String get setupCompleteWithPdfSuccess =>
      'सेटअप पूर्ण। PDF सुरक्षित स्थानमा सहेजनुस्।';

  @override
  String setupPdfFailed(String error) {
    return 'सेटअप पूर्ण भयो, तर PDF सहेज्न सकिएन: $error';
  }

  @override
  String get setupFailed =>
      'सेटअप पूर्ण गर्न सकिएन। कृपया पुनः प्रयास गर्नुस्।';

  @override
  String setupFailedWithDetails(String error) {
    return 'सेटअप असफल: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'स्थानीय सेटिङ र रिपोर्टिङ मुद्रा।';

  @override
  String get country => 'देश';

  @override
  String get currency => 'मुद्रा';

  @override
  String get selectCountry => 'देश छान्नुस्';

  @override
  String get language => 'भाषा';

  @override
  String get selectLanguage => 'भाषा छान्नुस्';

  @override
  String get languageChangeLaterHint =>
      'तपाईं यसलाई पछि सेटिङ्हरूबाट परिवर्तन गर्न सक्नुहुन्छ';

  @override
  String languageSelectionSubtitle(String appName) {
    return '$appName कसरी प्रयोग गर्न चाहनुहुन्छ छान्नुहोस्। तपाईं यसलाई पछि सेटिङ्हरूबाट परिवर्तन गर्न सक्नुहुन्छ।';
  }

  @override
  String get searchLanguages => 'भाषाहरू खोज्नुहोस्';

  @override
  String get languageSuggestedBadge => 'सिफारिस';

  @override
  String continueInLanguage(String languageName) {
    return '$languageName मा जारी राख्नुहोस्';
  }

  @override
  String get noLanguageMatches => 'कुनै मिल्दो छैन';

  @override
  String noLanguageMatchesForQuery(String query) {
    return '\"$query\" सँग कुनै भाषा मिलेन';
  }

  @override
  String get appearance => 'देखावट';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get darkModeSubtitle => 'एपभरि गाढा पृष्ठभूमि प्रयोग गर्नुहोस्';

  @override
  String get darkModeSystemSubtitle => 'तपाईंको उपकरणको थिम अनुसरण गर्छ';

  @override
  String languageUpdated(String name) {
    return 'भाषा $name मा सेट गरियो';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'भाषा अद्यावधिक गर्न सकिएन: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return '$appName मा स्वागत छ';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'जारी राख्न कृपया $appName को नवीनतम संस्करण स्थापना गर्नुस्।';
  }

  @override
  String generatedByApp(String appName) {
    return '$appName द्वारा उत्पन्न';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName के हो?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName ले तपाईंलाई बिक्री र खरिद बिल, पक्षहरू (ग्राहक र आपूर्तिकर्ता), स्टक, भुक्तानी, कर्मचारी र दैनिक सारांश आफ्नो फोन वा ट्याब्लेटबाट व्यवस्थापन गर्न मद्दत गर्छ।';
  }

  @override
  String faqIntro(String appName) {
    return '$appName बारे सामान्य प्रश्नहरूको उत्तर।';
  }

  @override
  String get chooseFromGallery => 'ग्यालेरीबाट छान्नुस्';

  @override
  String get takePhoto => 'फोटो लिनुस्';

  @override
  String get photoLibrary => 'फोटो लाइब्रेरी';

  @override
  String get addPhoto => 'फोटो थप्नुस्';

  @override
  String couldNotPickImage(String error) {
    return 'छवि छान्न सकिएन: $error';
  }

  @override
  String get unpaidAmount => 'भुक्तानी नगरिएको रकम';

  @override
  String get unpaidBalance => 'भुक्तानी नगरिएको बाँकी';

  @override
  String unpaidColonAmount(String amount) {
    return 'भुक्तानी नगरिएको: $amount';
  }

  @override
  String get previousUnpaid => 'अघिल्लो भुक्तानी नगरिएको';

  @override
  String get partyUnpaid => 'पार्टी भुक्तानी नगरिएको';

  @override
  String get loadingUnpaid => 'भुक्तानी नगरिएको लोड हुँदैछ…';

  @override
  String get totalUnpaid => 'कुल भुक्तानी नगरिएको';

  @override
  String get unpaidAmountNotYetCollected =>
      'अपरिशोधित रकम अझै सङ्कलन भएको छैन।';

  @override
  String get partyUnpaidTabHint =>
      'कर्मचारीहरू खोल्नुहोस्, एक व्यक्ति छान्नुहोस्, त्यसपछि उनीहरूको प्रोफाइलमा पार्टी अपरिशोधित थिच्नुहोस्। सर्भरलाई यो खोजीको लागि कर्मचारी आईडी चाहिन्छ।';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'पार्टी भुक्तानीले अपरिशोधित कुल रकम प्रयोग गर्छ।';

  @override
  String get selectPartyWithUnpaidFirst =>
      'पहिले भुक्तानीको रकम प्रविष्ट गर्नुहोस् (वा अपरिशोधित भएको पार्टी छान्नुहोस्)।';

  @override
  String get workspace => 'कार्यस्थान';

  @override
  String get change => 'परिवर्तन गर्नुहोस्';

  @override
  String get addMoreOrganization => 'थप थप्नुहोस् +';

  @override
  String get connectAnotherOrganization => 'अर्को संस्था जोड्नुहोस्';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'अझै कुनै सुरक्षित संस्था छैन। एउटा जोड्न थप थप्नुहोस् + प्रयोग गर्नुहोस्।';

  @override
  String get registerNewOrganizationTitleSignedIn => 'नयाँ संस्था दर्ता गर्ने?';

  @override
  String get registerNewOrganizationTitle => 'नयाँ संस्था दर्ता गर्ने?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'तपाईं साइन आउट हुनुहुनेछ र सेटअप विजार्ड सुरुदेखि सुरु हुनेछ ताकि तपाईं यस यन्त्रमा नयाँ व्यापार दर्ता गर्न सक्नुहुन्छ।\n\nतपाईंले पहिले नै सुरक्षित गरेका संस्थाहरू सेटअप पछि सूचीमा रहनेछन्।';

  @override
  String get registerNewOrganizationMessageLogin =>
      'यस यन्त्रमा नयाँ व्यापार दर्ता गर्न सेटअप विजार्ड सुरु हुनेछ। यसलाई बनाउन सेटअप पूरा गर्नुहोस्; तपाईंका सुरक्षित संस्थाहरू सूचीमा रहन्छन्।';

  @override
  String get startSetup => 'सेटअप सुरु गर्नुहोस्';

  @override
  String get enterOrganizationCode =>
      'कृपया तपाईंको संस्थाको कोड प्रविष्ट गर्नुहोस्';

  @override
  String get organizationNotFoundCheckCode =>
      'संस्था फेला परेन। कोड जाँच गरी पुनः प्रयास गर्नुहोस्।';

  @override
  String get organizationNotFound => 'संस्था फेला परेन';

  @override
  String get couldNotVerifyOrganization => 'संस्था प्रमाणित गर्न सकिएन';

  @override
  String noLocalDataCompleteSetup(String name) {
    return '$name को लागि कुनै स्थानीय डेटा छैन। पहिले यस संस्थाको सेटअप पूरा गर्नुहोस्।';
  }

  @override
  String get welcomeBack => 'फर्केर स्वागत छ';

  @override
  String get signInToContinue => 'जारी राख्न साइन इन गर्नुहोस्';

  @override
  String get enterEmail => 'इमेल प्रविष्ट गर्नुहोस्';

  @override
  String get pleaseEnterEmail => 'कृपया तपाईंको इमेल प्रविष्ट गर्नुहोस्';

  @override
  String get pleaseEnterValidEmail => 'कृपया मान्य इमेल प्रविष्ट गर्नुहोस्';

  @override
  String get enterEmailLocalPartOnly => '@ अघिको भाग मात्र प्रविष्ट गर्नुहोस्';

  @override
  String get pleaseEnterPassword => 'कृपया तपाईंको पासवर्ड प्रविष्ट गर्नुहोस्';

  @override
  String get logIn => 'लग इन';

  @override
  String get searchCountry => 'देश खोज्नुहोस्';

  @override
  String get searchCodeOrSymbol => 'कोड वा प्रतीक खोज्नुहोस्';

  @override
  String get saveLoginDetailsTitle => 'लगइन विवरण सुरक्षित गर्ने?';

  @override
  String get saveLoginDetailsMessage =>
      'तपाईं यस संस्थाको सेटअप पूरा गर्न लाग्नुभएको छ।\n\nतपाईंको संस्था कोड, संस्थाको नाम, लगइन इमेल र पासवर्ड भएको PDF सुरक्षित रूपमा डाउनलोड गर्न चाहनुहुन्छ? सुरक्षित ठाउँमा राख्नुहोस् — यो फाइल भएको जो कोहीले पनि साइन इन गर्न सक्छ।';

  @override
  String get downloadPdfAndContinue => 'PDF डाउनलोड गरी जारी राख्नुहोस्';

  @override
  String get continueWithoutPdf => 'PDF बिना जारी राख्नुहोस्';

  @override
  String get legalDisplayNameHint => 'कानूनी / प्रदर्शन नाम';

  @override
  String get chartOfAccounts => 'खाताको चार्ट';

  @override
  String get fiscalYearStart => 'आर्थिक वर्षको सुरुवात';

  @override
  String get fiscalYearEnd => 'आर्थिक वर्षको अन्त्य';

  @override
  String get removeTestDataTitle => 'परीक्षण डेटा हटाउने?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'सबै डेमो बिक्री, खरिद, सम्पर्कहरू, पार्टीहरू, इन्भेन्टरी वस्तुहरू, कर्मचारीहरू, मदिरा क्याल्कुलेटर उत्पादनहरू र थप डेमो संस्थाहरू हटाइनेछन्।\n\nतपाईं डेमो संस्थामा हुनुहुन्छ — यसपछि तपाईं स्वचालित रूपमा आफ्नो पहिलो संस्थामा फर्किनुहुनेछ।';

  @override
  String get removeTestDataMessageNormal =>
      'सबै डेमो बिक्री, खरिद, सम्पर्कहरू, पार्टीहरू, इन्भेन्टरी वस्तुहरू, कर्मचारीहरू र ३ थप डेमो संस्थाहरू हटाइनेछन्। तपाईंको एडमिन खाता र वास्तविक सेटअप डेटा सुरक्षित रहन्छ।';

  @override
  String get removeTestDataWarning =>
      'परीक्षण डेटा पुनः लोड नगरी यो फिर्ता गर्न सकिँदैन।';

  @override
  String get removeTestData => 'परीक्षण डेटा हटाउनुहोस्';

  @override
  String get keepTestData => 'परीक्षण डेटा राख्नुहोस्';

  @override
  String get demoDataRemoved => 'डेमो डेटा हटाइयो';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'परीक्षण डेटा हटाइयो। $name मा स्विच गरियो।';
  }

  @override
  String get testDataRemoved => 'परीक्षण डेटा हटाइयो';

  @override
  String couldNotRemoveTestData(String error) {
    return 'परीक्षण डेटा हटाउन सकिएन: $error';
  }

  @override
  String get loadTestDataTitle => 'परीक्षण डेटा लोड गर्ने?';

  @override
  String get loadTestDataMessage =>
      'यसले ५० सम्म डेमो सम्पर्कहरू, ५० बिक्री मात्र र ५० खरिद मात्र इन्भेन्टरी वस्तुहरू, साथै नमुना बिक्री, खरिद, भुक्तानी, स्टक, बन्द सारांशहरू, कर्मचारीहरू, तलब, पछिल्लो १५ दिनको उपस्थिति र क्याल्कुलेटरको लागि नमुना मदिरा उत्पादनहरू थप्नेछ।';

  @override
  String get loadTestData => 'परीक्षण डेटा लोड गर्नुहोस्';

  @override
  String get testDataLoaded => 'परीक्षण डेटा लोड भयो';

  @override
  String couldNotLoadTestData(String error) {
    return 'परीक्षण डेटा लोड गर्न सकिएन: $error';
  }

  @override
  String get demoTestData => 'डेमो परीक्षण डेटा';

  @override
  String get importTestDataSubtitle =>
      'सबै सुविधाहरूको लागि परीक्षण डेटा आयात गर्नुहोस्';

  @override
  String get hideTestDataTitle => 'यस संस्थाको लागि परीक्षण डेटा लुकाउने?';

  @override
  String get hideTestDataMessage =>
      'तपाईं जारी राख्नुभयो भने, परीक्षण डेटा खण्ड यस संस्थामा सर्वत्र लुकाइनेछ (सेटअप सहित)। तपाईं एप पुनः स्थापना गरेर वा यस संस्थाको एप डेटा खाली गरेर मात्र पुनः सक्षम गर्न सक्नुहुन्छ।';

  @override
  String get hideTestDataWarning =>
      'पहिले नै लोड भएको डेमो डेटा डेटाबेसमा तपाईंले सेटिङ्सबाट नहटाउन्जेल रहनेछ।';

  @override
  String get okHideTestData => 'ठीक छ, परीक्षण डेटा लुकाउनुहोस्';

  @override
  String get testDataHiddenForOrg => 'यस संस्थाको लागि परीक्षण डेटा लुकाइयो';

  @override
  String get hideTestDataTooltip => 'यस संस्थाको लागि परीक्षण डेटा लुकाउनुहोस्';

  @override
  String get partyRolesTitle => 'पार्टी भूमिकाहरू';

  @override
  String get partyRolesMoreSubtitle => 'ग्राहक, आपूर्तिकर्ता, दुवै र थप';

  @override
  String get exploreCustomizeTitle => 'सुविधाहरू अनुकूलन गर्नुहोस्';

  @override
  String get exploreCustomizeSubtitle =>
      'तपाईंको होम स्क्रिनमा सर्टकट देखाउनुहोस् वा लुकाउनुहोस्। तपाईंको संस्थाले पहुँच पाउने सुविधाहरू मात्र सूचीबद्ध छन्।';

  @override
  String get exploreVisibleOnDashboard => 'ड्यासबोर्डमा देखिने';

  @override
  String get exploreHiddenOnDashboard => 'ड्यासबोर्डमा लुकेको';

  @override
  String get partiesTitle => 'पार्टीहरू';

  @override
  String get partySearchByName => 'नामबाट खोज्नुहोस्…';

  @override
  String get partySortBy => 'क्रमबद्ध गर्नुहोस्:';

  @override
  String get partySortLatest => 'पछिल्लो';

  @override
  String get partySortAmountHighLow => 'रकम: बढीदेखि घटी';

  @override
  String get partySortAmountLowHigh => 'रकम: घटीदेखि बढी';

  @override
  String get partySortNameAZ => 'नाम: अ देखि ज्ञ';

  @override
  String get partySortNameZA => 'नाम: ज्ञ देखि अ';

  @override
  String get partyAddNew => 'नयाँ पार्टी थप्नुहोस्';

  @override
  String get partyEdit => 'पार्टी सम्पादन';

  @override
  String get partyUpdate => 'पार्टी अपडेट गर्नुहोस्';

  @override
  String get partyNameLabel => 'पार्टीको नाम*';

  @override
  String get partyNameHint => 'पार्टीको नाम लेख्नुहोस्';

  @override
  String get partyNewNameLabel => 'नयाँ पार्टीको नाम*';

  @override
  String get partyNewNameHint => 'नयाँ पार्टीको नाम लेख्नुहोस्';

  @override
  String get partyRoleLabel => 'पार्टी भूमिका *';

  @override
  String get partyTapToSelect => 'छान्न ट्याप गर्नुहोस्';

  @override
  String get partySelectRoleValidation => 'कृपया भूमिका छान्नुहोस्';

  @override
  String get partyEnterNameValidation => 'कृपया पार्टीको नाम लेख्नुहोस्';

  @override
  String get partyBasicInfo => 'आधारभूत जानकारी';

  @override
  String get partyAdditionalInfo => 'थप जानकारी';

  @override
  String get partyEmail => 'पार्टी इमेल';

  @override
  String get partyEmailHint => 'इमेल ठेगाना लेख्नुहोस्';

  @override
  String get partyPhone => 'फोन नम्बर';

  @override
  String get partyPhoneHint => 'फोन नम्बर लेख्नुहोस्';

  @override
  String get partyAddress => 'पार्टी ठेगाना';

  @override
  String get partyAddressHint => 'ठेगाना लेख्नुहोस्';

  @override
  String get partyRoleCustomer => 'ग्राहक';

  @override
  String get partyRoleSupplier => 'आपूर्तिकर्ता';

  @override
  String get partyRoleRoom => 'कोठा';

  @override
  String get partyRoleCabin => 'केबिन';

  @override
  String get partyRoleEmployee => 'कर्मचारी';

  @override
  String get partyRoleBoth => 'दुवै';

  @override
  String get partyDefaultAccount => 'पूर्वनिर्धारित खाता';

  @override
  String get partyLoyaltyProgram => 'वफादारी कार्यक्रम';

  @override
  String get partyLoyaltyPoints => 'वफादारी अंक';

  @override
  String get partySelectDefaultAccount => 'पूर्वनिर्धारित खाता छान्नुहोस्';

  @override
  String get partySelectLoyaltyProgram => 'वफादारी कार्यक्रम छान्नुहोस्';

  @override
  String get partyCreateNewProgram => 'नयाँ कार्यक्रम बनाउनुहोस्';

  @override
  String get partySelectPartyRole => 'पार्टी भूमिका छान्नुहोस्';

  @override
  String get partyAccountDebtors => 'देनदार';

  @override
  String get partyAccountCreditors => 'लेनदार';

  @override
  String get partyBothRoleHint =>
      'दुवै भनेको यो पार्टी ग्राहक र आपूर्तिकर्ता मात्र अन्तर्गत देखिन्छ — कोठा, केबिन वा कर्मचारी होइन।';

  @override
  String get partyValidNumber => 'कृपया मान्य नम्बर लेख्नुहोस्';

  @override
  String get partyValidAmount => 'कृपया मान्य रकम लेख्नुहोस्';

  @override
  String get searchRoles => 'भूमिकाहरू खोज्नुहोस्';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count भूमिकाहरू',
      one: '1 भूमिका',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'अहिलेसम्म कुनै भूमिका छैन';

  @override
  String get noRolesYetHint =>
      'सम्पर्कहरूको लागि ग्राहक, आपूर्तिकर्ता, दुवै वा कस्टम भूमिकाहरू थप्नुहोस्।';

  @override
  String get addRole => 'भूमिका थप्नुहोस्';

  @override
  String get deleteRoleTitle => 'भूमिका मेट्नुहोस्';

  @override
  String deleteRoleConfirm(String name) {
    return '\"$name\" मेट्ने? यो फिर्ता गर्न सकिँदैन।';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount पार्टीहरू',
      one: '1 पार्टी',
    );
    return '\"$name\" $_temp0ले प्रयोग गरिरहेको छ। ती पार्टीहरूलाई अर्को भूमिकामा स्थानान्तरण गर्नुहोस् वा बलपूर्वक मेटाउनुहोस्।';
  }

  @override
  String get transferParties => 'पार्टीहरू स्थानान्तरण गर्नुहोस्';

  @override
  String get hardDeleteLoseParties =>
      'बलपूर्वक मेट्नुहोस् (पार्टीहरू गुमाउनुहोस्)';

  @override
  String get hardDeleteRoleTitle => 'बलपूर्वक मेट्ने?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount पार्टीहरू',
      one: '1 पार्टी',
    );
    return 'यसले \"$name\" र यसमा तोकिएका सबै $_temp0 स्थायी रूपमा मेट्नेछ। पार्टी डेटा पुनः प्राप्त गर्न सकिँदैन।\n\nइनभ्वाइस वा भुक्तानीसँग जोडिएका पार्टीहरू मेटाउन नसकिन सक्छ — यसको सट्टा स्थानान्तरण प्रयोग गर्नुहोस्।';
  }

  @override
  String get deleteRoleAndParties => 'भूमिका र पार्टीहरू मेट्नुहोस्';

  @override
  String get addAnotherRoleBeforeDelete =>
      'यो मेट्नु अघि अर्को भूमिका थप्नुहोस्।';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount पार्टीहरू',
      one: '1 पार्टी',
    );
    return '$_temp0 \"$fromRole\" बाट सार्नुहोस्:';
  }

  @override
  String get transferAndDeleteRole => 'स्थानान्तरण गरी भूमिका मेट्नुहोस्';

  @override
  String get builtInRole => 'बिल्ट-इन';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पार्टीहरू',
      one: '1 पार्टी',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'अहिलेसम्म कुनै पार्टी छैन';

  @override
  String get newRole => 'नयाँ भूमिका';

  @override
  String get editRole => 'भूमिका सम्पादन गर्नुहोस्';

  @override
  String get defaultRolesCannotEdit =>
      'डिफल्ट भूमिकाहरूको नाम परिवर्तन वा मेटाउन सकिँदैन।';

  @override
  String get roleNameLabel => 'भूमिकाको नाम *';

  @override
  String get roleNameHint => 'जस्तै ग्राहक';

  @override
  String get roleDescriptionLabel => 'विवरण';

  @override
  String get roleDescriptionHint => 'तपाईंको टिमको लागि छोटो नोट';

  @override
  String get roleSortOrderLabel => 'क्रमबद्धता';

  @override
  String get roleSortOrderHint => 'कम मूल्यहरू सूचीमा पहिले देखिन्छन्';

  @override
  String get roleCreated => 'भूमिका बनाइयो';

  @override
  String get roleUpdated => 'भूमिका अपडेट भयो';

  @override
  String get roleDeleted => 'भूमिका मेटाइयो';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पार्टीहरू',
      one: '1 पार्टी',
    );
    return 'भूमिका मेटाइयो। $_temp0 $targetRole मा सारियो।';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पार्टीहरू',
      one: '1 पार्टी',
    );
    return 'भूमिका र $_temp0 मेटाइयो।';
  }

  @override
  String get privacyPolicyTitle => 'गोपनीयता नीति';

  @override
  String get termsAndConditions => 'नियम र सर्तहरू';

  @override
  String get logoutConfirmTitle => 'लग आउट';

  @override
  String get logoutConfirmMessage =>
      'के तपाईं साँच्चै आफ्नो खाताबाट लग आउट गर्न चाहनुहुन्छ?';

  @override
  String get faqTapToExpand => 'विस्तार गर्न प्रश्नमा थिच्नुहोस्।';

  @override
  String get faqSectionGettingStarted => 'सुरु गर्दै';

  @override
  String get faqSectionLogin => 'लगइन';

  @override
  String get faqSectionNavigation => 'नेभिगेसन';

  @override
  String get faqSectionInvoices => 'इनभ्वाइसहरू';

  @override
  String get faqSectionPayments => 'भुक्तानीहरू';

  @override
  String get faqSectionItemsStock => 'वस्तुहरू र स्टक';

  @override
  String get faqSectionProfileEmployees => 'प्रोफाइल र कर्मचारीहरू';

  @override
  String get faqSectionDashboardReports => 'ड्यासबोर्ड र रिपोर्टहरू';

  @override
  String get faqSectionSyncTroubleshooting => 'सिङ्क र समस्या समाधान';

  @override
  String get faqNeedInternetQuestion => 'के मलाई इन्टरनेट चाहिन्छ?';

  @override
  String get faqNeedInternetAnswer =>
      'पहिलो स्थानीय सेटअप पछि तपाईं इन्टरनेट बिना इनभ्वाइस, वस्तु र भुक्तानी रेकर्ड गर्न सक्नुहुन्छ। डेटा तपाईंको यन्त्रमा रहन्छ। सर्भरसँग सिङ्क ऐच्छिक छ।';

  @override
  String get faqFirstInstallQuestion => 'पहिलो स्थापनामा के हुन्छ?';

  @override
  String get faqFirstInstallAnswer =>
      'तपाईंले छोटो गाइड देख्न सक्नुहुन्छ, त्यसपछि स्थानीय सेटअप (संस्था, कम्पनी, लगइन इमेल र पासवर्ड, मुद्रा, आर्थिक वर्ष)। त्यसपछि तपाईंले बनाएको इमेल र पासवर्डले साइन इन गर्नुहोस्।';

  @override
  String get faqSignInCredentialsQuestion => 'साइन इनको लागि के प्रयोग गर्ने?';

  @override
  String get faqSignInCredentialsAnswer =>
      'सेटअपको तपाईंको इमेल ठेगाना र पासवर्ड। एपले तपाईंलाई थप बाट लग आउट नगर्दासम्म साइन इन राख्छ।';

  @override
  String get faqLoggedOutQuestion => 'म किन लग आउट भएँ?';

  @override
  String get faqLoggedOutAnswer =>
      'तपाईंले लग आउट छान्नुभयो, एप डेटा खाली गर्नुभयो वा सत्र समाप्त भयो। उही प्रमाणपत्रले पुनः साइन इन गर्नुहोस्।';

  @override
  String get faqBottomTabsQuestion => 'तल्लो ट्याबहरूले के गर्छन्?';

  @override
  String get faqBottomTabsAnswer =>
      'गृह — ड्यासबोर्ड र अवलोकन।\nबिक्री — मिति अनुसार बिक्री इनभ्वाइसहरू।\nखर्च — खरिद / खर्च इनभ्वाइसहरू।\nकेन्द्रीय बटन — पार्टीहरू (ग्राहक, आपूर्तिकर्ता)।\nथप — प्रोफाइल, रिपोर्ट, सिङ्क, मद्दत, लग आउट।';

  @override
  String get faqCreateInvoiceQuestion => 'बिक्री वा खरिद इनभ्वाइस कसरी बनाउने?';

  @override
  String get faqCreateInvoiceAnswer =>
      'बिक्री वा खर्च खोल्नुहोस्, क्यालेन्डरमा मिति छान्नुहोस्, + बटन थिच्नुहोस्, वस्तु र रकम थप्नुहोस्, आवश्यक भएमा पार्टी छान्नुहोस्, त्यसपछि सुरक्षित वा पेश गर्नुहोस्।';

  @override
  String get faqInvoiceDetailsQuestion => 'इनभ्वाइसको पूर्ण विवरण कसरी हेर्ने?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'सूचीमा कुनै पनि इनभ्वाइस थिच्नुहोस्। लेनदेन विवरणले लाइन वस्तुहरू, कुल, छुट र भुक्तानीहरू देखाउँछ। त्यहाँबाट छाप्न, साझा गर्न, नक्कल गर्न वा भुक्तान गर्न सकिन्छ।';

  @override
  String get faqZeroRateQuestion => 'विवरणमा दर वा रकम शून्य देखिन्छ';

  @override
  String get faqZeroRateAnswer =>
      'यसको अर्थ सामान्यतया पुरानो सुरक्षामा लाइन वा भुक्तानी डेटा गायब थियो। एप अपडेट गर्नुहोस् र आवश्यक भएमा पुनः बनाउनुहोस् वा व्यवस्था गर्नुहोस्।';

  @override
  String get faqPartialPaymentQuestion => 'आंशिक भुक्तानी कसरी रेकर्ड गर्ने?';

  @override
  String get faqPartialPaymentAnswer =>
      'इनभ्वाइस खोल्नुहोस् → लेनदेन विवरण → भुक्तानी गर्नुहोस्। रकम, विधि र मिति प्रविष्ट गर्नुहोस्, त्यसपछि भुक्तानी प्रक्रिया गर्नुहोस्।';

  @override
  String get faqMultiplePaymentQuestion => 'बहु भुक्तानी कसरी काम गर्छ?';

  @override
  String get faqMultiplePaymentAnswer =>
      'बहु भुक्तानी सक्षम गर्नुहोस्, सम्पादन थिच्नुहोस् र कुललाई नगद, कार्ड, QR आदिमा विभाजन गर्नुहोस्। प्रत्येक विधि छुट्टाछुट्टै रेकर्ड गरिन्छ।';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'विभाजनबाट एउटा मात्र भुक्तानी सुरक्षित भयो';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'नवीनतम एप संस्करणमा अपडेट गर्नुहोस्। पुराना संस्करणहरूले कहिलेकाहीँ पहिलो विभाजन लाइन मात्र सुरक्षित गर्थे। अपरिशोधित बाँकी अझै गलत छ भने पुनः व्यवस्था गर्नुहोस्।';

  @override
  String get faqAddItemQuestion => 'वस्तु कसरी थप्ने?';

  @override
  String get faqAddItemAnswer =>
      'बिक्री प्रवाह वा द्रुत थपबाट वस्तु थप्नुहोस् प्रयोग गर्नुहोस्। नाम, दर, एकाइ, उद्देश्य र वैकल्पिक फोटो (JPEG/PNG/GIF/WebP, अधिकतम ५ MB) प्रविष्ट गर्नुहोस्, त्यसपछि वस्तु बनाउनुहोस्।';

  @override
  String get faqCustomUnitQuestion => 'कस्टम एकाइ कसरी थप्ने?';

  @override
  String get faqCustomUnitAnswer =>
      'वस्तु फारममा, एकाइ थिच्नुहोस् → सूचीको तलमा नयाँ एकाइ बनाउनुहोस्, नाम (जस्तै लिटर, बाकस) प्रविष्ट गर्नुहोस् र बनाउनुहोस्।';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'मैले नाम परिवर्तन गरेँ तर प्रोफाइलले पुरानो नाम देखाउँछ';

  @override
  String get faqProfileNameAnswer =>
      'तपाईंको कर्मचारी रेकर्ड सम्पादन गर्नुहोस् (लगइनसँग उही इमेल) र सुरक्षित गर्नुहोस्। थप ट्याब र ड्यासबोर्ड अपडेट हुनुपर्छ।';

  @override
  String get faqRevenueDetailsQuestion => 'राजस्व विवरण के हो?';

  @override
  String get faqRevenueDetailsAnswer =>
      'दैनिक प्रवृत्ति चार्ट, खुद नाफा, अपरिशोधित प्राप्तिहरू र दिनप्रतिदिन बिक्री बनाम खरिद विश्लेषणसहित मासिक दृश्य। क्यालेन्डर वा महिना चिपले महिना परिवर्तन गर्नुहोस्।';

  @override
  String get faqOtherReportsQuestion => 'अन्य रिपोर्टहरू कहाँ छन्?';

  @override
  String get faqOtherReportsAnswer =>
      'थप खोल्नुहोस् र रिपोर्टहरू (विश्लेषण, नाफा र नोक्सान, विवरण आदि) अन्तर्गत हेर्नुहोस् यदि तपाईंको भूमिकाको पहुँच छ भने।';

  @override
  String get faqWhenSyncQuestion => 'कहिले सिङ्क गर्ने?';

  @override
  String get faqWhenSyncAnswer =>
      'तपाईंको एडमिनले भन्दा मात्र र स्थिर जडान भएको बेला। सिङ्कले यन्त्र र सर्भरबीच डेटा पठाउँछ वा प्राप्त गर्छ।';

  @override
  String get faqFabPositionQuestion =>
      '+ बटन बिक्री / खर्चमा धेरै माथि देखिन्छ';

  @override
  String get faqFabPositionAnswer =>
      'यो तल्लो नेभिगेसन बारको माथि छ। सूची स्क्रोल गर्नुहोस् वा यन्त्रमा बटनले सामग्री ओभरल्याप गरे एप अपडेट गर्नुहोस्।';

  @override
  String get faqHowLogoutQuestion => 'लग आउट कसरी गर्ने?';

  @override
  String get faqHowLogoutAnswer => 'थप → सेटिङ सूचीको तलमा लग आउट।';

  @override
  String get statisticsGoodMorning => 'शुभ प्रभात';

  @override
  String get statisticsGoodAfternoon => 'शुभ अपराह्न';

  @override
  String get statisticsGoodEvening => 'शुभ साँझ';

  @override
  String get statisticsDefaultUser => 'प्रयोगकर्ता';

  @override
  String get statisticsCheckConnection =>
      'कृपया जडान जाँच गर्नुहोस् र फेरि प्रयास गर्नुहोस्।';

  @override
  String get statisticsCouldNotLoadProfile => 'प्रोफाइल लोड गर्न सकिएन';

  @override
  String get statisticsCouldNotLoadData => 'डाटा लोड गर्न सकिएन';

  @override
  String get statisticsPeriodDay => 'दिन';

  @override
  String get statisticsPeriodMonth => 'महिना';

  @override
  String get statisticsPeriodYear => 'वर्ष';

  @override
  String get statisticsSelectedPeriod => 'छानिएको अवधि';

  @override
  String get statisticsSelectMonth => 'महिना छान्नुहोस्';

  @override
  String get statisticsSelectMonthSubtitle =>
      'डाटा फिल्टर गर्न महिना छान्नुहोस्';

  @override
  String get statisticsQuickOperations => 'छिटो सञ्चालन';

  @override
  String get statisticsQuickOperationsSeeAll => 'सबै हेर्नुहोस्';

  @override
  String get statisticsQuickOperationInvoice => 'इनभ्वाइस';

  @override
  String get statisticsQuickOperationReports => 'प्रतिवेदन';

  @override
  String get statisticsAnnualRevenue => 'वार्षिक आम्दानी';

  @override
  String get statisticsCashflow => 'नगद प्रवाह';

  @override
  String get statisticsCashflowLast7Days => 'नगद प्रवाह (गत ७ दिन)';

  @override
  String get statisticsCashflowLast12Months => 'नगद प्रवाह (गत १२ महिना)';

  @override
  String get statisticsDaily => 'दैनिक';

  @override
  String get statisticsMonthly => 'मासिक';

  @override
  String get statisticsOverall => 'समग्र';

  @override
  String get statisticsLast7Days => 'पछिल्लो ७ दिन';

  @override
  String get statisticsLast12Months => 'पछिल्लो १२ महिना';

  @override
  String get statisticsAllYears => 'सबै वर्ष';

  @override
  String get statisticsNoDataAvailable => 'कुनै डाटा उपलब्ध छैन';

  @override
  String get statisticsMoneyIn => 'आम्दानी';

  @override
  String get statisticsMoneyOut => 'खर्च';

  @override
  String get statisticsIncome => 'आम्दानी';

  @override
  String get statisticsExpenses => 'खर्च';

  @override
  String get statisticsSalesSummary => 'बिक्री सारांश';

  @override
  String get statisticsPurchaseSummary => 'खरिद सारांश';

  @override
  String get statisticsTotalSales => 'कुल बिक्री';

  @override
  String get statisticsTotalIncome => 'कुल आम्दानी';

  @override
  String get statisticsTotalUnpaid => 'कुल बाँकी';

  @override
  String get statisticsTotalPurchase => 'कुल खरिद';

  @override
  String get statisticsPaidPurchase => 'तिरेको खरिद';

  @override
  String get statisticsUnpaidPurchase => 'बाँकी खरिद';

  @override
  String get statisticsEmployeeDashboard => 'कर्मचारी ड्यासबोर्ड';

  @override
  String get statisticsDefaultEmployee => 'कर्मचारी';

  @override
  String get statisticsDefaultDepartment => 'विभाग';

  @override
  String get statisticsDefaultPosition => 'पद';

  @override
  String get statisticsCurrentMonth => 'हालको महिना';

  @override
  String get statisticsStatus => 'स्थिति';

  @override
  String get statisticsActive => 'सक्रिय';

  @override
  String get statisticsWelcome => 'स्वागत छ';

  @override
  String get statisticsEmployeeWelcomeMessage =>
      'तपाईं कर्मचारीको रूपमा लगइन हुनुहुन्छ। उपलब्ध सुविधाहरूको लागि नेभिगेसन मेनु प्रयोग गर्नुहोस्।';

  @override
  String get statisticsRevenueDetails => 'आम्दानी विवरण';

  @override
  String get statisticsEmployeeDetails => 'कर्मचारी विवरण';

  @override
  String get statisticsChangeMonth => 'महिना परिवर्तन';

  @override
  String get statisticsFilterChartsSubtitle => 'चार्ट र विवरण फिल्टर गर्नुहोस्';

  @override
  String get statisticsDailyTrend => 'दैनिक प्रवृत्ति';

  @override
  String get statisticsDailyActivity => 'दैनिक गतिविधि';

  @override
  String get statisticsNoDataForMonth => 'यो महिनाको लागि डाटा छैन';

  @override
  String get statisticsNetProfit => 'खुद नाफा';

  @override
  String get statisticsMonthReceivables => 'महिनाको बाँकी';

  @override
  String get statisticsMonthRevenue => 'महिनाको आम्दानी';

  @override
  String get statisticsMonthExpenses => 'महिनाको खर्च';

  @override
  String get statisticsNoDailyEntries => 'यो महिनाको लागि दैनिक प्रविष्टि छैन';

  @override
  String get statisticsDailySalesBreakdown => 'दैनिक बिक्री विवरण';

  @override
  String get statisticsDailyBreakdown => 'दैनिक विवरण';

  @override
  String get statisticsAdvance => 'अग्रिम';

  @override
  String get statisticsExploreFeatures => 'सुविधाहरू अन्वेषण';

  @override
  String get statisticsShowOrHideFeatures =>
      'सुविधाहरू देखाउनुहोस् वा लुकाउनुहोस्';

  @override
  String get statisticsAllFeaturesHidden => 'सबै सुविधाहरू लुकाइएका छन्';

  @override
  String get statisticsNoFeaturesForOrg =>
      'तपाईंको संस्थाको लागि कुनै सुविधा उपलब्ध छैन';

  @override
  String get statisticsTapTuneToShow =>
      'सर्टकट फेरि देखाउन माथिको ट्युन आइकन ट्याप गर्नुहोस्।';

  @override
  String get statisticsMenuCheck => 'मिलान';

  @override
  String get statisticsMenuEmployee => 'कर्मचारी';

  @override
  String get statisticsMenuOrder => 'अर्डर';

  @override
  String get statisticsMenuInventory => 'Items';

  @override
  String get statisticsMenuCustomers => 'ग्राहक';

  @override
  String get statisticsMenuCalculator => 'Liquor prices';

  @override
  String get statisticsMenuQuickExpenses => 'छिटो खर्च';

  @override
  String get statisticsMenuQuickSales => 'छिटो िक्री';

  @override
  String get statisticsMenuAddEmployee => 'कर्मचारी थप्नुहोस्';

  @override
  String get statisticsMenuAddParty => 'पार्टी थप्नुहोस्';

  @override
  String get statisticsMenuAddEmployeeSingle => 'कर्मचारी थप्नुहोस्';

  @override
  String get statisticsMenuAddPartySingle => 'पार्टी थप्नुहोस्';

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
    return '$amount संकलन';
  }

  @override
  String statisticsMetricPaid(String amount) {
    return '$amount तिरिएको';
  }

  @override
  String statisticsMoneyInAmount(String amount) {
    return 'आम्दानी: $amount';
  }

  @override
  String statisticsMoneyOutAmount(String amount) {
    return 'खर्च: $amount';
  }

  @override
  String statisticsDayTooltip(String day, String amount) {
    return 'दिन $day $amount';
  }

  @override
  String statisticsProfitMargin(String percent) {
    return '$percent% मार्जिन';
  }

  @override
  String get invoiceCommonActions => 'कार्यहरू';

  @override
  String get invoiceCommonSearchItems => 'वस्तु खोज्नुहोस्';

  @override
  String get invoiceCommonSearchItemsSubtitle => 'विशेष वस्तुहरू खोज्नुहोस्';

  @override
  String get invoiceCommonAddNewInvoice => 'नयाँ बिल थप्नुहोस्';

  @override
  String get invoiceCommonAddSalesInvoiceSubtitle =>
      'नयाँ बिक्री बिल बनाउनुहोस्';

  @override
  String get invoiceCommonAddPurchaseInvoiceSubtitle =>
      'नयाँ खरिद बिल बनाउनुहोस्';

  @override
  String get invoiceCommonSelectMonthYear => 'महिना/वर्ष छान्नुहोस्';

  @override
  String get invoiceCommonSelectMonthYearSubtitle => 'विशेष महिनामा जानुहोस्';

  @override
  String get invoiceCommonSelectMonthAndYear => 'महिना र वर्ष छान्नुहोस्';

  @override
  String get invoiceCommonFilterByDate => 'मिति अनुसार फिल्टर';

  @override
  String get invoiceCommonFilterByDateRange => 'मिति दायरा अनुसार फिल्टर';

  @override
  String get invoiceCommonCloseSearch => 'खोज बन्द गर्नुहोस्';

  @override
  String get invoiceCommonSelectAll => 'सबै छान्नुहोस्';

  @override
  String get invoiceCommonToday => 'आज';

  @override
  String get invoiceCommonTotalQuantity => 'कुल परिमाण';

  @override
  String get invoiceCommonTotalAmount => 'कुल रकम';

  @override
  String get invoiceCommonTotal => 'कुल';

  @override
  String get invoiceCommonSearchForItems => 'वस्तुहरू खोज्नुहोस्';

  @override
  String get invoiceCommonNoItemsFound => 'कुनै वस्तु भेटिएन';

  @override
  String get invoiceCommonUnknownItem => 'अज्ञात वस्तु';

  @override
  String get invoiceCommonNotAvailable => 'उपलब्ध छैन';

  @override
  String get invoiceSalesCouldNotLoad => 'बिक्री लोड गर्न सकिएन';

  @override
  String get invoiceSalesNoFound => 'कुनै बिक्री भेटिएन';

  @override
  String get invoiceSalesSelectDate => 'बिक्री हेर्न मिति छान्नुहोस्';

  @override
  String get invoiceSalesNoInvoicesFound => 'कुनै बिल भेटिएन';

  @override
  String get invoiceSalesSelectDateLegacy => 'बिल हेर्न मिति छान्नुहोस्';

  @override
  String get invoicePurchaseCouldNotLoad => 'खर्च लोड गर्न सकिएन';

  @override
  String get invoicePurchaseNoFound => 'कुनै खरिद भेटिएन';

  @override
  String get invoicePurchaseSelectDate => 'खरिद हेर्न मिति छान्नुहोस्';

  @override
  String get invoiceWeekdaySun => 'आइत';

  @override
  String get invoiceWeekdayMon => 'सोम';

  @override
  String get invoiceWeekdayTue => 'मङ्गल';

  @override
  String get invoiceWeekdayWed => 'बुध';

  @override
  String get invoiceWeekdayThu => 'बिही';

  @override
  String get invoiceWeekdayFri => 'शुक्र';

  @override
  String get invoiceWeekdaySat => 'शनि';

  @override
  String invoiceCommonSelectedCount(int count) {
    return '$count छानिएको';
  }

  @override
  String invoiceCommonQtyLabel(String qty) {
    return 'परि: $qty';
  }

  @override
  String invoiceCommonInvoiceLabel(String number) {
    return 'बिल: $number';
  }

  @override
  String invoiceCommonCustomerLabel(String name) {
    return 'ग्राहक: $name';
  }

  @override
  String invoiceCommonSupplierLabel(String name) {
    return 'आपूर्तिकर्ता: $name';
  }

  @override
  String invoiceCommonSearchingFor(String query) {
    return '\"$query\" खोज्दै...';
  }

  @override
  String invoiceCommonSearchItemsHint(String scope) {
    return '$scope मा वस्तु खोज्नुहोस्...';
  }

  @override
  String invoiceCommonSalesSearchPrompt(String scope) {
    return 'सबै बिक्री फेला पार्न वस्तुको नाम टाइप गर्नुहोस्\n$scope मा';
  }

  @override
  String invoiceCommonPurchaseSearchPrompt(String scope) {
    return 'सबै खरिद फेला पार्न वस्तुको नाम टाइप गर्नुहोस्\n$scope मा';
  }

  @override
  String invoiceCommonSalesNoMatch(String query, String scope) {
    return '\"$query\" को बिक्री छैन\n$scope मा';
  }

  @override
  String invoiceCommonPurchaseNoMatch(String query, String scope) {
    return '\"$query\" को खरिद छैन\n$scope मा';
  }

  @override
  String invoiceCommonEmptyForDate(String date) {
    return '$date को लागि';
  }

  @override
  String invoiceFoundSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बिक्री भेटियो',
      one: '१ बिक्री भेटियो',
    );
    return '$_temp0';
  }

  @override
  String invoiceFoundPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count खरिद भेटियो',
      one: '१ खरिद भेटियो',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बिक्री',
      one: '१ बिक्री',
    );
    return '$_temp0';
  }

  @override
  String invoiceDatePurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count खरिद',
      one: '१ खरिद',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बिल',
      one: '१ बिल',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बिल मेटाउनुहोस्',
      one: '१ बिल मेटाउनुहोस्',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'छानिएका $count बिल मेटाउने हो? यो पूर्ववत हुन सक्दैन।',
      one: 'छानिएको १ बिल मेटाउने हो? यो पूर्ववत हुन सक्दैन।',
    );
    return '$_temp0';
  }

  @override
  String get contacts => 'सम्पर्कहरू';

  @override
  String get categories => 'श्रेणीहरू';

  @override
  String get manageStaff => 'कर्मचारी व्यवस्थापन';

  @override
  String get payroll => 'पेरोल';

  @override
  String get attendance => 'हाजिरी';

  @override
  String get profitAndLoss => 'नाफा र नोक्सान';

  @override
  String get statementReport => 'विवरण';

  @override
  String get analytics => 'विश्लेषण';

  @override
  String get loggedOut => 'लग आउट भयो';

  @override
  String organizationCodeDisplay(String code) {
    return 'कोड: $code';
  }

  @override
  String get moreDataSynchronization => 'डेटा सिङ्क्रोनाइजेसन';

  @override
  String get moreSendDataToClient => 'क्लाइन्टमा डेटा पठाउनुहोस्';

  @override
  String get moreSendDataToClientSubtitle =>
      'सर्भर डेटा क्लाइन्टमा अपलोड गर्नुहोस्';

  @override
  String get moreSendDataToClientWarning =>
      'यो कार्यले हालको क्लाइन्ट डाटाबेस सर्भरको डेटाले प्रतिस्थापन गर्नेछ। हालैका क्लाइन्ट परिवर्तनहरू हराउन सक्छन्।';

  @override
  String get moreSendDataToClientConfirm =>
      'के तपाईं क्लाइन्टमा डेटा पठाउन निश्चित हुनुहुन्छ?';

  @override
  String get moreFetchDataFromClient => 'क्लाइन्टबाट डेटा ल्याउनुहोस्';

  @override
  String get moreFetchDataFromClientSubtitle =>
      'क्लाइन्ट डेटा सर्भरमा डाउनलोड गर्नुहोस्';

  @override
  String get moreFetchDataFromClientWarning =>
      'यो कार्यले हालको सर्भर डाटाबेस क्लाइन्टको डेटाले प्रतिस्थापन गर्नेछ। हालैका सर्भर परिवर्तनहरू हराउन सक्छन्।';

  @override
  String get moreFetchDataFromClientConfirm =>
      'के तपाईं क्लाइन्टबाट डेटा ल्याउन निश्चित हुनुहुन्छ?';

  @override
  String get notifications => 'सूचनाहरू';

  @override
  String get openingReminder => 'खोल्ने सम्झना';

  @override
  String get closingReminder => 'बन्द गर्ने सम्झना';

  @override
  String get activityReminder => 'Sales & purchase reminder';

  @override
  String get openingTime => 'खोल्ने समय';

  @override
  String get closingTime => 'बन्द गर्ने समय';

  @override
  String get activityReminderTime => 'Reminder time';

  @override
  String get notificationSettingsSaved => 'सूचना सेटिङ सुरक्षित गरियो';

  @override
  String get notificationPermissionHint =>
      'एप बन्द भए पनि सम्झना काम गर्न सूचना (Android मा अलार्म सहित) अनुमति दिनुहोस्';

  @override
  String dailyAtTime(String time) {
    return 'दैनिक $time मा';
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
  String get invoiceCommonYesterday => 'हिजो';

  @override
  String invoiceCommonTodayAt(String time) {
    return 'आज, $time';
  }

  @override
  String invoiceCommonDaysAgo(int count) {
    return '$count दिन अघि';
  }

  @override
  String invoiceReturnCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count फिर्ता',
      one: '१ फिर्ता',
    );
    return '$_temp0';
  }

  @override
  String get checkoutSelectParty => 'पक्ष छान्नुहोस्';

  @override
  String get partyPickerSubtitle => 'यो बिक्री कसका लागि?';

  @override
  String partyPickerSearchHint(String role) {
    return '$role खोज्नुहोस्...';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'नयाँ $role थप्नुहोस्';
  }

  @override
  String get partyPickerSettled => 'मिलाइयो';

  @override
  String get partyPickerSelectedLabel => 'छानिएको';

  @override
  String get checkoutCartSummary => 'कार्ट सारांश';

  @override
  String get checkoutNoItemsInCart => 'कार्टमा कुनै वस्तु छैन';

  @override
  String get checkoutSearchHere => 'यहाँ खोज्नुहोस्';

  @override
  String get checkoutCreateInvoice => 'बिल बनाउनुहोस्';

  @override
  String get checkoutEditInvoice => 'बिल सम्पादन';

  @override
  String get checkoutSaveInvoice => 'बिल बचत गर्नुहोस्';

  @override
  String get checkoutInvoiceSummary => 'बिल सारांश';

  @override
  String get checkoutEstimate => 'अनुमान';

  @override
  String get checkoutBasicInformation => 'आधारभूत जानकारी';

  @override
  String get checkoutAddItems => 'वस्तु थप्नुहोस्';

  @override
  String get checkoutItemsSection => 'वस्तुहरू';

  @override
  String get checkoutPartyRequired => 'पक्ष *';

  @override
  String get checkoutPartyInformation => 'पक्ष जानकारी';

  @override
  String get checkoutBillSummary => 'बिल सारांश';

  @override
  String get checkoutBillSummaryHint => 'विस्तृत गणना जान्न ट्याप गर्नुहोस्।';

  @override
  String get checkoutItemTotal => 'वस्तु जम्मा';

  @override
  String checkoutLoyaltyDiscount(String percent) {
    return 'लोयल्टी छुट ($percent%)';
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
    return '- छुट ($percent%)';
  }

  @override
  String get checkoutTapToEdit => 'सम्पादन गर्न ट्याप गर्नुहोस्';

  @override
  String get checkoutTotalAmount => 'कुल रकम';

  @override
  String get checkoutPaymentMode => 'Record payment';

  @override
  String get checkoutPaymentModeHint =>
      'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.';

  @override
  String get checkoutNetSalesAmount => 'खुद बिक्री रकम';

  @override
  String get checkoutConfirmCheckout => 'चेकआउट पुष्टि गर्नुहोस्';

  @override
  String get checkoutEditDiscount => 'छुट सम्पादन';

  @override
  String get checkoutPercentage => 'प्रतिशत';

  @override
  String get checkoutDiscard => 'रद्द गर्नुहोस्';

  @override
  String get checkoutPartialPayment => 'आंशिक भुक्तानी';

  @override
  String get checkoutPartialPaymentBanner =>
      'आंशिक भुक्तानी सक्रिय गर्दा ग्राहकले कुल बिल रकम भन्दा कम तिर्न सक्नेछन्।';

  @override
  String get checkoutPleaseEnterAmounts =>
      'कृपया सम्बन्धित रकम प्रविष्ट गर्नुहोस्:';

  @override
  String get checkoutPartialPaymentEqualHint =>
      'कुनै प्रयोगकर्ता तोकिएको छैन, कुल रकम बिल रकम बराबर हुनुपर्छ।';

  @override
  String checkoutOverGrandTotalBy(String amount) {
    return 'कुल जम्मा भन्दा बढी: $amount';
  }

  @override
  String checkoutRemainingUnpaid(String amount) {
    return 'बाँकी (कुल जम्मा बाट अवैतनिक): $amount';
  }

  @override
  String get checkoutConfirmPayment => 'भुक्तानी पुष्टि गर्नुहोस्';

  @override
  String get checkoutUnpaidCredit => 'अवैतनिक / उधारो';

  @override
  String get checkoutAddAtLeastOneLine =>
      'अनुमान हेर्न कम्तीमा एउटा वस्तु थप्नुहोस्';

  @override
  String get checkoutMultiplePayment => 'बहु भुक्तानी';

  @override
  String get checkoutPaymentStatus => 'भुक्तानी स्थिति';

  @override
  String get checkoutPaymentMethods => 'भुक्तानी विधिहरू';

  @override
  String get checkoutPaymentMethod => 'भुक्तानी विधि';

  @override
  String get checkoutTenderAmount => 'टेन्डर रकम';

  @override
  String get checkoutLoadingPaymentMethods => 'भुक्तानी विधिहरू लोड हुँदैछ…';

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
  String get stockSearchByDateHint => 'मिति वा महिनाबाट खोज्नुहोस्…';

  @override
  String get stockNoMatches => 'कुनै मिल्दो फेला परेन';

  @override
  String get stockTryDifferentSearch => 'अर्को खोज शब्द प्रयोग गर्नुहोस्';

  @override
  String get stockTryAnotherSearch => 'अर्को खोज प्रयास गर्नुहोस्';

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
    return 'मात्रा $qty';
  }

  @override
  String stockCardSummary(String records, String items, String locations) {
    return '$records रेकर्ड · $items वस्तु · $locations स्थान';
  }

  @override
  String get stockFilterTitle => 'Filter stock reconciliation';

  @override
  String get stockBatchNumber => 'ब्याच नम्बर';

  @override
  String get stockLocation => 'स्थान';

  @override
  String get stockOptionalHint => 'वैकल्पिक';

  @override
  String get stockApplyFilters => 'फिल्टर लागू गर्नुहोस्';

  @override
  String get stockClearFields => 'फिल्ड खाली गर्नुहोस्';

  @override
  String get stockDeleteAllTooltip => 'यो मितिको सबै स्टक मेटाउनुहोस्';

  @override
  String get stockNoItemsFound => 'कुनै स्टक वस्तु फेला परेन';

  @override
  String get stockNoItemsSubtitle =>
      'अर्को फिल्टर वा रिपोर्टिङ मिति प्रयास गर्नुहोस्।';

  @override
  String get stockAdjustFilters => 'फिल्टर मिलाउनुहोस्';

  @override
  String get stockSearchItemHint => 'वस्तु, ब्याच, स्थान खोज्नुहोस्…';

  @override
  String get stockEditQuantities => 'मात्रा सम्पादन';

  @override
  String get stockNoChangesDetected => 'कुनै परिवर्तन भेटिएन';

  @override
  String stockErrorPreparingChanges(String error) {
    return 'परिवर्तन तयार गर्दा त्रुटि: $error';
  }

  @override
  String get stockUpdateSuccessful => 'अपडेट सफल!';

  @override
  String get stockSummary => 'सारांश';

  @override
  String get stockTotalRequested => 'कुल अनुरोध';

  @override
  String get stockSuccessfullyUpdated => 'सफलतापूर्वक अपडेट';

  @override
  String get stockFailed => 'असफल';

  @override
  String get stockUpdateFailed => 'अपडेट असफल';

  @override
  String get stockClearAllQuantitiesTitle => 'सबै मात्रा खाली गर्ने?';

  @override
  String get stockClearAllQuantitiesMessage =>
      'यसले सबै मात्रा ० मा रिसेट गर्नेछ। के तपाईं निश्चित हुनुहुन्छ?';

  @override
  String get stockClearAll => 'सबै खाली गर्नुहोस्';

  @override
  String get stockUpdatingQuantities => 'स्टक मात्रा अपडेट हुँदैछ…';

  @override
  String get stockEditQuantitiesTitle => 'स्टक मात्रा सम्पादन';

  @override
  String stockReportingDate(String date) {
    return 'रिपोर्टिङ मिति: $date';
  }

  @override
  String stockTotalItemsHint(String count) {
    return 'कुल वस्तु: $count • आवश्यक अनुसार मात्रा अपडेट गर्नुहोस्';
  }

  @override
  String get stockItemName => 'वस्तुको नाम';

  @override
  String stockBatchPrefix(String batch) {
    return 'ब्याच: $batch';
  }

  @override
  String get stockDeleteConfirmTitle => 'मेटाउने पुष्टि';

  @override
  String get stockDeleteConfirmIntro =>
      'तपाईं निम्न मितिका सबै स्टक वस्तु स्थायी रूपमा मेटाउन लाग्दै हुनुहुन्छ:';

  @override
  String get stockDeleteConfirmWarning =>
      'यो कार्य फिर्ता गर्न सकिँदैन। यो मितिका सबै स्टक रेकर्ड स्थायी रूपमा मेटिनेछन्।';

  @override
  String get stockNoInternetRetry =>
      'इन्टरनेट जडान छैन। कृपया जडान जाँच गरी पुनः प्रयास गर्नुहोस्।';

  @override
  String get itemsTitle => 'वस्तुहरू';

  @override
  String get itemAddSheetTitle => 'वस्तु थप्नुहोस्';

  @override
  String get itemSingleAdd => 'एकल थप';

  @override
  String get itemBulkAdd => 'थोक थप';

  @override
  String get itemBulkAddTitle => 'थोक वस्तु थप';

  @override
  String get itemEditTitle => 'वस्तु सम्पादन';

  @override
  String get itemAddTitle => 'वस्तु थप्नुहोस्';

  @override
  String get itemCreateButton => 'वस्तु बनाउनुहोस्';

  @override
  String get itemUpdateButton => 'वस्तु अपडेट';

  @override
  String get itemDeleteTitle => 'वस्तु मेटाउनुहोस्';

  @override
  String itemDeleteConfirm(String name) {
    return 'के तपाईं \"$name\" मेटाउन निश्चित हुनुहुन्छ?';
  }

  @override
  String get itemDeletedSuccess => 'वस्तु सफलतापूर्वक मेटाइयो';

  @override
  String get itemCreatedSuccess => 'वस्तु सफलतापूर्वक बनाइयो';

  @override
  String get itemUpdatedSuccess => 'वस्तु सफलतापूर्वक अपडेट भयो';

  @override
  String get itemLoading => 'वस्तुहरू लोड हुँदैछ…';

  @override
  String get itemErrorTitle => 'केही गडबड भयो';

  @override
  String get itemTryAgain => 'पुनः प्रयास';

  @override
  String get itemSearchHint => 'वस्तु खोज्नुहोस्';

  @override
  String get itemNoItemsFound => 'कुनै वस्तु फेला परेन';

  @override
  String get itemTryAdjustSearch => 'खोज शब्द परिवर्तन गर्नुहोस्';

  @override
  String get itemNoItemsAvailable => 'कुनै वस्तु उपलब्ध छैन';

  @override
  String get itemAddToGetStarted => 'सुरु गर्न वस्तु थप्नुहोस्';

  @override
  String get itemNoMoreItems => 'थप वस्तु छैन';

  @override
  String get itemPurposeBoth => 'दुवै';

  @override
  String get itemPurposePurchases => 'खरिद';

  @override
  String get itemTypeProduct => 'उत्पादन';

  @override
  String get itemTypeService => 'सेवा';

  @override
  String get itemTypeInventory => 'सूची';

  @override
  String get itemPhotoTitle => 'वस्तुको फोटो';

  @override
  String get itemPhotoHint => 'फोटो छान्न वा अपलोड गर्न यहाँ ट्याप गर्नुहोस्';

  @override
  String get itemPhotoFormats => 'JPEG, PNG, GIF, वा WebP · अधिकतम ५MB';

  @override
  String get itemAddPhoto => 'फोटो थप्नुहोस्';

  @override
  String get itemPhotoLibrary => 'फोटो लाइब्रेरी';

  @override
  String get itemPhotoLibraryHint => 'आफ्ना फोटोबाट छान्नुहोस्';

  @override
  String get itemTakePhoto => 'फोटो खिच्नुहोस्';

  @override
  String get itemUploadGallery => 'ग्यालरीबाट अपलोड';

  @override
  String get itemUploadGalleryHint => 'यो उपकरणका फाइल ब्राउज गर्नुहोस्';

  @override
  String get itemTypeLabel => 'प्रकार';

  @override
  String get itemTypeField => 'वस्तु प्रकार';

  @override
  String get itemNameLabel => 'वस्तुको नाम';

  @override
  String get itemNameHint => 'वस्तुको नाम प्रविष्ट गर्नुहोस्';

  @override
  String get itemBarcodeLabel => 'बारकोड / QR कोड';

  @override
  String get itemBarcodeField => 'बारकोड / QR कोड';

  @override
  String get itemBarcodeHint => 'एप बारबाट स्क्यान वा पेस्ट';

  @override
  String get itemSkuLabel => 'SKU (optional)';

  @override
  String get itemSkuField => 'SKU';

  @override
  String get itemSkuHint => 'Product code — optional';

  @override
  String get itemPickerSearchHint => 'Search items by name or SKU…';

  @override
  String get itemRateLabel => 'दर';

  @override
  String get itemUnitLabel => 'इकाई';

  @override
  String get itemPurposeLabel => 'उद्देश्य';

  @override
  String get itemSelectUnit => 'इकाई छान्नुहोस्';

  @override
  String get itemSelectPurpose => 'उद्देश्य छान्नुहोस्';

  @override
  String get itemSelectCategory => 'श्रेणी छान्नुहोस्';

  @override
  String get itemSelectType => 'प्रकार छान्नुहोस्';

  @override
  String get itemSelectItemType => 'वस्तु प्रकार छान्नुहोस्';

  @override
  String get itemSearchUnits => 'इकाई खोज्नुहोस्…';

  @override
  String get itemSearchPurpose => 'उद्देश्य खोज्नुहोस्…';

  @override
  String get itemSearchCategories => 'श्रेणी खोज्नुहोस्…';

  @override
  String get itemCreateCustomUnit => 'कस्टम इकाई बनाउनुहोस्';

  @override
  String get itemUnitName => 'इकाईको नाम';

  @override
  String get itemUnitNameHint => 'जस्तै: लिटर, बक्स, पिस';

  @override
  String get itemValidationName => 'कृपया वस्तुको नाम प्रविष्ट गर्नुहोस्';

  @override
  String get itemValidationRate => 'कृपया दर प्रविष्ट गर्नुहोस्';

  @override
  String get itemValidationNumber => 'कृपया मान्य संख्या प्रविष्ट गर्नुहोस्';

  @override
  String get itemSelectUnitRequired => 'कृपया इकाई छान्नुहोस्';

  @override
  String get itemSelectPurposeRequired => 'कृपया उद्देश्य छान्नुहोस्';

  @override
  String get itemSelectCategoryRequired => 'कृपया एउटा श्रेणी छान्नुहोस्';

  @override
  String get itemImageMissing => 'छवि फाइल छैन';

  @override
  String get itemImageFormatError => 'JPEG, PNG, GIF, वा WebP प्रयोग गर्नुहोस्';

  @override
  String get itemImageSizeError => 'छवि ५MB वा सानो हुनुपर्छ';

  @override
  String get itemScanBarcode => 'बारकोड स्क्यान';

  @override
  String get posScanAlignHint => 'बारकोड वा QR लाई फ्रेमभित्र मिलाउनुहोस्';

  @override
  String get posScanKeepScanning => 'थप वस्तु थप्न स्क्यान गरिरहनुहोस्';

  @override
  String posScanItemAdded(String name, String qty) {
    return '$name × $qty थपियो';
  }

  @override
  String get posScanItemNotFound => 'यो कोडको वस्तु फेला परेन';

  @override
  String get posScanCameraDenied =>
      'बारकोड स्क्यान गर्न क्यामेरा अनुमति चाहिन्छ';

  @override
  String get posScanTorch => 'फ्ल्यासलाइट';

  @override
  String get posScanDone => 'सम्पन्न';

  @override
  String get btPrinterTitle => 'ब्लुटुथ प्रिन्टर';

  @override
  String get btPrinterSettingsTitle => 'रसिद प्रिन्टर';

  @override
  String get btPrinterPrintTitle => 'रसिद प्रिन्ट';

  @override
  String get btPrinterBluetooth => 'ब्लुटुथ थर्मल प्रिन्टर';

  @override
  String btPrinterPrintOn(String name) {
    return '$name मा प्रिन्ट';
  }

  @override
  String get btPrinterChooseAnother => 'अर्को ब्लुटुथ प्रिन्टर छान्नुहोस्';

  @override
  String get btPrinterSystem => 'सिस्टम प्रिन्टर / PDF सेभ';

  @override
  String get btPrinterAirPrint => 'AirPrint / PDF सेभ';

  @override
  String get btPrinterPaper58 => '५८ मिमी';

  @override
  String get btPrinterPaper80 => '८० मिमी';

  @override
  String get btPrinterPairHint =>
      'पहिले ब्लुटुथ सेटिङमा प्रिन्टर पेयर गर्नुहोस्, अनि यहाँ छान्नुहोस्। प्रिन्टर अन र नजिकै राख्नुहोस्।';

  @override
  String get btPrinterUse => 'प्रिन्टर प्रयोग गर्नुहोस्';

  @override
  String get btPrinterTest => 'टेस्ट प्रिन्ट';

  @override
  String get btPrinterForget => 'प्रिन्टर हटाउनुहोस्';

  @override
  String get btPrinterSelectOne => 'प्रिन्टर छान्नुहोस्';

  @override
  String get btPrinterNonePaired =>
      'पेयर भएका ब्लुटुथ उपकरण छैनन्। सिस्टम सेटिङमा रसिद प्रिन्टर पेयर गरेर फेरि प्रयास गर्नुहोस्।';

  @override
  String get btPrinterBluetoothOff => 'ब्लुटुथ अन गरेर फेरि प्रयास गर्नुहोस्।';

  @override
  String get btPrinterPermissionDenied =>
      'रसिद प्रिन्ट गर्न ब्लुटुथ अनुमति चाहिन्छ।';

  @override
  String get btPrinterConnectFailed =>
      'प्रिन्टरमा जडान हुन सकेन। अन छ र नजिकै छ कि जाँच्नुहोस्।';

  @override
  String get btPrinterPrintFailed => 'ब्लुटुथ प्रिन्टरमा प्रिन्ट हुन सकेन।';

  @override
  String get btPrinterPrintSent => 'रसिद प्रिन्टरमा पठाइयो';

  @override
  String get btPrinterTestSent => 'टेस्ट पेज प्रिन्टरमा पठाइयो';

  @override
  String get btPrinterSystemFailed => 'सिस्टम प्रिन्टर विकल्प खुल्न सकेन';

  @override
  String get btPrinterOpenSettings => 'सेटिङ खोल्नुहोस्';

  @override
  String get btPrinterNotConfigured =>
      'सेट छैन — प्रिन्टर छान्न ट्याप गर्नुहोस्';

  @override
  String get btPrinterIosHint =>
      'प्रिन्टर अन गर्नुहोस्, ब्लुटुथ अनुमति दिनुहोस्, अनि यहाँ छान्नुहोस्।';

  @override
  String itemNameFromCatalog(String name) {
    return 'क्याटलगबाट नाम भरियो: $name';
  }

  @override
  String get itemBarcodePasteHint =>
      'उत्पादन नाम फेला परेन — कोड नामको रूपमा पेस्ट भयो। आवश्यक भए सम्पादन गर्नुहोस्।';

  @override
  String get itemBulkRefillTooltip => 'अघिल्लो इनपुट भर्नुहोस्';

  @override
  String get itemBulkAddRow => 'पङ्क्ति थप्नुहोस्';

  @override
  String itemBulkRowLabel(String index) {
    return 'वस्तु $index';
  }

  @override
  String get itemBulkNameRequired => 'नाम आवश्यक';

  @override
  String get itemBulkInvalidNumber => 'अमान्य संख्या';

  @override
  String get itemBulkCreating => 'बनाउँदैछ…';

  @override
  String get itemBulkCreateItems => 'वस्तुहरू बनाउनुहोस्';

  @override
  String itemBulkCreatedCount(String count) {
    return '$count वस्तु बनाइयो';
  }

  @override
  String itemBulkCreateFailed(String error) {
    return 'वस्तु बनाउन असफल: $error';
  }

  @override
  String get itemBulkNoDraft => 'कुनै सुरक्षित ड्राफ्ट छैन';

  @override
  String get itemBulkInvalidDraft => 'सुरक्षित ड्राफ्ट ढाँचा अमान्य छ';

  @override
  String get itemBulkDraftRestored => 'अघिल्लो ड्राफ्ट पुनर्स्थापित';

  @override
  String get itemBulkDraftRestoreFailed =>
      'सुरक्षित ड्राफ्ट पुनर्स्थापित गर्न सकिएन';

  @override
  String get itemBulkAtLeastOne => 'कम्तीमा एउटा वस्तु थप्नुहोस्';

  @override
  String get itemBulkCategoriesLoading =>
      'श्रेणीहरू लोड हुँदैछ, पुनः प्रयास गर्नुहोस्';

  @override
  String get itemBulkLoadingCategories => 'श्रेणीहरू लोड हुँदैछ…';

  @override
  String get inventoryTitle => 'सूची विश्लेषण';

  @override
  String get inventorySubtitle => 'वास्तविक-समय स्टक चलाउने ट्र्याकिङ';

  @override
  String get inventorySearchHint => 'वस्तु खोज्नुहोस्…';

  @override
  String get inventorySold => 'बिक्री';

  @override
  String get inventoryPurchased => 'खरिद';

  @override
  String get catNoCategories => 'कुनै श्रेणी छैन। + थिचेर बनाउनुहोस्।';

  @override
  String get catLoadCategories => 'श्रेणीहरू लोड गर्नुहोस्';

  @override
  String get catCreated => 'श्रेणी बनाइयो';

  @override
  String get catRenamed => 'श्रेणी पुनःनामकरण';

  @override
  String get catDeleted => 'श्रेणी मेटाइयो';

  @override
  String catDeletedBulk(int count) {
    return '$count categories deleted';
  }

  @override
  String get catNewTitle => 'नयाँ श्रेणी';

  @override
  String get catRenameTitle => 'श्रेणी पुनःनामकरण';

  @override
  String get catNewName => 'नयाँ नाम';

  @override
  String get catRename => 'पुनःनामकरण';

  @override
  String get catDeleteTitle => 'श्रेणी मेटाउनुहोस्';

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
    return '\"$name\" मेटाउने?';
  }

  @override
  String get catDeleteLinkedHint =>
      'वस्तुहरू जोडिएका छन्। जबरजस्ती मेटाउन सकिन्छ।';

  @override
  String get catForceDelete => 'जबरजस्ती मेटाउनुहोस्';

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
    return '$count वस्तु';
  }

  @override
  String get contactFavoritesOnly => 'मात्र मनपर्ने';

  @override
  String get contactShowAll => 'सबै सम्पर्क देखाउनुहोस्';

  @override
  String get contactSearchHint => 'नाम, फोन, इमेल खोज्नुहोस्…';

  @override
  String get contactNoConnection => 'जडान छैन';

  @override
  String get contactCheckNetwork => 'नेटवर्क जाँच गरी पुनः प्रयास गर्नुहोस्।';

  @override
  String get contactSomethingWrong => 'केही गडबड भयो';

  @override
  String get contactNoContacts => 'कुनै सम्पर्क छैन';

  @override
  String get contactNoFavorites =>
      'कुनै मनपर्ने मिलेन। तारा फिल्टर बन्द गर्नुहोस् वा सम्पर्कमा मनपर्ने थप्नुहोस्।';

  @override
  String get contactTrySearchOrAdd =>
      'अर्को खोज प्रयास गर्नुहोस् वा + थिचेर सम्पर्क थप्नुहोस्।';

  @override
  String get contactEndOfList => 'सूचीको अन्त्य';

  @override
  String get contactNewTooltip => 'नयाँ सम्पर्क';

  @override
  String get contactLoading => 'सम्पर्क लोड हुँदैछ…';

  @override
  String get contactUnknown => 'अज्ञात';

  @override
  String get contactCallTooltip => 'कल';

  @override
  String get contactEditTitle => 'सम्पर्क सम्पादन';

  @override
  String get contactNewTitle => 'नयाँ सम्पर्क';

  @override
  String get contactSelectTitle => 'सम्पर्क छान्नुहोस्';

  @override
  String get contactDeleteTitle => 'सम्पर्क मेटाउने?';

  @override
  String get contactDeleteUndo => 'यो कार्य फिर्ता गर्न सकिँदैन।';

  @override
  String get contactNameRequired => 'नाम आवश्यक';

  @override
  String get contactNameLabel => 'नाम *';

  @override
  String get contactNameHint => 'सम्पर्कको नाम';

  @override
  String get contactPhoneHint => '+977-9841234567';

  @override
  String get contactEmailHint => 'email@example.com';

  @override
  String get contactCategoryHint => 'जस्तै: व्यापार, सामान्य, vip';

  @override
  String get contactCompanyHint => 'कम्पनीको नाम';

  @override
  String get contactFavorite => 'मनपर्ने';

  @override
  String get contactCannotCall => 'यो उपकरणमा कल गर्न सकिँदैन';

  @override
  String get contactPermissionDenied =>
      'सम्पर्क अनुमति अस्वीकार। सेटिङमा सक्षम गर्न सकिन्छ।';

  @override
  String get contactPermissionRequired =>
      'फोनबाट आयात गर्न सम्पर्क अनुमति चाहिन्छ';

  @override
  String get contactImported => 'फोनबाट सम्पर्क आयात भयो';

  @override
  String get contactCreated => 'सम्पर्क बनाइयो';

  @override
  String get contactUpdated => 'सम्पर्क अपडेट भयो';

  @override
  String get contactDeleted => 'सम्पर्क मेटाइयो';

  @override
  String get contactImportSearchHint => 'नाम, फोन, इमेल, कम्पनी खोज्नुहोस्';

  @override
  String get contactImportNoResults => 'कुनै सम्पर्क फेला परेन';

  @override
  String get checkoutMultiplePaymentHint =>
      'ग्राहकले धेरै भुक्तानी विधिबाट तिर्दा यो अन गर्नुहोस्।';

  @override
  String get checkoutFillRemainingBalance => 'बाँकी रकम भर्नुहोस्';

  @override
  String get checkoutEnterAtLeastOnePayment =>
      'कम्तीमा एउटा भुक्तानी रकम प्रविष्ट गर्नुहोस्';

  @override
  String get checkoutPaymentsExceedTotal =>
      'कुल भुक्तानी कुल जम्मा भन्दा बढी हुन सक्दैन';

  @override
  String checkoutSentAs(String api) {
    return 'पठाइयो: $api';
  }

  @override
  String get paymentCard => 'कार्ड';

  @override
  String get paymentQr => 'QR';

  @override
  String get paymentBank => 'बैंक';

  @override
  String get paymentTransfer => 'ट्रान्सफर';

  @override
  String get paymentBankTransfer => 'बैंक ट्रान्सफर';

  @override
  String get paymentSettlement => 'मिलान';

  @override
  String get paymentCheque => 'चेक';

  @override
  String get paymentDigital => 'डिजिटल';

  @override
  String get paymentDigitalQr => 'डिजिटल (QR)';

  @override
  String get closeSummaryTitle => 'बन्द सारांश';

  @override
  String get closeTabDashboard => 'ड्यासबोर्ड';

  @override
  String get closeTabCredits => 'उधारो';

  @override
  String get closeWelcome => 'बन्द सारांशमा स्वागत छ';

  @override
  String get closeSelectDateHint =>
      'डाटा लोड गर्न मिति छान्नुहोस् र रिफ्रेस ट्याप गर्नुहोस्';

  @override
  String get closeLoadingDashboard => 'ड्यासबोर्ड डेटा लोड हुँदैछ…';

  @override
  String get closeDataDeleted => 'डेटा मेटाइयो';

  @override
  String closeErrorPrefix(String message) {
    return 'त्रुटि: $message';
  }

  @override
  String get closeExtraAmount => 'थप रकम';

  @override
  String get closeExtraAmountDesc =>
      'यो बन्द दिनका लागि रेकर्ड गरिएको थप नगद वा समायोजन।';

  @override
  String get closeLostAmount => 'हराएको रकम';

  @override
  String get closeLostAmountDesc =>
      'यो अवधिका लागि चिन्ह लगाइएको नगद कमी वा भिन्नता।';

  @override
  String get closeTapForDetails => 'विवरणका लागि ट्याप गर्नुहोस्';

  @override
  String get closeAmountLabel => 'बन्द';

  @override
  String get closeAmountFormula => 'बन्द रकम सूत्र';

  @override
  String get closeFormulaExpression => 'नगद बिक्री - नगद खर्च = बन्द रकम';

  @override
  String get closeCashSales => 'नगद बिक्री';

  @override
  String get closeCashExpenses => 'नगद खर्च';

  @override
  String get closeClosingAmount => 'बन्द रकम';

  @override
  String get closeWhatThisMeans => 'यसको अर्थ:';

  @override
  String get closeClosingMeaning =>
      'दिनको अन्त्यमा तपाईंको रजिस्टर/दराजमा हुनुपर्ने नगद रकम हो। यसले प्राप्त सबै नगदबाट तिरिएको नगद घटाएर देखाउँछ।';

  @override
  String get closeQuickStats => 'छिटो तथ्याङ्क';

  @override
  String get closeTapCardHint => 'छोटो विवरणका लागि कार्ड ट्याप गर्नुहोस्';

  @override
  String get closeOpeningBalance => 'सुरुवाती मौज्दात';

  @override
  String get closeTotalSales => 'कुल बिक्री';

  @override
  String get closeQrAmount => 'QR रकम';

  @override
  String get closeCashAmount => 'नगद रकम';

  @override
  String get closeSalesDiscount => 'बिक्री छुट';

  @override
  String get closeCreditQr => 'उधारो QR';

  @override
  String get closeCreditCash => 'उधारो नगद';

  @override
  String get closeCreditDiscount => 'उधारो छुट';

  @override
  String get closePayCashGetQr => 'नगद तिरेर QR पाउनु';

  @override
  String get closePayQrGetCash => 'QR तिरेर नगद पाउनु';

  @override
  String get closePaymentMix => 'भुक्तानी मिश्रण';

  @override
  String get closePaymentMixHint =>
      'नगद वा डिजिटल ट्याप गर्नुहोस् · पट्टीले बिक्रीको हिस्सा देखाउँछ';

  @override
  String get closeCashVsDigitalTooltip => 'बिक्रीमा नगद बनाम डिजिटल हिस्सा';

  @override
  String closeSalesShareDesc(String label, String percent) {
    return '$label ले यो दिनको कुल बिक्रीको $percent% बनायो।';
  }

  @override
  String closeSalesLabel(String label) {
    return '$label बिक्री';
  }

  @override
  String get closeNoTransactions => 'कुनै कारोबार उपलब्ध छैन';

  @override
  String get closeRecentTransactions => 'भर्खरका कारोबार';

  @override
  String get closeViewAll => 'सबै हेर्नुहोस्';

  @override
  String get closeNoPurchases => 'कुनै खरिद उपलब्ध छैन';

  @override
  String get closeRecentPurchases => 'भर्खरका खरिद';

  @override
  String get closeNoSalesDate => 'यो मितिमा कुनै बिक्री छैन';

  @override
  String get closeNoSalesHint => 'बिक्री रेकर्ड भएपछि यहाँ देखिनेछ।';

  @override
  String get closeRoomSales => 'कोठा बिक्री';

  @override
  String get closeEmployeeSales => 'कर्मचारी बिक्री';

  @override
  String get closeOtherSales => 'अन्य बिक्री';

  @override
  String closeSectionCount(String title, String count) {
    return '$title ($count)';
  }

  @override
  String closeDiscountShort(String amount) {
    return 'छुट: $amount';
  }

  @override
  String closePercentOff(String percent) {
    return '$percent% छुट';
  }

  @override
  String get closePending => 'बाँकी';

  @override
  String get closeNoCreditPayments => 'कुनै उधारो भुक्तानी छैन';

  @override
  String get closeNoCreditHint => 'उधारो भुक्तानी यहाँ देखिनेछ';

  @override
  String get closeViewStatistics => 'तथ्याङ्क हेर्नुहोस्';

  @override
  String get closeExportData => 'डाटा निर्यात';

  @override
  String get closeExportComingSoon => 'निर्यात सुविधा यहाँ कार्यान्वयन हुनेछ';

  @override
  String get closeHintOpeningBalance => 'छानिएको दिनको सुरुवातमा नगद स्थिति।';

  @override
  String get closeHintTotalSales =>
      'यो मितिका लागि रेकर्ड भएका सबै बिक्रीको योग।';

  @override
  String get closeHintQrAmount => 'QR वा डिजिटल विधिबाट प्राप्त भुक्तानी।';

  @override
  String get closeHintCashAmount => 'दिनको बिक्रीको नगद हिस्सा।';

  @override
  String get closeHintCashExpenses => 'दिनभर तिरिएको नगद खर्च।';

  @override
  String get closeHintSalesDiscount => 'बिक्रीमा लागू छुट।';

  @override
  String get closeHintCreditQr => 'उधारोसँग सम्बन्धित QR संकलन।';

  @override
  String get closeHintCreditCash => 'उधारोसँग सम्बन्धित नगद कारोबार।';

  @override
  String get closeHintCreditDiscount => 'उधारो कारोबारमा लागू छुट।';

  @override
  String get closeHintPayCashGetQr => 'नगद तिरेर QR उधारो प्राप्त भएको विनिमय।';

  @override
  String get closeHintPayQrGetCash => 'QR तिरेर नगद प्राप्त भएको विनिमय।';

  @override
  String get closeOpeningAmount => 'सुरुवाती रकम';

  @override
  String get closeCurrentAmount => 'हालको रकम';

  @override
  String get closeSaveReport => 'रिपोर्ट बचत गर्नुहोस्';

  @override
  String get closeUpdateSummary => 'सारांश अपडेट गर्नुहोस्';

  @override
  String get closeExists => 'छ';

  @override
  String get closeExistingDataInfo =>
      'तपाईं अवस्थित डेटा हेर्न वा सम्पादन गर्न सक्नुहुन्छ';

  @override
  String get closeEnterOpeningAmount => 'कृपया सुरुवाती रकम प्रविष्ट गर्नुहोस्';

  @override
  String get closeEnterValidAmount => 'कृपया मान्य रकम प्रविष्ट गर्नुहोस्';

  @override
  String get closeAmountCannotBeNegative => 'Amount cannot be negative';

  @override
  String get googleDriveBackupSectionTitle => 'ब्याकअप र सिङ्क';

  @override
  String get googleDriveBackupTitle => 'Google Drive ब्याकअप';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Google Drive मा संगठन डेटा सुरक्षित ब्याकअप गर्न साइन इन गर्नुहोस्।';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return '$email को रूपमा साइन इन';
  }

  @override
  String get googleDriveSignIn => 'Google बाट साइन इन';

  @override
  String get googleDriveSignOut => 'साइन आउट';

  @override
  String get googleDriveBackupNow => 'अहिले ब्याकअप गर्नुहोस्';

  @override
  String get googleDriveSignInSuccess => 'Google Drive मा साइन इन भयो';

  @override
  String get googleDriveSignOutSuccess => 'Google Drive बाट साइन आउट भयो';

  @override
  String get googleDriveSignInCancelled => 'Google साइन-इन रद्द भयो';

  @override
  String get googleDriveBackupStarting => 'ब्याकअप तयार हुँदै…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'ब्याकअप अपलोड भयो ($tableCount तालिका, $recordCount रेकर्ड)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'ब्याकअपका लागि एप पूर्ण पुनः सुरु चाहिन्छ। एप बन्द गरी फेरि खोल्नुहोस् र पुनः प्रयास गर्नुहोस्।';

  @override
  String googleDriveBackupFailed(String error) {
    return 'ब्याकअप असफल: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'अन्तिम ब्याकअप: $date';
  }

  @override
  String get backupSyncPageTitle => 'ब्याकअप र सिङ्क';

  @override
  String get backupSyncGoogleAccount => 'Google खाता';

  @override
  String get backupSyncSignedInAs => 'यस रूपमा साइन इन';

  @override
  String get backupSyncSignInHint =>
      'संगठन डेटा ब्याकअप गर्न Google बाट साइन इन गर्नुहोस्।';

  @override
  String get backupSyncLastSyncTitle => 'अन्तिम सिङ्क';

  @override
  String get backupSyncLastSyncDate => 'मिति र समय';

  @override
  String get backupSyncNeverSynced => 'अहिलेसम्म कुनै ब्याकअप अपलोड भएको छैन।';

  @override
  String get backupSyncOrganization => 'संगठन';

  @override
  String get backupSyncTables => 'ब्याकअप गरिएका तालिकाहरू';

  @override
  String get backupSyncRecords => 'ब्याकअप गरिएका रेकर्डहरू';

  @override
  String get backupSyncStatus => 'स्थिति';

  @override
  String get backupSyncStatusSuccess => 'पूरा भयो';

  @override
  String get backupSyncActiveOrganization => 'हालको संगठन';

  @override
  String get backupSyncActiveOrganizationHint =>
      'ब्याकअपले तपाईंले अहिले प्रयोग गरिरहेको संगठनको डेटा अपलोड गर्छ।';

  @override
  String get backupSyncUnknownOrganization => 'हालको संगठन';

  @override
  String get backupSyncInProgress => 'सिङ्क प्रगतिमा';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'चरण: $step';
  }

  @override
  String get backupSyncStepExport => 'स्थानीय डेटा निर्यात हुँदै';

  @override
  String backupSyncStepUploadTable(String table) {
    return '$table अपलोड हुँदै';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return '$file अपलोड हुँदै';
  }

  @override
  String backupSyncLastError(String error) {
    return 'अन्तिम त्रुटि: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'यस उपकरणमा Google Drive बाट साइन आउट गर्ने?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Google Drive मा ब्याकअप';

  @override
  String get moreBackupSyncTileSignedInNoSync =>
      'साइन इन · अहिलेसम्म ब्याकअप छैन';

  @override
  String get backupSyncConnected => 'जडान भयो';

  @override
  String get backupSyncCompletedHint =>
      'तपाईंको डेटा Google Drive मा सुरक्षित रूपमा ब्याकअप भयो।';

  @override
  String get backupSyncPhaseExport => 'निर्यात';

  @override
  String get backupSyncPhaseUpload => 'अपलोड';

  @override
  String get backupAutoSettingsTitle => 'Google Drive सेटिङहरू';

  @override
  String get backupAutoBackupTitle => 'स्वचालित ब्याकअप';

  @override
  String get backupAutoBackupHint => 'समय भएमा एप सुरु हुँदा स्वचालित ब्याकअप';

  @override
  String get backupWifiOnlyTitle => 'Wi‑Fi मा मात्र ब्याकअप';

  @override
  String get backupWifiOnlyHint => 'स्वचालित ब्याकअप Wi‑Fi को पर्खन्छ';

  @override
  String get backupWifiOnlyContinue => 'मोबाइल डेटा प्रयोग गर्नुहोस्';

  @override
  String get backupAutoFrequencyTitle => 'ब्याकअप आवृत्ति';

  @override
  String get backupAutoFrequencyOff => 'बन्द';

  @override
  String get backupAutoFrequencyDaily => 'दैनिक';

  @override
  String get backupAutoFrequencyWeekly => 'साप्ताहिक';

  @override
  String get backupAutoFrequencyMonthly => 'मासिक';

  @override
  String get backupAutoSyncDirectionTitle => 'स्वचालित सिङ्क';

  @override
  String get backupAutoDirectionUpload => 'क्लाउडमा अपलोड';

  @override
  String get backupAutoDirectionDownload => 'क्लाउडबाट डाउनलोड';

  @override
  String get backupAutoDirectionBoth => 'अपलोड र डाउनलोड';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'अन्तिम स्वचालित ब्याकअप: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'अन्तिम स्वचालित पुनर्स्थापना: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'अन्तिम स्वचालित सिङ्क असफल: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'अन्तिम स्वचालित सिङ्क छोडियो: $detail';
  }

  @override
  String get restoreAction => 'पुनर्स्थापना';

  @override
  String get restoreFromGoogleDrive => 'Google Drive बाट पुनर्स्थापना';

  @override
  String get restoreFromGoogleDriveHint =>
      'साइन इन गरी ब्याकअप छान्नुहोस् र यस उपकरणमा संगठन पुनर्स्थापना गर्नुहोस्।';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '\"$name\" पुनर्स्थापना गर्ने? यसले त्यो संगठनको स्थानीय डेटा प्रतिस्थापन गर्छ।';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name पुनर्स्थापना भयो। अब साइन इन गर्न सक्नुहुन्छ।';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'पुनर्स्थापना असफल: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'तपाईंको Google Drive मा कुनै ब्याकअप फेला परेन।';

  @override
  String get restoreFromGoogleDriveStarting => 'पुनर्स्थापना सुरु हुँदै…';

  @override
  String get restoreStepDownload => 'ब्याकअप डाउनलोड हुँदै';

  @override
  String get restoreStepCreateDatabase => 'डाटाबेस बनाउँदै';

  @override
  String get restoreStepImport => 'डेटा आयात हुँदै';

  @override
  String get restoreStepFinalize => 'पुनर्स्थापना समाप्त हुँदै';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'अन्तिम सिङ्क: $date';
  }

  @override
  String get security => 'सुरक्षा';

  @override
  String get appLockTitle => 'एप लक';

  @override
  String get appLockSubtitle => 'एप पुनः खोल्दा PIN वा बायोमेट्रिक्स आवश्यक';

  @override
  String get appPin => 'एप PIN';

  @override
  String appPinSubtitle(int length) {
    return '$length-अङ्कको PIN बाट छिटो अनलक';
  }

  @override
  String get useBiometricUnlock => 'Face ID / बायोमेट्रिक्स प्रयोग गर्नुहोस्';

  @override
  String get useBiometricUnlockSubtitle =>
      'PIN सेट गरेपछि फिङ्गरप्रिन्ट वा Face ID ले अनलक गर्नुहोस्';

  @override
  String get changeAppPin => 'PIN परिवर्तन गर्नुहोस्';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'PIN सेट गर्नुहोस्';

  @override
  String get confirmAppPin => 'PIN पुष्टि गर्नुहोस्';

  @override
  String get enterAppPin => 'आफ्नो PIN प्रविष्ट गर्नुहोस्';

  @override
  String get enterPasscode => 'पासकोड प्रविष्ट गर्नुहोस्';

  @override
  String tapDigitsToUnlock(int length) {
    return 'अनलक गर्न $length अङ्क ट्याप गर्नुहोस्।';
  }

  @override
  String createPasscodeHint(int length) {
    return 'यस संगठनको लागि $length-अङ्कको पासकोड छान्नुहोस्';
  }

  @override
  String get confirmPasscodeHint =>
      'पुष्टि गर्न पासकोड फेरि प्रविष्ट गर्नुहोस्';

  @override
  String createAppPinHint(int length) {
    return 'यस संगठनको लागि $length-अङ्कको PIN छान्नुहोस्';
  }

  @override
  String get confirmAppPinHint => 'पुष्टि गर्न PIN फेरि प्रविष्ट गर्नुहोस्';

  @override
  String get appPinMismatch => 'PIN मिलेन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get appPinIncorrect => 'गलत PIN। फेरि प्रयास गर्नुहोस्।';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'गलत PIN। तपाईंसँग $remaining प्रयास बाँकी छ।';
  }

  @override
  String get appPinLockoutMessage =>
      'धेरै पटक गलत PIN। PIN रिसेट गर्न इमेल र पासवर्डले साइन इन गर्नुहोस्।';

  @override
  String get appPinSetSuccess => 'यस संगठनको लागि PIN सुरक्षित भयो';

  @override
  String get appPinRemoved => 'एप PIN हटाइयो';

  @override
  String get appLockSettingsSaved => 'एप लक सेटिङहरू सुरक्षित भयो';

  @override
  String get biometricUnlockReason => 'BizTrack अनलक गर्नुहोस्';

  @override
  String get biometricNotAvailable => 'यस उपकरणमा बायोमेट्रिक्स उपलब्ध छैन';

  @override
  String get biometricRequiresPin =>
      'बायोमेट्रिक्स सक्षम गर्नुअघि एप PIN सेट गर्नुहोस्';

  @override
  String get disableAppPinTitle => 'एप PIN हटाउने?';

  @override
  String get disableAppPinMessage =>
      'यस संगठनको लागि Face ID / बायोमेट्रिक अनलक पनि बन्द हुन्छ।';

  @override
  String get verifyPinToRemoveTitle => 'आफ्नो PIN प्रविष्ट गर्नुहोस्';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'एप लक हटाउन $length-अङ्कको PIN पुष्टि गर्नुहोस्';
  }

  @override
  String get unlockApp => 'एप अनलक गर्नुहोस्';

  @override
  String get usePinInstead => 'सट्टामा PIN प्रयोग गर्नुहोस्';

  @override
  String get useBiometricInstead => 'बायोमेट्रिक्स प्रयोग गर्नुहोस्';

  @override
  String get signInWithFaceId => 'Face ID ले साइन इन';

  @override
  String get signInWithFingerprint => 'फिङ्गरप्रिन्टले साइन इन';

  @override
  String get signInWithBiometric => 'बायोमेट्रिक्सले साइन इन';

  @override
  String get signInWithPin => 'PIN ले साइन इन';

  @override
  String get setUpQuickUnlock => 'PIN छिटो साइन-इन सेट गर्नुहोस्';

  @override
  String get setUpFaceIdOrPin => 'Face ID वा PIN सेट गर्नुहोस्';

  @override
  String get setUpFingerprintOrPin => 'फिङ्गरप्रिन्ट वा PIN सेट गर्नुहोस्';

  @override
  String get setUpQuickUnlockSubtitle =>
      'यस संगठनका लागि बायोमेट्रिक्स वा PIN प्रयोग गर्नुहोस्';

  @override
  String quickUnlockAsUser(String email) {
    return '$email को रूपमा छिटो साइन-इन';
  }

  @override
  String get orContinueWithPassword => 'वा पासवर्डले साइन इन गर्नुहोस्';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'छिटो साइन-इन सक्षम गर्ने?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'अर्को पटक छिटो साइन-इनका लागि Face ID, फिङ्गरप्रिन्ट वा PIN सेट गर्नुहोस्। पछि सेटिङहरूबाट पनि परिवर्तन गर्न सक्नुहुन्छ।';

  @override
  String get notNow => 'अहिले होइन';

  @override
  String get setUpNow => 'अहिले सेट गर्नुहोस्';

  @override
  String get enableFaceIdTitle => 'Face ID सक्षम गर्ने?';

  @override
  String get enableFingerprintTitle => 'फिङ्गरप्रिन्ट सक्षम गर्ने?';

  @override
  String get enableBiometricTitle => 'बायोमेट्रिक्स सक्षम गर्ने?';

  @override
  String get enableBiometricAfterPinMessage =>
      'छिटो साइन-इनका लागि PIN सँग उपकरण बायोमेट्रिक्स प्रयोग गर्नुहोस्।';

  @override
  String get useFaceIdUnlock => 'Face ID प्रयोग गर्नुहोस्';

  @override
  String get useFingerprintUnlock => 'फिङ्गरप्रिन्ट प्रयोग गर्नुहोस्';

  @override
  String get ok => 'ठीक छ';

  @override
  String get reportPeriodYear => 'वर्ष';

  @override
  String get reportPeriodMonth => 'महिना';

  @override
  String get reportPeriodRange => 'दायरा';

  @override
  String get reportPeriodDay => 'दिन';

  @override
  String get reportPeriodFrom => 'देखि';

  @override
  String get reportPeriodTo => 'सम्म';

  @override
  String get reportPeriod => 'अवधि';

  @override
  String get reportAllPurchases => 'सबै खरिद';

  @override
  String get reportBeforeTax => 'कर अघि';

  @override
  String get reportRevenueRetained => 'राजस्व बाँकी';

  @override
  String get reportHideDetails => 'विवरण लुकाउनुहोस्';

  @override
  String get reportShowDetails => 'विवरण देखाउनुहोस्';

  @override
  String get reportSalesRevenue => 'बिक्री राजस्व';

  @override
  String get reportDiscountsGiven => 'दिइएका छुट';

  @override
  String get reportNetRevenue => 'शुद्ध राजस्व';

  @override
  String get reportOperatingExpenses => 'सञ्चालन खर्च';

  @override
  String get reportTotalExpenses => 'कुल खर्च';

  @override
  String get reportGrossProfit => 'कुल नाफा';

  @override
  String get reportGrossProfitChart => 'कुल नाफा';

  @override
  String get reportOperatingPlDisclaimer =>
      'कर, मूल्यह्रास र तलब दायित्व अझै समावेश छैन — सञ्चालन स्तर P&L अनुमान।';

  @override
  String get reportContraLabel => 'कन्ट्रा';

  @override
  String get reportNoDataForPeriod => 'छानिएको अवधिका लागि कुनै डाटा छैन';

  @override
  String get reportRevenueVsExpenses => 'राजस्व बनाम खर्च';

  @override
  String get reportExpenseBreakdown => 'खर्च विवरण';

  @override
  String get reportExpenseFallback => 'खर्च';

  @override
  String get reportGrossMarginPercent => 'कुल मार्जिन %';

  @override
  String get reportRoomVsFnB => 'कोठा बनाम F&B';

  @override
  String get reportSegmentRoom => 'कोठा';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'मुख्य मेट्रिक';

  @override
  String get reportIncomeStatement => 'आय विवरण';

  @override
  String get reportChartsSection => 'चार्ट';

  @override
  String get reportSegmentSummary => 'खण्ड सारांश';

  @override
  String get reportFailedToLoad => 'प्रतिवेदन लोड असफल';

  @override
  String get reportOverview => 'अवलोकन';

  @override
  String get reportOverviewCash => 'नगद';

  @override
  String get reportOverviewBank => 'बैंक';

  @override
  String get reportMonthlyOpeningBalance => 'मासिक सुरुवाती शेष';

  @override
  String get reportOpeningBalanceHint => 'प्रत्येक महिनाको सुरुमा नगद स्थिति';

  @override
  String get reportCashInOut => 'नगद प्राप्ति / भुक्तानी';

  @override
  String get reportCashIn => 'नगद प्राप्ति';

  @override
  String get reportCashOut => 'नगद भुक्तानी';

  @override
  String get reportBankReceiptsPayments => 'बैंक प्राप्ति / भुक्तानी';

  @override
  String get reportReceipts => 'प्राप्ति';

  @override
  String get reportPayments => 'भुक्तानी';

  @override
  String get reportDailyCashVsQr => 'दैनिक नगद बनाम QR';

  @override
  String get reportSummariesSection => 'सारांश';

  @override
  String get reportCashSummary => 'नगद सारांश';

  @override
  String get reportBankSummary => 'बैंक सारांश';

  @override
  String get reportDailySummary => 'दैनिक सारांश';

  @override
  String get reportTabPurchase => 'खरिद';

  @override
  String get reportTabSales => 'बिक्री';

  @override
  String get reportTabDashboard => 'ड्यासबोर्ड';

  @override
  String get reportSingleDayTrend => 'एक दिन — दैनिक प्रवृत्ति';

  @override
  String get reportFullYearTrend => 'पूरा वर्ष — मासिक प्रवृत्ति चार्ट';

  @override
  String reportYearLabel(String year) {
    return 'वर्ष $year';
  }

  @override
  String reportJanDec(String year) {
    return 'जन – डिस $year';
  }

  @override
  String get reportTotalPurchases => 'कुल खरिद';

  @override
  String get reportTotalSales => 'कुल बिक्री';

  @override
  String get reportTotalInvoices => 'कुल बिल';

  @override
  String get reportUnpaidBalance => 'नतिरेको शेष';

  @override
  String get reportAvgPerInvoice => 'प्रति बिल औसत';

  @override
  String get reportPerTransaction => 'प्रति लेनदेन';

  @override
  String reportMonthlySpend(String symbol) {
    return 'मासिक खर्च ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'मासिक बिक्री ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'महिना अनुसार बिल संख्या';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'खर्च अनुसार शीर्ष वस्तु ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'श्रेणी अनुसार खर्च';

  @override
  String get reportOtherCategory => 'अन्य';

  @override
  String get reportSuppliers => 'आपूर्तिकर्ता';

  @override
  String get reportTableSupplier => 'आपूर्तिकर्ता';

  @override
  String get reportTableAmount => 'रकम';

  @override
  String get reportTableBills => 'बिल';

  @override
  String get reportSalesTotal => 'कुल बिक्री';

  @override
  String get reportPurchaseTotal => 'कुल खरिद';

  @override
  String get reportPositiveMargin => 'धनात्मक मार्जिन';

  @override
  String get reportNegativeMargin => 'ऋणात्मक मार्जिन';

  @override
  String get reportGrossMargin => 'कुल मार्जिन';

  @override
  String get reportOfTotalSales => 'कुल बिक्री को';

  @override
  String get reportFailedToLoadAnalytics => 'विश्लेषण लोड असफल';

  @override
  String get reportMarginKpi => 'मार्जिन';

  @override
  String get reportExpensesKpi => 'खर्च';

  @override
  String partyPickerNoResultsFor(String query) {
    return '\"$query\" का लागि कुनै नतिजा छैन';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'कुनै $role पक्ष फेला परेन';
  }

  @override
  String get partyPickerLoadParties => 'पक्ष लोड गर्नुहोस्';

  @override
  String get invoiceCashCustomer => 'नगद ग्राहक';

  @override
  String get invoiceQuickAddItemsTitle => 'छिटो वस्तु थप';

  @override
  String get invoiceQuickLoadingMenu => 'मेनु लोड हुँदै…';

  @override
  String get invoiceQuickInvoiceCreated => 'बिल बनाइयो';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'कम्तीमा एउटा वस्तु थप्नुहोस्';

  @override
  String get invoiceQuickNoResults => 'कुनै नतिजा फेला परेन!';

  @override
  String get invoiceQuickNoItemsInCategory => 'यो श्रेणीमा कुनै वस्तु छैन';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'वस्तु थप्नुहोस्';

  @override
  String get invoiceQuickLoadMore => 'थप लोड';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'थप लोड गर्न स्क्रोल गर्नुहोस् ($count प्रति पृष्ठ)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'आपूर्तिकर्ता / कर्मचारी';

  @override
  String get invoiceQuickEditItem => 'वस्तु सम्पादन';

  @override
  String get invoiceQuickFavorites => 'मनपर्ने';

  @override
  String get invoiceQuickManageFavorites => 'Manage';

  @override
  String get invoiceQuickRepeated => 'दोहोरिएको';

  @override
  String get invoiceQuickRepeatedHint => 'धेरै पटक बेचिने वस्तुहरू';

  @override
  String get invoiceQuickAddFavorite => 'मनपर्नेमा थप्नुहोस्';

  @override
  String get invoiceQuickRemoveFavorite => 'मनपर्नेबाट हटाउनुहोस्';

  @override
  String get invoiceQuickFavoriteAdded => 'मनपर्नेमा थपियो';

  @override
  String get invoiceQuickFavoriteRemoved => 'मनपर्नेबाट हटाइयो';

  @override
  String get invoiceQuickNoFavorites => 'अहिलेसम्म मनपर्ने वस्तु छैन';

  @override
  String get invoiceQuickNoFavoritesSubtitle =>
      'धेरै बेच्ने वस्तुमा तारा थिच्नुहोस्, यहाँ देखिन्छ।';

  @override
  String get invoiceQuickNoRepeated => 'अहिलेसम्म दोहोरिएको बिक्री छैन';

  @override
  String get invoiceQuickNoRepeatedSubtitle =>
      'एक पटकभन्दा बढी बेचेका वस्तुहरू यहाँ स्वतः देखिन्छन्।';

  @override
  String get closeSelectDateRange => 'मिति दायरा छान्नुहोस्';

  @override
  String get closeStartDate => 'सुरु मिति';

  @override
  String get closeEndDate => 'अन्त्य मिति';

  @override
  String get closeSelectBothDates => 'कृपया सुरु र अन्त्य दुवै मिति छान्नुहोस्';

  @override
  String get closeDeleteSummary => 'सारांश मेटाउनुहोस्';

  @override
  String get closeDeleteSummaryConfirm =>
      'के तपाईं यो सारांश मेटाउन निश्चित हुनुहुन्छ?';

  @override
  String get closeSelectDate => 'मिति छान्नुहोस्';

  @override
  String get closeNoDataToExport => 'निर्यात गर्न कुनै डाटा छैन';

  @override
  String get closeNoDataToShare => 'साझा गर्न कुनै डाटा छैन';

  @override
  String get closeNoDataToPrint => 'प्रिन्ट गर्न कुनै डाटा छैन';

  @override
  String closePdfGenerateError(String error) {
    return 'PDF बनाउँदा त्रुटि: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'PDF साझा गर्दा त्रुटि: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'PDF प्रिन्ट गर्दा त्रुटि: $error';
  }

  @override
  String get closeExportPdf => 'PDF को रूपमा निर्यात';

  @override
  String get closeSharePdf => 'PDF साझा';

  @override
  String get closePrint => 'प्रिन्ट';

  @override
  String get closeExportOptions => 'निर्यात विकल्प';

  @override
  String get closeExportPdfSubtitle => 'PDF कागजातको रूपमा बचत वा हेर्नुहोस्';

  @override
  String get closeSharePdfSubtitle => 'एप वा इमेल मार्फत साझा गर्नुहोस्';

  @override
  String get closePrintSubtitle => 'प्रतिवेदन प्रिन्ट गर्नुहोस्';

  @override
  String get closeDailyCashSummaryTitle => 'दैनिक नगद सारांश';

  @override
  String get closeDailyCashSummaryReport => 'दैनिक नगद सारांश प्रतिवेदन';

  @override
  String closeGeneratedAt(String date) {
    return 'उत्पादन: $date';
  }

  @override
  String get closeTotalRecords => 'कुल रेकर्ड';

  @override
  String get closeSummaryOverview => 'सारांश अवलोकन';

  @override
  String get closeAllRecords => 'सबै रेकर्ड';

  @override
  String closePeriodRange(String start, String end) {
    return 'अवधि: $start देखि $end';
  }

  @override
  String get closeDetails => 'विवरण';

  @override
  String closePageN(int n) {
    return 'पृष्ठ $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return '$total मध्ये $shown देखाइँदै';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'लोड: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'कोठा / केबिन / कर्मचारी';

  @override
  String reportPercentOfRevenue(String percent) {
    return 'राजस्व को $percent%';
  }

  @override
  String get reportParties => 'पक्ष';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — दैनिक प्रवृत्ति चार्ट';
  }

  @override
  String get invoiceQuickCart => 'कार्ट';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'कार्ट ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'खोज खाली गर्नुहोस्';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'सारांश थप्नुहोस्';

  @override
  String get closeSalesAmount => 'बिक्री रकम';

  @override
  String get closeClosingBalance => 'अन्तिम मौज्दात';

  @override
  String get closeLostMoney => 'हराएको पैसा';

  @override
  String get closeDiscount => 'छुट';

  @override
  String get closeExpenses => 'खर्च';

  @override
  String get closeUnpaid => 'नतिरिएको';

  @override
  String get closeTotalOpeningBalance => 'कुल सुरु मौज्दात';

  @override
  String get closeTotalSalesAmount => 'कुल बिक्री रकम';

  @override
  String get closeTotalCashAmount => 'कुल नगद रकम';

  @override
  String get closeTotalQrAmount => 'कुल QR रकम';

  @override
  String get closeTotalDiscount => 'कुल छुट';

  @override
  String get closeTotalExpenses => 'कुल खर्च';

  @override
  String get closeTotalClosingBalance => 'कुल अन्तिम मौज्दात';

  @override
  String get closeTotalLostMoney => 'कुल हराएको पैसा';

  @override
  String get closeTotalExtraAmount => 'कुल थप रकम';

  @override
  String get closeShowingCurrentMonth => 'हालको महिनाको डाटा देखाइँदै';

  @override
  String get closeNoSummariesFound => 'कुनै सारांश फेला परेन';

  @override
  String get closeNoSummariesAvailable => 'कुनै सारांश छैन';

  @override
  String get closeTryAdjustingDateRange => 'मिति दायरा समायोजन गर्नुहोस्';

  @override
  String get closeCreateFirstSummary => 'सुरु गर्न पहिलो सारांश बनाउनुहोस्';

  @override
  String get closeClearFilter => 'फिल्टर हटाउनुहोस्';

  @override
  String get closeFiltered => 'फिल्टर गरिएको';

  @override
  String closeFilteredWithRange(String range) {
    return 'फिल्टर: $range';
  }

  @override
  String get closeSummarySingular => 'सारांश';

  @override
  String get closeSummariesPlural => 'सारांशहरू';

  @override
  String get closeSummaryUpdatedSuccess => 'सारांश सफलतापूर्वक अपडेट';

  @override
  String get closeSummaryDeletedSuccess => 'सारांश सफलतापूर्वक मेटियो';

  @override
  String premiumUnlockTitle(String appName) {
    return '$appName Premium अनलक गर्नुहोस्';
  }

  @override
  String get premiumTagline =>
      'पूर्ण अफलाइन POS, इनभ्वाइस, इन्भेन्टरी र रिपोर्ट — तपाईंको व्यवसायका लागि एउटै सदस्यता।';

  @override
  String get premiumFeatureUnlimitedInvoices => 'असीमित इनभ्वाइस र रसिद';

  @override
  String get premiumFeatureInventoryStock => 'इन्भेन्टरी र स्टक ट्र्याकिङ';

  @override
  String get premiumFeatureReportsAnalytics => 'बिक्री रिपोर्ट र विश्लेषण';

  @override
  String get premiumFeatureOfflineLocal =>
      'अफलाइन काम गर्छ — तपाईंको डेटा स्थानीय रहन्छ';

  @override
  String premiumContinueWith(String plan) {
    return '$plan सँग जारी राख्नुहोस्';
  }

  @override
  String get premiumRestorePurchases => 'खरिद पुनर्स्थापना गर्नुहोस्';

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
      'भुक्तानी तपाईंको Apple ID मा चार्ज हुन्छ। अवधि समाप्त हुनुभन्दा कम्तीमा २४ घण्टा अघि रद्द नगरेमा सदस्यता स्वतः नवीकरण हुन्छ।';

  @override
  String get premiumPurchaseRestored => 'खरिद पुनर्स्थापना भयो।';

  @override
  String get premiumNoActiveSubscription => 'कुनै सक्रिय सदस्यता फेला परेन।';

  @override
  String get premiumPlanMonthly => 'मासिक';

  @override
  String get premiumPlanMonthlySubtitle =>
      'लचिलो — जुनसुकै बेला रद्द गर्नुहोस्';

  @override
  String get premiumPlanYearly => 'वार्षिक';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'उत्तम मूल्य — $percent% बचत';
  }

  @override
  String get premiumPlanLifetime => 'आजीवन';

  @override
  String get premiumPlanLifetimeSubtitle =>
      'एक पटक तिर्नुहोस्, सधैं राख्नुहोस्';

  @override
  String get premiumPlanPopular => 'लोकप्रिय';

  @override
  String get premiumOneTimePurchase => 'एक पटकको खरिद';

  @override
  String get subscriptionSectionTitle => 'सदस्यता';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Premium मा अपग्रेड गर्नुहोस्';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'मासिक $monthly · वार्षिक $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan $date सम्म सक्रिय';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan सक्रिय';
  }

  @override
  String get premiumRequired => 'Premium आवश्यक';

  @override
  String get upgradeToPremiumContinue =>
      'जारी राख्न Premium मा अपग्रेड गर्नुहोस्।';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'निःशुल्क योजनामा अधिकतम $limit $label। असीमित पहुँचका लागि Premium मा अपग्रेड गर्नुहोस्।';
  }

  @override
  String get freemiumPartyRoleRequired => 'पार्टी भूमिका आवश्यक छ।';

  @override
  String get freemiumLabelSalesInvoices => 'बिक्री इनभ्वाइस';

  @override
  String get freemiumLabelPurchaseInvoices => 'खरिद इनभ्वाइस';

  @override
  String get freemiumLabelEmployees => 'कर्मचारी';

  @override
  String get freemiumLabelItems => 'वस्तु';

  @override
  String get freemiumLabelCategories => 'श्रेणी';

  @override
  String get freemiumLabelPaymentMethods => 'भुक्तानी विधि';

  @override
  String get freemiumLabelCustomPartyRoles => 'अनुकूलित पार्टी भूमिका';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return '$role का लागि पार्टी';
  }

  @override
  String get freemiumLabelOrganizations => 'संस्था';

  @override
  String get freemiumPremiumReports => 'रिपोर्ट Premium सँग उपलब्ध छ।';

  @override
  String get freemiumPremiumBackupSync => 'ब्याकअप र सिङ्क Premium चाहिन्छ।';

  @override
  String get freemiumPremiumPayroll => 'पेरोल Premium चाहिन्छ।';

  @override
  String get freemiumPremiumAttendance => 'उपस्थिति Premium चाहिन्छ।';

  @override
  String get freemiumPremiumStock => 'स्टक व्यवस्थापन Premium चाहिन्छ।';

  @override
  String get freemiumPremiumInvoiceExport =>
      'डाउनलोड र प्रिन्ट Premium चाहिन्छ।';

  @override
  String get shiftReminderOpeningTitle => 'खोल्ने सम्झना';

  @override
  String get shiftReminderOpeningMessage =>
      'के तपाईंले आजको लागि रजिष्टर खोल्नुभयो?';

  @override
  String get shiftReminderOpeningProceed => 'हो, अहिले खोल्नुहोस्';

  @override
  String get shiftReminderClosingTitle => 'बन्द गर्ने सम्झना';

  @override
  String get shiftReminderClosingMessage =>
      'के तपाईंले आजको लागि रजिष्टर बन्द गर्नुभयो?';

  @override
  String get shiftReminderClosingProceed => 'हो, अहिले बन्द गर्नुहोस्';

  @override
  String get shiftReminderSkipToday => 'आजका लागि छोड्नुहोस्';

  @override
  String get shiftReminderOpeningNotificationTitle => 'खोल्ने सम्झना';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'के तपाईंले आजको लागि रजिष्टर खोल्नुभयो? अझै खोल्नुपर्छ भने यहाँ ट्याप गर्नुहोस्।';

  @override
  String get shiftReminderClosingNotificationTitle => 'बन्द गर्ने सम्झना';

  @override
  String get shiftReminderClosingNotificationBody =>
      'के तपाईंले आजको लागि रजिष्टर बन्द गर्नुभयो? अझै बन्द गर्नुपर्छ भने यहाँ ट्याप गर्नुहोस्।';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business ले ग्राहकलाई QR तिर्छ; ग्राहकले नगद दिन्छ।';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business ले ग्राहकलाई नगद तिर्छ; ग्राहकले QR भुक्तानी दिन्छ।';
  }

  @override
  String get closePaymentExchange => 'भुक्तानी विनिमय';

  @override
  String get closePayQrGetCashExchangeLabel => 'QR तिरेर नगद विनिमय';

  @override
  String get closePayCashGetQrExchangeLabel => 'नगद तिरेर QR विनिमय';

  @override
  String get closePayQrGetCashDetail => 'QR तिरेर नगद पाउनु';

  @override
  String get closePayCashGetQrDetail => 'नगद तिरेर QR पाउनु';

  @override
  String get faqSectionPremium => 'Premium र बिलिङ';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium मा के के छ?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium ले असीमित इनभ्वाइस, पूर्ण रिपोर्ट (P&L, विवरण, विश्लेषण), ब्याकअप र सिङ्क, पेरोल, उपस्थिति, स्टक उपकरण, इनभ्वाइस निर्यात/प्रिन्ट र थप संस्थाहरू unlock गर्छ। निःशुल्क स्तरमा मुख्य POS सुविधा उचित सीमा भित्र प्रयोग गर्न सकिन्छ।';

  @override
  String get faqPremiumFreeTierQuestion => 'निःशुल्क स्तरमा के छ?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'तपाईं अधिकतम १० बिक्री र १० खरिद इनभ्वाइस, ४ कर्मचारी, ३० वस्तु बनाउन सक्नुहुन्छ र सीमा पुग्दा अन्य सीमा देखिन्छ। खोल्ने, बन्द, क्याल्कुलेटर र डेटा हेर्नु निःशुल्क रहन्छ।';

  @override
  String get faqPremiumRestoreQuestion => 'खरिद कसरी पुनर्स्थापना गर्ने?';

  @override
  String get faqPremiumRestoreAnswer =>
      'थप → Premium मा अपग्रेड (वा paywall) खोल्नुहोस् र खरिद पुनर्स्थापना ट्याप गर्नुहोस्। सदस्यता लिएको Apple ID प्रयोग गर्नुहोस्।';

  @override
  String get faqPremiumCancelQuestion => 'सदस्यता कसरी रद्द गर्ने?';

  @override
  String get faqPremiumCancelAnswer =>
      'iPhone Settings → Apple ID → Subscriptions मा व्यवस्थापन वा रद्द गर्नुहोस्। भुक्तानी अवधि समाप्तसम्म पहुँच रहन्छ।';

  @override
  String get faqDarkModeQuestion => 'डार्क मोड कसरी सक्रिय गर्ने?';

  @override
  String get faqDarkModeAnswer =>
      'थप → देखावट खोल्नुहोस् र Dark mode सक्षम गर्नुहोस्। उपकरणले प्रणाली थिम प्रयोग गर्दा एप स्वतः अनुसरण गर्छ।';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'खोल्ने र बन्द गर्ने सम्झना के हो?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName ले दैनिक नगद रजिष्टर खोल्न वा बन्द गर्न सम्झना दिन सक्छ। तपाईं जारी राख्न, आज छोड्न वा सम्झना खारेज गर्न सक्नुहुन्छ।';
  }

  @override
  String get faqPartyRolesQuestion => 'पार्टी भूमिका के हो?';

  @override
  String get faqPartyRolesAnswer =>
      'पार्टी भूमिकाले ग्राहक, आपूर्तिकर्ता, कोठा वा कर्मचारी जस्ता सम्पर्क वर्गीकरण गर्छ। सञ्चालन → Party roles मा अनुकूलन गर्नुहोस् र टोलीका लागि छोटो विवरण थप्नुहोस्।';

  @override
  String faqRateAppQuestion(String appName) {
    return '$appName कसरी मूल्याङ्कन गर्ने?';
  }

  @override
  String get faqRateAppAnswer =>
      'App Store मा समीक्षा दिन थप → Rate us खोल्नुहोस्। तपाईंको प्रतिक्रियाले अफलाइन बिलिङ सुधार गर्छ।';
}
