// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get noInternetConnection => 'ইন্টারনেট সংযোগ নেই।';

  @override
  String get formatException => 'ফরম্যাট ব্যতিক্রম';

  @override
  String get rememberMe => 'আমাকে মনে রাখুন';

  @override
  String get signIn => 'সাইন ইন করুন';

  @override
  String get passwordHint => 'পাসওয়ার্ড দিন';

  @override
  String get forgetPassword => 'লগইন তথ্য ভুলে গেছেন?';

  @override
  String get okay => 'ঠিক আছে';

  @override
  String get success => 'সফল';

  @override
  String get hotel => 'হোটেল';

  @override
  String get errorEncountered => 'ত্রুটি পাওয়া গেছে';

  @override
  String get serverError => 'সার্ভার ত্রুটি';

  @override
  String get requestFailed => 'অনুরোধ ব্যর্থ';

  @override
  String get connectionTimedOut => 'সংযোগ সময় শেষ';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get keepSignIn => 'সাইন ইন থাকুন';

  @override
  String get enterPassword => 'পাসওয়ার্ড দিন';

  @override
  String get enterValidPassword => 'বৈধ পাসওয়ার্ড দিন';

  @override
  String get skip => 'এড়িয়ে যান';

  @override
  String get pleaseWait => 'অনুগ্রহ করে অপেক্ষা করুন ....';

  @override
  String get enterValidUserName => 'বৈধ ব্যবহারকারীর নাম দিন।';

  @override
  String get userName => 'ব্যবহারকারীর নাম';

  @override
  String get or => 'অথবা';

  @override
  String get retry => 'আবার চেষ্টা';

  @override
  String get error => 'ত্রুটি';

  @override
  String get supportMessage => 'অনুগ্রহ করে অ্যাডমিনের সাথে যোগাযোগ করুন।';

  @override
  String get responseMessage404 => '৪০৪ ত্রুটি';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get cancel => 'বাতিল';

  @override
  String get yes => 'হ্যাঁ';

  @override
  String get no => 'না';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get deleteOrganizationTitle => 'সংগঠন মুছুন?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'এই ডিভাইস থেকে $name সরান। এই সংগঠনের সমস্ত স্থানীয় ডেটা মুছে ফেলা হবে।';
  }

  @override
  String get deleteOrganizationWarning => 'এটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get organizationDeleted => 'সংগঠন মুছে ফেলা হয়েছে';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get done => 'সম্পন্ন';

  @override
  String get next => 'পরবর্তী';

  @override
  String get getStarted => 'শুরু করুন';

  @override
  String get walkthroughDashboardTitle => 'আপনার পুরো ব্যবসা, এক নজরে';

  @override
  String get walkthroughDashboardDescription =>
      'আজকের বিক্রয়, আয় ও বকেয়া ব্যালেন্স — অ্যাপ খুললেই এক পরিষ্কার ড্যাশবোর্ডে।';

  @override
  String get walkthroughOfflineTitle => 'ইন্টারনেট ছাড়াও কাজ করে';

  @override
  String get walkthroughOfflineDescription =>
      'সম্পূর্ণ অফলাইনে ইনভয়েস তৈরি, খরচ লগ ও স্টক ব্যবস্থাপনা করুন। অনলাইনে ফিরলে সব স্বয়ংক্রিয়ভাবে সিঙ্ক হয়।';

  @override
  String get walkthroughBillingTitle => 'সেকেন্ডে বিল ও বিক্রি';

  @override
  String get walkthroughBillingDescription =>
      'বিক্রয় ও ক্রয় ইনভয়েস, কিচেন টিকিট সহ টেবিল অর্ডার, এবং লাইভ ইনভেন্টরি — সব এক অ্যাপ থেকে।';

  @override
  String get walkthroughStaffTitle => 'কর্মী, বেতন ও রিপোর্ট';

  @override
  String get walkthroughStaffDescription =>
      'উপস্থিতি ও বেতন চালান, তারপর P&L বিবৃতি ও পে-স্লিপ PDF হিসেবে রপ্তানি করুন — অতিরিক্ত টুল লাগবে না।';

  @override
  String get walkthroughBackupTitle => 'আপনার ডেটা, সবসময় নিরাপদ';

  @override
  String get walkthroughBackupDescription =>
      'এক-ট্যাপ Google Drive ব্যাকআপের সাথে ব্যাংক-গ্রেড নিরাপত্তা, যাতে আপনার রেকর্ড সুরক্ষিত থাকে এবং সহজে পুনরুদ্ধার করা যায়।';

  @override
  String get walkthroughReadyTitle => 'আপনি প্রস্তুত হলেই প্রস্তুত';

  @override
  String get walkthroughReadyDescription =>
      'মিনিটের মধ্যে আপনার সংস্থা সেট আপ করুন এবং আজই স্মার্টভাবে ব্যবসা চালান। চলুন শুরু করি।';

  @override
  String get back => 'পিছনে';

  @override
  String get submit => 'জমা দিন';

  @override
  String get continueAction => 'চালিয়ে যান';

  @override
  String get createAction => 'তৈরি করুন';

  @override
  String get connectOrganizationTitle => 'আপনার সংগঠন সংযুক্ত করুন';

  @override
  String get connectOrganizationSubtitle =>
      'সাইন ইন করতে একটি সংগঠন নির্বাচন করুন।';

  @override
  String get selectOrganization => 'সংগঠনসমূহ';

  @override
  String get selectOrganizationHint => 'চালিয়ে যেতে একটি সংগঠনে ট্যাপ করুন';

  @override
  String get noSavedOrganizationsYet =>
      'এখনো কোনো সংগঠন নেই। একটি তৈরি করুন বা নিচের পরীক্ষামূলক ডেটা ব্যবহার করুন।';

  @override
  String get orgConnectOnceInfo =>
      'এটি অ্যাপটিকে আপনার ব্যবসায়িক অ্যাকাউন্টের সাথে যুক্ত করে। আপনাকে এটি প্রতিটি ডিভাইসে একবারই সেট করতে হবে।';

  @override
  String organizationCodeLabel(String code) {
    return 'কোড: $code';
  }

  @override
  String get tryAgain => 'আবার চেষ্টা করুন';

  @override
  String get warning => 'সতর্কতা';

  @override
  String get loading => 'লোড হচ্ছে…';

  @override
  String get comingSoon => 'শীঘ্রই আসছে';

  @override
  String get required => 'প্রয়োজনীয়';

  @override
  String get search => 'অনুসন্ধান';

  @override
  String get add => 'যোগ করুন';

  @override
  String get edit => 'সম্পাদনা করুন';

  @override
  String get remove => 'সরান';

  @override
  String get view => 'দেখুন';

  @override
  String get export => 'এক্সপোর্ট';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'আমদানি করুন';

  @override
  String get refresh => 'রিফ্রেশ করুন';

  @override
  String get select => 'নির্বাচন করুন';

  @override
  String get upload => 'আপলোড করুন';

  @override
  String get download => 'ডাউনলোড করুন';

  @override
  String get share => 'শেয়ার করুন';

  @override
  String get filter => 'ফিল্টার';

  @override
  String get sort => 'সাজান';

  @override
  String get apply => 'প্রয়োগ করুন';

  @override
  String get reset => 'পুনরায় সেট করুন';

  @override
  String get clear => 'মুছুন';

  @override
  String get all => 'সব';

  @override
  String get none => 'কোনোটিই না';

  @override
  String get total => 'মোট';

  @override
  String get subtotal => 'উপমোট';

  @override
  String get grandTotal => 'সর্বমোট';

  @override
  String get amount => 'পরিমাণ';

  @override
  String get quantity => 'পরিমাণ';

  @override
  String get rate => 'হার';

  @override
  String get discount => 'ছাড়';

  @override
  String get paid => 'পরিশোধিত';

  @override
  String get unpaid => 'অপরিশোধিত';

  @override
  String get credit => 'ধার';

  @override
  String get cash => 'নগদ';

  @override
  String get date => 'তারিখ';

  @override
  String get time => 'সময়';

  @override
  String get name => 'নাম';

  @override
  String get email => 'ইমেল';

  @override
  String get phone => 'ফোন';

  @override
  String get address => 'ঠিকানা';

  @override
  String get notes => 'নোট';

  @override
  String get description => 'বিবরণ';

  @override
  String get status => 'অবস্থা';

  @override
  String get type => 'ধরন';

  @override
  String get category => 'বিভাগ';

  @override
  String get party => 'পক্ষ';

  @override
  String get item => 'পণ্য';

  @override
  String get payment => 'পেমেন্ট';

  @override
  String get settlement => 'নিষ্পত্তি';

  @override
  String get opening => 'প্রারম্ভিক';

  @override
  String get closing => 'সমাপনী';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'ব্যয়';

  @override
  String get revenue => 'রাজস্ব';

  @override
  String get profit => 'লাভ';

  @override
  String get loss => 'ক্ষতি';

  @override
  String get sales => 'বিক্রয়';

  @override
  String get purchase => 'ক্রয়';

  @override
  String get monthJan => 'জান';

  @override
  String get monthFeb => 'ফেব';

  @override
  String get monthMar => 'মার্চ';

  @override
  String get monthApr => 'এপ্রি';

  @override
  String get monthMay => 'মে';

  @override
  String get monthJun => 'জুন';

  @override
  String get monthJul => 'জুল';

  @override
  String get monthAug => 'আগ';

  @override
  String get monthSep => 'সেপ';

  @override
  String get monthOct => 'অক্ট';

  @override
  String get monthNov => 'নভ';

  @override
  String get monthDec => 'ডিস';

  @override
  String get more => 'আরো';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get operations => 'অপারেশন';

  @override
  String get operationManagement => 'অপারেশন ব্যবস্থাপনা';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'কর্মচারী ব্যবস্থাপনা';

  @override
  String get employeeManagementSubtitle => 'কর্মী, বেতন ও উপস্থিতি';

  @override
  String get report => 'প্রতিবেদন';

  @override
  String get reportSubtitle => 'লাভ-ক্ষতি, বিবৃতি ও বিশ্লেষণ';

  @override
  String get helpAndSupport => 'সাহায্য ও সহায়তা';

  @override
  String get preferences => 'পছন্দসমূহ';

  @override
  String get dataAndBackup => 'ডেটা ও ব্যাকআপ';

  @override
  String get privacyAndPolicies => 'গোপনীয়তা ও নীতি';

  @override
  String get faq => 'সাধারণ জিজ্ঞাসা';

  @override
  String get contactSupport => 'সহায়তায় যোগাযোগ করুন';

  @override
  String get rateUs => 'আমাদের রেট করুন';

  @override
  String get rateUsSubtitle => 'BizTrack উপভোগ করছেন? Google Play-এ রিভিউ দিন';

  @override
  String get rateUsUnavailable => 'স্টোর খুলতে পারেনি। পরে আবার চেষ্টা করুন।';

  @override
  String get reportProblem => 'সমস্যা রিপোর্ট';

  @override
  String get contactUs => 'যোগাযোগ করুন';

  @override
  String get contactUsSubtitle =>
      'সহায়তা, মতামত বা অ্যাপ সম্পর্কে প্রশ্নের জন্য যোগাযোগ করুন।';

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
  String get developerLabel => 'ডেভেলপার';

  @override
  String get emailCopiedToClipboard => 'ইমেল ক্লিপবোর্ডে কপি হয়েছে';

  @override
  String get logout => 'লগ আউট';

  @override
  String get signOut => 'সাইন আউট';

  @override
  String get settings => 'সেটিংস';

  @override
  String get testData => 'পরীক্ষামূলক ডেটা';

  @override
  String get loginWithTestData => 'পরীক্ষামূলক ডেটা দিয়ে লগইন করুন';

  @override
  String get loginWithTestDataSubtitle =>
      'ডেমো হোটেল ডেটা লোড করুন এবং স্বয়ংক্রিয়ভাবে সাইন ইন করুন';

  @override
  String testDataLoginFailed(String error) {
    return 'পরীক্ষামূলক ডেটা লোড করা যায়নি: $error';
  }

  @override
  String get preparingTestData => 'ডেমো ডেটা প্রস্তুত হচ্ছে…';

  @override
  String get regionAndCurrency => 'অঞ্চল ও মুদ্রা';

  @override
  String get reportingCurrency => 'রিপোর্টিং মুদ্রা';

  @override
  String get selectCurrency => 'মুদ্রা নির্বাচন করুন';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · নমুনা $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'মুদ্রা $code ($symbol)-এ সেট করা হয়েছে';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'মুদ্রা আপডেট করা যায়নি: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return '$appName সেটআপ করুন';
  }

  @override
  String get setupSubtitle =>
      'আপনার প্রতিষ্ঠান ও হিসাব কনফিগার করুন — অফলাইন ব্যবহারের জন্য এই ডিভাইসে সংরক্ষিত।';

  @override
  String get setupOrganizationName => 'সংগঠনের নাম';

  @override
  String get setupCompanyName => 'কোম্পানির নাম';

  @override
  String get setupBusinessType => 'ব্যবসার ধরন';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => 'হোটেল';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => 'রেস্তোরাঁ';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => 'হোটেল ও রেস্তোরাঁ';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => 'খুচরা / দোকান';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'ক্যাফে / বেকারি';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'বার / পাব';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'অন্যান্য';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'ধরন: $type';
  }

  @override
  String get organizationSettings => 'প্রতিষ্ঠান';

  @override
  String get editOrganizationInfo => 'প্রতিষ্ঠানের তথ্য';

  @override
  String get editOrganizationInfoSubtitle =>
      'অ্যাপে এই ব্যবসাটি কীভাবে প্রদর্শিত হয় তা আপডেট করুন। প্রতিষ্ঠানের কোড পরিবর্তন করা যাবে না।';

  @override
  String get organizationCode => 'প্রতিষ্ঠানের কোড';

  @override
  String get organizationCodeReadOnly => 'সেটআপের পরে এই কোডটি স্থির।';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'প্রতিষ্ঠানের তথ্য সংরক্ষিত হয়েছে';

  @override
  String get organizationInfoLoadFailed => 'প্রতিষ্ঠানের তথ্য লোড করা যায়নি';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'প্রতিষ্ঠানের তথ্য সংরক্ষণ করা যায়নি: $error';
  }

  @override
  String get organizationTabGeneral => 'সাধারণ';

  @override
  String get organizationTabRegional => 'আঞ্চলিক ও অর্থবছর';

  @override
  String get organizationRegionalSubtitle =>
      'দেশ, রিপোর্টিং মুদ্রা ও অর্থবছরের তারিখ।';

  @override
  String get organizationTabAccounting => 'হিসাব';

  @override
  String get organizationAccountingSubtitle =>
      'ইনভয়েস ও পরিমাণ প্রদর্শন সেটিংস।';

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
  String get displayPrecision => 'প্রদর্শনের নির্ভুলতা';

  @override
  String get displayPrecisionRange => '০ থেকে ৫-এর মধ্যে একটি সংখ্যা দিন';

  @override
  String get enableInvoiceReturns => 'ইনভয়েস রিটার্ন চালু করুন';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'পরিশোধিত ইনভয়েস থেকে রিটার্ন তৈরি করার অনুমতি দিন।';

  @override
  String get saveChanges => 'পরিবর্তন সংরক্ষণ করুন';

  @override
  String get setupFullName => 'পুরো নাম';

  @override
  String get setupConfirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get setupBankName => 'ব্যাংকের নাম';

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
  String get setupRegionStepTitle => 'অঞ্চল ও মুদ্রা';

  @override
  String get setupOrganizationStepTitle => 'সংগঠন';

  @override
  String get setupOrganizationStepSubtitle =>
      'আপনার ব্যবসা অ্যাপে কীভাবে দেখায়';

  @override
  String get setupAdminStepTitle => 'অ্যাডমিন অ্যাকাউন্ট';

  @override
  String get setupAdminStepSubtitle => 'এই ইনস্টলেশনের প্রাথমিক ব্যবহারকারী';

  @override
  String get setupAccountingStepTitle => 'হিসাবরক্ষণ';

  @override
  String get setupAccountingStepSubtitle =>
      'ব্যাংক, হিসাবের তালিকা এবং আর্থিক বছর';

  @override
  String get setupCompleteSetup => 'সেটআপ সম্পন্ন করুন';

  @override
  String fieldRequired(String field) {
    return '$field আবশ্যক';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'একটি বৈধ ইমেল ঠিকানা দিন';

  @override
  String passwordMinLength(int min) {
    return 'পাসওয়ার্ড কমপক্ষে $min অক্ষরের হতে হবে';
  }

  @override
  String get passwordsDoNotMatch => 'পাসওয়ার্ড মেলে না';

  @override
  String get setupFixValidationErrors =>
      'চালিয়ে যেতে নিচের ত্রুটিগুলো ঠিক করুন';

  @override
  String get setupCompleteSuccess => 'সেটআপ সফলভাবে সম্পন্ন হয়েছে';

  @override
  String get setupCompleteWithPdfSuccess =>
      'সেটআপ সম্পন্ন। PDF নিরাপদ স্থানে সংরক্ষণ করুন।';

  @override
  String setupPdfFailed(String error) {
    return 'সেটআপ সম্পন্ন হয়েছে, কিন্তু PDF সংরক্ষণ করা যায়নি: $error';
  }

  @override
  String get setupFailed => 'সেটআপ সম্পন্ন করা যায়নি। আবার চেষ্টা করুন।';

  @override
  String setupFailedWithDetails(String error) {
    return 'সেটআপ ব্যর্থ: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'লোকেল ও প্রতিবেদন মুদ্রা।';

  @override
  String get country => 'দেশ';

  @override
  String get currency => 'মুদ্রা';

  @override
  String get selectCountry => 'দেশ নির্বাচন করুন';

  @override
  String get language => 'ভাষা';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get languageChangeLaterHint =>
      'আপনি পরে সেটিংস থেকে এটি পরিবর্তন করতে পারবেন';

  @override
  String languageSelectionSubtitle(String appName) {
    return '$appName কীভাবে ব্যবহার করতে চান তা নির্বাচন করুন। আপনি পরে সেটিংস থেকে এটি পরিবর্তন করতে পারবেন।';
  }

  @override
  String get searchLanguages => 'ভাষা খুঁজুন';

  @override
  String get languageSuggestedBadge => 'প্রস্তাবিত';

  @override
  String continueInLanguage(String languageName) {
    return '$languageName-এ চালিয়ে যান';
  }

  @override
  String get noLanguageMatches => 'কোনো মিল নেই';

  @override
  String noLanguageMatchesForQuery(String query) {
    return '\"$query\"-এর সাথে কোনো ভাষা মেলে না';
  }

  @override
  String get appearance => 'চেহারা';

  @override
  String get darkMode => 'ডার্ক মোড';

  @override
  String get darkModeSubtitle => 'অ্যাপ জুড়ে গাঢ় পটভূমি ব্যবহার করুন';

  @override
  String get darkModeSystemSubtitle => 'আপনার ডিভাইসের থিম অনুসরণ করে';

  @override
  String languageUpdated(String name) {
    return 'ভাষা $name-এ সেট করা হয়েছে';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'ভাষা আপডেট করা যায়নি: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return '$appName-এ স্বাগতম';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'চালিয়ে যেতে অনুগ্রহ করে $appName-এর সর্বশেষ সংস্করণ ইনস্টল করুন।';
  }

  @override
  String generatedByApp(String appName) {
    return '$appName দ্বারা তৈরি';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName কী?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName আপনাকে বিক্রয় ও ক্রয় চালান, পক্ষ (গ্রাহক ও সরবরাহকারী), মজুদ, পেমেন্ট, কর্মচারী ও দৈনিক সারাংশ পরিচালনা করতে সাহায্য করে — আপনার ফোন বা ট্যাবলেট থেকে।';
  }

  @override
  String faqIntro(String appName) {
    return '$appName সম্পর্কে সাধারণ প্রশ্নের উত্তর।';
  }

  @override
  String get chooseFromGallery => 'গ্যালারি থেকে বেছে নিন';

  @override
  String get takePhoto => 'ছবি তুলুন';

  @override
  String get photoLibrary => 'ফটো লাইব্রেরি';

  @override
  String get addPhoto => 'ছবি যোগ করুন';

  @override
  String couldNotPickImage(String error) {
    return 'ছবি বেছে নেওয়া যায়নি: $error';
  }

  @override
  String get unpaidAmount => 'অপরিশোধিত পরিমাণ';

  @override
  String get unpaidBalance => 'অপরিশোধিত';

  @override
  String unpaidColonAmount(String amount) {
    return 'অপরিশোধিত: $amount';
  }

  @override
  String get previousUnpaid => 'অপরিশোধিত';

  @override
  String get partyUnpaid => 'অপরিশোধিত';

  @override
  String get loadingUnpaid => 'অপরিশোধিত…';

  @override
  String get totalUnpaid => 'অপরিশোধিত';

  @override
  String get unpaidAmountNotYetCollected =>
      'অপরিশোধিত পরিমাণ এখনও সংগ্রহ করা হয়নি।';

  @override
  String get partyUnpaidTabHint =>
      'কর্মচারী খুলুন, একজন ব্যক্তি নির্বাচন করুন, তারপর তাদের প্রোফাইলে পার্টি অপরিশোধিত ট্যাপ করুন। এই অনুসন্ধানের জন্য সার্ভারে কর্মচারী আইডি প্রয়োজন।';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'পার্টি নিষ্পত্তি অপরিশোধিত মোট ব্যবহার করে।';

  @override
  String get selectPartyWithUnpaidFirst =>
      'প্রথমে নিষ্পত্তির পরিমাণ লিখুন (বা অপরিশোধিত সহ একটি পার্টি নির্বাচন করুন)।';

  @override
  String get workspace => 'কর্মক্ষেত্র';

  @override
  String get change => 'পরিবর্তন করুন';

  @override
  String get addMoreOrganization => 'আরো যোগ করুন +';

  @override
  String get connectAnotherOrganization => 'অন্য সংগঠন সংযুক্ত করুন';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'এখনো কোনো সংগঠন সংরক্ষিত নেই। সংযোগ করতে আরো যোগ করুন + ব্যবহার করুন।';

  @override
  String get registerNewOrganizationTitleSignedIn =>
      'নতুন সংগঠন নিবন্ধন করবেন?';

  @override
  String get registerNewOrganizationTitle => 'নতুন সংগঠন নিবন্ধন করবেন?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'আপনাকে সাইন আউট করা হবে এবং সেটআপ উইজার্ড শুরু থেকে শুরু হবে।\n\nআপনি ইতিমধ্যে সংরক্ষণ করা সংগঠনগুলি সেটআপের পরেও তালিকায় থাকবে।';

  @override
  String get registerNewOrganizationMessageLogin =>
      'সেটআপ উইজার্ড শুরু হবে। এটি তৈরি করতে সেটআপ সম্পন্ন করুন; আপনার সংরক্ষিত সংগঠনগুলি তালিকায় থাকবে।';

  @override
  String get startSetup => 'সেটআপ শুরু করুন';

  @override
  String get enterOrganizationCode => 'আপনার সংগঠন কোড দিন';

  @override
  String get organizationNotFoundCheckCode =>
      'সংগঠন পাওয়া যায়নি। কোড যাচাই করে আবার চেষ্টা করুন।';

  @override
  String get organizationNotFound => 'সংগঠন পাওয়া যায়নি';

  @override
  String get couldNotVerifyOrganization => 'সংগঠন যাচাই করা সম্ভব হয়নি';

  @override
  String noLocalDataCompleteSetup(String name) {
    return '$name-এর জন্য কোনো স্থানীয় ডেটা নেই। প্রথমে এই সংগঠনের সেটআপ সম্পন্ন করুন।';
  }

  @override
  String get welcomeBack => 'আবার স্বাগতম';

  @override
  String get signInToContinue => 'চালিয়ে যেতে সাইন ইন করুন';

  @override
  String get enterEmail => 'ইমেল দিন';

  @override
  String get pleaseEnterEmail => 'আপনার ইমেল দিন';

  @override
  String get pleaseEnterValidEmail => 'একটি বৈধ ইমেল দিন';

  @override
  String get enterEmailLocalPartOnly => 'শুধু @ এর আগের অংশ দিন';

  @override
  String get pleaseEnterPassword => 'আপনার পাসওয়ার্ড দিন';

  @override
  String get logIn => 'লগ ইন';

  @override
  String get searchCountry => 'দেশ খুঁজুন';

  @override
  String get searchCodeOrSymbol => 'কোড বা প্রতীক খুঁজুন';

  @override
  String get saveLoginDetailsTitle => 'লগইন বিবরণ সংরক্ষণ করবেন?';

  @override
  String get saveLoginDetailsMessage =>
      'আপনি এই সংগঠনের সেটআপ সম্পন্ন করতে যাচ্ছেন।\n\nআপনি কি নিরাপদে সংগঠন কোড, নাম, লগইন ইমেল এবং পাসওয়ার্ড সহ একটি PDF ডাউনলোড করতে চান? এটি নিরাপদ স্থানে রাখুন।';

  @override
  String get downloadPdfAndContinue => 'PDF ডাউনলোড করুন এবং চালিয়ে যান';

  @override
  String get continueWithoutPdf => 'PDF ছাড়া চালিয়ে যান';

  @override
  String get legalDisplayNameHint => 'আইনি / প্রদর্শন নাম';

  @override
  String get chartOfAccounts => 'হিসাবের তালিকা';

  @override
  String get fiscalYearStart => 'আর্থিক বছর শুরু';

  @override
  String get fiscalYearEnd => 'আর্থিক বছর শেষ';

  @override
  String get removeTestDataTitle => 'পরীক্ষামূলক ডেটা সরাবেন?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'সমস্ত ডেমো বিক্রয়, ক্রয়, যোগাযোগ, পক্ষ, মজুদ আইটেম, কর্মচারী এবং অতিরিক্ত ডেমো সংগঠনগুলি সরানো হবে।\n\nআপনি একটি ডেমো সংগঠনে আছেন — এরপর স্বয়ংক্রিয়ভাবে আপনার প্রথম সংগঠনে ফিরিয়ে দেওয়া হবে।';

  @override
  String get removeTestDataMessageNormal =>
      'সমস্ত ডেমো বিক্রয়, ক্রয়, যোগাযোগ, পক্ষ, মজুদ আইটেম, কর্মচারী এবং ৩টি অতিরিক্ত ডেমো সংগঠন সরানো হবে।';

  @override
  String get removeTestDataWarning =>
      'আবার পরীক্ষামূলক ডেটা লোড না করলে এটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get removeTestData => 'পরীক্ষামূলক ডেটা সরান';

  @override
  String get keepTestData => 'পরীক্ষামূলক ডেটা রাখুন';

  @override
  String get demoDataRemoved => 'ডেমো ডেটা সরানো হয়েছে';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'পরীক্ষামূলক ডেটা সরানো হয়েছে। $name-এ স্থানান্তরিত।';
  }

  @override
  String get testDataRemoved => 'পরীক্ষামূলক ডেটা সরানো হয়েছে';

  @override
  String couldNotRemoveTestData(String error) {
    return 'পরীক্ষামূলক ডেটা সরানো যায়নি: $error';
  }

  @override
  String get loadTestDataTitle => 'পরীক্ষামূলক ডেটা লোড করবেন?';

  @override
  String get loadTestDataMessage =>
      'এটি ডেমো যোগাযোগ, মজুদ আইটেম, বিক্রয়, ক্রয়, পেমেন্ট, স্টক, কর্মচারী এবং গত ১৫ দিনের উপস্থিতি যোগ করবে।';

  @override
  String get loadTestData => 'পরীক্ষামূলক ডেটা লোড করুন';

  @override
  String get testDataLoaded => 'পরীক্ষামূলক ডেটা লোড হয়েছে';

  @override
  String couldNotLoadTestData(String error) {
    return 'পরীক্ষামূলক ডেটা লোড করা যায়নি: $error';
  }

  @override
  String get demoTestData => 'ডেমো পরীক্ষামূলক ডেটা';

  @override
  String get importTestDataSubtitle =>
      'সমস্ত ফিচারের জন্য পরীক্ষামূলক ডেটা আমদানি করুন';

  @override
  String get hideTestDataTitle => 'এই সংগঠনের জন্য পরীক্ষামূলক ডেটা লুকাবেন?';

  @override
  String get hideTestDataMessage =>
      'যদি চালিয়ে যান, এই সংগঠনের সর্বত্র পরীক্ষামূলক ডেটা বিভাগ লুকানো হবে।';

  @override
  String get hideTestDataWarning =>
      'ইতিমধ্যে লোড করা ডেমো ডেটা ডাটাবেসে থাকবে যতক্ষণ না আপনি সেটিংস থেকে এটি সরান।';

  @override
  String get okHideTestData => 'ঠিক আছে, পরীক্ষামূলক ডেটা লুকান';

  @override
  String get testDataHiddenForOrg =>
      'এই সংগঠনের জন্য পরীক্ষামূলক ডেটা লুকানো হয়েছে';

  @override
  String get hideTestDataTooltip => 'এই সংগঠনের জন্য পরীক্ষামূলক ডেটা লুকান';

  @override
  String get partyRolesTitle => 'পক্ষের ভূমিকা';

  @override
  String get partyRolesMoreSubtitle => 'গ্রাহক, সরবরাহকারী, উভয় এবং আরো';

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
  String get partyRoleCustomer => 'গ্রাহক';

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
  String get searchRoles => 'ভূমিকা খুঁজুন';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি ভূমিকা',
      one: '১টি ভূমিকা',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'এখনো কোনো ভূমিকা নেই';

  @override
  String get noRolesYetHint =>
      'যোগাযোগের জন্য গ্রাহক, সরবরাহকারী, উভয়, বা কাস্টম ভূমিকা যোগ করুন।';

  @override
  String get addRole => 'ভূমিকা যোগ করুন';

  @override
  String get deleteRoleTitle => 'ভূমিকা মুছুন';

  @override
  String deleteRoleConfirm(String name) {
    return '\"$name\" মুছবেন? এটি পূর্বাবস্থায় ফেরানো যাবে না।';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCountটি পক্ষ',
      one: '১টি পক্ষ',
    );
    return '\"$name\" $_temp0 ব্যবহার করছে। এই পক্ষগুলি অন্য ভূমিকায় স্থানান্তর করুন, অথবা জোর করে মুছুন।';
  }

  @override
  String get transferParties => 'পক্ষ স্থানান্তর করুন';

  @override
  String get hardDeleteLoseParties => 'জোর করে মুছুন (পক্ষ হারাবেন)';

  @override
  String get hardDeleteRoleTitle => 'জোর করে মুছবেন?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCountটি পক্ষ',
      one: '১টি পক্ষ',
    );
    return 'এটি \"$name\" এবং $_temp0 স্থায়ীভাবে মুছে দেবে। পক্ষের ডেটা পুনরুদ্ধার করা যাবে না।\n\nচালান বা পেমেন্টের সাথে লিঙ্কযুক্ত পক্ষ মুছে নাও যেতে পারে।';
  }

  @override
  String get deleteRoleAndParties => 'ভূমিকা এবং পক্ষ মুছুন';

  @override
  String get addAnotherRoleBeforeDelete =>
      'এটি মুছার আগে আরেকটি ভূমিকা যোগ করুন।';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCountটি পক্ষ',
      one: '১টি পক্ষ',
    );
    return '\"$fromRole\" থেকে $_temp0 সরান:';
  }

  @override
  String get transferAndDeleteRole => 'স্থানান্তর করুন এবং ভূমিকা মুছুন';

  @override
  String get builtInRole => 'অন্তর্নির্মিত';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি পক্ষ',
      one: '১টি পক্ষ',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'এখনো কোনো পক্ষ নেই';

  @override
  String get newRole => 'নতুন ভূমিকা';

  @override
  String get editRole => 'ভূমিকা সম্পাদনা করুন';

  @override
  String get defaultRolesCannotEdit =>
      'ডিফল্ট ভূমিকা পুনর্নামকরণ বা মুছা যাবে না।';

  @override
  String get roleNameLabel => 'ভূমিকার নাম *';

  @override
  String get roleNameHint => 'যেমন: গ্রাহক';

  @override
  String get roleDescriptionLabel => 'বিবরণ';

  @override
  String get roleDescriptionHint => 'আপনার দলের জন্য সংক্ষিপ্ত নোট';

  @override
  String get roleSortOrderLabel => 'সাজানোর ক্রম';

  @override
  String get roleSortOrderHint => 'কম সংখ্যা তালিকায় আগে দেখায়';

  @override
  String get roleCreated => 'ভূমিকা তৈরি হয়েছে';

  @override
  String get roleUpdated => 'ভূমিকা আপডেট হয়েছে';

  @override
  String get roleDeleted => 'ভূমিকা মুছা হয়েছে';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি পক্ষ',
      one: '১টি পক্ষ',
    );
    return 'ভূমিকা মুছা হয়েছে। $_temp0 $targetRole-এ সরানো হয়েছে।';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি পক্ষ',
      one: '১টি পক্ষ',
    );
    return 'ভূমিকা এবং $_temp0 মুছা হয়েছে।';
  }

  @override
  String get privacyPolicyTitle => 'গোপনীয়তা নীতি';

  @override
  String get termsAndConditions => 'শর্তাবলী';

  @override
  String get logoutConfirmTitle => 'লগআউট';

  @override
  String get logoutConfirmMessage =>
      'আপনি কি আপনার অ্যাকাউন্ট থেকে লগআউট করতে চান?';

  @override
  String get faqTapToExpand => 'প্রসারিত করতে একটি প্রশ্নে ট্যাপ করুন।';

  @override
  String get faqSectionGettingStarted => 'শুরু করুন';

  @override
  String get faqSectionLogin => 'লগইন';

  @override
  String get faqSectionNavigation => 'নেভিগেশন';

  @override
  String get faqSectionInvoices => 'চালানসমূহ';

  @override
  String get faqSectionPayments => 'পেমেন্টসমূহ';

  @override
  String get faqSectionItemsStock => 'আইটেম ও স্টক';

  @override
  String get faqSectionProfileEmployees => 'প্রোফাইল ও কর্মচারী';

  @override
  String get faqSectionDashboardReports => 'ড্যাশবোর্ড ও রিপোর্ট';

  @override
  String get faqSectionSyncTroubleshooting => 'সিঙ্ক ও সমস্যা সমাধান';

  @override
  String get faqNeedInternetQuestion => 'আমার কি ইন্টারনেট দরকার?';

  @override
  String get faqNeedInternetAnswer =>
      'প্রথমবার স্থানীয় সেটআপের পরে, আপনি ইন্টারনেট ছাড়াই চালান, আইটেম এবং পেমেন্ট রেকর্ড করতে পারবেন। ডেটা আপনার ডিভাইসে থাকে।';

  @override
  String get faqFirstInstallQuestion => 'প্রথম ইনস্টলে কী হয়?';

  @override
  String get faqFirstInstallAnswer =>
      'আপনি একটি সংক্ষিপ্ত ওয়াকথ্রু দেখতে পাবেন, তারপর স্থানীয় সেটআপ (সংগঠন, কোম্পানি, ইমেল ও পাসওয়ার্ড, মুদ্রা, আর্থিক বছর)। এরপর সাইন ইন করুন।';

  @override
  String get faqSignInCredentialsQuestion => 'সাইন ইন করতে কী ব্যবহার করব?';

  @override
  String get faqSignInCredentialsAnswer =>
      'সেটআপের আপনার ইমেল ঠিকানা এবং পাসওয়ার্ড।';

  @override
  String get faqLoggedOutQuestion => 'কেন আমি লগআউট হয়ে গেলাম?';

  @override
  String get faqLoggedOutAnswer =>
      'আপনি লগআউট বেছে নিয়েছেন, অ্যাপ ডেটা মুছেছেন, বা সেশনের মেয়াদ শেষ হয়েছে।';

  @override
  String get faqBottomTabsQuestion => 'নিচের ট্যাবগুলো কী করে?';

  @override
  String get faqBottomTabsAnswer =>
      'হোম — ড্যাশবোর্ড।\nবিক্রয় — বিক্রয় চালান।\nখরচ — ক্রয় চালান।\nমাঝের বোতাম — পক্ষ।\nআরো — প্রোফাইল, রিপোর্ট, লগআউট।';

  @override
  String get faqCreateInvoiceQuestion => 'চালান কীভাবে তৈরি করব?';

  @override
  String get faqCreateInvoiceAnswer =>
      'বিক্রয় বা খরচ খুলুন, তারিখ নির্বাচন করুন, + ট্যাপ করুন, আইটেম ও পরিমাণ যোগ করুন, তারপর সংরক্ষণ করুন।';

  @override
  String get faqInvoiceDetailsQuestion => 'চালানের বিবরণ কীভাবে দেখব?';

  @override
  String get faqInvoiceDetailsAnswer => 'তালিকায় যেকোনো চালানে ট্যাপ করুন।';

  @override
  String get faqZeroRateQuestion => 'বিবরণে রেট বা পরিমাণ শূন্য দেখাচ্ছে';

  @override
  String get faqZeroRateAnswer =>
      'পুরানো সেভে লাইন ডেটা অনুপস্থিত ছিল। অ্যাপ আপডেট করুন।';

  @override
  String get faqPartialPaymentQuestion => 'আংশিক পেমেন্ট কীভাবে রেকর্ড করব?';

  @override
  String get faqPartialPaymentAnswer =>
      'চালান খুলুন → লেনদেনের বিবরণ → পেমেন্ট করুন।';

  @override
  String get faqMultiplePaymentQuestion => 'একাধিক পেমেন্ট কীভাবে কাজ করে?';

  @override
  String get faqMultiplePaymentAnswer =>
      'একাধিক পেমেন্ট চালু করুন এবং নগদ, কার্ড, QR-এ মোট ভাগ করুন।';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'বিভাজন থেকে শুধুমাত্র একটি পেমেন্ট সংরক্ষিত হয়েছে';

  @override
  String get faqSplitPaymentSavedAnswer => 'সর্বশেষ অ্যাপ সংস্করণে আপডেট করুন।';

  @override
  String get faqAddItemQuestion => 'আইটেম কীভাবে যোগ করব?';

  @override
  String get faqAddItemAnswer =>
      'বিক্রয় প্রবাহ থেকে আইটেম যোগ করুন। নাম, রেট, একক দিন, তারপর আইটেম তৈরি করুন।';

  @override
  String get faqCustomUnitQuestion => 'কাস্টম একক কীভাবে যোগ করব?';

  @override
  String get faqCustomUnitAnswer =>
      'আইটেম ফর্মে, একক ট্যাপ করুন → নতুন একক তৈরি করুন।';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'আমি নাম পরিবর্তন করেছি কিন্তু প্রোফাইলে পুরানো নাম দেখাচ্ছে';

  @override
  String get faqProfileNameAnswer =>
      'আপনার কর্মচারী রেকর্ড সম্পাদনা করুন এবং সংরক্ষণ করুন।';

  @override
  String get faqRevenueDetailsQuestion => 'রাজস্ব বিবরণ কী?';

  @override
  String get faqRevenueDetailsAnswer =>
      'দৈনিক ট্রেন্ড চার্ট, নিট মুনাফা এবং দিন-ভিত্তিক বিক্রয় বনাম ক্রয় বিভাজন সহ একটি মাসিক ভিউ।';

  @override
  String get faqOtherReportsQuestion => 'অন্যান্য রিপোর্ট কোথায়?';

  @override
  String get faqOtherReportsAnswer => 'আরো খুলুন এবং রিপোর্টের অধীনে দেখুন।';

  @override
  String get faqWhenSyncQuestion => 'কখন সিঙ্ক করা উচিত?';

  @override
  String get faqWhenSyncAnswer =>
      'শুধুমাত্র যখন আপনার প্রশাসক বলেন এবং স্থিতিশীল সংযোগ আছে।';

  @override
  String get faqFabPositionQuestion =>
      'বিক্রয়/খরচে + বোতাম অনেক উঁচুতে দেখাচ্ছে';

  @override
  String get faqFabPositionAnswer => 'এটি নিচের নেভিগেশন বারের উপরে থাকে।';

  @override
  String get faqHowLogoutQuestion => 'কীভাবে লগআউট করব?';

  @override
  String get faqHowLogoutAnswer => 'আরো → সেটিংস তালিকার নিচে লগআউট।';

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
  String get statisticsQuickOperations => 'Quick Operations';

  @override
  String get statisticsQuickOperationsSeeAll => 'সব দেখুন';

  @override
  String get statisticsQuickOperationInvoice => 'ইনভয়েস';

  @override
  String get statisticsQuickOperationReports => 'রিপোর্ট';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'নগদ প্রবাহ';

  @override
  String get statisticsCashflowLast7Days => 'নগদ প্রবাহ (গত ৭ দিন)';

  @override
  String get statisticsCashflowLast12Months => 'নগদ প্রবাহ (গত ১২ মাস)';

  @override
  String get statisticsDaily => 'Daily';

  @override
  String get statisticsMonthly => 'Monthly';

  @override
  String get statisticsOverall => 'Overall';

  @override
  String get statisticsLast7Days => 'Last 7 Days';

  @override
  String get statisticsLast12Months => 'Last 12 Months';

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
  String get profitAndLoss => 'লাভ ও ক্ষতি';

  @override
  String get statementReport => 'বিবৃতি';

  @override
  String get analytics => 'বিশ্লেষণ';

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
  String get partyPickerSubtitle => 'এই বিক্রয় কার জন্য?';

  @override
  String partyPickerSearchHint(String role) {
    return '$role খুঁজুন...';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'নতুন $role যোগ করুন';
  }

  @override
  String get partyPickerSettled => 'নিষ্পত্তি হয়েছে';

  @override
  String get partyPickerSelectedLabel => 'নির্বাচিত';

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
  String get itemSearchHint => 'Search items';

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
  String get itemSelectCategoryRequired =>
      'অনুগ্রহ করে একটি বিভাগ নির্বাচন করুন';

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
      'Items are linked. You can force delete to unlink them.';

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
  String get closeSummaryTitle => 'ক্লোজিং সারাংশ';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint =>
      'ডেটা লোড করতে তারিখ নির্বাচন করে রিফ্রেশ ট্যাপ করুন';

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
  String get closeTotalSales => 'মোট বিক্রয়';

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
  String get closePayCashGetQr => 'নগদ দিন → QR নিন';

  @override
  String get closePayQrGetCash => 'QR দিন → নগদ নিন';

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
  String get closeExportData => 'ডেটা এক্সপোর্ট';

  @override
  String get closeExportComingSoon => 'এক্সপোর্ট ফিচার এখানে যোগ করা হবে';

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
  String get googleDriveBackupSectionTitle => 'ব্যাকআপ ও সিঙ্ক';

  @override
  String get googleDriveBackupTitle => 'Google Drive ব্যাকআপ';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Google Drive-এ আপনার সংস্থার ডেটা নিরাপদে ব্যাকআপ করতে সাইন ইন করুন।';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return '$email হিসেবে সাইন ইন';
  }

  @override
  String get googleDriveSignIn => 'Google দিয়ে সাইন ইন';

  @override
  String get googleDriveSignOut => 'সাইন আউট';

  @override
  String get googleDriveBackupNow => 'এখনই ব্যাকআপ';

  @override
  String get googleDriveSignInSuccess => 'Google Drive-এ সাইন ইন হয়েছে';

  @override
  String get googleDriveSignOutSuccess => 'Google Drive থেকে সাইন আউট হয়েছে';

  @override
  String get googleDriveSignInCancelled => 'Google সাইন-ইন বাতিল হয়েছে';

  @override
  String get googleDriveBackupStarting => 'ব্যাকআপ প্রস্তুত হচ্ছে…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'ব্যাকআপ আপলোড হয়েছে ($tableCountটি টেবিল, $recordCountটি রেকর্ড)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'ব্যাকআপের জন্য অ্যাপ সম্পূর্ণভাবে পুনরায় চালু করতে হবে। অ্যাপ বন্ধ করে আবার চালু করে চেষ্টা করুন।';

  @override
  String googleDriveBackupFailed(String error) {
    return 'ব্যাকআপ ব্যর্থ: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'সর্বশেষ ব্যাকআপ: $date';
  }

  @override
  String get backupSyncPageTitle => 'ব্যাকআপ ও সিঙ্ক';

  @override
  String get backupSyncGoogleAccount => 'Google অ্যাকাউন্ট';

  @override
  String get backupSyncSignedInAs => 'সাইন ইন করা হয়েছে';

  @override
  String get backupSyncSignInHint =>
      'আপনার সংস্থার ডেটা ব্যাকআপ করতে Google দিয়ে সাইন ইন করুন।';

  @override
  String get backupSyncLastSyncTitle => 'সর্বশেষ সিঙ্ক';

  @override
  String get backupSyncLastSyncDate => 'তারিখ ও সময়';

  @override
  String get backupSyncNeverSynced => 'এখনও কোনো ব্যাকআপ আপলোড হয়নি।';

  @override
  String get backupSyncOrganization => 'সংস্থা';

  @override
  String get backupSyncTables => 'ব্যাকআপ করা টেবিল';

  @override
  String get backupSyncRecords => 'ব্যাকআপ করা রেকর্ড';

  @override
  String get backupSyncStatus => 'অবস্থা';

  @override
  String get backupSyncStatusSuccess => 'সম্পন্ন';

  @override
  String get backupSyncActiveOrganization => 'বর্তমান সংস্থা';

  @override
  String get backupSyncActiveOrganizationHint =>
      'ব্যাকআপ আপনি এখন যে সংস্থা ব্যবহার করছেন তার ডেটা আপলোড করে।';

  @override
  String get backupSyncUnknownOrganization => 'বর্তমান সংস্থা';

  @override
  String get backupSyncInProgress => 'সিঙ্ক চলছে';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'ধাপ: $step';
  }

  @override
  String get backupSyncStepExport => 'স্থানীয় ডেটা রপ্তানি হচ্ছে';

  @override
  String backupSyncStepUploadTable(String table) {
    return '$table আপলোড হচ্ছে';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return '$file আপলোড হচ্ছে';
  }

  @override
  String backupSyncLastError(String error) {
    return 'সর্বশেষ ত্রুটি: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'এই ডিভাইসে Google Drive থেকে সাইন আউট করবেন?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Google Drive-এ ব্যাকআপ করুন';

  @override
  String get moreBackupSyncTileSignedInNoSync => 'সাইন ইন · এখনও ব্যাকআপ নেই';

  @override
  String get backupSyncConnected => 'সংযুক্ত';

  @override
  String get backupSyncCompletedHint =>
      'আপনার ডেটা Google Drive-এ নিরাপদে ব্যাকআপ করা হয়েছে।';

  @override
  String get backupSyncPhaseExport => 'রপ্তানি';

  @override
  String get backupSyncPhaseUpload => 'আপলোড';

  @override
  String get backupAutoSettingsTitle => 'Google Drive সেটিংস';

  @override
  String get backupAutoBackupTitle => 'স্বয়ংক্রিয় ব্যাকআপ';

  @override
  String get backupAutoBackupHint =>
      'সময় হলে অ্যাপ শুরুতে স্বয়ংক্রিয়ভাবে ব্যাকআপ নিন';

  @override
  String get backupWifiOnlyTitle => 'শুধু Wi‑Fi-তে ব্যাকআপ';

  @override
  String get backupWifiOnlyHint =>
      'স্বয়ংক্রিয় ব্যাকআপ Wi‑Fi-এর জন্য অপেক্ষা করে';

  @override
  String get backupWifiOnlyContinue => 'মোবাইল ডেটা ব্যবহার করুন';

  @override
  String get backupAutoFrequencyTitle => 'ব্যাকআপ ফ্রিকোয়েন্সি';

  @override
  String get backupAutoFrequencyOff => 'বন্ধ';

  @override
  String get backupAutoFrequencyDaily => 'দৈনিক';

  @override
  String get backupAutoFrequencyWeekly => 'সাপ্তাহিক';

  @override
  String get backupAutoFrequencyMonthly => 'মাসিক';

  @override
  String get backupAutoSyncDirectionTitle => 'স্বয়ংক্রিয় সিঙ্ক';

  @override
  String get backupAutoDirectionUpload => 'ক্লাউডে আপলোড';

  @override
  String get backupAutoDirectionDownload => 'ক্লাউড থেকে ডাউনলোড';

  @override
  String get backupAutoDirectionBoth => 'আপলোড ও ডাউনলোড';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'সর্বশেষ স্বয়ংক্রিয় ব্যাকআপ: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'সর্বশেষ স্বয়ংক্রিয় পুনরুদ্ধার: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'সর্বশেষ স্বয়ংক্রিয় সিঙ্ক ব্যর্থ: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'সর্বশেষ স্বয়ংক্রিয় সিঙ্ক এড়িয়ে গেছে: $detail';
  }

  @override
  String get restoreAction => 'পুনরুদ্ধার';

  @override
  String get restoreFromGoogleDrive => 'Google Drive থেকে পুনরুদ্ধার';

  @override
  String get restoreFromGoogleDriveHint =>
      'সাইন ইন করে একটি ব্যাকআপ বেছে নিন এবং এই ডিভাইসে আপনার সংস্থা পুনরুদ্ধার করুন।';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '\"$name\" পুনরুদ্ধার করবেন? এটি সেই সংস্থার স্থানীয় ডেটা প্রতিস্থাপন করবে।';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name পুনরুদ্ধার হয়েছে। এখন সাইন ইন করতে পারেন।';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'পুনরুদ্ধার ব্যর্থ: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'আপনার Google Drive-এ কোনো ব্যাকআপ পাওয়া যায়নি।';

  @override
  String get restoreFromGoogleDriveStarting => 'পুনরুদ্ধার শুরু হচ্ছে…';

  @override
  String get restoreStepDownload => 'ব্যাকআপ ডাউনলোড হচ্ছে';

  @override
  String get restoreStepCreateDatabase => 'ডাটাবেস তৈরি হচ্ছে';

  @override
  String get restoreStepImport => 'ডেটা আমদানি হচ্ছে';

  @override
  String get restoreStepFinalize => 'পুনরুদ্ধার সমাপ্ত হচ্ছে';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'সর্বশেষ সিঙ্ক: $date';
  }

  @override
  String get security => 'নিরাপত্তা';

  @override
  String get appLockTitle => 'অ্যাপ লক';

  @override
  String get appLockSubtitle =>
      'অ্যাপ পুনরায় খোলার সময় PIN বা বায়োমেট্রিক্স প্রয়োজন';

  @override
  String get appPin => 'অ্যাপ PIN';

  @override
  String appPinSubtitle(int length) {
    return '$length-অঙ্কের PIN দিয়ে দ্রুত আনলক';
  }

  @override
  String get useBiometricUnlock => 'Face ID / বায়োমেট্রিক্স ব্যবহার করুন';

  @override
  String get useBiometricUnlockSubtitle =>
      'PIN সেট করার পর ফিঙ্গারপ্রিন্ট বা Face ID দিয়ে আনলক করুন';

  @override
  String get changeAppPin => 'PIN পরিবর্তন করুন';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'PIN সেট করুন';

  @override
  String get confirmAppPin => 'PIN নিশ্চিত করুন';

  @override
  String get enterAppPin => 'আপনার PIN দিন';

  @override
  String get enterPasscode => 'পাসকোড দিন';

  @override
  String tapDigitsToUnlock(int length) {
    return 'আনলক করতে যেকোনো $lengthটি অঙ্ক ট্যাপ করুন।';
  }

  @override
  String createPasscodeHint(int length) {
    return 'এই সংস্থার জন্য $length-অঙ্কের পাসকোড বেছে নিন';
  }

  @override
  String get confirmPasscodeHint => 'নিশ্চিত করতে পাসকোড আবার দিন';

  @override
  String createAppPinHint(int length) {
    return 'এই সংস্থার জন্য $length-অঙ্কের PIN বেছে নিন';
  }

  @override
  String get confirmAppPinHint => 'নিশ্চিত করতে PIN আবার দিন';

  @override
  String get appPinMismatch => 'PIN মিলছে না। আবার চেষ্টা করুন।';

  @override
  String get appPinIncorrect => 'ভুল PIN। আবার চেষ্টা করুন।';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'ভুল PIN। আপনার $remainingটি চেষ্টা বাকি আছে।';
  }

  @override
  String get appPinLockoutMessage =>
      'অনেকবার ভুল PIN দেওয়া হয়েছে। PIN রিসেট করতে আপনার ইমেল ও পাসওয়ার্ড দিয়ে সাইন ইন করুন।';

  @override
  String get appPinSetSuccess => 'এই সংস্থার জন্য PIN সংরক্ষিত হয়েছে';

  @override
  String get appPinRemoved => 'অ্যাপ PIN সরানো হয়েছে';

  @override
  String get appLockSettingsSaved => 'অ্যাপ লক সেটিংস সংরক্ষিত হয়েছে';

  @override
  String get biometricUnlockReason => 'BizTrack আনলক করুন';

  @override
  String get biometricNotAvailable => 'এই ডিভাইসে বায়োমেট্রিক্স উপলব্ধ নয়';

  @override
  String get biometricRequiresPin =>
      'বায়োমেট্রিক্স চালু করার আগে অ্যাপ PIN সেট করুন';

  @override
  String get disableAppPinTitle => 'অ্যাপ PIN সরাবেন?';

  @override
  String get disableAppPinMessage =>
      'এই সংস্থার জন্য Face ID / বায়োমেট্রিক আনলকও বন্ধ হয়ে যাবে।';

  @override
  String get verifyPinToRemoveTitle => 'আপনার PIN দিন';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'অ্যাপ লক সরাতে আপনার $length-অঙ্কের PIN নিশ্চিত করুন';
  }

  @override
  String get unlockApp => 'অ্যাপ আনলক করুন';

  @override
  String get usePinInstead => 'পরিবর্তে PIN ব্যবহার করুন';

  @override
  String get useBiometricInstead => 'বায়োমেট্রিক্স ব্যবহার করুন';

  @override
  String get signInWithFaceId => 'Face ID দিয়ে সাইন ইন';

  @override
  String get signInWithFingerprint => 'ফিঙ্গারপ্রিন্ট দিয়ে সাইন ইন';

  @override
  String get signInWithBiometric => 'বায়োমেট্রিক্স দিয়ে সাইন ইন';

  @override
  String get signInWithPin => 'PIN দিয়ে সাইন ইন';

  @override
  String get setUpQuickUnlock => 'PIN দ্রুত সাইন-ইন সেট করুন';

  @override
  String get setUpFaceIdOrPin => 'Face ID বা PIN সেট করুন';

  @override
  String get setUpFingerprintOrPin => 'ফিঙ্গারপ্রিন্ট বা PIN সেট করুন';

  @override
  String get setUpQuickUnlockSubtitle =>
      'এই সংস্থার জন্য ডিভাইস বায়োমেট্রিক্স বা PIN ব্যবহার করুন';

  @override
  String quickUnlockAsUser(String email) {
    return '$email হিসেবে দ্রুত সাইন-ইন';
  }

  @override
  String get orContinueWithPassword => 'অথবা পাসওয়ার্ড দিয়ে সাইন ইন করুন';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'দ্রুত সাইন-ইন চালু করবেন?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'এই সংস্থার জন্য পরের বার দ্রুত সাইন-ইনের জন্য Face ID, ফিঙ্গারপ্রিন্ট বা PIN সেট করুন। পরে সেটিংস থেকেও পরিবর্তন করতে পারবেন।';

  @override
  String get notNow => 'এখন নয়';

  @override
  String get setUpNow => 'এখনই সেট করুন';

  @override
  String get enableFaceIdTitle => 'Face ID চালু করবেন?';

  @override
  String get enableFingerprintTitle => 'ফিঙ্গারপ্রিন্ট চালু করবেন?';

  @override
  String get enableBiometricTitle => 'বায়োমেট্রিক্স চালু করবেন?';

  @override
  String get enableBiometricAfterPinMessage =>
      'দ্রুত সাইন-ইনের জন্য PIN-এর সাথে ডিভাইস বায়োমেট্রিক্স ব্যবহার করুন।';

  @override
  String get useFaceIdUnlock => 'Face ID ব্যবহার করুন';

  @override
  String get useFingerprintUnlock => 'ফিঙ্গারপ্রিন্ট ব্যবহার করুন';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get reportPeriodYear => 'বছর';

  @override
  String get reportPeriodMonth => 'মাস';

  @override
  String get reportPeriodRange => 'পরিসর';

  @override
  String get reportPeriodDay => 'দিন';

  @override
  String get reportPeriodFrom => 'থেকে';

  @override
  String get reportPeriodTo => 'পর্যন্ত';

  @override
  String get reportPeriod => 'সময়কাল';

  @override
  String get reportAllPurchases => 'সব ক্রয়';

  @override
  String get reportBeforeTax => 'করের আগে';

  @override
  String get reportRevenueRetained => 'রাজস্ব অবশিষ্ট';

  @override
  String get reportHideDetails => 'বিবরণ লুকান';

  @override
  String get reportShowDetails => 'বিবরণ দেখান';

  @override
  String get reportSalesRevenue => 'বিক্রয় রাজস্ব';

  @override
  String get reportDiscountsGiven => 'প্রদত্ত ছাড়';

  @override
  String get reportNetRevenue => 'নিট রাজস্ব';

  @override
  String get reportOperatingExpenses => 'পরিচালন খরচ';

  @override
  String get reportTotalExpenses => 'মোট খরচ';

  @override
  String get reportGrossProfit => 'মোট লাভ';

  @override
  String get reportGrossProfitChart => 'মোট লাভ';

  @override
  String get reportOperatingPlDisclaimer =>
      'কর, অবচয় ও বেতন দায় এখনো অন্তর্ভুক্ত নয় — পরিচালন স্তরের P&L অনুমান।';

  @override
  String get reportContraLabel => 'কনট্রা';

  @override
  String get reportNoDataForPeriod => 'নির্বাচিত সময়কালে কোনো ডেটা নেই';

  @override
  String get reportRevenueVsExpenses => 'রাজস্ব বনাম খরচ';

  @override
  String get reportExpenseBreakdown => 'খরচের বিবরণ';

  @override
  String get reportExpenseFallback => 'খরচ';

  @override
  String get reportGrossMarginPercent => 'মোট মার্জিন %';

  @override
  String get reportRoomVsFnB => 'রুম বনাম F&B';

  @override
  String get reportSegmentRoom => 'রুম';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'মূল মেট্রিক';

  @override
  String get reportIncomeStatement => 'আয় বিবৃতি';

  @override
  String get reportChartsSection => 'চার্ট';

  @override
  String get reportSegmentSummary => 'সেগমেন্ট সারাংশ';

  @override
  String get reportFailedToLoad => 'রিপোর্ট লোড ব্যর্থ';

  @override
  String get reportOverview => 'সংক্ষিপ্ত বিবরণ';

  @override
  String get reportOverviewCash => 'নগদ';

  @override
  String get reportOverviewBank => 'ব্যাংক';

  @override
  String get reportMonthlyOpeningBalance => 'মাসিক প্রারম্ভিক ব্যালেন্স';

  @override
  String get reportOpeningBalanceHint => 'প্রতিটি মাসের শুরুতে নগদ অবস্থান';

  @override
  String get reportCashInOut => 'নগদ প্রাপ্তি / প্রদান';

  @override
  String get reportCashIn => 'নগদ প্রাপ্তি';

  @override
  String get reportCashOut => 'নগদ প্রদান';

  @override
  String get reportBankReceiptsPayments => 'ব্যাংক প্রাপ্তি / প্রদান';

  @override
  String get reportReceipts => 'প্রাপ্তি';

  @override
  String get reportPayments => 'প্রদান';

  @override
  String get reportDailyCashVsQr => 'দৈনিক নগদ বনাম QR';

  @override
  String get reportSummariesSection => 'সারাংশ';

  @override
  String get reportCashSummary => 'নগদ সারাংশ';

  @override
  String get reportBankSummary => 'ব্যাংক সারাংশ';

  @override
  String get reportDailySummary => 'দৈনিক সারাংশ';

  @override
  String get reportTabPurchase => 'ক্রয়';

  @override
  String get reportTabSales => 'বিক্রয়';

  @override
  String get reportTabDashboard => 'ড্যাশবোর্ড';

  @override
  String get reportSingleDayTrend => 'এক দিন — দৈনিক ট্রেন্ড';

  @override
  String get reportFullYearTrend => 'পুরো বছর — মাসিক ট্রেন্ড চার্ট';

  @override
  String reportYearLabel(String year) {
    return 'বছর $year';
  }

  @override
  String reportJanDec(String year) {
    return 'জান – ডিস $year';
  }

  @override
  String get reportTotalPurchases => 'মোট ক্রয়';

  @override
  String get reportTotalSales => 'মোট বিক্রয়';

  @override
  String get reportTotalInvoices => 'মোট ইনভয়েস';

  @override
  String get reportUnpaidBalance => 'অপরিশোধিত ব্যালেন্স';

  @override
  String get reportAvgPerInvoice => 'প্রতি ইনভয়েস গড়';

  @override
  String get reportPerTransaction => 'প্রতি লেনদেন';

  @override
  String reportMonthlySpend(String symbol) {
    return 'মাসিক খরচ ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'মাসিক বিক্রয় ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'মাস অনুযায়ী ইনভয়েস সংখ্যা';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'খরচ অনুযায়ী শীর্ষ আইটেম ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'বিভাগ অনুযায়ী খরচ';

  @override
  String get reportOtherCategory => 'অন্যান্য';

  @override
  String get reportSuppliers => 'সরবরাহকারী';

  @override
  String get reportTableSupplier => 'সরবরাহকারী';

  @override
  String get reportTableAmount => 'পরিমাণ';

  @override
  String get reportTableBills => 'বিল';

  @override
  String get reportSalesTotal => 'মোট বিক্রয়';

  @override
  String get reportPurchaseTotal => 'মোট ক্রয়';

  @override
  String get reportPositiveMargin => 'ধনাত্মক মার্জিন';

  @override
  String get reportNegativeMargin => 'ঋণাত্মক মার্জিন';

  @override
  String get reportGrossMargin => 'মোট মার্জিন';

  @override
  String get reportOfTotalSales => 'মোট বিক্রয়ের';

  @override
  String get reportFailedToLoadAnalytics => 'বিশ্লেষণ লোড ব্যর্থ';

  @override
  String get reportMarginKpi => 'মার্জিন';

  @override
  String get reportExpensesKpi => 'খরচ';

  @override
  String partyPickerNoResultsFor(String query) {
    return '\"$query\"-এর জন্য কোনো ফলাফল নেই';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'কোনো $role পক্ষ পাওয়া যায়নি';
  }

  @override
  String get partyPickerLoadParties => 'পক্ষ লোড করুন';

  @override
  String get invoiceCashCustomer => 'নগদ গ্রাহক';

  @override
  String get invoiceQuickAddItemsTitle => 'দ্রুত আইটেম যোগ';

  @override
  String get invoiceQuickLoadingMenu => 'মেনু লোড হচ্ছে…';

  @override
  String get invoiceQuickInvoiceCreated => 'ইনভয়েস তৈরি হয়েছে';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'অন্তত একটি আইটেম যোগ করুন';

  @override
  String get invoiceQuickNoResults => 'কোনো ফলাফল পাওয়া যায়নি!';

  @override
  String get invoiceQuickNoItemsInCategory => 'এই বিভাগে কোনো আইটেম নেই';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'আইটেম যোগ';

  @override
  String get invoiceQuickLoadMore => 'আরও লোড';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'আরও লোড করতে স্ক্রল করুন ($count প্রতি পৃষ্ঠা)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'সরবরাহকারী / কর্মচারী';

  @override
  String get invoiceQuickEditItem => 'আইটেম সম্পাদনা';

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
  String get closeSelectDateRange => 'তারিখের পরিসর নির্বাচন';

  @override
  String get closeStartDate => 'শুরুর তারিখ';

  @override
  String get closeEndDate => 'শেষ তারিখ';

  @override
  String get closeSelectBothDates =>
      'অনুগ্রহ করে শুরু ও শেষ তারিখ দুটোই নির্বাচন করুন';

  @override
  String get closeDeleteSummary => 'সারাংশ মুছুন';

  @override
  String get closeDeleteSummaryConfirm =>
      'আপনি কি নিশ্চিত যে এই সারাংশ মুছতে চান?';

  @override
  String get closeSelectDate => 'তারিখ নির্বাচন';

  @override
  String get closeNoDataToExport => 'এক্সপোর্ট করার কোনো ডেটা নেই';

  @override
  String get closeNoDataToShare => 'শেয়ার করার কোনো ডেটা নেই';

  @override
  String get closeNoDataToPrint => 'প্রিন্ট করার কোনো ডেটা নেই';

  @override
  String closePdfGenerateError(String error) {
    return 'PDF তৈরিতে ত্রুটি: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'PDF শেয়ারে ত্রুটি: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'PDF প্রিন্টে ত্রুটি: $error';
  }

  @override
  String get closeExportPdf => 'PDF হিসেবে এক্সপোর্ট';

  @override
  String get closeSharePdf => 'PDF শেয়ার';

  @override
  String get closePrint => 'প্রিন্ট';

  @override
  String get closeExportOptions => 'এক্সপোর্ট অপশন';

  @override
  String get closeExportPdfSubtitle => 'PDF ডকুমেন্ট হিসেবে সংরক্ষণ বা দেখুন';

  @override
  String get closeSharePdfSubtitle => 'অ্যাপ বা ইমেইলে শেয়ার করুন';

  @override
  String get closePrintSubtitle => 'রিপোর্ট প্রিন্ট করুন';

  @override
  String get closeDailyCashSummaryTitle => 'দৈনিক নগদ সারাংশ';

  @override
  String get closeDailyCashSummaryReport => 'দৈনিক নগদ সারাংশ রিপোর্ট';

  @override
  String closeGeneratedAt(String date) {
    return 'তৈরি: $date';
  }

  @override
  String get closeTotalRecords => 'মোট রেকর্ড';

  @override
  String get closeSummaryOverview => 'সারাংশ সংক্ষিপ্ত';

  @override
  String get closeAllRecords => 'সব রেকর্ড';

  @override
  String closePeriodRange(String start, String end) {
    return 'সময়কাল: $start থেকে $end';
  }

  @override
  String get closeDetails => 'বিবরণ';

  @override
  String closePageN(int n) {
    return 'পৃষ্ঠা $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return '$total-এর মধ্যে $shown দেখানো হচ্ছে';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'লোড: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'রুম / কেবিন / কর্মচারী';

  @override
  String reportPercentOfRevenue(String percent) {
    return 'রাজস্বের $percent%';
  }

  @override
  String get reportParties => 'পক্ষ';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — দৈনিক ট্রেন্ড চার্ট';
  }

  @override
  String get invoiceQuickCart => 'কার্ট';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'কার্ট ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'অনুসন্ধান মুছুন';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'সারাংশ যোগ করুন';

  @override
  String get closeSalesAmount => 'বিক্রয় পরিমাণ';

  @override
  String get closeClosingBalance => 'সমাপনী ব্যালেন্স';

  @override
  String get closeLostMoney => 'হারানো টাকা';

  @override
  String get closeDiscount => 'ছাড়';

  @override
  String get closeExpenses => 'খরচ';

  @override
  String get closeUnpaid => 'অপরিশোধিত';

  @override
  String get closeTotalOpeningBalance => 'মোট প্রারম্ভিক ব্যালেন্স';

  @override
  String get closeTotalSalesAmount => 'মোট বিক্রয় পরিমাণ';

  @override
  String get closeTotalCashAmount => 'মোট নগদ পরিমাণ';

  @override
  String get closeTotalQrAmount => 'মোট QR পরিমাণ';

  @override
  String get closeTotalDiscount => 'মোট ছাড়';

  @override
  String get closeTotalExpenses => 'মোট খরচ';

  @override
  String get closeTotalClosingBalance => 'মোট সমাপনী ব্যালেন্স';

  @override
  String get closeTotalLostMoney => 'মোট হারানো টাকা';

  @override
  String get closeTotalExtraAmount => 'মোট অতিরিক্ত পরিমাণ';

  @override
  String get closeShowingCurrentMonth => 'বর্তমান মাসের ডেটা দেখানো হচ্ছে';

  @override
  String get closeNoSummariesFound => 'কোনো সারাংশ পাওয়া যায়নি';

  @override
  String get closeNoSummariesAvailable => 'কোনো সারাংশ নেই';

  @override
  String get closeTryAdjustingDateRange => 'তারিখের পরিসর সামঞ্জস্য করুন';

  @override
  String get closeCreateFirstSummary => 'শুরু করতে প্রথম সারাংশ তৈরি করুন';

  @override
  String get closeClearFilter => 'ফিল্টার মুছুন';

  @override
  String get closeFiltered => 'ফিল্টার করা';

  @override
  String closeFilteredWithRange(String range) {
    return 'ফিল্টার: $range';
  }

  @override
  String get closeSummarySingular => 'সারাংশ';

  @override
  String get closeSummariesPlural => 'সারাংশ';

  @override
  String get closeSummaryUpdatedSuccess => 'সারাংশ সফলভাবে আপডেট';

  @override
  String get closeSummaryDeletedSuccess => 'সারাংশ সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String premiumUnlockTitle(String appName) {
    return '$appName Premium আনলক করুন';
  }

  @override
  String get premiumTagline =>
      'সম্পূর্ণ অফলাইন POS, ইনভয়েসিং, ইনভেন্টরি ও রিপোর্ট — আপনার ব্যবসার জন্য একটি সাবস্ক্রিপশন।';

  @override
  String get premiumFeatureUnlimitedInvoices => 'সীমাহীন ইনভয়েস ও রসিদ';

  @override
  String get premiumFeatureInventoryStock => 'ইনভেন্টরি ও স্টক ট্র্যাকিং';

  @override
  String get premiumFeatureReportsAnalytics => 'বিক্রয় রিপোর্ট ও বিশ্লেষণ';

  @override
  String get premiumFeatureOfflineLocal =>
      'অফলাইনে কাজ করে — আপনার ডেটা স্থানীয় থাকে';

  @override
  String premiumContinueWith(String plan) {
    return '$plan দিয়ে চালিয়ে যান';
  }

  @override
  String get premiumRestorePurchases => 'ক্রয় পুনরুদ্ধার করুন';

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
      'পেমেন্ট আপনার Apple ID-তে চার্জ হবে। সময়সীমা শেষ হওয়ার কমপক্ষে ২৪ ঘণ্টা আগে বাতিল না করলে সাবস্ক্রিপশন স্বয়ংক্রিয়ভাবে নবায়ন হয়।';

  @override
  String get premiumPurchaseRestored => 'ক্রয় পুনরুদ্ধার হয়েছে।';

  @override
  String get premiumNoActiveSubscription =>
      'কোনো সক্রিয় সাবস্ক্রিপশন পাওয়া যায়নি।';

  @override
  String get premiumPlanMonthly => 'মাসিক';

  @override
  String get premiumPlanMonthlySubtitle => 'নমনীয় — যেকোনো সময় বাতিল করুন';

  @override
  String get premiumPlanYearly => 'বার্ষিক';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'সেরা মূল্য — $percent% সাশ্রয়';
  }

  @override
  String get premiumPlanLifetime => 'আজীবন';

  @override
  String get premiumPlanLifetimeSubtitle => 'একবার দিন, চিরকাল রাখুন';

  @override
  String get premiumPlanPopular => 'জনপ্রিয়';

  @override
  String get premiumOneTimePurchase => 'এককালীন ক্রয়';

  @override
  String get subscriptionSectionTitle => 'সাবস্ক্রিপশন';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Premium-এ আপগ্রেড করুন';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'মাসিক $monthly · বার্ষিক $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan $date পর্যন্ত সক্রিয়';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan সক্রিয়';
  }

  @override
  String get premiumRequired => 'Premium প্রয়োজন';

  @override
  String get upgradeToPremiumContinue => 'চালিয়ে যেতে Premium-এ আপগ্রেড করুন।';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'ফ্রি প্ল্যানে সর্বোচ্চ $limit $label। সীমাহীন অ্যাক্সেসের জন্য Premium-এ আপগ্রেড করুন।';
  }

  @override
  String get freemiumPartyRoleRequired => 'পার্টি ভূমিকা প্রয়োজন।';

  @override
  String get freemiumLabelSalesInvoices => 'বিক্রয় ইনভয়েস';

  @override
  String get freemiumLabelPurchaseInvoices => 'ক্রয় ইনভয়েস';

  @override
  String get freemiumLabelEmployees => 'কর্মচারী';

  @override
  String get freemiumLabelItems => 'আইটেম';

  @override
  String get freemiumLabelCategories => 'বিভাগ';

  @override
  String get freemiumLabelPaymentMethods => 'পেমেন্ট পদ্ধতি';

  @override
  String get freemiumLabelCustomPartyRoles => 'কাস্টম পার্টি ভূমিকা';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return '$role-এর জন্য পার্টি';
  }

  @override
  String get freemiumLabelOrganizations => 'সংস্থা';

  @override
  String get freemiumPremiumReports => 'রিপোর্ট Premium-এ উপলব্ধ।';

  @override
  String get freemiumPremiumBackupSync => 'ব্যাকআপ ও সিঙ্ক Premium প্রয়োজন।';

  @override
  String get freemiumPremiumPayroll => 'পে-রোল Premium প্রয়োজন।';

  @override
  String get freemiumPremiumAttendance => 'উপস্থিতি Premium প্রয়োজন।';

  @override
  String get freemiumPremiumStock => 'স্টক ব্যবস্থাপনা Premium প্রয়োজন।';

  @override
  String get freemiumPremiumInvoiceExport =>
      'ডাউনলোড ও প্রিন্ট Premium প্রয়োজন।';

  @override
  String get shiftReminderOpeningTitle => 'খোলার অনুস্মারক';

  @override
  String get shiftReminderOpeningMessage => 'আজকের জন্য রেজিস্টার খুলেছেন?';

  @override
  String get shiftReminderOpeningProceed => 'হ্যাঁ, এখন খুলুন';

  @override
  String get shiftReminderClosingTitle => 'বন্ধের অনুস্মারক';

  @override
  String get shiftReminderClosingMessage => 'আজকের জন্য রেজিস্টার বন্ধ করেছেন?';

  @override
  String get shiftReminderClosingProceed => 'হ্যাঁ, এখন বন্ধ করুন';

  @override
  String get shiftReminderSkipToday => 'আজকের জন্য এড়িয়ে যান';

  @override
  String get shiftReminderOpeningNotificationTitle => 'খোলার অনুস্মারক';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'আজকের জন্য রেজিস্টার খুলেছেন? এখনও খুলতে হলে এখানে ট্যাপ করুন।';

  @override
  String get shiftReminderClosingNotificationTitle => 'বন্ধের অনুস্মারক';

  @override
  String get shiftReminderClosingNotificationBody =>
      'আজকের জন্য রেজিস্টার বন্ধ করেছেন? এখনও বন্ধ করতে হলে এখানে ট্যাপ করুন।';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business গ্রাহককে QR দেয়; গ্রাহক নগদ দেয়।';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business গ্রাহককে নগদ দেয়; গ্রাহক QR পেমেন্ট দেয়।';
  }

  @override
  String get closePaymentExchange => 'পেমেন্ট বিনিময়';

  @override
  String get closePayQrGetCashExchangeLabel => 'QR দিন → নগদ বিনিময়';

  @override
  String get closePayCashGetQrExchangeLabel => 'নগদ দিন → QR বিনিময়';

  @override
  String get closePayQrGetCashDetail => 'QR দিয়ে নগদ নিন';

  @override
  String get closePayCashGetQrDetail => 'নগদ দিয়ে QR নিন';

  @override
  String get faqSectionPremium => 'Premium ও বিলিং';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium-এ কী কী আছে?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium-এ সীমাহীন ইনভয়েস, সম্পূর্ণ রিপোর্ট (P&L, স্টেটমেন্ট, বিশ্লেষণ), ব্যাকআপ ও সিঙ্ক, পে-রোল, উপস্থিতি, স্টক টুল, ইনভয়েস এক্সপোর্ট/প্রিন্ট এবং অতিরিক্ত সংস্থা unlock হয়। ফ্রি টিয়ারে মূল POS ফিচার যুক্তিসঙ্গত সীমার মধ্যে ব্যবহার করা যায়।';

  @override
  String get faqPremiumFreeTierQuestion => 'ফ্রি টিয়ারে কী আছে?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'আপনি সর্বোচ্চ ১০টি বিক্রয় ও ১০টি ক্রয় ইনভয়েস, ৪ জন কর্মচারী, ৩০টি আইটেম তৈরি করতে পারেন এবং সীমায় পৌঁছালে অন্যান্য সীমা দেখাবে। খোলা, বন্ধ, ক্যালকুলেটর ও ডেটা ব্রাউজিং ফ্রি থাকে।';

  @override
  String get faqPremiumRestoreQuestion => 'ক্রয় কীভাবে পুনরুদ্ধার করব?';

  @override
  String get faqPremiumRestoreAnswer =>
      'আরও → Premium-এ আপগ্রেড (বা পে-ওয়াল) খুলে ক্রয় পুনরুদ্ধার ট্যাপ করুন। সাবস্ক্রাইব করতে যে Apple ID ব্যবহার করেছিলেন সেটি ব্যবহার করুন।';

  @override
  String get faqPremiumCancelQuestion => 'সাবস্ক্রিপশন কীভাবে বাতিল করব?';

  @override
  String get faqPremiumCancelAnswer =>
      'iPhone Settings → Apple ID → Subscriptions-এ পরিচালনা বা বাতিল করুন। পরিশোধিত সময় শেষ পর্যন্ত অ্যাক্সেস থাকবে।';

  @override
  String get faqDarkModeQuestion => 'ডার্ক মোড কীভাবে চালু করব?';

  @override
  String get faqDarkModeAnswer =>
      'আরও → চেহারা খুলে Dark mode চালু করুন। ডিভাইস সিস্টেম থিম ব্যবহার করলে অ্যাপ স্বয়ংক্রিয়ভাবে অনুসরণ করে।';

  @override
  String get faqOpeningClosingReminderQuestion => 'খোলা ও বন্ধের অনুস্মারক কী?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName দৈনিক ক্যাশ রেজিস্টার খোলা বা বন্ধ করার অনুস্মারক দিতে পারে। আপনি চালিয়ে যেতে, আজকের জন্য এড়িয়ে যেতে বা অনুস্মারক বাতিল করতে পারেন।';
  }

  @override
  String get faqPartyRolesQuestion => 'পার্টি ভূমিকা কী?';

  @override
  String get faqPartyRolesAnswer =>
      'পার্টি ভূমিকা গ্রাহক, সরবরাহকারী, রুম বা কর্মচারীর মতো পরিচিতি শ্রেণীবদ্ধ করে। অপারেশন → Party roles-এ কাস্টমাইজ করুন এবং দলের জন্য সংক্ষিপ্ত বিবরণ যোগ করুন।';

  @override
  String faqRateAppQuestion(String appName) {
    return '$appName কীভাবে রেট করব?';
  }

  @override
  String get faqRateAppAnswer =>
      'App Store-এ রিভিউ দিতে আরও → Rate us খুলুন। আপনার মতামত অফলাইন বিলিং উন্নত করতে সাহায্য করে।';
}
