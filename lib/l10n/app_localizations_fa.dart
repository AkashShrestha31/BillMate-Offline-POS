// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get noInternetConnection => 'اتصال اینترنت وجود ندارد.';

  @override
  String get formatException => 'استثنای فرمت';

  @override
  String get rememberMe => 'مرا به خاطر بسپار';

  @override
  String get signIn => 'ورود';

  @override
  String get passwordHint => 'رمز عبور را وارد کنید';

  @override
  String get forgetPassword => 'اطلاعات ورود را فراموش کردید؟';

  @override
  String get okay => 'باشه';

  @override
  String get success => 'موفقیت';

  @override
  String get hotel => 'هتل';

  @override
  String get errorEncountered => 'خطایی رخ داد';

  @override
  String get serverError => 'خطای سرور';

  @override
  String get requestFailed => 'درخواست ناموفق بود';

  @override
  String get connectionTimedOut => 'زمان اتصال به پایان رسید';

  @override
  String get password => 'رمز عبور';

  @override
  String get keepSignIn => 'وارد بمانید';

  @override
  String get enterPassword => 'رمز عبور را وارد کنید';

  @override
  String get enterValidPassword => 'رمز عبور معتبر وارد کنید';

  @override
  String get skip => 'رد کردن';

  @override
  String get pleaseWait => 'لطفاً صبر کنید ....';

  @override
  String get enterValidUserName => 'نام کاربری معتبر وارد کنید.';

  @override
  String get userName => 'نام کاربری';

  @override
  String get or => 'یا';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get error => 'خطا';

  @override
  String get supportMessage => 'لطفاً با مدیر تماس بگیرید.';

  @override
  String get responseMessage404 => 'خطای ۴۰۴';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'نسخه $version';
  }

  @override
  String get cancel => 'لغو';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get close => 'بستن';

  @override
  String get save => 'ذخیره';

  @override
  String get delete => 'حذف';

  @override
  String get deleteOrganizationTitle => 'سازمان حذف شود؟';

  @override
  String deleteOrganizationMessage(String name) {
    return '$name را از این دستگاه حذف کنید. تمام داده‌های محلی این سازمان حذف خواهد شد.';
  }

  @override
  String get deleteOrganizationWarning => 'این عملیات قابل بازگشت نیست.';

  @override
  String get organizationDeleted => 'سازمان حذف شد';

  @override
  String get confirm => 'تأیید';

  @override
  String get done => 'انجام شد';

  @override
  String get next => 'بعدی';

  @override
  String get getStarted => 'شروع کنید';

  @override
  String get walkthroughDashboardTitle => 'کل کسب‌وکار شما در یک نگاه';

  @override
  String get walkthroughDashboardDescription =>
      'فروش امروز، درآمد و مانده‌های معوق — همه در یک داشبورد واضح با باز کردن برنامه.';

  @override
  String get walkthroughOfflineTitle => 'بدون اینترنت هم کار می‌کند';

  @override
  String get walkthroughOfflineDescription =>
      'فاکتور بسازید، هزینه ثبت کنید و موجودی را کاملاً آفلاین مدیریت کنید. با آنلاین شدن همه چیز خودکار همگام می‌شود.';

  @override
  String get walkthroughBillingTitle => 'صورتحساب و فروش در چند ثانیه';

  @override
  String get walkthroughBillingDescription =>
      'فاکتور فروش و خرید، سفارش میز با رسید آشپزخانه و موجودی زنده — همه در یک برنامه.';

  @override
  String get walkthroughStaffTitle => 'کارکنان، حقوق و گزارش‌ها';

  @override
  String get walkthroughStaffDescription =>
      'حضور و حقوق را مدیریت کنید، سپس صورت سود و زیان و فیش حقوق را PDF export کنید — بدون ابزار اضافی.';

  @override
  String get walkthroughBackupTitle => 'داده‌های شما، همیشه امن';

  @override
  String get walkthroughBackupDescription =>
      'امنیت در سطح بانکی با پشتیبان Google Drive یک‌لمسی — سوابق شما محافظت و بازیابی آسان است.';

  @override
  String get walkthroughReadyTitle => 'وقتی شما آماده‌اید';

  @override
  String get walkthroughReadyDescription =>
      'سازمان خود را در چند دقیقه راه‌اندازی کنید و از امروز هوشمندتر کار کنید. بیایید شروع کنیم.';

  @override
  String get back => 'بازگشت';

  @override
  String get submit => 'ارسال';

  @override
  String get continueAction => 'ادامه';

  @override
  String get createAction => 'ایجاد';

  @override
  String get connectOrganizationTitle => 'سازمان خود را متصل کنید';

  @override
  String get connectOrganizationSubtitle =>
      'برای ورود یک سازمان را انتخاب کنید.';

  @override
  String get selectOrganization => 'سازمان‌ها';

  @override
  String get selectOrganizationHint => 'برای ادامه روی یک سازمان ضربه بزنید';

  @override
  String get noSavedOrganizationsYet =>
      'هنوز هیچ سازمانی وجود ندارد. یکی بسازید یا از داده‌های آزمایشی زیر استفاده کنید.';

  @override
  String get orgConnectOnceInfo =>
      'این برنامه را به حساب کاری شما متصل می‌کند. فقط یک بار در هر دستگاه نیاز به تنظیم دارید.';

  @override
  String organizationCodeLabel(String code) {
    return 'کد: $code';
  }

  @override
  String get tryAgain => 'دوباره تلاش کنید';

  @override
  String get warning => 'هشدار';

  @override
  String get loading => 'در حال بارگذاری…';

  @override
  String get comingSoon => 'به زودی';

  @override
  String get required => 'الزامی';

  @override
  String get search => 'جستجو';

  @override
  String get add => 'افزودن';

  @override
  String get edit => 'ویرایش';

  @override
  String get remove => 'حذف';

  @override
  String get view => 'مشاهده';

  @override
  String get export => 'صدور';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'ورودی';

  @override
  String get refresh => 'بروزرسانی';

  @override
  String get select => 'انتخاب';

  @override
  String get upload => 'آپلود';

  @override
  String get download => 'دانلود';

  @override
  String get share => 'اشتراک‌گذاری';

  @override
  String get filter => 'فیلتر';

  @override
  String get sort => 'مرتب‌سازی';

  @override
  String get apply => 'اعمال';

  @override
  String get reset => 'بازنشانی';

  @override
  String get clear => 'پاک کردن';

  @override
  String get all => 'همه';

  @override
  String get none => 'هیچ';

  @override
  String get total => 'جمع';

  @override
  String get subtotal => 'جمع جزء';

  @override
  String get grandTotal => 'جمع کل نهایی';

  @override
  String get amount => 'مبلغ';

  @override
  String get quantity => 'مقدار';

  @override
  String get rate => 'نرخ';

  @override
  String get discount => 'تخفیف';

  @override
  String get paid => 'پرداخت شده';

  @override
  String get unpaid => 'پرداخت‌نشده';

  @override
  String get credit => 'اعتبار';

  @override
  String get cash => 'نقد';

  @override
  String get date => 'تاریخ';

  @override
  String get time => 'زمان';

  @override
  String get name => 'نام';

  @override
  String get email => 'ایمیل';

  @override
  String get phone => 'تلفن';

  @override
  String get address => 'آدرس';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get description => 'توضیحات';

  @override
  String get status => 'وضعیت';

  @override
  String get type => 'نوع';

  @override
  String get category => 'دسته‌بندی';

  @override
  String get party => 'طرف';

  @override
  String get item => 'مورد';

  @override
  String get payment => 'پرداخت';

  @override
  String get settlement => 'تسویه';

  @override
  String get opening => 'افتتاحیه';

  @override
  String get closing => 'اختتامیه';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'هزینه';

  @override
  String get revenue => 'درآمد';

  @override
  String get profit => 'سود';

  @override
  String get loss => 'ضرر';

  @override
  String get sales => 'فروش';

  @override
  String get purchase => 'خرید';

  @override
  String get monthJan => 'ژانویه';

  @override
  String get monthFeb => 'فوریه';

  @override
  String get monthMar => 'مارس';

  @override
  String get monthApr => 'آوریل';

  @override
  String get monthMay => 'مه';

  @override
  String get monthJun => 'ژوئن';

  @override
  String get monthJul => 'ژوئیه';

  @override
  String get monthAug => 'اوت';

  @override
  String get monthSep => 'سپتامبر';

  @override
  String get monthOct => 'اکتبر';

  @override
  String get monthNov => 'نوامبر';

  @override
  String get monthDec => 'دسامبر';

  @override
  String get more => 'بیشتر';

  @override
  String get profile => 'پروفایل';

  @override
  String get operations => 'عملیات';

  @override
  String get operationManagement => 'مدیریت عملیات';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'مدیریت کارمندان';

  @override
  String get employeeManagementSubtitle => 'کارکنان، حقوق و حضور';

  @override
  String get report => 'گزارش';

  @override
  String get reportSubtitle => 'سود و زیان، صورت‌ها و تحلیل‌ها';

  @override
  String get helpAndSupport => 'راهنما و پشتیبانی';

  @override
  String get preferences => 'ترجیحات';

  @override
  String get dataAndBackup => 'داده و پشتیبان';

  @override
  String get privacyAndPolicies => 'حریم خصوصی و سیاست‌ها';

  @override
  String get faq => 'سؤالات متداول';

  @override
  String get contactSupport => 'تماس با پشتیبانی';

  @override
  String get rateUs => 'به ما امتیاز دهید';

  @override
  String get rateUsSubtitle =>
      'از BizTrack لذت می‌برید؟ در Google Play نظر بدهید';

  @override
  String get rateUsUnavailable => 'فروشگاه باز نشد. بعداً دوباره امتحان کنید.';

  @override
  String get reportProblem => 'گزارش مشکل';

  @override
  String get contactUs => 'تماس با ما';

  @override
  String get contactUsSubtitle =>
      'برای پشتیبانی، بازخورد یا سؤالات درباره برنامه تماس بگیرید.';

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
  String get developerLabel => 'توسعه‌دهنده';

  @override
  String get emailCopiedToClipboard => 'ایمیل در کلیپ‌بورد کپی شد';

  @override
  String get logout => 'خروج';

  @override
  String get signOut => 'خروج از حساب';

  @override
  String get settings => 'تنظیمات';

  @override
  String get testData => 'داده آزمایشی';

  @override
  String get loginWithTestData => 'ورود با داده‌های آزمایشی';

  @override
  String get loginWithTestDataSubtitle =>
      'داده‌های هتل نمایشی را بارگذاری کنید و به صورت خودکار وارد شوید';

  @override
  String testDataLoginFailed(String error) {
    return 'بارگذاری داده‌های آزمایشی ممکن نشد: $error';
  }

  @override
  String get preparingTestData => 'در حال آماده‌سازی داده‌های نمایشی…';

  @override
  String get regionAndCurrency => 'منطقه و ارز';

  @override
  String get reportingCurrency => 'ارز گزارش‌دهی';

  @override
  String get selectCurrency => 'انتخاب ارز';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · نمونه $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'ارز روی $code ($symbol) تنظیم شد';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'به‌روزرسانی ارز ممکن نشد: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'راه‌اندازی $appName';
  }

  @override
  String get setupSubtitle =>
      'سازمان و حسابداری خود را پیکربندی کنید — برای استفاده آفلاین روی این دستگاه ذخیره می‌شود.';

  @override
  String get setupOrganizationName => 'نام سازمان';

  @override
  String get setupCompanyName => 'نام شرکت';

  @override
  String get setupBusinessType => 'نوع کسب‌وکار';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => 'هتل';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => 'رستوران';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => 'هتل و رستوران';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => 'خرده‌فروشی / مغازه';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'کافه / نانوایی';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'بار / پاب';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'سایر';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'نوع: $type';
  }

  @override
  String get organizationSettings => 'سازمان';

  @override
  String get editOrganizationInfo => 'اطلاعات سازمان';

  @override
  String get editOrganizationInfoSubtitle =>
      'نحوه نمایش این کسب‌وکار در برنامه را به‌روزرسانی کنید. کد سازمان قابل تغییر نیست.';

  @override
  String get organizationCode => 'کد سازمان';

  @override
  String get organizationCodeReadOnly => 'این کد پس از راه‌اندازی ثابت است.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'اطلاعات سازمان ذخیره شد';

  @override
  String get organizationInfoLoadFailed => 'اطلاعات سازمان بارگذاری نشد';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'اطلاعات سازمان ذخیره نشد: $error';
  }

  @override
  String get organizationTabGeneral => 'عمومی';

  @override
  String get organizationTabRegional => 'منطقه‌ای و مالی';

  @override
  String get organizationRegionalSubtitle =>
      'کشور، ارز گزارش‌دهی و تاریخ‌های سال مالی.';

  @override
  String get organizationTabAccounting => 'حسابداری';

  @override
  String get organizationAccountingSubtitle => 'تنظیمات فاکتور و نمایش مبلغ.';

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
  String get displayPrecision => 'دقت نمایش';

  @override
  String get displayPrecisionRange => 'عددی بین ۰ تا ۵ وارد کنید';

  @override
  String get enableInvoiceReturns => 'فعال‌سازی مرجوعی فاکتور';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'ایجاد مرجوعی از فاکتورهای پرداخت‌شده مجاز باشد.';

  @override
  String get saveChanges => 'ذخیره تغییرات';

  @override
  String get setupFullName => 'نام کامل';

  @override
  String get setupConfirmPassword => 'تأیید رمز عبور';

  @override
  String get setupBankName => 'نام بانک';

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
  String get setupRegionStepTitle => 'منطقه و ارز';

  @override
  String get setupOrganizationStepTitle => 'سازمان';

  @override
  String get setupOrganizationStepSubtitle =>
      'نحوه نمایش کسب‌وکار شما در برنامه';

  @override
  String get setupAdminStepTitle => 'حساب مدیر';

  @override
  String get setupAdminStepSubtitle => 'کاربر اصلی برای این نصب';

  @override
  String get setupAccountingStepTitle => 'حسابداری';

  @override
  String get setupAccountingStepSubtitle => 'بانک، نمودار حسابات و سال مالی';

  @override
  String get setupCompleteSetup => 'تکمیل راه‌اندازی';

  @override
  String fieldRequired(String field) {
    return '$field الزامی است';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'یک آدرس ایمیل معتبر وارد کنید';

  @override
  String passwordMinLength(int min) {
    return 'رمز عبور باید حداقل $min کاراکتر باشد';
  }

  @override
  String get passwordsDoNotMatch => 'رمزهای عبور مطابقت ندارند';

  @override
  String get setupFixValidationErrors =>
      'لطفاً خطاهای زیر را برای ادامه برطرف کنید';

  @override
  String get setupCompleteSuccess => 'راه‌اندازی با موفقیت تکمیل شد';

  @override
  String get setupCompleteWithPdfSuccess =>
      'راه‌اندازی کامل شد. PDF را در مکانی امن ذخیره کنید.';

  @override
  String setupPdfFailed(String error) {
    return 'راه‌اندازی تمام شد، اما PDF ذخیره نشد: $error';
  }

  @override
  String get setupFailed => 'راه‌اندازی تکمیل نشد. لطفاً دوباره امتحان کنید.';

  @override
  String setupFailedWithDetails(String error) {
    return 'راه‌اندازی ناموفق بود: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'تنظیمات منطقه‌ای و ارز گزارش‌دهی.';

  @override
  String get country => 'کشور';

  @override
  String get currency => 'ارز';

  @override
  String get selectCountry => 'انتخاب کشور';

  @override
  String get language => 'زبان';

  @override
  String get selectLanguage => 'انتخاب زبان';

  @override
  String get languageChangeLaterHint =>
      'می‌توانید آن را بعداً از تنظیمات تغییر دهید';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'انتخاب کنید چگونه می‌خواهید از $appName استفاده کنید. می‌توانید بعداً در تنظیمات تغییر دهید.';
  }

  @override
  String get searchLanguages => 'جستجوی زبان‌ها';

  @override
  String get languageSuggestedBadge => 'پیشنهادی';

  @override
  String continueInLanguage(String languageName) {
    return 'ادامه به $languageName';
  }

  @override
  String get noLanguageMatches => 'موردی یافت نشد';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'زبانی با \"$query\" مطابقت ندارد';
  }

  @override
  String get appearance => 'ظاهر';

  @override
  String get darkMode => 'حالت تاریک';

  @override
  String get darkModeSubtitle => 'استفاده از پس‌زمینه تیره در سراسر برنامه';

  @override
  String get darkModeSystemSubtitle => 'از تم دستگاه شما پیروی می‌کند';

  @override
  String languageUpdated(String name) {
    return 'زبان روی $name تنظیم شد';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'به‌روزرسانی زبان ممکن نشد: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'به $appName خوش آمدید';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'برای ادامه لطفاً آخرین نسخه $appName را نصب کنید.';
  }

  @override
  String generatedByApp(String appName) {
    return 'تولید شده توسط $appName';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName چیست؟';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName به شما کمک می‌کند فاکتورهای فروش و خرید، طرف‌ها (مشتریان و تأمین‌کنندگان)، موجودی، پرداخت‌ها، کارمندان و خلاصه‌های روزانه را از گوشی یا تبلت خود مدیریت کنید.';
  }

  @override
  String faqIntro(String appName) {
    return 'پاسخ به سؤالات متداول درباره $appName.';
  }

  @override
  String get chooseFromGallery => 'انتخاب از گالری';

  @override
  String get takePhoto => 'عکس بگیرید';

  @override
  String get photoLibrary => 'کتابخانه عکس';

  @override
  String get addPhoto => 'افزودن عکس';

  @override
  String couldNotPickImage(String error) {
    return 'انتخاب تصویر ممکن نشد: $error';
  }

  @override
  String get unpaidAmount => 'پرداخت نشده مبلغ';

  @override
  String get unpaidBalance => 'پرداخت نشده';

  @override
  String unpaidColonAmount(String amount) {
    return 'پرداخت نشده: $amount';
  }

  @override
  String get previousUnpaid => 'پرداخت نشده';

  @override
  String get partyUnpaid => 'پرداخت نشده';

  @override
  String get loadingUnpaid => 'پرداخت نشده…';

  @override
  String get totalUnpaid => 'پرداخت نشده';

  @override
  String get unpaidAmountNotYetCollected =>
      'مبلغ پرداخت‌نشده هنوز دریافت نشده است.';

  @override
  String get partyUnpaidTabHint =>
      'کارمندان را باز کنید، یک نفر را انتخاب کنید، سپس در پروفایل آن‌ها روی پرداخت‌نشده طرف ضربه بزنید. سرور برای این جستجو به شناسه کارمند نیاز دارد.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'تسویه طرف از مجموع پرداخت‌نشده استفاده می‌کند.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'ابتدا مبلغ تسویه را وارد کنید (یا طرفی با پرداخت‌نشده انتخاب کنید).';

  @override
  String get workspace => 'فضای کاری';

  @override
  String get change => 'تغییر';

  @override
  String get addMoreOrganization => 'افزودن بیشتر +';

  @override
  String get connectAnotherOrganization => 'اتصال سازمان دیگر';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'هنوز سازمانی ذخیره نشده. از افزودن بیشتر + برای اتصال استفاده کنید.';

  @override
  String get registerNewOrganizationTitleSignedIn => 'ثبت سازمان جدید؟';

  @override
  String get registerNewOrganizationTitle => 'ثبت سازمان جدید؟';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'از حساب خارج می‌شوید و راه‌انداز از ابتدا شروع می‌کند.\n\nسازمان‌های ذخیره‌شده پس از راه‌اندازی در لیست باقی می‌مانند.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'راه‌انداز شروع می‌کند. راه‌اندازی را تکمیل کنید؛ سازمان‌های ذخیره‌شده در لیست باقی می‌مانند.';

  @override
  String get startSetup => 'شروع راه‌اندازی';

  @override
  String get enterOrganizationCode => 'لطفاً کد سازمان خود را وارد کنید';

  @override
  String get organizationNotFoundCheckCode =>
      'سازمان یافت نشد. کد را بررسی کرده و دوباره امتحان کنید.';

  @override
  String get organizationNotFound => 'سازمان یافت نشد';

  @override
  String get couldNotVerifyOrganization => 'تأیید سازمان امکان‌پذیر نبود';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'داده محلی برای $name وجود ندارد. ابتدا راه‌اندازی این سازمان را تکمیل کنید.';
  }

  @override
  String get welcomeBack => 'خوش برگشتید';

  @override
  String get signInToContinue => 'برای ادامه وارد شوید';

  @override
  String get enterEmail => 'ایمیل را وارد کنید';

  @override
  String get pleaseEnterEmail => 'لطفاً ایمیل خود را وارد کنید';

  @override
  String get pleaseEnterValidEmail => 'لطفاً یک ایمیل معتبر وارد کنید';

  @override
  String get enterEmailLocalPartOnly => 'فقط بخش قبل از @ را وارد کنید';

  @override
  String get pleaseEnterPassword => 'لطفاً رمز عبور خود را وارد کنید';

  @override
  String get logIn => 'ورود';

  @override
  String get searchCountry => 'جستجوی کشور';

  @override
  String get searchCodeOrSymbol => 'جستجوی کد یا نماد';

  @override
  String get saveLoginDetailsTitle => 'اطلاعات ورود را ذخیره کنید؟';

  @override
  String get saveLoginDetailsMessage =>
      'در شرف تکمیل راه‌اندازی این سازمان هستید.\n\nآیا می‌خواهید یک PDF با کد، نام، ایمیل و رمز عبور دانلود کنید؟ آن را در مکانی امن نگهداری کنید.';

  @override
  String get downloadPdfAndContinue => 'دانلود PDF و ادامه';

  @override
  String get continueWithoutPdf => 'ادامه بدون PDF';

  @override
  String get legalDisplayNameHint => 'نام قانونی / نمایشی';

  @override
  String get chartOfAccounts => 'نمودار حسابات';

  @override
  String get fiscalYearStart => 'شروع سال مالی';

  @override
  String get fiscalYearEnd => 'پایان سال مالی';

  @override
  String get removeTestDataTitle => 'حذف داده‌های آزمایشی؟';

  @override
  String get removeTestDataMessageDemoOrg =>
      'تمام فروش‌ها، خریدها، مخاطبان، طرف‌ها، موجودی، کارمندان و سازمان‌های آزمایشی حذف می‌شوند.\n\nشما در یک سازمان آزمایشی هستید — پس از این به اولین سازمان شما برمی‌گردید.';

  @override
  String get removeTestDataMessageNormal =>
      'تمام داده‌های آزمایشی و ۳ سازمان اضافی حذف می‌شوند. حساب مدیر شما دست‌نخورده باقی می‌ماند.';

  @override
  String get removeTestDataWarning =>
      'این عمل قابل بازگشت نیست مگر با بارگذاری مجدد داده‌های آزمایشی.';

  @override
  String get removeTestData => 'حذف داده‌های آزمایشی';

  @override
  String get keepTestData => 'نگه‌داشتن داده‌های آزمایشی';

  @override
  String get demoDataRemoved => 'داده‌های نمایشی حذف شدند';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'داده‌های آزمایشی حذف شدند. به $name تغییر یافت.';
  }

  @override
  String get testDataRemoved => 'داده‌های آزمایشی حذف شدند';

  @override
  String couldNotRemoveTestData(String error) {
    return 'حذف داده‌های آزمایشی ممکن نشد: $error';
  }

  @override
  String get loadTestDataTitle => 'بارگذاری داده‌های آزمایشی؟';

  @override
  String get loadTestDataMessage =>
      'این مخاطبان، موجودی، فروش، خرید، پرداخت، کارمندان و حضور ۱۵ روز اخیر را اضافه می‌کند.';

  @override
  String get loadTestData => 'بارگذاری داده‌های آزمایشی';

  @override
  String get testDataLoaded => 'داده‌های آزمایشی بارگذاری شدند';

  @override
  String couldNotLoadTestData(String error) {
    return 'بارگذاری داده‌های آزمایشی ممکن نشد: $error';
  }

  @override
  String get demoTestData => 'داده‌های آزمایشی نمایشی';

  @override
  String get importTestDataSubtitle =>
      'وارد کردن داده‌های آزمایشی برای همه ویژگی‌ها';

  @override
  String get hideTestDataTitle =>
      'پنهان‌سازی داده‌های آزمایشی برای این سازمان؟';

  @override
  String get hideTestDataMessage =>
      'بخش داده‌های آزمایشی در همه جای این سازمان پنهان می‌شود.';

  @override
  String get hideTestDataWarning =>
      'داده‌های نمایشی قبلاً بارگذاری‌شده تا زمانی که از تنظیمات حذف نشوند در پایگاه داده باقی می‌مانند.';

  @override
  String get okHideTestData => 'باشه، داده‌های آزمایشی را پنهان کن';

  @override
  String get testDataHiddenForOrg =>
      'داده‌های آزمایشی برای این سازمان پنهان شدند';

  @override
  String get hideTestDataTooltip =>
      'پنهان‌سازی داده‌های آزمایشی برای این سازمان';

  @override
  String get partyRolesTitle => 'نقش‌های طرف';

  @override
  String get partyRolesMoreSubtitle => 'مشتری، تأمین‌کننده، هر دو و بیشتر';

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
  String get partyRoleCustomer => 'مشتری';

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
  String get searchRoles => 'جستجوی نقش‌ها';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نقش',
      one: '۱ نقش',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'هنوز نقشی وجود ندارد';

  @override
  String get noRolesYetHint =>
      'مشتری، تأمین‌کننده، هر دو یا نقش‌های سفارشی برای مخاطبان اضافه کنید.';

  @override
  String get addRole => 'افزودن نقش';

  @override
  String get deleteRoleTitle => 'حذف نقش';

  @override
  String deleteRoleConfirm(String name) {
    return 'حذف \"$name\"؟ این عمل قابل بازگشت نیست.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount طرف',
      one: '۱ طرف',
    );
    return '\"$name\" توسط $_temp0 استفاده می‌شود. انتقال دهید یا حذف اجباری کنید.';
  }

  @override
  String get transferParties => 'انتقال طرف‌ها';

  @override
  String get hardDeleteLoseParties => 'حذف اجباری (از دست دادن طرف‌ها)';

  @override
  String get hardDeleteRoleTitle => 'حذف اجباری؟';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount طرف',
      one: '۱ طرف',
    );
    return 'این عمل \"$name\" و $_temp0 مرتبط را به‌طور دائم حذف می‌کند.\n\nطرف‌های مرتبط با فاکتور ممکن است حذف نشوند — از انتقال استفاده کنید.';
  }

  @override
  String get deleteRoleAndParties => 'حذف نقش و طرف‌ها';

  @override
  String get addAnotherRoleBeforeDelete =>
      'قبل از حذف این نقش، یکی دیگر اضافه کنید.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount طرف',
      one: '۱ طرف',
    );
    return 'انتقال $_temp0 از \"$fromRole\" به:';
  }

  @override
  String get transferAndDeleteRole => 'انتقال و حذف نقش';

  @override
  String get builtInRole => 'داخلی';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طرف',
      one: '۱ طرف',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'هنوز طرفی وجود ندارد';

  @override
  String get newRole => 'نقش جدید';

  @override
  String get editRole => 'ویرایش نقش';

  @override
  String get defaultRolesCannotEdit =>
      'نقش‌های پیش‌فرض قابل تغییر نام یا حذف نیستند.';

  @override
  String get roleNameLabel => 'نام نقش *';

  @override
  String get roleNameHint => 'مثال: مشتری';

  @override
  String get roleDescriptionLabel => 'توضیحات';

  @override
  String get roleDescriptionHint => 'یادداشت کوتاه برای تیم شما';

  @override
  String get roleSortOrderLabel => 'ترتیب مرتب‌سازی';

  @override
  String get roleSortOrderHint => 'عدد کمتر اول در لیست نمایش داده می‌شود';

  @override
  String get roleCreated => 'نقش ایجاد شد';

  @override
  String get roleUpdated => 'نقش به‌روز شد';

  @override
  String get roleDeleted => 'نقش حذف شد';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طرف',
      one: '۱ طرف',
    );
    return 'نقش حذف شد. $_temp0 به $targetRole منتقل شد.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طرف',
      one: '۱ طرف',
    );
    return 'نقش و $_temp0 حذف شدند.';
  }

  @override
  String get privacyPolicyTitle => 'سیاست حریم خصوصی';

  @override
  String get termsAndConditions => 'شرایط و ضوابط';

  @override
  String get logoutConfirmTitle => 'خروج';

  @override
  String get logoutConfirmMessage =>
      'آیا مطمئن هستید که می‌خواهید از حساب خود خارج شوید؟';

  @override
  String get faqTapToExpand => 'برای گسترش روی سؤال ضربه بزنید.';

  @override
  String get faqSectionGettingStarted => 'شروع به کار';

  @override
  String get faqSectionLogin => 'ورود';

  @override
  String get faqSectionNavigation => 'ناوبری';

  @override
  String get faqSectionInvoices => 'فاکتورها';

  @override
  String get faqSectionPayments => 'پرداخت‌ها';

  @override
  String get faqSectionItemsStock => 'اقلام و موجودی';

  @override
  String get faqSectionProfileEmployees => 'پروفایل و کارمندان';

  @override
  String get faqSectionDashboardReports => 'داشبورد و گزارش‌ها';

  @override
  String get faqSectionSyncTroubleshooting => 'همگام‌سازی و عیب‌یابی';

  @override
  String get faqNeedInternetQuestion => 'آیا به اینترنت نیاز دارم؟';

  @override
  String get faqNeedInternetAnswer =>
      'پس از راه‌اندازی اولیه می‌توانید بدون اینترنت فاکتور، اقلام و پرداخت ثبت کنید.';

  @override
  String get faqFirstInstallQuestion => 'در اولین نصب چه اتفاقی می‌افتد؟';

  @override
  String get faqFirstInstallAnswer =>
      'یک آموزش کوتاه می‌بینید، سپس راه‌اندازی محلی (سازمان، شرکت، ایمیل، رمز، ارز، سال مالی). بعد وارد شوید.';

  @override
  String get faqSignInCredentialsQuestion => 'برای ورود از چه استفاده کنم؟';

  @override
  String get faqSignInCredentialsAnswer => 'ایمیل و رمز عبور از راه‌اندازی.';

  @override
  String get faqLoggedOutQuestion => 'چرا خارج شدم؟';

  @override
  String get faqLoggedOutAnswer =>
      'خروج انتخاب کردید یا جلسه منقضی شد. دوباره وارد شوید.';

  @override
  String get faqBottomTabsQuestion => 'تب‌های پایین چه کاری می‌کنند؟';

  @override
  String get faqBottomTabsAnswer =>
      'خانه — داشبورد.\nفروش — فاکتورهای فروش.\nهزینه‌ها — فاکتورهای خرید.\nدکمه وسط — طرف‌ها.\nبیشتر — پروفایل، گزارش‌ها، خروج.';

  @override
  String get faqCreateInvoiceQuestion => 'چطور فاکتور ایجاد کنم؟';

  @override
  String get faqCreateInvoiceAnswer =>
      'فروش یا هزینه را باز کنید، تاریخ انتخاب کنید، + بزنید، اقلام اضافه کنید، ذخیره کنید.';

  @override
  String get faqInvoiceDetailsQuestion => 'چطور جزئیات فاکتور را ببینم؟';

  @override
  String get faqInvoiceDetailsAnswer => 'روی هر فاکتور در لیست ضربه بزنید.';

  @override
  String get faqZeroRateQuestion => 'نرخ یا مبلغ صفر نشان می‌دهد';

  @override
  String get faqZeroRateAnswer =>
      'داده‌های خط در ذخیره‌های قدیمی وجود نداشت. برنامه را به‌روز کنید.';

  @override
  String get faqPartialPaymentQuestion => 'چطور پرداخت جزئی ثبت کنم؟';

  @override
  String get faqPartialPaymentAnswer =>
      'فاکتور → جزئیات معامله → انجام پرداخت.';

  @override
  String get faqMultiplePaymentQuestion => 'پرداخت چندگانه چطور کار می‌کند؟';

  @override
  String get faqMultiplePaymentAnswer =>
      'پرداخت چندگانه را روشن کنید و مبلغ را بین نقد، کارت، QR تقسیم کنید.';

  @override
  String get faqSplitPaymentSavedQuestion => 'فقط یک پرداخت از تقسیم ذخیره شد';

  @override
  String get faqSplitPaymentSavedAnswer => 'به آخرین نسخه برنامه به‌روز کنید.';

  @override
  String get faqAddItemQuestion => 'چطور قلم اضافه کنم؟';

  @override
  String get faqAddItemAnswer =>
      'از جریان فروش قلم اضافه کنید. نام، نرخ، واحد وارد کنید.';

  @override
  String get faqCustomUnitQuestion => 'چطور واحد سفارشی اضافه کنم؟';

  @override
  String get faqCustomUnitAnswer => 'قلم → واحد → ایجاد واحد جدید.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion => 'پروفایل هنوز نام قدیمی را نشان می‌دهد';

  @override
  String get faqProfileNameAnswer => 'رکورد کارمند خود را ویرایش و ذخیره کنید.';

  @override
  String get faqRevenueDetailsQuestion => 'جزئیات درآمد چیست؟';

  @override
  String get faqRevenueDetailsAnswer =>
      'نمای ماهانه با نمودار روزانه، سود خالص و تفکیک فروش در مقابل خرید.';

  @override
  String get faqOtherReportsQuestion => 'گزارش‌های دیگر کجاست؟';

  @override
  String get faqOtherReportsAnswer =>
      'بیشتر → گزارش‌ها، اگر نقش شما دسترسی دارد.';

  @override
  String get faqWhenSyncQuestion => 'کِی باید همگام‌سازی کنم؟';

  @override
  String get faqWhenSyncAnswer =>
      'فقط وقتی مدیر می‌خواهد و اتصال پایدار دارید.';

  @override
  String get faqFabPositionQuestion => 'دکمه + خیلی بالا به نظر می‌رسد';

  @override
  String get faqFabPositionAnswer =>
      'بالای نوار ناوبری است. لیست را اسکرول کنید یا برنامه را به‌روز کنید.';

  @override
  String get faqHowLogoutQuestion => 'چطور خارج شوم؟';

  @override
  String get faqHowLogoutAnswer => 'بیشتر → خروج در پایین لیست تنظیمات.';

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
  String get statisticsQuickOperationsSeeAll => 'مشاهده همه';

  @override
  String get statisticsQuickOperationInvoice => 'فاکتور';

  @override
  String get statisticsQuickOperationReports => 'گزارش‌ها';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'جریان نقدی';

  @override
  String get statisticsCashflowLast7Days => 'جریان نقدی (۷ روز گذشته)';

  @override
  String get statisticsCashflowLast12Months => 'جریان نقدی (۱۲ ماه گذشته)';

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
  String get profitAndLoss => 'سود و زیان';

  @override
  String get statementReport => 'صورت‌حساب';

  @override
  String get analytics => 'تحلیل‌ها';

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
  String get partyPickerSubtitle => 'این فروش برای چه کسی است؟';

  @override
  String partyPickerSearchHint(String role) {
    return 'جستجوی $role...';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'افزودن $role جدید';
  }

  @override
  String get partyPickerSettled => 'تسویه‌شده';

  @override
  String get partyPickerSelectedLabel => 'انتخاب‌شده';

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
  String get itemSelectCategoryRequired => 'لطفاً یک دسته انتخاب کنید';

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
  String get closeSummaryTitle => 'خلاصه بستن';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint =>
      'تاریخ را انتخاب و برای بارگذاری داده، به‌روزرسانی را بزنید';

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
  String get closeTotalSales => 'کل فروش';

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
  String get closePayCashGetQr => 'پرداخت نقد ← دریافت QR';

  @override
  String get closePayQrGetCash => 'پرداخت QR ← دریافت نقد';

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
  String get closeExportData => 'صدور داده';

  @override
  String get closeExportComingSoon => 'قابلیت صادرات اینجا پیاده‌سازی خواهد شد';

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
  String get googleDriveBackupSectionTitle => 'پشتیبان‌گیری و همگام‌سازی';

  @override
  String get googleDriveBackupTitle => 'پشتیبان Google Drive';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'برای پشتیبان‌گیری امن داده‌های سازمان در Google Drive وارد شوید.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'وارد شده به عنوان $email';
  }

  @override
  String get googleDriveSignIn => 'ورود با Google';

  @override
  String get googleDriveSignOut => 'خروج';

  @override
  String get googleDriveBackupNow => 'همین حالا پشتیبان بگیر';

  @override
  String get googleDriveSignInSuccess => 'در Google Drive وارد شدید';

  @override
  String get googleDriveSignOutSuccess => 'از Google Drive خارج شدید';

  @override
  String get googleDriveSignInCancelled => 'ورود Google لغو شد';

  @override
  String get googleDriveBackupStarting => 'در حال آماده‌سازی پشتیبان…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'پشتیبان بارگذاری شد ($tableCount جدول، $recordCount رکورد)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'پشتیبان‌گیری نیاز به راه‌اندازی مجدد کامل برنامه دارد. برنامه را ببندید، دوباره باز کنید و تلاش کنید.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'پشتیبان‌گیری ناموفق: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'آخرین پشتیبان: $date';
  }

  @override
  String get backupSyncPageTitle => 'پشتیبان‌گیری و همگام‌سازی';

  @override
  String get backupSyncGoogleAccount => 'حساب Google';

  @override
  String get backupSyncSignedInAs => 'وارد شده به عنوان';

  @override
  String get backupSyncSignInHint =>
      'برای پشتیبان‌گیری داده‌های سازمان با Google وارد شوید.';

  @override
  String get backupSyncLastSyncTitle => 'آخرین همگام‌سازی';

  @override
  String get backupSyncLastSyncDate => 'تاریخ و زمان';

  @override
  String get backupSyncNeverSynced => 'هنوز پشتیبانی بارگذاری نشده است.';

  @override
  String get backupSyncOrganization => 'سازمان';

  @override
  String get backupSyncTables => 'جدول‌های پشتیبان‌شده';

  @override
  String get backupSyncRecords => 'رکوردهای پشتیبان‌شده';

  @override
  String get backupSyncStatus => 'وضعیت';

  @override
  String get backupSyncStatusSuccess => 'تکمیل شد';

  @override
  String get backupSyncActiveOrganization => 'سازمان فعلی';

  @override
  String get backupSyncActiveOrganizationHint =>
      'پشتیبان‌گیری داده‌های سازمانی را که اکنون استفاده می‌کنید بارگذاری می‌کند.';

  @override
  String get backupSyncUnknownOrganization => 'سازمان فعلی';

  @override
  String get backupSyncInProgress => 'همگام‌سازی در حال انجام';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent٪';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'مرحله: $step';
  }

  @override
  String get backupSyncStepExport => 'در حال خروجی گرفتن از داده‌های محلی';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'در حال بارگذاری $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'در حال بارگذاری $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'آخرین خطا: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'از Google Drive در این دستگاه خارج شوید؟';

  @override
  String get moreBackupSyncTileNeverSynced => 'پشتیبان در Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync => 'وارد شده · هنوز پشتیبان نیست';

  @override
  String get backupSyncConnected => 'متصل';

  @override
  String get backupSyncCompletedHint =>
      'داده‌های شما با امنیت در Google Drive پشتیبان‌گیری شده‌اند.';

  @override
  String get backupSyncPhaseExport => 'خروجی';

  @override
  String get backupSyncPhaseUpload => 'بارگذاری';

  @override
  String get backupAutoSettingsTitle => 'تنظیمات Google Drive';

  @override
  String get backupAutoBackupTitle => 'پشتیبان‌گیری خودکار';

  @override
  String get backupAutoBackupHint =>
      'در زمان مقرر هنگام شروع برنامه، پشتیبان‌گیری خودکار';

  @override
  String get backupWifiOnlyTitle => 'فقط از Wi‑Fi پشتیبان بگیر';

  @override
  String get backupWifiOnlyHint => 'پشتیبان خودکار منتظر Wi‑Fi می‌ماند';

  @override
  String get backupWifiOnlyContinue => 'استفاده از داده موبایل';

  @override
  String get backupAutoFrequencyTitle => 'تناوب پشتیبان‌گیری';

  @override
  String get backupAutoFrequencyOff => 'خاموش';

  @override
  String get backupAutoFrequencyDaily => 'روزانه';

  @override
  String get backupAutoFrequencyWeekly => 'هفتگی';

  @override
  String get backupAutoFrequencyMonthly => 'ماهانه';

  @override
  String get backupAutoSyncDirectionTitle => 'همگام‌سازی خودکار';

  @override
  String get backupAutoDirectionUpload => 'بارگذاری در فضای ابری';

  @override
  String get backupAutoDirectionDownload => 'دانلود از فضای ابری';

  @override
  String get backupAutoDirectionBoth => 'بارگذاری و دانلود';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'آخرین پشتیبان خودکار: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'آخرین بازیابی خودکار: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'آخرین همگام‌سازی خودکار ناموفق: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'آخرین همگام‌سازی خودکار رد شد: $detail';
  }

  @override
  String get restoreAction => 'بازیابی';

  @override
  String get restoreFromGoogleDrive => 'بازیابی از Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'وارد شوید و یک پشتیبان برای بازیابی سازمان در این دستگاه انتخاب کنید.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '\"$name\" بازیابی شود؟ این داده‌های محلی آن سازمان را جایگزین می‌کند.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name بازیابی شد. اکنون می‌توانید وارد شوید.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'بازیابی ناموفق: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'پشتیبانی در Google Drive شما یافت نشد.';

  @override
  String get restoreFromGoogleDriveStarting => 'در حال شروع بازیابی…';

  @override
  String get restoreStepDownload => 'در حال دانلود پشتیبان';

  @override
  String get restoreStepCreateDatabase => 'در حال ایجاد پایگاه داده';

  @override
  String get restoreStepImport => 'در حال وارد کردن داده';

  @override
  String get restoreStepFinalize => 'در حال تکمیل بازیابی';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'آخرین همگام‌سازی: $date';
  }

  @override
  String get security => 'امنیت';

  @override
  String get appLockTitle => 'قفل برنامه';

  @override
  String get appLockSubtitle =>
      'هنگام باز کردن مجدد برنامه، PIN یا بیومتریک لازم است';

  @override
  String get appPin => 'PIN برنامه';

  @override
  String appPinSubtitle(int length) {
    return 'باز کردن سریع با PIN $length رقمی';
  }

  @override
  String get useBiometricUnlock => 'استفاده از Face ID / بیومتریک';

  @override
  String get useBiometricUnlockSubtitle =>
      'پس از تنظیم PIN با اثر انگشت یا Face ID باز کنید';

  @override
  String get changeAppPin => 'تغییر PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'تنظیم PIN';

  @override
  String get confirmAppPin => 'تأیید PIN';

  @override
  String get enterAppPin => 'PIN خود را وارد کنید';

  @override
  String get enterPasscode => 'رمز عبور را وارد کنید';

  @override
  String tapDigitsToUnlock(int length) {
    return 'برای باز کردن هر $length رقم را لمس کنید.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'یک رمز $length رقمی برای این سازمان انتخاب کنید';
  }

  @override
  String get confirmPasscodeHint => 'برای تأیید رمز عبور را دوباره وارد کنید';

  @override
  String createAppPinHint(int length) {
    return 'یک PIN $length رقمی برای این سازمان انتخاب کنید';
  }

  @override
  String get confirmAppPinHint => 'برای تأیید PIN را دوباره وارد کنید';

  @override
  String get appPinMismatch => 'PINها مطابقت ندارند. دوباره تلاش کنید.';

  @override
  String get appPinIncorrect => 'PIN نادرست است. دوباره تلاش کنید.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN نادرست است. $remaining تلاش باقی مانده.';
  }

  @override
  String get appPinLockoutMessage =>
      'تلاش‌های PIN نادرست بیش از حد بود. برای بازنشانی PIN با ایمیل و رمز عبور وارد شوید.';

  @override
  String get appPinSetSuccess => 'PIN برای این سازمان ذخیره شد';

  @override
  String get appPinRemoved => 'PIN برنامه حذف شد';

  @override
  String get appLockSettingsSaved => 'تنظیمات قفل برنامه ذخیره شد';

  @override
  String get biometricUnlockReason => 'باز کردن BizTrack';

  @override
  String get biometricNotAvailable => 'بیومتریک در این دستگاه در دسترس نیست';

  @override
  String get biometricRequiresPin =>
      'قبل از فعال‌سازی بیومتریک، PIN برنامه را تنظیم کنید';

  @override
  String get disableAppPinTitle => 'PIN برنامه حذف شود؟';

  @override
  String get disableAppPinMessage =>
      'Face ID / باز کردن بیومتریک نیز برای این سازمان غیرفعال می‌شود.';

  @override
  String get verifyPinToRemoveTitle => 'PIN خود را وارد کنید';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'برای حذف قفل برنامه، PIN $length رقمی خود را تأیید کنید';
  }

  @override
  String get unlockApp => 'باز کردن برنامه';

  @override
  String get usePinInstead => 'در عوض از PIN استفاده کن';

  @override
  String get useBiometricInstead => 'استفاده از بیومتریک';

  @override
  String get signInWithFaceId => 'ورود با Face ID';

  @override
  String get signInWithFingerprint => 'ورود با اثر انگشت';

  @override
  String get signInWithBiometric => 'ورود با بیومتریک';

  @override
  String get signInWithPin => 'ورود با PIN';

  @override
  String get setUpQuickUnlock => 'تنظیم ورود سریع با PIN';

  @override
  String get setUpFaceIdOrPin => 'تنظیم Face ID یا PIN';

  @override
  String get setUpFingerprintOrPin => 'تنظیم اثر انگشت یا PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'از بیومتریک یا PIN برای این سازمان استفاده کنید';

  @override
  String quickUnlockAsUser(String email) {
    return 'ورود سریع به عنوان $email';
  }

  @override
  String get orContinueWithPassword => 'یا ورود با رمز عبور';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'ورود سریع فعال شود؟';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'برای ورود سریع‌تر دفعه بعد Face ID، اثر انگشت یا PIN تنظیم کنید. بعداً در تنظیمات هم می‌توانید تغییر دهید.';

  @override
  String get notNow => 'الان نه';

  @override
  String get setUpNow => 'همین حالا تنظیم کن';

  @override
  String get enableFaceIdTitle => 'Face ID فعال شود؟';

  @override
  String get enableFingerprintTitle => 'اثر انگشت فعال شود؟';

  @override
  String get enableBiometricTitle => 'بیومتریک فعال شود؟';

  @override
  String get enableBiometricAfterPinMessage =>
      'برای ورود سریع‌تر از بیومتریک دستگاه همراه با PIN استفاده کنید.';

  @override
  String get useFaceIdUnlock => 'استفاده از Face ID';

  @override
  String get useFingerprintUnlock => 'استفاده از اثر انگشت';

  @override
  String get ok => 'تأیید';

  @override
  String get reportPeriodYear => 'سال';

  @override
  String get reportPeriodMonth => 'ماه';

  @override
  String get reportPeriodRange => 'بازه';

  @override
  String get reportPeriodDay => 'روز';

  @override
  String get reportPeriodFrom => 'از';

  @override
  String get reportPeriodTo => 'تا';

  @override
  String get reportPeriod => 'دوره';

  @override
  String get reportAllPurchases => 'همه خریدها';

  @override
  String get reportBeforeTax => 'قبل از مالیات';

  @override
  String get reportRevenueRetained => 'درآمد باقی‌مانده';

  @override
  String get reportHideDetails => 'پنهان کردن جزئیات';

  @override
  String get reportShowDetails => 'نمایش جزئیات';

  @override
  String get reportSalesRevenue => 'درآمد فروش';

  @override
  String get reportDiscountsGiven => 'تخفیف‌های اعمال‌شده';

  @override
  String get reportNetRevenue => 'درآمد خالص';

  @override
  String get reportOperatingExpenses => 'هزینه‌های عملیاتی';

  @override
  String get reportTotalExpenses => 'کل هزینه‌ها';

  @override
  String get reportGrossProfit => 'سود ناخالص';

  @override
  String get reportGrossProfitChart => 'سود ناخالص';

  @override
  String get reportOperatingPlDisclaimer =>
      'مالیات، استهلاک و بدهی حقوق هنوز لحاظ نشده — تقریب P&L عملیاتی.';

  @override
  String get reportContraLabel => 'کنترا';

  @override
  String get reportNoDataForPeriod => 'داده‌ای برای دوره انتخاب‌شده نیست';

  @override
  String get reportRevenueVsExpenses => 'درآمد در برابر هزینه';

  @override
  String get reportExpenseBreakdown => 'تفکیک هزینه';

  @override
  String get reportExpenseFallback => 'هزینه';

  @override
  String get reportGrossMarginPercent => 'حاشیه ناخالص %';

  @override
  String get reportRoomVsFnB => 'اتاق در برابر F&B';

  @override
  String get reportSegmentRoom => 'اتاق';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'شاخص‌های کلیدی';

  @override
  String get reportIncomeStatement => 'صورت سود و زیان';

  @override
  String get reportChartsSection => 'نمودارها';

  @override
  String get reportSegmentSummary => 'خلاصه بخش';

  @override
  String get reportFailedToLoad => 'بارگذاری گزارش ناموفق';

  @override
  String get reportOverview => 'نمای کلی';

  @override
  String get reportOverviewCash => 'نقد';

  @override
  String get reportOverviewBank => 'بانک';

  @override
  String get reportMonthlyOpeningBalance => 'مانده افتتاحیه ماهانه';

  @override
  String get reportOpeningBalanceHint => 'وضعیت نقد در ابتدای هر ماه';

  @override
  String get reportCashInOut => 'ورود / خروج نقد';

  @override
  String get reportCashIn => 'ورود نقد';

  @override
  String get reportCashOut => 'خروج نقد';

  @override
  String get reportBankReceiptsPayments => 'دریافت / پرداخت بانکی';

  @override
  String get reportReceipts => 'دریافت‌ها';

  @override
  String get reportPayments => 'پرداخت‌ها';

  @override
  String get reportDailyCashVsQr => 'نقد روزانه در برابر QR';

  @override
  String get reportSummariesSection => 'خلاصه‌ها';

  @override
  String get reportCashSummary => 'خلاصه نقد';

  @override
  String get reportBankSummary => 'خلاصه بانک';

  @override
  String get reportDailySummary => 'خلاصه روزانه';

  @override
  String get reportTabPurchase => 'خرید';

  @override
  String get reportTabSales => 'فروش';

  @override
  String get reportTabDashboard => 'داشبورد';

  @override
  String get reportSingleDayTrend => 'یک روز — روند روزانه';

  @override
  String get reportFullYearTrend => 'کل سال — نمودار روند ماهانه';

  @override
  String reportYearLabel(String year) {
    return 'سال $year';
  }

  @override
  String reportJanDec(String year) {
    return 'ژان – دس $year';
  }

  @override
  String get reportTotalPurchases => 'کل خریدها';

  @override
  String get reportTotalSales => 'کل فروش';

  @override
  String get reportTotalInvoices => 'کل فاکتورها';

  @override
  String get reportUnpaidBalance => 'مانده پرداخت‌نشده';

  @override
  String get reportAvgPerInvoice => 'میانگین هر فاکتور';

  @override
  String get reportPerTransaction => 'به ازای هر تراکنش';

  @override
  String reportMonthlySpend(String symbol) {
    return 'هزینه ماهانه ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'فروش ماهانه ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'تعداد فاکتور به تفکیک ماه';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'برترین اقلام بر اساس هزینه ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'هزینه به تفکیک دسته';

  @override
  String get reportOtherCategory => 'سایر';

  @override
  String get reportSuppliers => 'تأمین‌کنندگان';

  @override
  String get reportTableSupplier => 'تأمین‌کننده';

  @override
  String get reportTableAmount => 'مبلغ';

  @override
  String get reportTableBills => 'صورتحساب‌ها';

  @override
  String get reportSalesTotal => 'کل فروش';

  @override
  String get reportPurchaseTotal => 'کل خرید';

  @override
  String get reportPositiveMargin => 'حاشیه مثبت';

  @override
  String get reportNegativeMargin => 'حاشیه منفی';

  @override
  String get reportGrossMargin => 'حاشیه ناخالص';

  @override
  String get reportOfTotalSales => 'از کل فروش';

  @override
  String get reportFailedToLoadAnalytics => 'بارگذاری تحلیل ناموفق';

  @override
  String get reportMarginKpi => 'حاشیه';

  @override
  String get reportExpensesKpi => 'هزینه‌ها';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'نتیجه‌ای برای \"$query\" نیست';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'هیچ طرف $role یافت نشد';
  }

  @override
  String get partyPickerLoadParties => 'بارگذاری طرف‌ها';

  @override
  String get invoiceCashCustomer => 'مشتری نقدی';

  @override
  String get invoiceQuickAddItemsTitle => 'افزودن سریع اقلام';

  @override
  String get invoiceQuickLoadingMenu => 'در حال بارگذاری منو…';

  @override
  String get invoiceQuickInvoiceCreated => 'فاکتور ایجاد شد';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'حداقل یک قلم اضافه کنید';

  @override
  String get invoiceQuickNoResults => 'نتیجه‌ای یافت نشد!';

  @override
  String get invoiceQuickNoItemsInCategory => 'قلمی در این دسته نیست';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'افزودن قلم';

  @override
  String get invoiceQuickLoadMore => 'بارگذاری بیشتر';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'برای بارگذاری بیشتر اسکرول ($count در صفحه)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'تأمین‌کننده / کارمند';

  @override
  String get invoiceQuickEditItem => 'ویرایش قلم';

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
  String get closeSelectDateRange => 'انتخاب بازه تاریخ';

  @override
  String get closeStartDate => 'تاریخ شروع';

  @override
  String get closeEndDate => 'تاریخ پایان';

  @override
  String get closeSelectBothDates => 'لطفاً تاریخ شروع و پایان را انتخاب کنید';

  @override
  String get closeDeleteSummary => 'حذف خلاصه';

  @override
  String get closeDeleteSummaryConfirm =>
      'آیا مطمئن هستید که می‌خواهید این خلاصه را حذف کنید؟';

  @override
  String get closeSelectDate => 'انتخاب تاریخ';

  @override
  String get closeNoDataToExport => 'داده‌ای برای صادرات نیست';

  @override
  String get closeNoDataToShare => 'داده‌ای برای اشتراک‌گذاری نیست';

  @override
  String get closeNoDataToPrint => 'داده‌ای برای چاپ نیست';

  @override
  String closePdfGenerateError(String error) {
    return 'خطا در ایجاد PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'خطا در اشتراک PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'خطا در چاپ PDF: $error';
  }

  @override
  String get closeExportPdf => 'صدور به PDF';

  @override
  String get closeSharePdf => 'اشتراک PDF';

  @override
  String get closePrint => 'چاپ';

  @override
  String get closeExportOptions => 'گزینه‌های صادرات';

  @override
  String get closeExportPdfSubtitle => 'ذخیره یا مشاهده به‌صورت PDF';

  @override
  String get closeSharePdfSubtitle => 'اشتراک از طریق برنامه یا ایمیل';

  @override
  String get closePrintSubtitle => 'چاپ گزارش';

  @override
  String get closeDailyCashSummaryTitle => 'خلاصه نقد روزانه';

  @override
  String get closeDailyCashSummaryReport => 'گزارش خلاصه نقد روزانه';

  @override
  String closeGeneratedAt(String date) {
    return 'ایجاد: $date';
  }

  @override
  String get closeTotalRecords => 'کل رکوردها';

  @override
  String get closeSummaryOverview => 'نمای کلی خلاصه';

  @override
  String get closeAllRecords => 'همه رکوردها';

  @override
  String closePeriodRange(String start, String end) {
    return 'دوره: از $start تا $end';
  }

  @override
  String get closeDetails => 'جزئیات';

  @override
  String closePageN(int n) {
    return 'صفحه $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'نمایش $shown از $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'بارگذاری: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'اتاق / کابین / کارمند';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent% از درآمد';
  }

  @override
  String get reportParties => 'طرف‌ها';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — نمودار روند روزانه';
  }

  @override
  String get invoiceQuickCart => 'سبد';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'سبد ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'پاک کردن جستجو';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'افزودن خلاصه';

  @override
  String get closeSalesAmount => 'مبلغ فروش';

  @override
  String get closeClosingBalance => 'مانده پایانی';

  @override
  String get closeLostMoney => 'پول گم‌شده';

  @override
  String get closeDiscount => 'تخفیف';

  @override
  String get closeExpenses => 'هزینه‌ها';

  @override
  String get closeUnpaid => 'پرداخت‌نشده';

  @override
  String get closeTotalOpeningBalance => 'مجموع مانده اولیه';

  @override
  String get closeTotalSalesAmount => 'مجموع مبلغ فروش';

  @override
  String get closeTotalCashAmount => 'مجموع نقد';

  @override
  String get closeTotalQrAmount => 'مجموع QR';

  @override
  String get closeTotalDiscount => 'مجموع تخفیف';

  @override
  String get closeTotalExpenses => 'مجموع هزینه‌ها';

  @override
  String get closeTotalClosingBalance => 'مجموع مانده پایانی';

  @override
  String get closeTotalLostMoney => 'مجموع پول گم‌شده';

  @override
  String get closeTotalExtraAmount => 'مجموع مبلغ اضافی';

  @override
  String get closeShowingCurrentMonth => 'نمایش داده‌های ماه جاری';

  @override
  String get closeNoSummariesFound => 'خلاصه‌ای یافت نشد';

  @override
  String get closeNoSummariesAvailable => 'خلاصه‌ای موجود نیست';

  @override
  String get closeTryAdjustingDateRange => 'بازه تاریخ را تنظیم کنید';

  @override
  String get closeCreateFirstSummary => 'اولین خلاصه را برای شروع بسازید';

  @override
  String get closeClearFilter => 'پاک کردن فیلتر';

  @override
  String get closeFiltered => 'فیلتر شده';

  @override
  String closeFilteredWithRange(String range) {
    return 'فیلتر: $range';
  }

  @override
  String get closeSummarySingular => 'خلاصه';

  @override
  String get closeSummariesPlural => 'خلاصه‌ها';

  @override
  String get closeSummaryUpdatedSuccess => 'خلاصه با موفقیت به‌روزرسانی شد';

  @override
  String get closeSummaryDeletedSuccess => 'خلاصه با موفقیت حذف شد';

  @override
  String premiumUnlockTitle(String appName) {
    return 'باز کردن $appName Premium';
  }

  @override
  String get premiumTagline =>
      'صندوق فروش آفلاین کامل، فاکتور، موجودی و گزارش — یک اشتراک برای کسب‌وکار شما.';

  @override
  String get premiumFeatureUnlimitedInvoices => 'فاکتور و رسید نامحدود';

  @override
  String get premiumFeatureInventoryStock => 'ردیابی موجودی و انبار';

  @override
  String get premiumFeatureReportsAnalytics => 'گزارش فروش و تحلیل';

  @override
  String get premiumFeatureOfflineLocal =>
      'آفلاین کار می‌کند — داده‌های شما محلی می‌ماند';

  @override
  String premiumContinueWith(String plan) {
    return 'ادامه با $plan';
  }

  @override
  String get premiumRestorePurchases => 'بازیابی خریدها';

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
      'پرداخت از Apple ID شما کسر می‌شود. اشتراک‌ها خودکار تمدید می‌شوند مگر حداقل ۲۴ ساعت قبل از پایان دوره لغو شوند.';

  @override
  String get premiumPurchaseRestored => 'خرید بازیابی شد.';

  @override
  String get premiumNoActiveSubscription => 'اشتراک فعالی یافت نشد.';

  @override
  String get premiumPlanMonthly => 'ماهانه';

  @override
  String get premiumPlanMonthlySubtitle => 'انعطاف‌پذیر — هر زمان لغو کنید';

  @override
  String get premiumPlanYearly => 'سالانه';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'بهترین ارزش — $percent٪ صرفه‌جویی';
  }

  @override
  String get premiumPlanLifetime => 'مادام‌العمر';

  @override
  String get premiumPlanLifetimeSubtitle => 'یک‌بار پرداخت، برای همیشه';

  @override
  String get premiumPlanPopular => 'محبوب';

  @override
  String get premiumOneTimePurchase => 'خرید یک‌باره';

  @override
  String get subscriptionSectionTitle => 'اشتراک';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'ارتقا به Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'ماهانه $monthly · سالانه $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan فعال تا $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan فعال';
  }

  @override
  String get premiumRequired => 'Premium لازم است';

  @override
  String get upgradeToPremiumContinue => 'برای ادامه به Premium ارتقا دهید.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'طرح رایگان تا $limit $label مجاز است. برای دسترسی نامحدود به Premium ارتقا دهید.';
  }

  @override
  String get freemiumPartyRoleRequired => 'نقش طرف الزامی است.';

  @override
  String get freemiumLabelSalesInvoices => 'فاکتور فروش';

  @override
  String get freemiumLabelPurchaseInvoices => 'فاکتور خرید';

  @override
  String get freemiumLabelEmployees => 'کارمند';

  @override
  String get freemiumLabelItems => 'قلم';

  @override
  String get freemiumLabelCategories => 'دسته';

  @override
  String get freemiumLabelPaymentMethods => 'روش پرداخت';

  @override
  String get freemiumLabelCustomPartyRoles => 'نقش طرف سفارشی';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'طرف برای $role';
  }

  @override
  String get freemiumLabelOrganizations => 'سازمان';

  @override
  String get freemiumPremiumReports => 'گزارش‌ها با Premium در دسترس است.';

  @override
  String get freemiumPremiumBackupSync =>
      'پشتیبان‌گیری و همگام‌سازی Premium می‌خواهد.';

  @override
  String get freemiumPremiumPayroll => 'حقوق Premium می‌خواهد.';

  @override
  String get freemiumPremiumAttendance => 'حضور Premium می‌خواهد.';

  @override
  String get freemiumPremiumStock => 'مدیریت موجودی Premium می‌خواهد.';

  @override
  String get freemiumPremiumInvoiceExport => 'دانلود و چاپ Premium می‌خواهد.';

  @override
  String get shiftReminderOpeningTitle => 'یادآور باز کردن';

  @override
  String get shiftReminderOpeningMessage => 'آیا صندوق امروز را باز کردید؟';

  @override
  String get shiftReminderOpeningProceed => 'بله، الان باز کن';

  @override
  String get shiftReminderClosingTitle => 'یادآور بستن';

  @override
  String get shiftReminderClosingMessage => 'آیا صندوق امروز را بستید؟';

  @override
  String get shiftReminderClosingProceed => 'بله، الان ببند';

  @override
  String get shiftReminderSkipToday => 'امروز رد شود';

  @override
  String get shiftReminderOpeningNotificationTitle => 'یادآور باز کردن';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'آیا صندوق امروز را باز کردید؟ اگر هنوز باید باز کنید اینجا بزنید.';

  @override
  String get shiftReminderClosingNotificationTitle => 'یادآور بستن';

  @override
  String get shiftReminderClosingNotificationBody =>
      'آیا صندوق امروز را بستید؟ اگر هنوز باید ببندید اینجا بزنید.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business به مشتری QR می‌پردازد؛ مشتری نقد می‌دهد.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business به مشتری نقد می‌پردازد؛ مشتری QR پرداخت می‌کند.';
  }

  @override
  String get closePaymentExchange => 'تبادل پرداخت';

  @override
  String get closePayQrGetCashExchangeLabel => 'پرداخت QR ← دریافت نقد (تبادل)';

  @override
  String get closePayCashGetQrExchangeLabel => 'پرداخت نقد ← دریافت QR (تبادل)';

  @override
  String get closePayQrGetCashDetail => 'QR بده، نقد بگیر';

  @override
  String get closePayCashGetQrDetail => 'نقد بده، QR بگیر';

  @override
  String get faqSectionPremium => 'Premium و صورتحساب';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium چه شامل می‌شود؟';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium فاکتور نامحدود، گزارش کامل (سود و زیان، صورت‌حساب، تحلیل)، پشتیبان‌گیری و همگام‌سازی، حقوق، حضور، ابزار موجودی، خروجی/چاپ فاکتور و سازمان‌های اضافی را باز می‌کند. سطح رایگان همچنان امکان استفاده از POS اصلی در محدودیت‌های منصفانه را می‌دهد.';

  @override
  String get faqPremiumFreeTierQuestion => 'سطح رایگان چه شامل می‌شود؟';

  @override
  String get faqPremiumFreeTierAnswer =>
      'می‌توانید تا ۱۰ فاکتور فروش و ۱۰ فاکتور خرید، ۴ کارمند، ۳۰ قلم و محدودیت‌های دیگر ایجاد کنید. باز کردن، بستن، ماشین‌حساب و مرور داده رایگان می‌ماند.';

  @override
  String get faqPremiumRestoreQuestion => 'چگونه خرید را بازیابی کنم؟';

  @override
  String get faqPremiumRestoreAnswer =>
      'بیشتر ← ارتقا به Premium (یا صفحه پرداخت) را باز کنید و بازیابی خریدها را بزنید. همان Apple ID اشتراک را استفاده کنید.';

  @override
  String get faqPremiumCancelQuestion => 'چگونه اشتراک را لغو کنم؟';

  @override
  String get faqPremiumCancelAnswer =>
      'در تنظیمات iPhone ← Apple ID ← اشتراک‌ها مدیریت یا لغو کنید. تا پایان دوره پرداخت‌شده دسترسی دارید.';

  @override
  String get faqDarkModeQuestion => 'چگونه حالت تاریک را روشن کنم؟';

  @override
  String get faqDarkModeAnswer =>
      'بیشتر ← ظاهر را باز کنید و حالت تاریک را فعال کنید. وقتی دستگاه از تم سیستم استفاده می‌کند، برنامه خودکار پیروی می‌کند.';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'یادآورهای باز و بسته کردن چیست؟';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName می‌تواند باز یا بستن صندوق روزانه را یادآوری کند. می‌توانید ادامه دهید، امروز رد کنید یا یادآور را ببندید.';
  }

  @override
  String get faqPartyRolesQuestion => 'نقش‌های طرف چیست؟';

  @override
  String get faqPartyRolesAnswer =>
      'نقش‌های طرف مخاطبانی مانند مشتری، تأمین‌کننده، اتاق یا کارمند را دسته‌بندی می‌کنند. در عملیات ← نقش‌های طرف سفارشی کنید و توضیح کوتاه برای تیم اضافه کنید.';

  @override
  String faqRateAppQuestion(String appName) {
    return 'چگونه $appName را امتیاز دهم؟';
  }

  @override
  String get faqRateAppAnswer =>
      'بیشتر ← به ما امتیاز دهید را باز کنید تا در App Store نظر بگذارید. بازخورد شما به بهبود صورتحساب آفلاین کمک می‌کند.';
}
