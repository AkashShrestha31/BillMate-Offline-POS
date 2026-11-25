// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get noInternetConnection => 'ไม่มีการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get formatException => 'ข้อยกเว้นรูปแบบ';

  @override
  String get rememberMe => 'จดจำฉัน';

  @override
  String get signIn => 'เข้าสู่ระบบ';

  @override
  String get passwordHint => 'ใส่รหัสผ่าน';

  @override
  String get forgetPassword => 'ลืมข้อมูลการเข้าสู่ระบบ?';

  @override
  String get okay => 'ตกลง';

  @override
  String get success => 'สำเร็จ';

  @override
  String get hotel => 'โรงแรม';

  @override
  String get errorEncountered => 'พบข้อผิดพลาด';

  @override
  String get serverError => 'ข้อผิดพลาดของเซิร์ฟเวอร์';

  @override
  String get requestFailed => 'คำขอล้มเหลว';

  @override
  String get connectionTimedOut => 'การเชื่อมต่อหมดเวลา';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get keepSignIn => 'คงสถานะเข้าสู่ระบบ';

  @override
  String get enterPassword => 'ใส่รหัสผ่าน';

  @override
  String get enterValidPassword => 'ใส่รหัสผ่านที่ถูกต้อง';

  @override
  String get skip => 'ข้าม';

  @override
  String get pleaseWait => 'กรุณารอสักครู่ ....';

  @override
  String get enterValidUserName => 'ใส่ชื่อผู้ใช้ที่ถูกต้อง';

  @override
  String get userName => 'ชื่อผู้ใช้';

  @override
  String get or => 'หรือ';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get supportMessage => 'กรุณาติดต่อผู้ดูแลระบบ';

  @override
  String get responseMessage404 => 'ข้อผิดพลาด 404';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get yes => 'ใช่';

  @override
  String get no => 'ไม่';

  @override
  String get close => 'ปิด';

  @override
  String get save => 'บันทึก';

  @override
  String get delete => 'ลบ';

  @override
  String get deleteOrganizationTitle => 'ลบองค์กร?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'ลบ $name ออกจากอุปกรณ์นี้ ข้อมูลในเครื่องทั้งหมดขององค์กรนี้จะถูกลบ';
  }

  @override
  String get deleteOrganizationWarning => 'ไม่สามารถยกเลิกการกระทำนี้ได้';

  @override
  String get organizationDeleted => 'ลบองค์กรแล้ว';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get done => 'เสร็จสิ้น';

  @override
  String get next => 'ถัดไป';

  @override
  String get getStarted => 'เริ่มต้น';

  @override
  String get walkthroughDashboardTitle => 'ธุรกิจทั้งหมดในภาพเดียว';

  @override
  String get walkthroughDashboardDescription =>
      'ยอดขายวันนี้ รายได้ และยอดค้าง — ทั้งหมดบนแดชบอร์ดชัดเจนเมื่อเปิดแอป';

  @override
  String get walkthroughOfflineTitle => 'ใช้งานได้แม้ไม่มีอินเทอร์เน็ต';

  @override
  String get walkthroughOfflineDescription =>
      'สร้างใบแจ้งหนี้ บันทึกค่าใช้จ่าย และจัดการสต็อกออฟไลน์ ซิงค์อัตโนมัติเมื่อออนไลน์';

  @override
  String get walkthroughBillingTitle => 'ออกบิลและขายในไม่กี่วินาที';

  @override
  String get walkthroughBillingDescription =>
      'ใบแจ้งหนี้ขายและซื้อ ออร์เดอร์โต๊ะพร้อมตั๋วครัว และสต็อกสด — ทั้งหมดในแอปเดียว';

  @override
  String get walkthroughStaffTitle => 'พนักงาน เงินเดือน และรายงาน';

  @override
  String get walkthroughStaffDescription =>
      'จัดการการเข้างานและเงินเดือน ส่งออก P&L และสลิปเงินเดือนเป็น PDF — ไม่ต้องใช้เครื่องมือเพิ่ม';

  @override
  String get walkthroughBackupTitle => 'ข้อมูลของคุณ ปลอดภัยเสมอ';

  @override
  String get walkthroughBackupDescription =>
      'ความปลอดภัยระดับธนาคารพร้อมสำรอง Google Drive แตะเดียว — ข้อมูลปลอดภัยและกู้คืนง่าย';

  @override
  String get walkthroughReadyTitle => 'พร้อมเมื่อคุณพร้อม';

  @override
  String get walkthroughReadyDescription =>
      'ตั้งองค์กรในไม่กี่นาทีและบริหารธุรกิจอย่างชาญฉลาดตั้งแต่วันนี้ เริ่มกันเลย';

  @override
  String get back => 'กลับ';

  @override
  String get submit => 'ส่ง';

  @override
  String get continueAction => 'ดำเนินการต่อ';

  @override
  String get createAction => 'สร้าง';

  @override
  String get connectOrganizationTitle => 'เชื่อมต่อองค์กรของคุณ';

  @override
  String get connectOrganizationSubtitle => 'เลือกองค์กรเพื่อเข้าสู่ระบบ';

  @override
  String get selectOrganization => 'องค์กร';

  @override
  String get selectOrganizationHint => 'แตะองค์กรเพื่อดำเนินการต่อ';

  @override
  String get noSavedOrganizationsYet =>
      'ยังไม่มีองค์กร สร้างหนึ่งอย่างหรือใช้ข้อมูลทดสอบด้านล่าง';

  @override
  String get orgConnectOnceInfo =>
      'เชื่อมต่อแอปกับบัญชีธุรกิจของคุณ คุณต้องตั้งค่าเพียงครั้งเดียวต่ออุปกรณ์';

  @override
  String organizationCodeLabel(String code) {
    return 'รหัส: $code';
  }

  @override
  String get tryAgain => 'ลองอีกครั้ง';

  @override
  String get warning => 'คำเตือน';

  @override
  String get loading => 'กำลังโหลด…';

  @override
  String get comingSoon => 'เร็วๆ นี้';

  @override
  String get required => 'จำเป็น';

  @override
  String get search => 'ค้นหา';

  @override
  String get add => 'เพิ่ม';

  @override
  String get edit => 'แก้ไข';

  @override
  String get remove => 'ลบออก';

  @override
  String get view => 'ดู';

  @override
  String get export => 'ส่งออก';

  @override
  String get exportAsPdf => 'ส่งออกเป็น PDF';

  @override
  String get sharePdf => 'แบ่งปัน PDF';

  @override
  String get partyExportPdfTooltip => 'ส่งออก PDF';

  @override
  String get import => 'นำเข้า';

  @override
  String get refresh => 'รีเฟรช';

  @override
  String get select => 'เลือก';

  @override
  String get upload => 'อัปโหลด';

  @override
  String get download => 'ดาวน์โหลด';

  @override
  String get share => 'แชร์';

  @override
  String get filter => 'กรอง';

  @override
  String get sort => 'จัดเรียง';

  @override
  String get apply => 'ใช้งาน';

  @override
  String get reset => 'รีเซ็ต';

  @override
  String get clear => 'ล้าง';

  @override
  String get all => 'ทั้งหมด';

  @override
  String get none => 'ไม่มี';

  @override
  String get total => 'รวม';

  @override
  String get subtotal => 'ยอดรวมย่อย';

  @override
  String get grandTotal => 'ยอดรวมทั้งหมด';

  @override
  String get amount => 'จำนวนเงิน';

  @override
  String get quantity => 'จำนวน';

  @override
  String get rate => 'ราคา';

  @override
  String get discount => 'ส่วนลด';

  @override
  String get paid => 'ชำระแล้ว';

  @override
  String get unpaid => 'ยังไม่ชำระ';

  @override
  String get credit => 'เครดิต';

  @override
  String get cash => 'เงินสด';

  @override
  String get date => 'วันที่';

  @override
  String get time => 'เวลา';

  @override
  String get name => 'ชื่อ';

  @override
  String get email => 'อีเมล';

  @override
  String get phone => 'โทรศัพท์';

  @override
  String get address => 'ที่อยู่';

  @override
  String get notes => 'บันทึก';

  @override
  String get description => 'คำอธิบาย';

  @override
  String get status => 'สถานะ';

  @override
  String get type => 'ประเภท';

  @override
  String get category => 'หมวดหมู่';

  @override
  String get party => 'คู่ค้า';

  @override
  String get item => 'รายการ';

  @override
  String get payment => 'การชำระเงิน';

  @override
  String get settlement => 'การชำระบัญชี';

  @override
  String get opening => 'ยอดเปิด';

  @override
  String get closing => 'ยอดปิด';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'ค่าใช้จ่าย';

  @override
  String get revenue => 'รายได้';

  @override
  String get profit => 'กำไร';

  @override
  String get loss => 'ขาดทุน';

  @override
  String get sales => 'การขาย';

  @override
  String get purchase => 'ซื้อ';

  @override
  String get monthJan => 'ม.ค.';

  @override
  String get monthFeb => 'ก.พ.';

  @override
  String get monthMar => 'มี.ค.';

  @override
  String get monthApr => 'เม.ย.';

  @override
  String get monthMay => 'พ.ค.';

  @override
  String get monthJun => 'มิ.ย.';

  @override
  String get monthJul => 'ก.ค.';

  @override
  String get monthAug => 'ส.ค.';

  @override
  String get monthSep => 'ก.ย.';

  @override
  String get monthOct => 'ต.ค.';

  @override
  String get monthNov => 'พ.ย.';

  @override
  String get monthDec => 'ธ.ค.';

  @override
  String get more => 'เพิ่มเติม';

  @override
  String get profile => 'โปรไฟล์';

  @override
  String get operations => 'ปฏิบัติการ';

  @override
  String get operationManagement => 'การจัดการปฏิบัติการ';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'การจัดการพนักงาน';

  @override
  String get employeeManagementSubtitle => 'พนักงาน เงินเดือน และการเข้างาน';

  @override
  String get report => 'รายงาน';

  @override
  String get reportSubtitle => 'กำไรขาดทุน งบ และการวิเคราะห์';

  @override
  String get helpAndSupport => 'ช่วยเหลือและสนับสนุน';

  @override
  String get preferences => 'การตั้งค่า';

  @override
  String get dataAndBackup => 'ข้อมูลและสำรอง';

  @override
  String get privacyAndPolicies => 'ความเป็นส่วนตัวและนโยบาย';

  @override
  String get faq => 'คำถามที่พบบ่อย';

  @override
  String get contactSupport => 'ติดต่อฝ่ายสนับสนุน';

  @override
  String get rateUs => 'ให้คะแนนเรา';

  @override
  String get rateUsSubtitle => 'ชอบ BizTrack ไหม? ฝากรีวิวไว้ใน Google Play';

  @override
  String get rateUsUnavailable => 'ไม่สามารถเปิดร้านค้าได้ กรุณาลองใหม่ภายหลัง';

  @override
  String get reportProblem => 'รายงานปัญหา';

  @override
  String get contactUs => 'ติดต่อเรา';

  @override
  String get contactUsSubtitle => 'สนับสนุน ข้อเสนอแนะ หรือคำถามเกี่ยวกับแอป';

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
  String get developerLabel => 'นักพัฒนา';

  @override
  String get emailCopiedToClipboard => 'คัดลอกอีเมลไปคลิปบอร์ดแล้ว';

  @override
  String get logout => 'ออกจากระบบ';

  @override
  String get signOut => 'ออกจากระบบ';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get testData => 'ข้อมูลทดสอบ';

  @override
  String get loginWithTestData => 'เข้าสู่ระบบด้วยข้อมูลทดสอบ';

  @override
  String get loginWithTestDataSubtitle =>
      'โหลดข้อมูลโรงแรมเดโมและเข้าสู่ระบบอัตโนมัติ';

  @override
  String testDataLoginFailed(String error) {
    return 'ไม่สามารถโหลดข้อมูลทดสอบ: $error';
  }

  @override
  String get preparingTestData => 'กำลังเตรียมข้อมูลเดโม…';

  @override
  String get regionAndCurrency => 'ภูมิภาคและสกุลเงิน';

  @override
  String get reportingCurrency => 'สกุลเงินรายงาน';

  @override
  String get selectCurrency => 'เลือกสกุลเงิน';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · ตัวอย่าง $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'ตั้งค่าสกุลเงินเป็น $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'ไม่สามารถอัปเดตสกุลเงิน: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'ตั้งค่า $appName';
  }

  @override
  String get setupSubtitle =>
      'กำหนดค่าองค์กรและการบัญชีของคุณ — เก็บไว้ในอุปกรณ์นี้สำหรับใช้งานออฟไลน์';

  @override
  String get setupOrganizationName => 'ชื่อองค์กร';

  @override
  String get setupCompanyName => 'ชื่อบริษัท';

  @override
  String get setupBusinessType => 'ประเภทธุรกิจ';

  @override
  String get selectBusinessType => 'เลือกประเภทธุรกิจ';

  @override
  String get businessTypeHotel => 'โรงแรม';

  @override
  String get businessTypeHotelSubtitle => 'ห้องพัก แขก และแผนกต้อนรับ';

  @override
  String get businessTypeRestaurant => 'ร้านอาหาร';

  @override
  String get businessTypeRestaurantSubtitle => 'สั่งอาหารในครัวและโต๊ะ';

  @override
  String get businessTypeHotelRestaurant => 'โรงแรมและร้านอาหาร';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'ห้องพักในโรงแรมและร้านอาหารด้วยกัน';

  @override
  String get businessTypeRetail => 'ค้าปลีก / ร้านค้า';

  @override
  String get businessTypeRetailSubtitle => 'สินค้า สต๊อก และชำระเงิน';

  @override
  String get businessTypeCafe => 'คาเฟ่ / เบเกอรี่';

  @override
  String get businessTypeCafeSubtitle => 'กาแฟ ขนมอบ และอาหารว่าง';

  @override
  String get businessTypeBar => 'บาร์ / พับ';

  @override
  String get businessTypeBarSubtitle => 'ขายเมนูเครื่องดื่ม แท็บ & บาร์';

  @override
  String get businessTypeOther => 'อื่นๆ';

  @override
  String get businessTypeOtherSubtitle =>
      'การตั้งค่าแบบกำหนดเองสำหรับธุรกิจต่างๆ';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'ประเภท: $type';
  }

  @override
  String get organizationSettings => 'องค์กร';

  @override
  String get editOrganizationInfo => 'ข้อมูลองค์กร';

  @override
  String get editOrganizationInfoSubtitle =>
      'อัปเดตวิธีที่ธุรกิจนี้แสดงในแอป รหัสองค์กรไม่สามารถเปลี่ยนได้';

  @override
  String get organizationCode => 'รหัสองค์กร';

  @override
  String get organizationCodeReadOnly => 'รหัสนี้จะถูกกำหนดหลังการตั้งค่า';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'บันทึกข้อมูลองค์กรแล้ว';

  @override
  String get organizationInfoLoadFailed => 'ไม่สามารถโหลดข้อมูลองค์กรได้';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'ไม่สามารถบันทึกข้อมูลองค์กรได้: $error';
  }

  @override
  String get organizationTabGeneral => 'ทั่วไป';

  @override
  String get organizationTabRegional => 'ภูมิภาคและงบประมาณ';

  @override
  String get organizationRegionalSubtitle =>
      'ประเทศ สกุลเงินรายงาน และวันที่ปีงบประมาณ';

  @override
  String get organizationTabAccounting => 'บัญชี';

  @override
  String get organizationAccountingSubtitle =>
      'การตั้งค่าใบแจ้งหนี้และการแสดงจำนวนเงิน';

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
  String get displayPrecision => 'ความละเอียดการแสดงผล';

  @override
  String get displayPrecisionRange => 'ใส่ตัวเลข 0 ถึง 5';

  @override
  String get enableInvoiceReturns => 'เปิดการคืนใบแจ้งหนี้';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'อนุญาตสร้างการคืนจากใบแจ้งหนี้ที่ชำระแล้ว';

  @override
  String get saveChanges => 'บันทึกการเปลี่ยนแปลง';

  @override
  String get setupFullName => 'ชื่อ-นามสกุล';

  @override
  String get setupConfirmPassword => 'ยืนยันรหัสผ่าน';

  @override
  String get setupBankName => 'ชื่อธนาคาร';

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
  String get setupRegionStepTitle => 'ภูมิภาคและสกุลเงิน';

  @override
  String get setupOrganizationStepTitle => 'องค์กร';

  @override
  String get setupOrganizationStepSubtitle => 'ลักษณะธุรกิจของคุณในแอป';

  @override
  String get setupAdminStepTitle => 'บัญชีผู้ดูแลระบบ';

  @override
  String get setupAdminStepSubtitle => 'ผู้ใช้หลักสำหรับการติดตั้งนี้';

  @override
  String get setupAccountingStepTitle => 'การบัญชี';

  @override
  String get setupAccountingStepSubtitle => 'ธนาคาร แผนผังบัญชี และปีการเงิน';

  @override
  String get setupCompleteSetup => 'ตั้งค่าให้เสร็จสิ้น';

  @override
  String fieldRequired(String field) {
    return 'จำเป็นต้องระบุ $field';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'กรอกที่อยู่อีเมลที่ถูกต้อง';

  @override
  String passwordMinLength(int min) {
    return 'รหัสผ่านต้องมีอย่างน้อย $min ตัวอักษร';
  }

  @override
  String get passwordsDoNotMatch => 'รหัสผ่านไม่ตรงกัน';

  @override
  String get setupFixValidationErrors =>
      'กรุณาแก้ไขข้อผิดพลาดด้านล่างเพื่อดำเนินการต่อ';

  @override
  String get setupCompleteSuccess => 'ตั้งค่าเสร็จสมบูรณ์';

  @override
  String get setupCompleteWithPdfSuccess =>
      'ตั้งค่าเสร็จสิ้น บันทึก PDF ไว้ในที่ปลอดภัย';

  @override
  String setupPdfFailed(String error) {
    return 'ตั้งค่าเสร็จสิ้นแล้ว แต่ไม่สามารถบันทึก PDF ได้: $error';
  }

  @override
  String get setupFailed => 'ไม่สามารถตั้งค่าให้เสร็จสิ้น กรุณาลองอีกครั้ง';

  @override
  String setupFailedWithDetails(String error) {
    return 'การตั้งค่าล้มเหลว: $error';
  }

  @override
  String get regionAndCurrencySubtitle =>
      'การตั้งค่าท้องถิ่นและสกุลเงินสำหรับรายงาน';

  @override
  String get country => 'ประเทศ';

  @override
  String get currency => 'สกุลเงิน';

  @override
  String get selectCountry => 'เลือกประเทศ';

  @override
  String get language => 'ภาษา';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String get languageChangeLaterHint =>
      'คุณสามารถเปลี่ยนได้ภายหลังจากการตั้งค่า';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'เลือกวิธีที่คุณต้องการใช้ $appName คุณสามารถเปลี่ยนได้ภายหลังในการตั้งค่า';
  }

  @override
  String get searchLanguages => 'ค้นหาภาษา';

  @override
  String get languageSuggestedBadge => 'แนะนำ';

  @override
  String continueInLanguage(String languageName) {
    return 'ดำเนินการต่อใน $languageName';
  }

  @override
  String get noLanguageMatches => 'ไม่พบรายการที่ตรงกัน';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'ไม่มีภาษาที่ตรงกับ \"$query\"';
  }

  @override
  String get appearance => 'รูปลักษณ์';

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get darkModeSubtitle => 'ใช้พื้นหลังมืดทั่วแอป';

  @override
  String get darkModeSystemSubtitle => 'ตามธีมของอุปกรณ์';

  @override
  String languageUpdated(String name) {
    return 'ตั้งค่าภาษาเป็น $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'ไม่สามารถอัปเดตภาษา: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'ยินดีต้อนรับสู่ $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'กรุณาติดตั้ง $appName เวอร์ชันล่าสุดเพื่อดำเนินการต่อ';
  }

  @override
  String generatedByApp(String appName) {
    return 'สร้างโดย $appName';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName คืออะไร?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName ช่วยให้คุณจัดการใบแจ้งหนี้การขายและการซื้อ คู่ค้า (ลูกค้าและซัพพลายเออร์) สินค้าคงคลัง การชำระเงิน พนักงาน และสรุปประจำวัน — จากโทรศัพท์หรือแท็บเล็ตของคุณ';
  }

  @override
  String faqIntro(String appName) {
    return 'คำตอบสำหรับคำถามทั่วไปเกี่ยวกับ $appName';
  }

  @override
  String get chooseFromGallery => 'เลือกจากคลังภาพ';

  @override
  String get takePhoto => 'ถ่ายภาพ';

  @override
  String get photoLibrary => 'คลังรูปภาพ';

  @override
  String get addPhoto => 'เพิ่มรูปภาพ';

  @override
  String couldNotPickImage(String error) {
    return 'ไม่สามารถเลือกรูปภาพ: $error';
  }

  @override
  String get unpaidAmount => 'ยังไม่ชำระ จำนวนเงิน';

  @override
  String get unpaidBalance => 'ยังไม่ชำระ';

  @override
  String unpaidColonAmount(String amount) {
    return 'ยังไม่ชำระ: $amount';
  }

  @override
  String get previousUnpaid => 'ยังไม่ชำระ';

  @override
  String get partyUnpaid => 'ยังไม่ชำระ';

  @override
  String get loadingUnpaid => 'ยังไม่ชำระ…';

  @override
  String get totalUnpaid => 'ยังไม่ชำระ';

  @override
  String get unpaidAmountNotYetCollected => 'ยอดค้างชำระยังไม่ได้รับ';

  @override
  String get partyUnpaidTabHint =>
      'เปิดพนักงาน เลือกบุคคล แล้วแตะยอดค้างของคู่สัญญาในโปรไฟล์ เซิร์ฟเวอร์ต้องการ ID พนักงานสำหรับการค้นหานี้';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'การชำระของคู่สัญญาใช้ยอดรวมที่ค้างชำระ';

  @override
  String get selectPartyWithUnpaidFirst =>
      'ป้อนยอดการชำระก่อน (หรือเลือกคู่สัญญาที่มียอดค้าง)';

  @override
  String get workspace => 'พื้นที่ทำงาน';

  @override
  String get change => 'เปลี่ยน';

  @override
  String get addMoreOrganization => 'เพิ่มเติม +';

  @override
  String get connectAnotherOrganization => 'เชื่อมต่อองค์กรอื่น';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'ยังไม่มีองค์กรที่บันทึกไว้ ใช้เพิ่มเติม + เพื่อเชื่อมต่อ';

  @override
  String get registerNewOrganizationTitleSignedIn => 'ลงทะเบียนองค์กรใหม่?';

  @override
  String get registerNewOrganizationTitle => 'ลงทะเบียนองค์กรใหม่?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'คุณจะออกจากระบบและวิซาร์ดการตั้งค่าจะเริ่มต้นใหม่เพื่อให้คุณลงทะเบียนธุรกิจใหม่บนอุปกรณ์นี้\n\nองค์กรที่บันทึกไว้แล้วจะยังคงอยู่ในรายการหลังการตั้งค่า';

  @override
  String get registerNewOrganizationMessageLogin =>
      'วิซาร์ดการตั้งค่าจะเริ่มเพื่อให้คุณลงทะเบียนธุรกิจใหม่บนอุปกรณ์นี้ ทำการตั้งค่าให้เสร็จสิ้นเพื่อสร้าง; องค์กรที่บันทึกยังคงอยู่ในรายการ';

  @override
  String get startSetup => 'เริ่มการตั้งค่า';

  @override
  String get enterOrganizationCode => 'กรุณาป้อนรหัสองค์กรของคุณ';

  @override
  String get organizationNotFoundCheckCode =>
      'ไม่พบองค์กร ตรวจสอบรหัสและลองอีกครั้ง';

  @override
  String get organizationNotFound => 'ไม่พบองค์กร';

  @override
  String get couldNotVerifyOrganization => 'ไม่สามารถยืนยันองค์กรได้';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'ไม่มีข้อมูลในเครื่องสำหรับ $name กรุณาทำการตั้งค่าองค์กรนี้ก่อน';
  }

  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับ';

  @override
  String get signInToContinue => 'ลงชื่อเข้าใช้เพื่อดำเนินการต่อ';

  @override
  String get enterEmail => 'ป้อนอีเมล';

  @override
  String get pleaseEnterEmail => 'กรุณาป้อนอีเมลของคุณ';

  @override
  String get pleaseEnterValidEmail => 'กรุณาป้อนอีเมลที่ถูกต้อง';

  @override
  String get enterEmailLocalPartOnly => 'ป้อนเฉพาะส่วนก่อน @';

  @override
  String get pleaseEnterPassword => 'กรุณาป้อนรหัสผ่านของคุณ';

  @override
  String get logIn => 'เข้าสู่ระบบ';

  @override
  String get searchCountry => 'ค้นหาประเทศ';

  @override
  String get searchCodeOrSymbol => 'ค้นหารหัสหรือสัญลักษณ์';

  @override
  String get saveLoginDetailsTitle => 'บันทึกข้อมูลเข้าสู่ระบบ?';

  @override
  String get saveLoginDetailsMessage =>
      'คุณกำลังจะทำการตั้งค่าองค์กรนี้เสร็จสิ้น\n\nต้องการดาวน์โหลด PDF ที่ประกอบด้วยรหัสองค์กร ชื่อองค์กร อีเมล และรหัสผ่านอย่างปลอดภัยหรือไม่? เก็บไว้ในที่ปลอดภัย — ใครก็ตามที่มีไฟล์นี้สามารถเข้าสู่ระบบได้';

  @override
  String get downloadPdfAndContinue => 'ดาวน์โหลด PDF และดำเนินการต่อ';

  @override
  String get continueWithoutPdf => 'ดำเนินการต่อโดยไม่มี PDF';

  @override
  String get legalDisplayNameHint => 'ชื่อทางกฎหมาย / ชื่อที่แสดง';

  @override
  String get chartOfAccounts => 'ผังบัญชี';

  @override
  String get fiscalYearStart => 'ต้นปีงบประมาณ';

  @override
  String get fiscalYearEnd => 'สิ้นปีงบประมาณ';

  @override
  String get removeTestDataTitle => 'ลบข้อมูลทดสอบ?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'ยอดขายสาธิต การซื้อ ผู้ติดต่อ คู่สัญญา รายการสินค้าคงคลัง เจ้าหน้าที่ ผลิตภัณฑ์เครื่องคิดเลขเครื่องดื่ม และองค์กรสาธิตเพิ่มเติมทั้งหมดจะถูกลบ\n\nคุณอยู่ในองค์กรสาธิต — หลังจากนี้คุณจะถูกเปลี่ยนกลับไปยังองค์กรแรกโดยอัตโนมัติ';

  @override
  String get removeTestDataMessageNormal =>
      'ยอดขายสาธิต การซื้อ ผู้ติดต่อ คู่สัญญา รายการสินค้าคงคลัง เจ้าหน้าที่ และ 3 องค์กรสาธิตเพิ่มเติมทั้งหมดจะถูกลบ บัญชีผู้ดูแลระบบและข้อมูลการตั้งค่าจริงยังคงอยู่';

  @override
  String get removeTestDataWarning =>
      'ไม่สามารถยกเลิกได้เว้นแต่จะโหลดข้อมูลทดสอบอีกครั้ง';

  @override
  String get removeTestData => 'ลบข้อมูลทดสอบ';

  @override
  String get keepTestData => 'เก็บข้อมูลทดสอบ';

  @override
  String get demoDataRemoved => 'ลบข้อมูลสาธิตแล้ว';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'ลบข้อมูลทดสอบแล้ว เปลี่ยนเป็น $name';
  }

  @override
  String get testDataRemoved => 'ลบข้อมูลทดสอบแล้ว';

  @override
  String couldNotRemoveTestData(String error) {
    return 'ไม่สามารถลบข้อมูลทดสอบได้: $error';
  }

  @override
  String get loadTestDataTitle => 'โหลดข้อมูลทดสอบ?';

  @override
  String get loadTestDataMessage =>
      'การดำเนินการนี้จะเพิ่มผู้ติดต่อสาธิตสูงสุด 50 ราย รายการสินค้าขายเท่านั้น 50 รายการ และซื้อเท่านั้น 50 รายการ พร้อมตัวอย่างยอดขาย การซื้อ การชำระ สต็อก สรุปการปิด เจ้าหน้าที่ เงินเดือน การเข้างาน 15 วันที่ผ่านมา และผลิตภัณฑ์เครื่องดื่มตัวอย่าง';

  @override
  String get loadTestData => 'โหลดข้อมูลทดสอบ';

  @override
  String get testDataLoaded => 'โหลดข้อมูลทดสอบแล้ว';

  @override
  String couldNotLoadTestData(String error) {
    return 'ไม่สามารถโหลดข้อมูลทดสอบได้: $error';
  }

  @override
  String get demoTestData => 'ข้อมูลทดสอบสาธิต';

  @override
  String get importTestDataSubtitle => 'นำเข้าข้อมูลทดสอบสำหรับทุกฟีเจอร์';

  @override
  String get hideTestDataTitle => 'ซ่อนข้อมูลทดสอบสำหรับองค์กรนี้?';

  @override
  String get hideTestDataMessage =>
      'หากดำเนินการต่อ ส่วนข้อมูลทดสอบจะถูกซ่อนในทุกที่ขององค์กรนี้ (รวมถึงการตั้งค่า) คุณสามารถเปิดใช้งานได้อีกครั้งโดยการติดตั้งใหม่หรือล้างข้อมูลแอปเท่านั้น';

  @override
  String get hideTestDataWarning =>
      'ข้อมูลสาธิตที่โหลดไว้แล้วจะยังคงอยู่ในฐานข้อมูลจนกว่าคุณจะลบออกจากการตั้งค่า';

  @override
  String get okHideTestData => 'ตกลง ซ่อนข้อมูลทดสอบ';

  @override
  String get testDataHiddenForOrg => 'ซ่อนข้อมูลทดสอบสำหรับองค์กรนี้แล้ว';

  @override
  String get hideTestDataTooltip => 'ซ่อนข้อมูลทดสอบสำหรับองค์กรนี้';

  @override
  String get partyRolesTitle => 'บทบาทของคู่สัญญา';

  @override
  String get partyRolesMoreSubtitle => 'ลูกค้า ผู้จัดหา ทั้งคู่ และอื่นๆ';

  @override
  String get exploreCustomizeTitle => 'ปรับแต่งคุณสมบัติ';

  @override
  String get exploreCustomizeSubtitle =>
      'แสดงหรือซ่อนทางลัดบนหน้าจอหลักของคุณ มีเพียงฟีเจอร์ที่องค์กรของคุณสามารถเข้าถึงได้เท่านั้นที่แสดงอยู่ในรายการ';

  @override
  String get exploreVisibleOnDashboard => 'มองเห็นได้บนแดชบอร์ด';

  @override
  String get exploreHiddenOnDashboard => 'ซ่อนอยู่บนแดชบอร์ด';

  @override
  String get partiesTitle => 'คู่ค้า';

  @override
  String get partySearchByName => 'ค้นหาตามชื่อ…';

  @override
  String get partySortBy => 'เรียงตาม:';

  @override
  String get partySortLatest => 'ล่าสุด';

  @override
  String get partySortAmountHighLow => 'จำนวน: สูงไปต่ำ';

  @override
  String get partySortAmountLowHigh => 'จำนวน: ต่ำไปสูง';

  @override
  String get partySortNameAZ => 'ชื่อ: A ถึง Z';

  @override
  String get partySortNameZA => 'ชื่อ: Z ถึง A';

  @override
  String get partyAddNew => 'เพิ่มคู่ค้าใหม่';

  @override
  String get partyEdit => 'แก้ไขคู่ค้า';

  @override
  String get partyUpdate => 'อัปเดตคู่ค้า';

  @override
  String get partyNameLabel => 'ชื่อคู่ค้า*';

  @override
  String get partyNameHint => 'กรอกชื่อคู่ค้า';

  @override
  String get partyNewNameLabel => 'ชื่อคู่ค้าใหม่*';

  @override
  String get partyNewNameHint => 'กรอกชื่อคู่ค้าใหม่';

  @override
  String get partyRoleLabel => 'บทบาทคู่ค้า *';

  @override
  String get partyTapToSelect => 'แตะเพื่อเลือก';

  @override
  String get partySelectRoleValidation => 'กรุณาเลือกบทบาท';

  @override
  String get partyEnterNameValidation => 'กรุณากรอกชื่อคู่ค้า';

  @override
  String get partyBasicInfo => 'ข้อมูลพื้นฐาน';

  @override
  String get partyAdditionalInfo => 'ข้อมูลเพิ่มเติม';

  @override
  String get partyEmail => 'อีเมลคู่ค้า';

  @override
  String get partyEmailHint => 'กรอกที่อยู่อีเมล';

  @override
  String get partyPhone => 'หมายเลขโทรศัพท์';

  @override
  String get partyPhoneHint => 'กรอกหมายเลขโทรศัพท์';

  @override
  String get partyAddress => 'ที่อยู่คู่ค้า';

  @override
  String get partyAddressHint => 'กรอกที่อยู่';

  @override
  String get partyRoleCustomer => 'ลูกค้า';

  @override
  String get partyRoleSupplier => 'ซัพพลายเออร์';

  @override
  String get partyRoleRoom => 'ห้อง';

  @override
  String get partyRoleCabin => 'ห้องพักเล็ก';

  @override
  String get partyRoleEmployee => 'พนักงาน';

  @override
  String get partyRoleBoth => 'ทั้งสอง';

  @override
  String get partyDefaultAccount => 'บัญชีเริ่มต้น';

  @override
  String get partyLoyaltyProgram => 'โปรแกรมสะสมคะแนน';

  @override
  String get partyLoyaltyPoints => 'คะแนนสะสม';

  @override
  String get partySelectDefaultAccount => 'เลือกบัญชีเริ่มต้น';

  @override
  String get partySelectLoyaltyProgram => 'เลือกโปรแกรมสะสมคะแนน';

  @override
  String get partyCreateNewProgram => 'สร้างโปรแกรมใหม่';

  @override
  String get partySelectPartyRole => 'เลือกบทบาทคู่ค้า';

  @override
  String get partyAccountDebtors => 'ลูกหนี้';

  @override
  String get partyAccountCreditors => 'เจ้าหนี้';

  @override
  String get partyBothRoleHint =>
      '“ทั้งสอง” หมายความว่าคู่ค้านี้จะปรากฏเฉพาะในลูกค้าและซัพพลายเออร์ — ไม่ใช่ห้อง ห้องพักเล็ก หรือพนักงาน';

  @override
  String get partyValidNumber => 'กรุณากรอกหมายเลขที่ถูกต้อง';

  @override
  String get partyValidAmount => 'กรุณากรอกจำนวนเงินที่ถูกต้อง';

  @override
  String get searchRoles => 'ค้นหาบทบาท';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count บทบาท',
      one: '1 บทบาท',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'ยังไม่มีบทบาท';

  @override
  String get noRolesYetHint =>
      'เพิ่มบทบาทลูกค้า ผู้จัดหา ทั้งคู่ หรือกำหนดเองสำหรับผู้ติดต่อ';

  @override
  String get addRole => 'เพิ่มบทบาท';

  @override
  String get deleteRoleTitle => 'ลบบทบาท';

  @override
  String deleteRoleConfirm(String name) {
    return 'ลบ \"$name\"? ไม่สามารถยกเลิกได้';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount คู่สัญญา',
      one: '1 คู่สัญญา',
    );
    return '\"$name\" ถูกใช้โดย $_temp0 โอนคู่สัญญาเหล่านั้นไปยังบทบาทอื่น หรือบังคับลบ';
  }

  @override
  String get transferParties => 'โอนคู่สัญญา';

  @override
  String get hardDeleteLoseParties => 'บังคับลบ (สูญเสียคู่สัญญา)';

  @override
  String get hardDeleteRoleTitle => 'บังคับลบ?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount คู่สัญญา',
      one: '1 คู่สัญญา',
    );
    return 'การดำเนินการนี้จะลบ \"$name\" และ $_temp0 ที่กำหนดไว้ทั้งหมดอย่างถาวร ข้อมูลคู่สัญญาไม่สามารถกู้คืนได้\n\nคู่สัญญาที่เชื่อมโยงกับใบแจ้งหนี้หรือการชำระอาจไม่ถูกลบ — ใช้โอนแทน';
  }

  @override
  String get deleteRoleAndParties => 'ลบบทบาทและคู่สัญญา';

  @override
  String get addAnotherRoleBeforeDelete => 'เพิ่มบทบาทอื่นก่อนลบบทบาทนี้';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount คู่สัญญา',
      one: '1 คู่สัญญา',
    );
    return 'ย้าย $_temp0 จาก \"$fromRole\" ไปยัง:';
  }

  @override
  String get transferAndDeleteRole => 'โอนและลบบทบาท';

  @override
  String get builtInRole => 'ในตัว';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count คู่สัญญา',
      one: '1 คู่สัญญา',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'ยังไม่มีคู่สัญญา';

  @override
  String get newRole => 'บทบาทใหม่';

  @override
  String get editRole => 'แก้ไขบทบาท';

  @override
  String get defaultRolesCannotEdit =>
      'บทบาทเริ่มต้นไม่สามารถเปลี่ยนชื่อหรือลบได้';

  @override
  String get roleNameLabel => 'ชื่อบทบาท *';

  @override
  String get roleNameHint => 'เช่น ลูกค้า';

  @override
  String get roleDescriptionLabel => 'คำอธิบาย';

  @override
  String get roleDescriptionHint => 'บันทึกสั้นๆ สำหรับทีม';

  @override
  String get roleSortOrderLabel => 'ลำดับการเรียง';

  @override
  String get roleSortOrderHint => 'ค่าต่ำกว่าแสดงก่อนในรายการ';

  @override
  String get roleCreated => 'สร้างบทบาทแล้ว';

  @override
  String get roleUpdated => 'อัปเดตบทบาทแล้ว';

  @override
  String get roleDeleted => 'ลบบทบาทแล้ว';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count คู่สัญญา',
      one: '1 คู่สัญญา',
    );
    return 'ลบบทบาทแล้ว $_temp0 ย้ายไปยัง $targetRole';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count คู่สัญญา',
      one: '1 คู่สัญญา',
    );
    return 'ลบบทบาทและ $_temp0 แล้ว';
  }

  @override
  String get privacyPolicyTitle => 'นโยบายความเป็นส่วนตัว';

  @override
  String get termsAndConditions => 'ข้อกำหนดและเงื่อนไข';

  @override
  String get logoutConfirmTitle => 'ออกจากระบบ';

  @override
  String get logoutConfirmMessage => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?';

  @override
  String get faqTapToExpand => 'แตะคำถามเพื่อขยาย';

  @override
  String get faqSectionGettingStarted => 'เริ่มต้นใช้งาน';

  @override
  String get faqSectionLogin => 'เข้าสู่ระบบ';

  @override
  String get faqSectionNavigation => 'การนำทาง';

  @override
  String get faqSectionInvoices => 'ใบแจ้งหนี้';

  @override
  String get faqSectionPayments => 'การชำระเงิน';

  @override
  String get faqSectionItemsStock => 'รายการและสต็อก';

  @override
  String get faqSectionProfileEmployees => 'โปรไฟล์และพนักงาน';

  @override
  String get faqSectionDashboardReports => 'แดชบอร์ดและรายงาน';

  @override
  String get faqSectionSyncTroubleshooting => 'การซิงค์และการแก้ปัญหา';

  @override
  String get faqNeedInternetQuestion => 'ฉันต้องใช้อินเทอร์เน็ตหรือไม่?';

  @override
  String get faqNeedInternetAnswer =>
      'หลังการตั้งค่าในเครื่องครั้งแรก คุณสามารถบันทึกใบแจ้งหนี้ รายการ และการชำระเงินโดยไม่ต้องใช้อินเทอร์เน็ต ข้อมูลยังคงอยู่บนอุปกรณ์ของคุณ การซิงค์กับเซิร์ฟเวอร์เป็นทางเลือก';

  @override
  String get faqFirstInstallQuestion => 'เกิดอะไรขึ้นเมื่อติดตั้งครั้งแรก?';

  @override
  String get faqFirstInstallAnswer =>
      'คุณอาจเห็นคำแนะนำสั้นๆ จากนั้นการตั้งค่าในเครื่อง (องค์กร บริษัท อีเมลและรหัสผ่าน สกุลเงิน ปีงบประมาณ) จากนั้นลงชื่อเข้าใช้ด้วยอีเมลและรหัสผ่านที่สร้าง';

  @override
  String get faqSignInCredentialsQuestion => 'ใช้อะไรในการลงชื่อเข้าใช้?';

  @override
  String get faqSignInCredentialsAnswer =>
      'อีเมลและรหัสผ่านจากการตั้งค่า แอปจะคงสถานะเข้าสู่ระบบจนกว่าคุณจะออกจากระบบผ่านเมนูเพิ่มเติม';

  @override
  String get faqLoggedOutQuestion => 'ทำไมฉันถึงถูกออกจากระบบ?';

  @override
  String get faqLoggedOutAnswer =>
      'คุณเลือกออกจากระบบ ล้างข้อมูลแอป หรือเซสชันหมดอายุ ลงชื่อเข้าใช้อีกครั้งด้วยข้อมูลเดิม';

  @override
  String get faqBottomTabsQuestion => 'แท็บด้านล่างทำอะไร?';

  @override
  String get faqBottomTabsAnswer =>
      'หน้าหลัก — แดชบอร์ดและภาพรวม\nยอดขาย — ใบแจ้งหนี้ขายตามวันที่\nค่าใช้จ่าย — ใบแจ้งหนี้ซื้อ/ค่าใช้จ่าย\nปุ่มกลาง — คู่สัญญา (ลูกค้า ผู้จัดหา)\nเพิ่มเติม — โปรไฟล์ รายงาน ซิงค์ ช่วยเหลือ ออกจากระบบ';

  @override
  String get faqCreateInvoiceQuestion => 'สร้างใบแจ้งหนี้ขายหรือซื้ออย่างไร?';

  @override
  String get faqCreateInvoiceAnswer =>
      'เปิดยอดขายหรือค่าใช้จ่าย เลือกวันที่ในปฏิทิน แตะปุ่ม + เพิ่มรายการและจำนวน เลือกคู่สัญญาหากจำเป็น จากนั้นบันทึกหรือส่ง';

  @override
  String get faqInvoiceDetailsQuestion => 'ดูรายละเอียดใบแจ้งหนี้เต็มอย่างไร?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'แตะใบแจ้งหนี้ใดก็ได้ในรายการ รายละเอียดธุรกรรมแสดงรายการ ยอดรวม ส่วนลด และการชำระ คุณสามารถพิมพ์ แชร์ ทำสำเนา หรือชำระได้จากที่นั่น';

  @override
  String get faqZeroRateQuestion => 'อัตราหรือจำนวนแสดงเป็นศูนย์ในรายละเอียด';

  @override
  String get faqZeroRateAnswer =>
      'โดยปกติหมายความว่าข้อมูลรายการหรือการชำระหายไปในการบันทึกเก่า อัปเดตแอปและสร้างหรือชำระอีกครั้งหากจำเป็น';

  @override
  String get faqPartialPaymentQuestion => 'บันทึกการชำระบางส่วนอย่างไร?';

  @override
  String get faqPartialPaymentAnswer =>
      'เปิดใบแจ้งหนี้ → รายละเอียดธุรกรรม → ชำระเงิน ป้อนจำนวน วิธีการ และวันที่ จากนั้นประมวลผลการชำระ';

  @override
  String get faqMultiplePaymentQuestion => 'การชำระหลายรายการทำงานอย่างไร?';

  @override
  String get faqMultiplePaymentAnswer =>
      'เปิดการชำระหลายรายการ แตะแก้ไข และแบ่งยอดรวมเป็นเงินสด บัตร QR เป็นต้น แต่ละวิธีถูกบันทึกแยกกัน';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'บันทึกการชำระเพียงรายการเดียวจากการแยก';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'อัปเดตเป็นเวอร์ชันล่าสุดของแอป เวอร์ชันเก่าบางครั้งบันทึกเฉพาะบรรทัดแรก ชำระอีกครั้งหากยอดคงเหลือยังผิด';

  @override
  String get faqAddItemQuestion => 'เพิ่มรายการอย่างไร?';

  @override
  String get faqAddItemAnswer =>
      'ใช้เพิ่มรายการจากขั้นตอนการขายหรือเพิ่มด่วน ป้อนชื่อ อัตรา หน่วย วัตถุประสงค์ และรูปภาพเพิ่มเติม (JPEG/PNG/GIF/WebP สูงสุด 5 MB) จากนั้นสร้างรายการ';

  @override
  String get faqCustomUnitQuestion => 'เพิ่มหน่วยกำหนดเองอย่างไร?';

  @override
  String get faqCustomUnitAnswer =>
      'ในฟอร์มรายการ แตะหน่วย → สร้างหน่วยใหม่ที่ด้านล่างของรายการ ป้อนชื่อ (เช่น ลิตร กล่อง) และสร้าง';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'ฉันเปลี่ยนชื่อแล้วแต่โปรไฟล์ยังแสดงชื่อเก่า';

  @override
  String get faqProfileNameAnswer =>
      'แก้ไขบันทึกพนักงานของคุณ (อีเมลเดียวกับที่ใช้เข้าสู่ระบบ) และบันทึก แท็บเพิ่มเติมและแดชบอร์ดควรอัปเดต';

  @override
  String get faqRevenueDetailsQuestion => 'รายละเอียดรายได้คืออะไร?';

  @override
  String get faqRevenueDetailsAnswer =>
      'มุมมองรายเดือนพร้อมกราฟแนวโน้มรายวัน กำไรสุทธิ ลูกหนี้ค้างชำระ และการวิเคราะห์ยอดขายเทียบการซื้อรายวัน เปลี่ยนเดือนด้วยปฏิทินหรือชิปเดือน';

  @override
  String get faqOtherReportsQuestion => 'รายงานอื่นๆ อยู่ที่ไหน?';

  @override
  String get faqOtherReportsAnswer =>
      'เปิดเพิ่มเติมและดูภายใต้รายงาน (การวิเคราะห์ กำไรขาดทุน ใบแจ้งยอด ฯลฯ) หากบทบาทของคุณมีสิทธิ์เข้าถึง';

  @override
  String get faqWhenSyncQuestion => 'ควรซิงค์เมื่อใด?';

  @override
  String get faqWhenSyncAnswer =>
      'เฉพาะเมื่อผู้ดูแลระบบขอและมีการเชื่อมต่อที่เสถียร การซิงค์ส่งหรือรับข้อมูลระหว่างอุปกรณ์และเซิร์ฟเวอร์';

  @override
  String get faqFabPositionQuestion => 'ปุ่ม + ดูสูงเกินไปในยอดขาย/ค่าใช้จ่าย';

  @override
  String get faqFabPositionAnswer =>
      'อยู่เหนือแถบนำทางด้านล่าง เลื่อนรายการหรืออัปเดตแอปหากปุ่มทับเนื้อหาบนอุปกรณ์ของคุณ';

  @override
  String get faqHowLogoutQuestion => 'ออกจากระบบอย่างไร?';

  @override
  String get faqHowLogoutAnswer =>
      'เพิ่มเติม → ออกจากระบบที่ด้านล่างของรายการการตั้งค่า';

  @override
  String get statisticsGoodMorning => 'สวัสดีตอนเช้า';

  @override
  String get statisticsGoodAfternoon => 'สวัสดีตอนบ่าย';

  @override
  String get statisticsGoodEvening => 'สวัสดีตอนเย็น';

  @override
  String get statisticsDefaultUser => 'ผู้ใช้';

  @override
  String get statisticsCheckConnection =>
      'โปรดตรวจสอบการเชื่อมต่อของคุณแล้วลองอีกครั้ง';

  @override
  String get statisticsCouldNotLoadProfile => 'ไม่สามารถโหลดโปรไฟล์ได้';

  @override
  String get statisticsCouldNotLoadData => 'ไม่สามารถโหลดข้อมูลได้';

  @override
  String get statisticsPeriodDay => 'วัน';

  @override
  String get statisticsPeriodMonth => 'เดือน';

  @override
  String get statisticsPeriodYear => 'ปี';

  @override
  String get statisticsSelectedPeriod => 'ระยะเวลาที่เลือก';

  @override
  String get statisticsSelectMonth => 'เลือกเดือน';

  @override
  String get statisticsSelectMonthSubtitle => 'เลือกเดือนเพื่อกรองข้อมูล';

  @override
  String get statisticsQuickOperations => 'Quick Operations';

  @override
  String get statisticsQuickOperationsSeeAll => 'ดูทั้งหมด';

  @override
  String get statisticsQuickOperationInvoice => 'ใบแจ้งหนี้';

  @override
  String get statisticsQuickOperationReports => 'รายงาน';

  @override
  String get statisticsAnnualRevenue => 'รายได้ต่อปี';

  @override
  String get statisticsCashflow => 'กระแสเงินสด';

  @override
  String get statisticsCashflowLast7Days => 'กระแสเงินสด (7 วันล่าสุด)';

  @override
  String get statisticsCashflowLast12Months => 'กระแสเงินสด (12 เดือนล่าสุด)';

  @override
  String get statisticsDaily => 'รายวัน';

  @override
  String get statisticsMonthly => 'รายเดือน';

  @override
  String get statisticsOverall => 'โดยรวม';

  @override
  String get statisticsLast7Days => 'Last 7 Days';

  @override
  String get statisticsLast12Months => 'Last 12 Months';

  @override
  String get statisticsAllYears => 'ทุกปี';

  @override
  String get statisticsNoDataAvailable => 'ไม่มีข้อมูล';

  @override
  String get statisticsMoneyIn => 'เงินเข้า';

  @override
  String get statisticsMoneyOut => 'เงินออก';

  @override
  String get statisticsIncome => 'รายได้';

  @override
  String get statisticsExpenses => 'ค่าใช้จ่าย';

  @override
  String get statisticsSalesSummary => 'สรุปการขาย';

  @override
  String get statisticsPurchaseSummary => 'สรุปการซื้อ';

  @override
  String get statisticsTotalSales => 'ยอดขายรวม';

  @override
  String get statisticsTotalIncome => 'รายได้รวม';

  @override
  String get statisticsTotalUnpaid => 'ยอดค้างชำระทั้งหมด';

  @override
  String get statisticsTotalPurchase => 'ยอดซื้อรวม';

  @override
  String get statisticsPaidPurchase => 'ชำระเงินซื้อ';

  @override
  String get statisticsUnpaidPurchase => 'การซื้อที่ค้างชำระ';

  @override
  String get statisticsEmployeeDashboard => 'แดชบอร์ดพนักงาน';

  @override
  String get statisticsDefaultEmployee => 'พนักงาน';

  @override
  String get statisticsDefaultDepartment => 'แผนก';

  @override
  String get statisticsDefaultPosition => 'ตำแหน่ง';

  @override
  String get statisticsCurrentMonth => 'เดือนปัจจุบัน';

  @override
  String get statisticsStatus => 'สถานะ';

  @override
  String get statisticsActive => 'คล่องแคล่ว';

  @override
  String get statisticsWelcome => 'ยินดีต้อนรับ';

  @override
  String get statisticsEmployeeWelcomeMessage =>
      'คุณเข้าสู่ระบบในฐานะพนักงาน ใช้เมนูนำทางเพื่อเข้าถึงคุณสมบัติที่มี';

  @override
  String get statisticsRevenueDetails => 'รายละเอียดรายได้';

  @override
  String get statisticsEmployeeDetails => 'รายละเอียดพนักงาน';

  @override
  String get statisticsChangeMonth => 'เปลี่ยนเดือน';

  @override
  String get statisticsFilterChartsSubtitle => 'กรองแผนภูมิและรายละเอียด';

  @override
  String get statisticsDailyTrend => 'เทรนด์รายวัน';

  @override
  String get statisticsDailyActivity => 'กิจกรรมประจำวัน';

  @override
  String get statisticsNoDataForMonth => 'ไม่มีข้อมูลสำหรับเดือนนี้';

  @override
  String get statisticsNetProfit => 'กำไรสุทธิ';

  @override
  String get statisticsMonthReceivables => 'ลูกหนี้เดือน';

  @override
  String get statisticsMonthRevenue => 'รายได้เดือน';

  @override
  String get statisticsMonthExpenses => 'ค่าใช้จ่ายเดือน';

  @override
  String get statisticsNoDailyEntries => 'ไม่มีรายการรายวันสำหรับเดือนนี้';

  @override
  String get statisticsDailySalesBreakdown => 'สรุปยอดขายในแต่ละวัน';

  @override
  String get statisticsDailyBreakdown => 'รายละเอียดรายวัน';

  @override
  String get statisticsAdvance => 'ก้าวหน้า';

  @override
  String get statisticsExploreFeatures => 'สำรวจคุณสมบัติ';

  @override
  String get statisticsShowOrHideFeatures => 'แสดงหรือซ่อนคุณสมบัติ';

  @override
  String get statisticsAllFeaturesHidden =>
      'คุณสมบัติการสำรวจทั้งหมดถูกซ่อนอยู่';

  @override
  String get statisticsNoFeaturesForOrg =>
      'ไม่มีฟีเจอร์ที่พร้อมใช้งานสำหรับองค์กรของคุณ';

  @override
  String get statisticsTapTuneToShow =>
      'แตะไอคอนปรับแต่งด้านบนเพื่อแสดงทางลัดอีกครั้ง';

  @override
  String get statisticsMenuCheck => 'กระทบยอด';

  @override
  String get statisticsMenuEmployee => 'พนักงาน';

  @override
  String get statisticsMenuOrder => 'คำสั่ง';

  @override
  String get statisticsMenuInventory => 'Items';

  @override
  String get statisticsMenuCustomers => 'ลูกค้า';

  @override
  String get statisticsMenuCalculator => 'Liquor prices';

  @override
  String get statisticsMenuQuickExpenses => 'ด่วน\nค่าใช้จ่าย';

  @override
  String get statisticsMenuQuickSales => 'ด่วน\nการขาย';

  @override
  String get statisticsMenuAddEmployee => 'เพิ่ม\nลูกจ้าง';

  @override
  String get statisticsMenuAddParty => 'เพิ่ม\nคู่ค้า';

  @override
  String get statisticsMenuAddEmployeeSingle => 'เพิ่มพนักงาน';

  @override
  String get statisticsMenuAddPartySingle => 'เพิ่มคู่ค้า';

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
    return '$amount รวบรวมแล้ว';
  }

  @override
  String statisticsMetricPaid(String amount) {
    return '$amount จ่ายแล้ว';
  }

  @override
  String statisticsMoneyInAmount(String amount) {
    return 'เงินเข้า: $amount';
  }

  @override
  String statisticsMoneyOutAmount(String amount) {
    return 'เงินออก: $amount';
  }

  @override
  String statisticsDayTooltip(String day, String amount) {
    return 'วัน $day\n$amount';
  }

  @override
  String statisticsProfitMargin(String percent) {
    return '$percent% มาร์จิ้น';
  }

  @override
  String get invoiceCommonActions => 'การดำเนินการ';

  @override
  String get invoiceCommonSearchItems => 'ค้นหารายการ';

  @override
  String get invoiceCommonSearchItemsSubtitle => 'ค้นหารายการที่เฉพาะเจาะจง';

  @override
  String get invoiceCommonAddNewInvoice => 'เพิ่มใบแจ้งหนี้ใหม่';

  @override
  String get invoiceCommonAddSalesInvoiceSubtitle =>
      'สร้างใบแจ้งหนี้การขายใหม่';

  @override
  String get invoiceCommonAddPurchaseInvoiceSubtitle =>
      'สร้างใบแจ้งหนี้การซื้อใหม่';

  @override
  String get invoiceCommonSelectMonthYear => 'เลือกเดือน/ปี';

  @override
  String get invoiceCommonSelectMonthYearSubtitle => 'ข้ามไปยังเดือนที่ต้องการ';

  @override
  String get invoiceCommonSelectMonthAndYear => 'เลือกเดือนและปี';

  @override
  String get invoiceCommonFilterByDate => 'กรองตามวันที่';

  @override
  String get invoiceCommonFilterByDateRange => 'กรองตามช่วงวันที่';

  @override
  String get invoiceCommonCloseSearch => 'ปิดการค้นหา';

  @override
  String get invoiceCommonSelectAll => 'เลือกทั้งหมด';

  @override
  String get invoiceCommonToday => 'วันนี้';

  @override
  String get invoiceCommonTotalQuantity => 'ปริมาณรวม';

  @override
  String get invoiceCommonTotalAmount => 'จำนวนเงินทั้งหมด';

  @override
  String get invoiceCommonTotal => 'ทั้งหมด';

  @override
  String get invoiceCommonSearchForItems => 'ค้นหารายการ';

  @override
  String get invoiceCommonNoItemsFound => 'ไม่พบรายการ';

  @override
  String get invoiceCommonUnknownItem => 'รายการที่ไม่รู้จัก';

  @override
  String get invoiceCommonNotAvailable => 'ไม่มี';

  @override
  String get invoiceSalesCouldNotLoad => 'ไม่สามารถโหลดยอดขายได้';

  @override
  String get invoiceSalesNoFound => 'ไม่พบยอดขาย';

  @override
  String get invoiceSalesSelectDate => 'เลือกวันที่เพื่อดูยอดขาย';

  @override
  String get invoiceSalesNoInvoicesFound => 'ไม่พบใบแจ้งหนี้';

  @override
  String get invoiceSalesSelectDateLegacy => 'เลือกวันที่เพื่อดูใบแจ้งหนี้';

  @override
  String get invoicePurchaseCouldNotLoad => 'ไม่สามารถโหลดค่าใช้จ่ายได้';

  @override
  String get invoicePurchaseNoFound => 'ไม่พบการซื้อ';

  @override
  String get invoicePurchaseSelectDate => 'เลือกวันที่เพื่อดูการซื้อ';

  @override
  String get invoiceWeekdaySun => 'ดวงอาทิตย์';

  @override
  String get invoiceWeekdayMon => 'จันทร์';

  @override
  String get invoiceWeekdayTue => 'อ';

  @override
  String get invoiceWeekdayWed => 'พ';

  @override
  String get invoiceWeekdayThu => 'พฤ';

  @override
  String get invoiceWeekdayFri => 'ศุกร์';

  @override
  String get invoiceWeekdaySat => 'นั่ง';

  @override
  String invoiceCommonSelectedCount(int count) {
    return '$count เลือกแล้ว';
  }

  @override
  String invoiceCommonQtyLabel(String qty) {
    return 'จำนวน: $qty';
  }

  @override
  String invoiceCommonInvoiceLabel(String number) {
    return 'ใบแจ้งหนี้: $number';
  }

  @override
  String invoiceCommonCustomerLabel(String name) {
    return 'ลูกค้า: $name';
  }

  @override
  String invoiceCommonSupplierLabel(String name) {
    return 'ผู้จัดจำหน่าย: $name';
  }

  @override
  String invoiceCommonSearchingFor(String query) {
    return 'กำลังค้นหา \"$query\"...';
  }

  @override
  String invoiceCommonSearchItemsHint(String scope) {
    return 'ค้นหารายการใน $scope...';
  }

  @override
  String invoiceCommonSalesSearchPrompt(String scope) {
    return 'พิมพ์ชื่อรายการเพื่อค้นหายอดขายทั้งหมด\nใน $scope';
  }

  @override
  String invoiceCommonPurchaseSearchPrompt(String scope) {
    return 'พิมพ์ชื่อรายการเพื่อค้นหาการซื้อทั้งหมด\nใน $scope';
  }

  @override
  String invoiceCommonSalesNoMatch(String query, String scope) {
    return 'ไม่มีการขาย \"$query\"\nใน $scope';
  }

  @override
  String invoiceCommonPurchaseNoMatch(String query, String scope) {
    return 'ไม่มีการซื้อ \"$query\"\nใน $scope';
  }

  @override
  String invoiceCommonEmptyForDate(String date) {
    return 'สำหรับ $date';
  }

  @override
  String invoiceFoundSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count รายการขาย',
      one: '1 รายการขาย',
    );
    return 'พบ $_temp0';
  }

  @override
  String invoiceFoundPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count รายการซื้อ',
      one: '1 รายการซื้อ',
    );
    return 'พบ $_temp0';
  }

  @override
  String invoiceDateSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ยอดขาย',
      one: '1 การขาย',
    );
    return '$_temp0';
  }

  @override
  String invoiceDatePurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ซื้อ',
      one: '1 ซื้อ',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ใบแจ้งหนี้',
      one: '1 ใบแจ้งหนี้',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ใบแจ้งหนี้',
      one: '1 ใบแจ้งหนี้',
    );
    return 'ลบ $_temp0';
  }

  @override
  String invoiceDeleteMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ใบแจ้งหนี้ที่เลือก',
      one: '1 ใบแจ้งหนี้ที่เลือก',
    );
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $_temp0 การดำเนินการนี้ไม่สามารถยกเลิกได้';
  }

  @override
  String get contacts => 'รายชื่อผู้ติดต่อ';

  @override
  String get categories => 'หมวดหมู่';

  @override
  String get manageStaff => 'จัดการพนักงาน';

  @override
  String get payroll => 'เงินเดือน';

  @override
  String get attendance => 'การเข้าร่วม';

  @override
  String get profitAndLoss => 'กำไรขาดทุน';

  @override
  String get statementReport => 'งบ';

  @override
  String get analytics => 'การวิเคราะห์';

  @override
  String get loggedOut => 'ออกจากระบบแล้ว';

  @override
  String organizationCodeDisplay(String code) {
    return 'รหัส: $code';
  }

  @override
  String get moreDataSynchronization => 'การซิงโครไนซ์ข้อมูล';

  @override
  String get moreSendDataToClient => 'ส่งข้อมูลไปยังลูกค้า';

  @override
  String get moreSendDataToClientSubtitle =>
      'อัปโหลดข้อมูลเซิร์ฟเวอร์ไปยังไคลเอนต์';

  @override
  String get moreSendDataToClientWarning =>
      'การดำเนินการนี้จะแทนที่ฐานข้อมูลไคลเอนต์ปัจจุบันด้วยข้อมูลจากเซิร์ฟเวอร์ การเปลี่ยนแปลงไคลเอนต์ล่าสุดทั้งหมดอาจสูญหาย';

  @override
  String get moreSendDataToClientConfirm =>
      'คุณแน่ใจหรือไม่ว่าต้องการส่งข้อมูลไปยังไคลเอ็นต์';

  @override
  String get moreFetchDataFromClient => 'ดึงข้อมูลจากไคลเอนต์';

  @override
  String get moreFetchDataFromClientSubtitle =>
      'ดาวน์โหลดข้อมูลไคลเอนต์ไปยังเซิร์ฟเวอร์';

  @override
  String get moreFetchDataFromClientWarning =>
      'การดำเนินการนี้จะแทนที่ฐานข้อมูลเซิร์ฟเวอร์ปัจจุบันด้วยข้อมูลจากไคลเอนต์ การเปลี่ยนแปลงเซิร์ฟเวอร์ล่าสุดทั้งหมดอาจสูญหาย';

  @override
  String get moreFetchDataFromClientConfirm =>
      'คุณแน่ใจหรือไม่ว่าต้องการดึงข้อมูลจากไคลเอ็นต์';

  @override
  String get notifications => 'การแจ้งเตือน';

  @override
  String get openingReminder => 'กำลังเปิดการแจ้งเตือน';

  @override
  String get closingReminder => 'การแจ้งเตือนการปิด';

  @override
  String get activityReminder => 'Sales & purchase reminder';

  @override
  String get openingTime => 'เวลาเปิดทำการ';

  @override
  String get closingTime => 'เวลาปิด';

  @override
  String get activityReminderTime => 'Reminder time';

  @override
  String get notificationSettingsSaved => 'บันทึกการตั้งค่าการแจ้งเตือนแล้ว';

  @override
  String get notificationPermissionHint =>
      'อนุญาตการแจ้งเตือน (และการเตือนบน Android) เพื่อให้การแจ้งเตือนทำงานเมื่อปิดแอป';

  @override
  String dailyAtTime(String time) {
    return 'ทุกวันเวลา $time';
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
  String get invoiceCommonYesterday => 'เมื่อวาน';

  @override
  String invoiceCommonTodayAt(String time) {
    return 'วันนี้ $time';
  }

  @override
  String invoiceCommonDaysAgo(int count) {
    return '$count วันที่ผ่านมา';
  }

  @override
  String invoiceReturnCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count รายการคืน',
      one: '1 รายการคืน',
    );
    return '$_temp0';
  }

  @override
  String get checkoutSelectParty => 'เลือกคู่ค้า';

  @override
  String get partyPickerSubtitle => 'การขายนี้สำหรับใคร?';

  @override
  String partyPickerSearchHint(String role) {
    return 'ค้นหา$role…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'เพิ่ม$roleใหม่';
  }

  @override
  String get partyPickerSettled => 'ชำระแล้ว';

  @override
  String get partyPickerSelectedLabel => 'เลือกแล้ว';

  @override
  String get checkoutCartSummary => 'สรุปรถเข็น';

  @override
  String get checkoutNoItemsInCart => 'ไม่มีสินค้าในรถเข็น';

  @override
  String get checkoutSearchHere => 'ค้นหาที่นี่';

  @override
  String get checkoutCreateInvoice => 'สร้างใบแจ้งหนี้';

  @override
  String get checkoutEditInvoice => 'แก้ไขใบแจ้งหนี้';

  @override
  String get checkoutSaveInvoice => 'บันทึกใบแจ้งหนี้';

  @override
  String get checkoutInvoiceSummary => 'สรุปใบแจ้งหนี้';

  @override
  String get checkoutEstimate => 'ประมาณการ';

  @override
  String get checkoutBasicInformation => 'ข้อมูลพื้นฐาน';

  @override
  String get checkoutAddItems => 'เพิ่มรายการ';

  @override
  String get checkoutItemsSection => 'รายการ';

  @override
  String get checkoutPartyRequired => 'คู่ค้า *';

  @override
  String get checkoutPartyInformation => 'ข้อมูลคู่ค้า';

  @override
  String get checkoutBillSummary => 'สรุปบิล';

  @override
  String get checkoutBillSummaryHint =>
      'แตะเพื่อทราบการคำนวณโดยละเอียดเพิ่มเติม';

  @override
  String get checkoutItemTotal => 'รายการทั้งหมด';

  @override
  String checkoutLoyaltyDiscount(String percent) {
    return 'ส่วนลดความภักดี ($percent%)';
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
    return '- ส่วนลด ($percent%)';
  }

  @override
  String get checkoutTapToEdit => 'แตะเพื่อแก้ไข';

  @override
  String get checkoutTotalAmount => 'จำนวนเงินทั้งหมด';

  @override
  String get checkoutPaymentMode => 'Record payment';

  @override
  String get checkoutPaymentModeHint =>
      'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.';

  @override
  String get checkoutNetSalesAmount => 'ยอดขายสุทธิ';

  @override
  String get checkoutConfirmCheckout => 'ยืนยันการชำระเงิน';

  @override
  String get checkoutEditDiscount => 'แก้ไขส่วนลด';

  @override
  String get checkoutPercentage => 'เปอร์เซ็นต์';

  @override
  String get checkoutDiscard => 'ทิ้ง';

  @override
  String get checkoutPartialPayment => 'การชำระเงินบางส่วน';

  @override
  String get checkoutPartialPaymentBanner =>
      'เมื่อเปิดใช้งานการชำระเงินบางส่วน ลูกค้าจะสามารถชำระเงินจำนวนที่น้อยกว่าจำนวนเงินที่เรียกเก็บทั้งหมด';

  @override
  String get checkoutPleaseEnterAmounts => 'กรุณากรอกจำนวนเงินตามลำดับ:';

  @override
  String get checkoutPartialPaymentEqualHint =>
      'เนื่องจากไม่มีการกำหนดผู้ใช้ จำนวนเงินทั้งหมดจึงควรเท่ากับจำนวนเงินที่เรียกเก็บทั้งหมด';

  @override
  String checkoutOverGrandTotalBy(String amount) {
    return 'เกินผลรวมทั้งหมดโดย: $amount';
  }

  @override
  String checkoutRemainingUnpaid(String amount) {
    return 'ส่วนที่เหลือ (ยังไม่ได้ชำระจากผลรวมทั้งหมด): $amount';
  }

  @override
  String get checkoutConfirmPayment => 'ยืนยันการชำระเงิน';

  @override
  String get checkoutUnpaidCredit => 'ค้างชำระ / เครดิต';

  @override
  String get checkoutAddAtLeastOneLine =>
      'เพิ่มรายการโฆษณาอย่างน้อยหนึ่งรายการเพื่อดูค่าประมาณ';

  @override
  String get checkoutMultiplePayment => 'การชำระเงินหลายครั้ง';

  @override
  String get checkoutPaymentStatus => 'สถานะการชำระเงิน';

  @override
  String get checkoutPaymentMethods => 'วิธีการชำระเงิน';

  @override
  String get checkoutPaymentMethod => 'วิธีการชำระเงิน';

  @override
  String get checkoutTenderAmount => 'จำนวนเงินที่ประกวดราคา';

  @override
  String get checkoutLoadingPaymentMethods => 'กำลังโหลดวิธีการชำระเงิน...';

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
  String get stockSearchByDateHint => 'ค้นหาตามวันที่หรือเดือน...';

  @override
  String get stockNoMatches => 'ไม่มีการแข่งขัน';

  @override
  String get stockTryDifferentSearch => 'ลองใช้คำค้นหาอื่น';

  @override
  String get stockTryAnotherSearch => 'ลองค้นหาอีกครั้ง';

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
    return 'จำนวน $qty';
  }

  @override
  String stockCardSummary(String records, String items, String locations) {
    return '$records บันทึก · $items รายการ · $locations ตำแหน่ง';
  }

  @override
  String get stockFilterTitle => 'Filter stock reconciliation';

  @override
  String get stockBatchNumber => 'หมายเลขแบทช์';

  @override
  String get stockLocation => 'ที่ตั้ง';

  @override
  String get stockOptionalHint => 'ไม่จำเป็น';

  @override
  String get stockApplyFilters => 'ใช้ตัวกรอง';

  @override
  String get stockClearFields => 'ล้างฟิลด์';

  @override
  String get stockDeleteAllTooltip => 'ลบสต็อกทั้งหมดสำหรับวันที่นี้';

  @override
  String get stockNoItemsFound => 'ไม่พบสินค้าในสต๊อก';

  @override
  String get stockNoItemsSubtitle => 'ลองใช้ตัวกรองอื่นหรือวันที่รายงานอื่น';

  @override
  String get stockAdjustFilters => 'ปรับตัวกรอง';

  @override
  String get stockSearchItemHint => 'ค้นหารายการ ชุด สถานที่...';

  @override
  String get stockEditQuantities => 'แก้ไขปริมาณ';

  @override
  String get stockNoChangesDetected => 'ไม่พบการเปลี่ยนแปลง';

  @override
  String stockErrorPreparingChanges(String error) {
    return 'เกิดข้อผิดพลาดในการเตรียมการเปลี่ยนแปลง: $error';
  }

  @override
  String get stockUpdateSuccessful => 'อัปเดตสำเร็จ!';

  @override
  String get stockSummary => 'สรุป';

  @override
  String get stockTotalRequested => 'รวมที่ร้องขอ';

  @override
  String get stockSuccessfullyUpdated => 'อัปเดตเรียบร้อยแล้ว';

  @override
  String get stockFailed => 'ล้มเหลว';

  @override
  String get stockUpdateFailed => 'การอัปเดตล้มเหลว';

  @override
  String get stockClearAllQuantitiesTitle => 'ล้างปริมาณทั้งหมดใช่ไหม';

  @override
  String get stockClearAllQuantitiesMessage =>
      'การดำเนินการนี้จะรีเซ็ตปริมาณทั้งหมดเป็น 0 คุณแน่ใจหรือไม่';

  @override
  String get stockClearAll => 'ล้างทั้งหมด';

  @override
  String get stockUpdatingQuantities => 'กำลังอัปเดตจำนวนสต็อก...';

  @override
  String get stockEditQuantitiesTitle => 'แก้ไขปริมาณสต็อค';

  @override
  String stockReportingDate(String date) {
    return 'วันที่รายงาน: $date';
  }

  @override
  String stockTotalItemsHint(String count) {
    return 'รายการทั้งหมด: $count • อัปเดตปริมาณตามความจำเป็น';
  }

  @override
  String get stockItemName => 'ชื่อรายการ';

  @override
  String stockBatchPrefix(String batch) {
    return 'ชุด: $batch';
  }

  @override
  String get stockDeleteConfirmTitle => 'ยืนยันการลบ';

  @override
  String get stockDeleteConfirmIntro =>
      'คุณกำลังจะลบสินค้าในสต็อกทั้งหมดอย่างถาวรสำหรับวันต่อไปนี้:';

  @override
  String get stockDeleteConfirmWarning =>
      'การดำเนินการนี้ไม่สามารถยกเลิกได้ บันทึกสต็อกทั้งหมดสำหรับวันที่นี้จะถูกลบอย่างถาวร';

  @override
  String get stockNoInternetRetry =>
      'ไม่มีการเชื่อมต่ออินเทอร์เน็ต โปรดตรวจสอบการเชื่อมต่อของคุณแล้วลองอีกครั้ง';

  @override
  String get itemsTitle => 'รายการ';

  @override
  String get itemAddSheetTitle => 'เพิ่มรายการ';

  @override
  String get itemSingleAdd => 'เพิ่มเดี่ยว';

  @override
  String get itemBulkAdd => 'เพิ่มเป็นกลุ่ม';

  @override
  String get itemBulkAddTitle => 'เพิ่มรายการจำนวนมาก';

  @override
  String get itemEditTitle => 'แก้ไขรายการ';

  @override
  String get itemAddTitle => 'เพิ่มรายการ';

  @override
  String get itemCreateButton => 'สร้างรายการ';

  @override
  String get itemUpdateButton => 'อัปเดตรายการ';

  @override
  String get itemDeleteTitle => 'ลบรายการ';

  @override
  String itemDeleteConfirm(String name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ \"$name\"';
  }

  @override
  String get itemDeletedSuccess => 'ลบรายการเรียบร้อยแล้ว';

  @override
  String get itemCreatedSuccess => 'สร้างรายการสำเร็จแล้ว';

  @override
  String get itemUpdatedSuccess => 'อัปเดตรายการสำเร็จแล้ว';

  @override
  String get itemLoading => 'กำลังโหลดรายการ...';

  @override
  String get itemErrorTitle => 'อ๊ะ! มีบางอย่างผิดพลาด';

  @override
  String get itemTryAgain => 'ลองอีกครั้ง';

  @override
  String get itemSearchHint => 'ค้นหารายการ';

  @override
  String get itemNoItemsFound => 'ไม่พบรายการ';

  @override
  String get itemTryAdjustSearch => 'ลองปรับคำค้นหาของคุณ';

  @override
  String get itemNoItemsAvailable => 'ไม่มีรายการที่มีอยู่';

  @override
  String get itemAddToGetStarted => 'เพิ่มรายการเพื่อเริ่มต้น';

  @override
  String get itemNoMoreItems => 'ไม่มีรายการอีกต่อไป';

  @override
  String get itemPurposeBoth => 'ทั้งคู่';

  @override
  String get itemPurposePurchases => 'การซื้อ';

  @override
  String get itemTypeProduct => 'ผลิตภัณฑ์';

  @override
  String get itemTypeService => 'บริการ';

  @override
  String get itemTypeInventory => 'รายการสิ่งของ';

  @override
  String get itemPhotoTitle => 'รูปสินค้า';

  @override
  String get itemPhotoHint => 'คลิกที่นี่เพื่อเลือกหรืออัพโหลดรูปภาพ';

  @override
  String get itemPhotoFormats => 'JPEG, PNG, GIF หรือ WebP · สูงสุด 5MB';

  @override
  String get itemAddPhoto => 'เพิ่มรูปภาพ';

  @override
  String get itemPhotoLibrary => 'ห้องสมุดรูปภาพ';

  @override
  String get itemPhotoLibraryHint => 'เลือกจากรูปถ่ายของคุณ';

  @override
  String get itemTakePhoto => 'ถ่ายรูป';

  @override
  String get itemUploadGallery => 'อัปโหลดจากแกลเลอรี่';

  @override
  String get itemUploadGalleryHint => 'เรียกดูไฟล์บนอุปกรณ์นี้';

  @override
  String get itemTypeLabel => 'พิมพ์';

  @override
  String get itemTypeField => 'ประเภทรายการ';

  @override
  String get itemNameLabel => 'ชื่อรายการ';

  @override
  String get itemNameHint => 'ป้อนชื่อรายการ';

  @override
  String get itemBarcodeLabel => 'บาร์โค้ด/คิวอาร์โค้ด';

  @override
  String get itemBarcodeField => 'บาร์โค้ด/คิวอาร์โค้ด';

  @override
  String get itemBarcodeHint => 'สแกนจากแถบแอปหรือวาง';

  @override
  String get itemSkuLabel => 'SKU (optional)';

  @override
  String get itemSkuField => 'SKU';

  @override
  String get itemSkuHint => 'Product code — optional';

  @override
  String get itemPickerSearchHint => 'Search items by name or SKU…';

  @override
  String get itemRateLabel => 'ประเมิน';

  @override
  String get itemUnitLabel => 'หน่วย';

  @override
  String get itemPurposeLabel => 'วัตถุประสงค์';

  @override
  String get itemSelectUnit => 'เลือกหน่วย';

  @override
  String get itemSelectPurpose => 'เลือกวัตถุประสงค์';

  @override
  String get itemSelectCategory => 'เลือกหมวดหมู่';

  @override
  String get itemSelectType => 'เลือกประเภท';

  @override
  String get itemSelectItemType => 'เลือกประเภทรายการ';

  @override
  String get itemSearchUnits => 'ค้นหาหน่วย...';

  @override
  String get itemSearchPurpose => 'วัตถุประสงค์ในการค้นหา...';

  @override
  String get itemSearchCategories => 'ค้นหาหมวดหมู่...';

  @override
  String get itemCreateCustomUnit => 'สร้างหน่วยที่กำหนดเอง';

  @override
  String get itemUnitName => 'ชื่อหน่วย';

  @override
  String get itemUnitNameHint => 'เช่น ลิตร กล่อง ชิ้น';

  @override
  String get itemValidationName => 'กรุณากรอกชื่อรายการ';

  @override
  String get itemValidationRate => 'กรุณากรอกอัตรา';

  @override
  String get itemValidationNumber => 'กรุณากรอกหมายเลขที่ถูกต้อง';

  @override
  String get itemSelectUnitRequired => 'กรุณาเลือกหน่วย';

  @override
  String get itemSelectPurposeRequired => 'โปรดเลือกวัตถุประสงค์';

  @override
  String get itemSelectCategoryRequired => 'กรุณาเลือกหมวดหมู่';

  @override
  String get itemImageMissing => 'ไฟล์รูปภาพหายไป';

  @override
  String get itemImageFormatError => 'ใช้ JPEG, PNG, GIF หรือ WebP';

  @override
  String get itemImageSizeError => 'รูปภาพต้องมีขนาด 5MB หรือเล็กกว่า';

  @override
  String get itemScanBarcode => 'สแกนบาร์โค้ด';

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
    return 'ชื่อที่กรอกจากแค็ตตาล็อก: $name';
  }

  @override
  String get itemBarcodePasteHint =>
      'ไม่พบชื่อผลิตภัณฑ์ — รหัสวางเป็นชื่อ แก้ไขหากจำเป็น';

  @override
  String get itemBulkRefillTooltip => 'เติมอินพุตก่อนหน้า';

  @override
  String get itemBulkAddRow => 'เพิ่มแถว';

  @override
  String itemBulkRowLabel(String index) {
    return 'รายการ $index';
  }

  @override
  String get itemBulkNameRequired => 'จำเป็นต้องระบุชื่อ';

  @override
  String get itemBulkInvalidNumber => 'หมายเลขไม่ถูกต้อง';

  @override
  String get itemBulkCreating => 'กำลังสร้าง...';

  @override
  String get itemBulkCreateItems => 'สร้างรายการ';

  @override
  String itemBulkCreatedCount(String count) {
    return '$count สร้างรายการแล้ว';
  }

  @override
  String itemBulkCreateFailed(String error) {
    return 'ไม่สามารถสร้างรายการ: $error';
  }

  @override
  String get itemBulkNoDraft => 'ไม่พบฉบับร่างที่บันทึกไว้';

  @override
  String get itemBulkInvalidDraft => 'รูปแบบร่างที่บันทึกไว้ไม่ถูกต้อง';

  @override
  String get itemBulkDraftRestored => 'กู้คืนฉบับร่างก่อนหน้าแล้ว';

  @override
  String get itemBulkDraftRestoreFailed =>
      'ไม่สามารถกู้คืนฉบับร่างที่บันทึกไว้ได้';

  @override
  String get itemBulkAtLeastOne => 'เพิ่มอย่างน้อยหนึ่งรายการ';

  @override
  String get itemBulkCategoriesLoading => 'กำลังโหลดหมวดหมู่ โปรดลองอีกครั้ง';

  @override
  String get itemBulkLoadingCategories => 'กำลังโหลดหมวดหมู่...';

  @override
  String get inventoryTitle => 'การวิเคราะห์สินค้าคงคลัง';

  @override
  String get inventorySubtitle => 'การติดตามความเคลื่อนไหวของหุ้นแบบเรียลไทม์';

  @override
  String get inventorySearchHint => 'ค้นหารายการ...';

  @override
  String get inventorySold => 'ขายแล้ว';

  @override
  String get inventoryPurchased => 'ซื้อแล้ว';

  @override
  String get catNoCategories => 'ไม่มีหมวดหมู่ แตะ + เพื่อสร้าง';

  @override
  String get catLoadCategories => 'โหลดหมวดหมู่';

  @override
  String get catCreated => 'สร้างหมวดหมู่แล้ว';

  @override
  String get catRenamed => 'เปลี่ยนชื่อหมวดหมู่แล้ว';

  @override
  String get catDeleted => 'ลบหมวดหมู่แล้ว';

  @override
  String catDeletedBulk(int count) {
    return '$count categories deleted';
  }

  @override
  String get catNewTitle => 'หมวดหมู่ใหม่';

  @override
  String get catRenameTitle => 'เปลี่ยนชื่อหมวดหมู่';

  @override
  String get catNewName => 'ชื่อใหม่';

  @override
  String get catRename => 'เปลี่ยนชื่อ';

  @override
  String get catDeleteTitle => 'ลบหมวดหมู่';

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
    return 'ลบ \"$name\" หรือไม่';
  }

  @override
  String get catDeleteLinkedHint =>
      'มีการเชื่อมโยงรายการต่างๆ คุณสามารถบังคับลบเพื่อยกเลิกการเชื่อมโยงได้';

  @override
  String get catForceDelete => 'บังคับลบ';

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
    return '$count รายการ';
  }

  @override
  String get contactFavoritesOnly => 'รายการโปรดเท่านั้น';

  @override
  String get contactShowAll => 'แสดงผู้ติดต่อทั้งหมด';

  @override
  String get contactSearchHint => 'ค้นหาชื่อ โทรศัพท์ อีเมล...';

  @override
  String get contactNoConnection => 'ไม่มีการเชื่อมต่อ';

  @override
  String get contactCheckNetwork => 'ตรวจสอบเครือข่ายของคุณแล้วลองอีกครั้ง';

  @override
  String get contactSomethingWrong => 'มีบางอย่างผิดพลาด';

  @override
  String get contactNoContacts => 'ไม่มีผู้ติดต่อ';

  @override
  String get contactNoFavorites =>
      'ไม่มีรายการโปรดที่ตรงกัน ปิดตัวกรองดาวหรือเพิ่มรายการโปรดในผู้ติดต่อ';

  @override
  String get contactTrySearchOrAdd =>
      'ลองค้นหาแบบอื่นหรือแตะ + เพื่อเพิ่มผู้ติดต่อ';

  @override
  String get contactEndOfList => 'สิ้นสุดรายการ';

  @override
  String get contactNewTooltip => 'ติดต่อใหม่';

  @override
  String get contactLoading => 'กำลังโหลดรายชื่อติดต่อ...';

  @override
  String get contactUnknown => 'ไม่ทราบ';

  @override
  String get contactCallTooltip => 'เรียก';

  @override
  String get contactEditTitle => 'แก้ไขผู้ติดต่อ';

  @override
  String get contactNewTitle => 'ติดต่อใหม่';

  @override
  String get contactSelectTitle => 'เลือกผู้ติดต่อ';

  @override
  String get contactDeleteTitle => 'ลบผู้ติดต่อใช่ไหม';

  @override
  String get contactDeleteUndo => 'การดำเนินการนี้ไม่สามารถยกเลิกได้';

  @override
  String get contactNameRequired => 'ต้องระบุชื่อ';

  @override
  String get contactNameLabel => 'ชื่อ *';

  @override
  String get contactNameHint => 'ชื่อผู้ติดต่อ';

  @override
  String get contactPhoneHint => '+977-9841234567';

  @override
  String get contactEmailHint => 'email@example.com';

  @override
  String get contactCategoryHint => 'เช่น ธุรกิจทั่วไปวีไอพี';

  @override
  String get contactCompanyHint => 'ชื่อบริษัท';

  @override
  String get contactFavorite => 'ที่ชื่นชอบ';

  @override
  String get contactCannotCall => 'ไม่สามารถโทรออกบนอุปกรณ์นี้ได้';

  @override
  String get contactPermissionDenied =>
      'การอนุญาตการติดต่อถูกปฏิเสธ คุณสามารถเปิดใช้งานได้ในการตั้งค่า';

  @override
  String get contactPermissionRequired =>
      'ต้องได้รับอนุญาตจากการติดต่อเพื่อนำเข้าจากโทรศัพท์';

  @override
  String get contactImported => 'ติดต่อนำเข้าจากโทรศัพท์';

  @override
  String get contactCreated => 'สร้างที่อยู่ติดต่อแล้ว';

  @override
  String get contactUpdated => 'อัพเดทรายชื่อติดต่อแล้ว';

  @override
  String get contactDeleted => 'ลบผู้ติดต่อแล้ว';

  @override
  String get contactImportSearchHint => 'ค้นหาตามชื่อ โทรศัพท์ อีเมล บริษัท';

  @override
  String get contactImportNoResults => 'ไม่พบผู้ติดต่อ';

  @override
  String get checkoutMultiplePaymentHint =>
      'เปิดการตั้งค่านี้ หากลูกค้าชำระเงินผ่านโหมดการชำระเงินหลายรูปแบบ';

  @override
  String get checkoutFillRemainingBalance => 'เติมยอดเงินคงเหลือ';

  @override
  String get checkoutEnterAtLeastOnePayment =>
      'ป้อนจำนวนเงินที่ชำระอย่างน้อยหนึ่งรายการ';

  @override
  String get checkoutPaymentsExceedTotal =>
      'การชำระเงินทั้งหมดต้องไม่เกินยอดรวมทั้งหมด';

  @override
  String checkoutSentAs(String api) {
    return 'ส่งเป็น: $api';
  }

  @override
  String get paymentCard => 'การ์ด';

  @override
  String get paymentQr => 'QR';

  @override
  String get paymentBank => 'ธนาคาร';

  @override
  String get paymentTransfer => 'โอนย้าย';

  @override
  String get paymentBankTransfer => 'โอนเงินผ่านธนาคาร';

  @override
  String get paymentSettlement => 'การตั้งถิ่นฐาน';

  @override
  String get paymentCheque => 'ตรวจสอบ';

  @override
  String get paymentDigital => 'ดิจิตอล';

  @override
  String get paymentDigitalQr => 'ดิจิทัล (คิวอาร์)';

  @override
  String get closeSummaryTitle => 'สรุปการปิด';

  @override
  String get closeTabDashboard => 'แดชบอร์ด';

  @override
  String get closeTabCredits => 'เครดิต';

  @override
  String get closeWelcome => 'ยินดีต้อนรับสู่บทสรุปปิดท้าย';

  @override
  String get closeSelectDateHint => 'เลือกวันที่และแตะรีเฟรชเพื่อโหลดข้อมูล';

  @override
  String get closeLoadingDashboard => 'กำลังโหลดข้อมูลแดชบอร์ด...';

  @override
  String get closeDataDeleted => 'ลบข้อมูลแล้ว';

  @override
  String closeErrorPrefix(String message) {
    return 'ข้อผิดพลาด: $message';
  }

  @override
  String get closeExtraAmount => 'จำนวนพิเศษ';

  @override
  String get closeExtraAmountDesc =>
      'เงินสดเพิ่มเติมหรือการปรับค่าใช้จ่ายที่บันทึกไว้สำหรับวันปิดบัญชีนี้';

  @override
  String get closeLostAmount => 'จำนวนเงินที่หายไป';

  @override
  String get closeLostAmountDesc =>
      'การขาดแคลนเงินสดหรือผลต่างที่ทำเครื่องหมายไว้สำหรับงวดนี้';

  @override
  String get closeTapForDetails => 'แตะเพื่อดูรายละเอียด';

  @override
  String get closeAmountLabel => 'ปิดยอด';

  @override
  String get closeAmountFormula => 'สูตรปิดยอด';

  @override
  String get closeFormulaExpression =>
      'การขายเงินสด - ค่าใช้จ่ายเงินสด = จำนวนเงินที่ปิดบัญชี';

  @override
  String get closeCashSales => 'ขายเงินสด';

  @override
  String get closeCashExpenses => 'ค่าใช้จ่ายเงินสด';

  @override
  String get closeClosingAmount => 'จำนวนเงินปิด';

  @override
  String get closeWhatThisMeans => 'สิ่งนี้หมายถึงอะไร:';

  @override
  String get closeClosingMeaning =>
      'นี่คือจำนวนเงินสดที่ควรอยู่ในทะเบียน/ลิ้นชักของคุณเมื่อสิ้นสุดวัน หมายถึงเงินสดทั้งหมดที่ได้รับลบด้วยเงินสดที่จ่ายออกไปทั้งหมด';

  @override
  String get closeQuickStats => 'สถิติด่วน';

  @override
  String get closeTapCardHint => 'แตะการ์ดเพื่อดูคำอธิบายสั้นๆ';

  @override
  String get closeOpeningBalance => 'ยอดคงเหลือเปิด';

  @override
  String get closeTotalSales => 'ยอดขายรวม';

  @override
  String get closeQrAmount => 'จำนวนเงิน QR';

  @override
  String get closeCashAmount => 'จำนวนเงินสด';

  @override
  String get closeSalesDiscount => 'ส่วนลดการขาย';

  @override
  String get closeCreditQr => 'เครดิต คิวอาร์';

  @override
  String get closeCreditCash => 'เครดิตเงินสด';

  @override
  String get closeCreditDiscount => 'ส่วนลดเครดิต';

  @override
  String get closePayCashGetQr => 'จ่ายเงินสด → รับ QR';

  @override
  String get closePayQrGetCash => 'จ่าย QR → รับเงินสด';

  @override
  String get closePaymentMix => 'ส่วนผสมการชำระเงิน';

  @override
  String get closePaymentMixHint =>
      'แตะเงินสดหรือดิจิทัล · บาร์แสดงส่วนแบ่งการขาย';

  @override
  String get closeCashVsDigitalTooltip => 'เงินสดเทียบกับส่วนแบ่งการขายดิจิทัล';

  @override
  String closeSalesShareDesc(String label, String percent) {
    return '$label คิดเป็น $percent% ของยอดขายรวมสำหรับวันนี้';
  }

  @override
  String closeSalesLabel(String label) {
    return '$label ยอดขาย';
  }

  @override
  String get closeNoTransactions => 'ไม่มีการทำธุรกรรม';

  @override
  String get closeRecentTransactions => 'การทำธุรกรรมล่าสุด';

  @override
  String get closeViewAll => 'ดูทั้งหมด';

  @override
  String get closeNoPurchases => 'ไม่มีการซื้อที่มีอยู่';

  @override
  String get closeRecentPurchases => 'การซื้อล่าสุด';

  @override
  String get closeNoSalesDate => 'ไม่มีการขายสำหรับวันที่นี้';

  @override
  String get closeNoSalesHint => 'ยอดขายจะแสดงที่นี่หลังจากบันทึกแล้ว';

  @override
  String get closeRoomSales => 'ขายห้อง';

  @override
  String get closeEmployeeSales => 'การขายพนักงาน';

  @override
  String get closeOtherSales => 'other ยอดขาย';

  @override
  String closeSectionCount(String title, String count) {
    return '$title ($count)';
  }

  @override
  String closeDiscountShort(String amount) {
    return 'แผ่นดิสก์: $amount';
  }

  @override
  String closePercentOff(String percent) {
    return 'ลด $percent%';
  }

  @override
  String get closePending => 'รอดำเนินการ';

  @override
  String get closeNoCreditPayments => 'ไม่มีการจ่ายเครดิต';

  @override
  String get closeNoCreditHint => 'การชำระเครดิตจะปรากฏที่นี่';

  @override
  String get closeViewStatistics => 'ดูสถิติ';

  @override
  String get closeExportData => 'ส่งออกข้อมูล';

  @override
  String get closeExportComingSoon => 'ฟีเจอร์ส่งออกจะถูกใช้งานที่นี่';

  @override
  String get closeHintOpeningBalance =>
      'สถานะเงินสด ณ วันเริ่มต้นของวันที่เลือก';

  @override
  String get closeHintTotalSales =>
      'ผลรวมยอดขายทั้งหมดที่บันทึกไว้สำหรับวันนี้';

  @override
  String get closeHintQrAmount => 'การชำระเงินที่ได้รับผ่าน QR หรือวิธีดิจิทัล';

  @override
  String get closeHintCashAmount => 'สัดส่วนเงินสดของการขายสำหรับวัน';

  @override
  String get closeHintCashExpenses => 'เงินสดจ่ายเป็นค่าใช้จ่ายระหว่างวัน';

  @override
  String get closeHintSalesDiscount => 'ส่วนลดนำไปใช้กับการขาย';

  @override
  String get closeHintCreditQr => 'คอลเลกชัน QR ที่เกี่ยวข้องกับเครดิต';

  @override
  String get closeHintCreditCash =>
      'การเคลื่อนไหวของเงินสดที่เกี่ยวข้องกับเครดิต';

  @override
  String get closeHintCreditDiscount => 'ส่วนลดใช้กับธุรกรรมเครดิต';

  @override
  String get closeHintPayCashGetQr =>
      'แลกเปลี่ยนที่จ่ายเงินสดและได้รับเครดิต QR';

  @override
  String get closeHintPayQrGetCash => 'แลกเปลี่ยนที่จ่าย QR และรับเงินสด';

  @override
  String get closeOpeningAmount => 'จำนวนการเปิด';

  @override
  String get closeCurrentAmount => 'จำนวนเงินปัจจุบัน';

  @override
  String get closeSaveReport => 'บันทึกรายงาน';

  @override
  String get closeUpdateSummary => 'อัปเดตข้อมูลสรุป';

  @override
  String get closeExists => 'มีอยู่';

  @override
  String get closeExistingDataInfo => 'คุณสามารถดูหรือแก้ไขข้อมูลที่มีอยู่ได้';

  @override
  String get closeEnterOpeningAmount => 'กรุณากรอกจำนวนเงินเปิดบัญชี';

  @override
  String get closeEnterValidAmount => 'กรุณากรอกจำนวนเงินที่ถูกต้อง';

  @override
  String get closeAmountCannotBeNegative => 'Amount cannot be negative';

  @override
  String get googleDriveBackupSectionTitle => 'สำรองและซิงค์';

  @override
  String get googleDriveBackupTitle => 'สำรอง Google Drive';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'ลงชื่อเข้าใช้เพื่อสำรองข้อมูลองค์กรอย่างปลอดภัยใน Google Drive';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'ลงชื่อเข้าใช้เป็น $email';
  }

  @override
  String get googleDriveSignIn => 'ลงชื่อเข้าใช้ด้วย Google';

  @override
  String get googleDriveSignOut => 'ออกจากระบบ';

  @override
  String get googleDriveBackupNow => 'สำรองตอนนี้';

  @override
  String get googleDriveSignInSuccess => 'ลงชื่อเข้าใช้ Google Drive แล้ว';

  @override
  String get googleDriveSignOutSuccess => 'ออกจาก Google Drive แล้ว';

  @override
  String get googleDriveSignInCancelled => 'ยกเลิกการลงชื่อเข้าใช้ Google';

  @override
  String get googleDriveBackupStarting => 'กำลังเตรียมสำรอง…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'อัปโหลดสำรองแล้ว ($tableCount ตาราง, $recordCount เรคอร์ด)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'การสำรองต้องรีสตาร์ทแอปทั้งหมด ปิดแอป เปิดใหม่ แล้วลองอีกครั้ง';

  @override
  String googleDriveBackupFailed(String error) {
    return 'สำรองล้มเหลว: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'สำรองล่าสุด: $date';
  }

  @override
  String get backupSyncPageTitle => 'สำรองและซิงค์';

  @override
  String get backupSyncGoogleAccount => 'บัญชี Google';

  @override
  String get backupSyncSignedInAs => 'ลงชื่อเข้าใช้เป็น';

  @override
  String get backupSyncSignInHint =>
      'ลงชื่อเข้าใช้ด้วย Google เพื่อสำรองข้อมูลองค์กร';

  @override
  String get backupSyncLastSyncTitle => 'ซิงค์ล่าสุด';

  @override
  String get backupSyncLastSyncDate => 'วันที่และเวลา';

  @override
  String get backupSyncNeverSynced => 'ยังไม่มีการอัปโหลดสำรองข้อมูล';

  @override
  String get backupSyncOrganization => 'องค์กร';

  @override
  String get backupSyncTables => 'ตารางที่สำรอง';

  @override
  String get backupSyncRecords => 'เรคอร์ดที่สำรอง';

  @override
  String get backupSyncStatus => 'สถานะ';

  @override
  String get backupSyncStatusSuccess => 'เสร็จสมบูรณ์';

  @override
  String get backupSyncActiveOrganization => 'องค์กรปัจจุบัน';

  @override
  String get backupSyncActiveOrganizationHint =>
      'การสำรองอัปโหลดข้อมูลขององค์กรที่คุณใช้อยู่';

  @override
  String get backupSyncUnknownOrganization => 'องค์กรปัจจุบัน';

  @override
  String get backupSyncInProgress => 'กำลังซิงค์';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'ขั้นตอน: $step';
  }

  @override
  String get backupSyncStepExport => 'กำลังส่งออกข้อมูลในเครื่อง';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'กำลังอัปโหลด $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'กำลังอัปโหลด $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'ข้อผิดพลาดล่าสุด: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'ออกจากระบบ Google Drive บนอุปกรณ์นี้?';

  @override
  String get moreBackupSyncTileNeverSynced => 'สำรองไป Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync =>
      'ลงชื่อเข้าใช้แล้ว · ยังไม่มีสำรอง';

  @override
  String get backupSyncConnected => 'เชื่อมต่อแล้ว';

  @override
  String get backupSyncCompletedHint =>
      'ข้อมูลของคุณสำรองอย่างปลอดภัยใน Google Drive แล้ว';

  @override
  String get backupSyncPhaseExport => 'ส่งออก';

  @override
  String get backupSyncPhaseUpload => 'อัปโหลด';

  @override
  String get backupAutoSettingsTitle => 'การตั้งค่า Google Drive';

  @override
  String get backupAutoBackupTitle => 'สำรองข้อมูลอัตโนมัติ';

  @override
  String get backupAutoBackupHint => 'สำรองข้อมูลอัตโนมัติเมื่อเปิดแอปตามกำหนด';

  @override
  String get backupWifiOnlyTitle => 'สำรองผ่าน Wi‑Fi เท่านั้น';

  @override
  String get backupWifiOnlyHint => 'สำรองอัตโนมัติรอ Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => 'ใช้ข้อมูลมือถือ';

  @override
  String get backupAutoFrequencyTitle => 'ความถี่การสำรอง';

  @override
  String get backupAutoFrequencyOff => 'ปิด';

  @override
  String get backupAutoFrequencyDaily => 'รายวัน';

  @override
  String get backupAutoFrequencyWeekly => 'รายสัปดาห์';

  @override
  String get backupAutoFrequencyMonthly => 'รายเดือน';

  @override
  String get backupAutoSyncDirectionTitle => 'ซิงค์อัตโนมัติ';

  @override
  String get backupAutoDirectionUpload => 'อัปโหลดไปคลาวด์';

  @override
  String get backupAutoDirectionDownload => 'ดาวน์โหลดจากคลาวด์';

  @override
  String get backupAutoDirectionBoth => 'อัปโหลดและดาวน์โหลด';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'สำรองอัตโนมัติล่าสุด: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'กู้คืนอัตโนมัติล่าสุด: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'ซิงค์อัตโนมัติล่าสุดล้มเหลว: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'ซิงค์อัตโนมัติล่าสุดข้าม: $detail';
  }

  @override
  String get restoreAction => 'กู้คืน';

  @override
  String get restoreFromGoogleDrive => 'กู้คืนจาก Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'ลงชื่อเข้าใช้และเลือกการสำรองเพื่อกู้คืนองค์กรบนอุปกรณ์นี้';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return 'กู้คืน \"$name\"? จะแทนที่ข้อมูลในเครื่องขององค์กรนั้น';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return 'กู้คืน $name แล้ว คุณสามารถลงชื่อเข้าใช้ได้';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'กู้คืนล้มเหลว: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'ไม่พบการสำรองใน Google Drive ของคุณ';

  @override
  String get restoreFromGoogleDriveStarting => 'กำลังเริ่มกู้คืน…';

  @override
  String get restoreStepDownload => 'กำลังดาวน์โหลดสำรอง';

  @override
  String get restoreStepCreateDatabase => 'กำลังสร้างฐานข้อมูล';

  @override
  String get restoreStepImport => 'กำลังนำเข้าข้อมูล';

  @override
  String get restoreStepFinalize => 'กำลังเสร็จสิ้นการกู้คืน';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'ซิงค์ล่าสุด: $date';
  }

  @override
  String get security => 'ความปลอดภัย';

  @override
  String get appLockTitle => 'ล็อกแอป';

  @override
  String get appLockSubtitle =>
      'ต้องใช้ PIN หรือไบโอเมตริกเมื่อเปิดแอปอีกครั้ง';

  @override
  String get appPin => 'PIN แอป';

  @override
  String appPinSubtitle(int length) {
    return 'ปลดล็อกด่วนด้วย PIN $length หลัก';
  }

  @override
  String get useBiometricUnlock => 'ใช้ Face ID / ไบโอเมตริก';

  @override
  String get useBiometricUnlockSubtitle =>
      'ปลดล็อกด้วยลายนิ้วมือหรือ Face ID หลังตั้ง PIN';

  @override
  String get changeAppPin => 'เปลี่ยน PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'ตั้ง PIN';

  @override
  String get confirmAppPin => 'ยืนยัน PIN';

  @override
  String get enterAppPin => 'ใส่ PIN ของคุณ';

  @override
  String get enterPasscode => 'ใส่รหัส';

  @override
  String tapDigitsToUnlock(int length) {
    return 'แตะตัวเลข $length หลักใดก็ได้เพื่อปลดล็อก';
  }

  @override
  String createPasscodeHint(int length) {
    return 'เลือกรหัส $length หลักสำหรับองค์กรนี้';
  }

  @override
  String get confirmPasscodeHint => 'ใส่รหัสอีกครั้งเพื่อยืนยัน';

  @override
  String createAppPinHint(int length) {
    return 'เลือก PIN $length หลักสำหรับองค์กรนี้';
  }

  @override
  String get confirmAppPinHint => 'ใส่ PIN อีกครั้งเพื่อยืนยัน';

  @override
  String get appPinMismatch => 'PIN ไม่ตรงกัน ลองอีกครั้ง';

  @override
  String get appPinIncorrect => 'PIN ไม่ถูกต้อง ลองอีกครั้ง';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN ไม่ถูกต้อง เหลืออีก $remaining ครั้ง';
  }

  @override
  String get appPinLockoutMessage =>
      'ใส่ PIN ผิดเกินไป ลงชื่อเข้าใช้ด้วยอีเมลและรหัสผ่านเพื่อรีเซ็ต PIN';

  @override
  String get appPinSetSuccess => 'บันทึก PIN สำหรับองค์กรนี้แล้ว';

  @override
  String get appPinRemoved => 'ลบ PIN แอปแล้ว';

  @override
  String get appLockSettingsSaved => 'บันทึกการตั้งค่าการล็อกแอปแล้ว';

  @override
  String get biometricUnlockReason => 'ปลดล็อก BizTrack';

  @override
  String get biometricNotAvailable => 'ไบโอเมตริกไม่พร้อมใช้บนอุปกรณ์นี้';

  @override
  String get biometricRequiresPin => 'ตั้ง PIN แอปก่อนเปิดไบโอเมตริก';

  @override
  String get disableAppPinTitle => 'ลบ PIN แอป?';

  @override
  String get disableAppPinMessage =>
      'Face ID / ปลดล็อกไบโอเมตริกจะปิดสำหรับองค์กรนี้ด้วย';

  @override
  String get verifyPinToRemoveTitle => 'ใส่ PIN ของคุณ';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'ยืนยัน PIN $length หลักเพื่อลบการล็อกแอป';
  }

  @override
  String get unlockApp => 'ปลดล็อกแอป';

  @override
  String get usePinInstead => 'ใช้ PIN แทน';

  @override
  String get useBiometricInstead => 'ใช้ไบโอเมตริก';

  @override
  String get signInWithFaceId => 'ลงชื่อเข้าใช้ด้วย Face ID';

  @override
  String get signInWithFingerprint => 'ลงชื่อเข้าใช้ด้วยลายนิ้วมือ';

  @override
  String get signInWithBiometric => 'ลงชื่อเข้าใช้ด้วยไบโอเมตริก';

  @override
  String get signInWithPin => 'ลงชื่อเข้าใช้ด้วย PIN';

  @override
  String get setUpQuickUnlock => 'ตั้งลงชื่อเข้าใช้ด่วนด้วย PIN';

  @override
  String get setUpFaceIdOrPin => 'ตั้ง Face ID หรือ PIN';

  @override
  String get setUpFingerprintOrPin => 'ตั้งลายนิ้วมือหรือ PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'ใช้ไบโอเมตริกหรือ PIN สำหรับองค์กรนี้';

  @override
  String quickUnlockAsUser(String email) {
    return 'ลงชื่อเข้าใช้ด่วนเป็น $email';
  }

  @override
  String get orContinueWithPassword => 'หรือลงชื่อเข้าใช้ด้วยรหัสผ่าน';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'เปิดลงชื่อเข้าใช้ด่วน?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'ตั้ง Face ID ลายนิ้วมือ หรือ PIN เพื่อลงชื่อเข้าใช้เร็วขึ้นครั้งหน้า เปลี่ยนได้ภายหลังในการตั้งค่า';

  @override
  String get notNow => 'ไม่ใช่ตอนนี้';

  @override
  String get setUpNow => 'ตั้งตอนนี้';

  @override
  String get enableFaceIdTitle => 'เปิด Face ID?';

  @override
  String get enableFingerprintTitle => 'เปิดลายนิ้วมือ?';

  @override
  String get enableBiometricTitle => 'เปิดไบโอเมตริก?';

  @override
  String get enableBiometricAfterPinMessage =>
      'ใช้ไบโอเมตริกของอุปกรณ์ร่วมกับ PIN เพื่อลงชื่อเข้าใช้เร็วขึ้น';

  @override
  String get useFaceIdUnlock => 'ใช้ Face ID';

  @override
  String get useFingerprintUnlock => 'ใช้ลายนิ้วมือ';

  @override
  String get ok => 'ตกลง';

  @override
  String get reportPeriodYear => 'ปี';

  @override
  String get reportPeriodMonth => 'เดือน';

  @override
  String get reportPeriodRange => 'ช่วง';

  @override
  String get reportPeriodDay => 'วัน';

  @override
  String get reportPeriodFrom => 'จาก';

  @override
  String get reportPeriodTo => 'ถึง';

  @override
  String get reportPeriod => 'ช่วงเวลา';

  @override
  String get reportAllPurchases => 'การซื้อทั้งหมด';

  @override
  String get reportBeforeTax => 'ก่อนหักภาษี';

  @override
  String get reportRevenueRetained => 'รายได้คงเหลือ';

  @override
  String get reportHideDetails => 'ซ่อนรายละเอียด';

  @override
  String get reportShowDetails => 'แสดงรายละเอียด';

  @override
  String get reportSalesRevenue => 'รายได้จากการขาย';

  @override
  String get reportDiscountsGiven => 'ส่วนลดที่ให้';

  @override
  String get reportNetRevenue => 'รายได้สุทธิ';

  @override
  String get reportOperatingExpenses => 'ค่าใช้จ่ายในการดำเนินงาน';

  @override
  String get reportTotalExpenses => 'ค่าใช้จ่ายรวม';

  @override
  String get reportGrossProfit => 'กำไรขั้นต้น';

  @override
  String get reportGrossProfitChart => 'กำไรขั้นต้น';

  @override
  String get reportOperatingPlDisclaimer =>
      'ยังไม่รวมภาษี ค่าเสื่อมราคา และหนี้เงินเดือน — ประมาณการกำไรขาดทุนระดับปฏิบัติการ';

  @override
  String get reportContraLabel => 'คู่กัน';

  @override
  String get reportNoDataForPeriod => 'ไม่มีข้อมูลสำหรับช่วงที่เลือก';

  @override
  String get reportRevenueVsExpenses => 'รายได้ vs ค่าใช้จ่าย';

  @override
  String get reportExpenseBreakdown => 'รายละเอียดค่าใช้จ่าย';

  @override
  String get reportExpenseFallback => 'ค่าใช้จ่าย';

  @override
  String get reportGrossMarginPercent => 'อัตรากำไรขั้นต้น %';

  @override
  String get reportRoomVsFnB => 'ห้อง vs F&B';

  @override
  String get reportSegmentRoom => 'ห้อง';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'ตัวชี้วัดหลัก';

  @override
  String get reportIncomeStatement => 'งบกำไรขาดทุน';

  @override
  String get reportChartsSection => 'กราฟ';

  @override
  String get reportSegmentSummary => 'สรุปตามกลุ่ม';

  @override
  String get reportFailedToLoad => 'โหลดรายงานไม่สำเร็จ';

  @override
  String get reportOverview => 'ภาพรวม';

  @override
  String get reportOverviewCash => 'เงินสด';

  @override
  String get reportOverviewBank => 'ธนาคาร';

  @override
  String get reportMonthlyOpeningBalance => 'ยอดยกมาต้นเดือน';

  @override
  String get reportOpeningBalanceHint => 'เงินสดต้นเดือนของแต่ละเดือน';

  @override
  String get reportCashInOut => 'เงินสดเข้า / ออก';

  @override
  String get reportCashIn => 'เงินสดเข้า';

  @override
  String get reportCashOut => 'เงินสดออก';

  @override
  String get reportBankReceiptsPayments => 'เงินรับ / จ่ายธนาคาร';

  @override
  String get reportReceipts => 'เงินรับ';

  @override
  String get reportPayments => 'การชำระเงิน';

  @override
  String get reportDailyCashVsQr => 'เงินสดรายวัน vs QR';

  @override
  String get reportSummariesSection => 'สรุป';

  @override
  String get reportCashSummary => 'สรุปเงินสด';

  @override
  String get reportBankSummary => 'สรุปธนาคาร';

  @override
  String get reportDailySummary => 'สรุปรายวัน';

  @override
  String get reportTabPurchase => 'ซื้อ';

  @override
  String get reportTabSales => 'ขาย';

  @override
  String get reportTabDashboard => 'แดชบอร์ด';

  @override
  String get reportSingleDayTrend => 'วันเดียว — แนวโน้มรายวัน';

  @override
  String get reportFullYearTrend => 'ทั้งปี — กราฟแนวโน้มรายเดือน';

  @override
  String reportYearLabel(String year) {
    return 'ปี $year';
  }

  @override
  String reportJanDec(String year) {
    return 'ม.ค. – ธ.ค. $year';
  }

  @override
  String get reportTotalPurchases => 'ยอดซื้อรวม';

  @override
  String get reportTotalSales => 'ยอดขายรวม';

  @override
  String get reportTotalInvoices => 'ใบแจ้งหนี้รวม';

  @override
  String get reportUnpaidBalance => 'ยอดค้างชำระ';

  @override
  String get reportAvgPerInvoice => 'เฉลี่ยต่อใบแจ้งหนี้';

  @override
  String get reportPerTransaction => 'ต่อรายการ';

  @override
  String reportMonthlySpend(String symbol) {
    return 'ค่าใช้จ่ายรายเดือน ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'ยอดขายรายเดือน ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'จำนวนใบแจ้งหนี้ตามเดือน';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'รายการยอดใช้จ่ายสูงสุด ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'ค่าใช้จ่ายตามหมวดหมู่';

  @override
  String get reportOtherCategory => 'อื่นๆ';

  @override
  String get reportSuppliers => 'ผู้จัดจำหน่าย';

  @override
  String get reportTableSupplier => 'ผู้จัดจำหน่าย';

  @override
  String get reportTableAmount => 'จำนวนเงิน';

  @override
  String get reportTableBills => 'ใบแจ้งหนี้';

  @override
  String get reportSalesTotal => 'ยอดขายรวม';

  @override
  String get reportPurchaseTotal => 'ยอดซื้อรวม';

  @override
  String get reportPositiveMargin => 'มาร์จินบวก';

  @override
  String get reportNegativeMargin => 'มาร์จินติดลบ';

  @override
  String get reportGrossMargin => 'อัตรากำไรขั้นต้น';

  @override
  String get reportOfTotalSales => 'ของยอดขายรวม';

  @override
  String get reportFailedToLoadAnalytics => 'โหลดการวิเคราะห์ไม่สำเร็จ';

  @override
  String get reportMarginKpi => 'มาร์จิน';

  @override
  String get reportExpensesKpi => 'ค่าใช้จ่าย';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'ไม่พบผลลัพธ์สำหรับ \"$query\"';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'ไม่พบคู่ค้า$role';
  }

  @override
  String get partyPickerLoadParties => 'โหลดคู่ค้า';

  @override
  String get invoiceCashCustomer => 'ลูกค้าเงินสด';

  @override
  String get invoiceQuickAddItemsTitle => 'เพิ่มรายการด่วน';

  @override
  String get invoiceQuickLoadingMenu => 'กำลังโหลดเมนู…';

  @override
  String get invoiceQuickInvoiceCreated => 'สร้างใบแจ้งหนี้แล้ว';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'เพิ่มอย่างน้อยหนึ่งรายการ';

  @override
  String get invoiceQuickNoResults => 'ไม่พบผลลัพธ์!';

  @override
  String get invoiceQuickNoItemsInCategory => 'ไม่มีรายการในหมวดหมู่นี้';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'เพิ่มรายการ';

  @override
  String get invoiceQuickLoadMore => 'โหลดเพิ่ม';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'เลื่อนเพื่อโหลดเพิ่ม ($count ต่อหน้า)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'ผู้จัดจำหน่าย / พนักงาน';

  @override
  String get invoiceQuickEditItem => 'แก้ไขรายการ';

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
  String get closeSelectDateRange => 'เลือกช่วงวันที่';

  @override
  String get closeStartDate => 'วันที่เริ่มต้น';

  @override
  String get closeEndDate => 'วันที่สิ้นสุด';

  @override
  String get closeSelectBothDates => 'กรุณาเลือกวันที่เริ่มต้นและสิ้นสุด';

  @override
  String get closeDeleteSummary => 'ลบสรุป';

  @override
  String get closeDeleteSummaryConfirm => 'คุณแน่ใจหรือไม่ว่าต้องการลบสรุปนี้?';

  @override
  String get closeSelectDate => 'เลือกวันที่';

  @override
  String get closeNoDataToExport => 'ไม่มีข้อมูลให้ส่งออก';

  @override
  String get closeNoDataToShare => 'ไม่มีข้อมูลให้แชร์';

  @override
  String get closeNoDataToPrint => 'ไม่มีข้อมูลให้พิมพ์';

  @override
  String closePdfGenerateError(String error) {
    return 'ข้อผิดพลาดในการสร้าง PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'ข้อผิดพลาดในการแชร์ PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'ข้อผิดพลาดในการพิมพ์ PDF: $error';
  }

  @override
  String get closeExportPdf => 'ส่งออกเป็น PDF';

  @override
  String get closeSharePdf => 'แชร์ PDF';

  @override
  String get closePrint => 'พิมพ์';

  @override
  String get closeExportOptions => 'ตัวเลือกการส่งออก';

  @override
  String get closeExportPdfSubtitle => 'บันทึกหรือดูเป็นเอกสาร PDF';

  @override
  String get closeSharePdfSubtitle => 'แชร์ผ่านแอปหรืออีเมล';

  @override
  String get closePrintSubtitle => 'พิมพ์รายงาน';

  @override
  String get closeDailyCashSummaryTitle => 'สรุปเงินสดรายวัน';

  @override
  String get closeDailyCashSummaryReport => 'รายงานสรุปเงินสดรายวัน';

  @override
  String closeGeneratedAt(String date) {
    return 'สร้างเมื่อ: $date';
  }

  @override
  String get closeTotalRecords => 'จำนวนบันทึกทั้งหมด';

  @override
  String get closeSummaryOverview => 'ภาพรวมสรุป';

  @override
  String get closeAllRecords => 'บันทึกทั้งหมด';

  @override
  String closePeriodRange(String start, String end) {
    return 'ช่วงเวลา: $start ถึง $end';
  }

  @override
  String get closeDetails => 'รายละเอียด';

  @override
  String closePageN(int n) {
    return 'หน้า $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'แสดง $shown จาก $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'โหลดแล้ว: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'ห้อง / กะเรือ / พนักงาน';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent% ของรายได้';
  }

  @override
  String get reportParties => 'คู่ค้า';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — กราฟแนวโน้มรายวัน';
  }

  @override
  String get invoiceQuickCart => 'ตะกร้า';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'ตะกร้า ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'ล้างการค้นหา';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'เพิ่มสรุป';

  @override
  String get closeSalesAmount => 'ยอดขาย';

  @override
  String get closeClosingBalance => 'ยอดคงเหลือปิด';

  @override
  String get closeLostMoney => 'เงินสูญหาย';

  @override
  String get closeDiscount => 'ส่วนลด';

  @override
  String get closeExpenses => 'ค่าใช้จ่าย';

  @override
  String get closeUnpaid => 'ค้างชำระ';

  @override
  String get closeTotalOpeningBalance => 'ยอดเปิดรวม';

  @override
  String get closeTotalSalesAmount => 'ยอดขายรวม';

  @override
  String get closeTotalCashAmount => 'เงินสดรวม';

  @override
  String get closeTotalQrAmount => 'QR รวม';

  @override
  String get closeTotalDiscount => 'ส่วนลดรวม';

  @override
  String get closeTotalExpenses => 'ค่าใช้จ่ายรวม';

  @override
  String get closeTotalClosingBalance => 'ยอดปิดรวม';

  @override
  String get closeTotalLostMoney => 'เงินสูญหายรวม';

  @override
  String get closeTotalExtraAmount => 'จำนวนเพิ่มเติมรวม';

  @override
  String get closeShowingCurrentMonth => 'แสดงข้อมูลเดือนนี้';

  @override
  String get closeNoSummariesFound => 'ไม่พบสรุป';

  @override
  String get closeNoSummariesAvailable => 'ไม่มีสรุป';

  @override
  String get closeTryAdjustingDateRange => 'ลองปรับช่วงวันที่';

  @override
  String get closeCreateFirstSummary => 'สร้างสรุปแรกเพื่อเริ่มต้น';

  @override
  String get closeClearFilter => 'ล้างตัวกรอง';

  @override
  String get closeFiltered => 'กรองแล้ว';

  @override
  String closeFilteredWithRange(String range) {
    return 'กรองแล้ว: $range';
  }

  @override
  String get closeSummarySingular => 'สรุป';

  @override
  String get closeSummariesPlural => 'สรุป';

  @override
  String get closeSummaryUpdatedSuccess => 'อัปเดตสรุปสำเร็จ';

  @override
  String get closeSummaryDeletedSuccess => 'ลบสรุปสำเร็จ';

  @override
  String premiumUnlockTitle(String appName) {
    return 'ปลดล็อก $appName Premium';
  }

  @override
  String get premiumTagline =>
      'POS ออฟไลน์ครบ ใบแจ้งหนี้ สต็อก และรายงาน — สมัครสมาชิกเดียวสำหรับธุรกิจของคุณ';

  @override
  String get premiumFeatureUnlimitedInvoices => 'ใบแจ้งหนี้และใบเสร็จไม่จำกัด';

  @override
  String get premiumFeatureInventoryStock => 'สินค้าคงคลังและติดตามสต็อก';

  @override
  String get premiumFeatureReportsAnalytics => 'รายงานยอดขายและการวิเคราะห์';

  @override
  String get premiumFeatureOfflineLocal =>
      'ใช้งานออฟไลน์ได้ — ข้อมูลอยู่ในเครื่อง';

  @override
  String premiumContinueWith(String plan) {
    return 'ดำเนินการต่อด้วย $plan';
  }

  @override
  String get premiumRestorePurchases => 'กู้คืนการซื้อ';

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
      'เรียกเก็บเงินผ่าน Apple ID ของคุณ สมาชิกต่ออายุอัตโนมัติ เว้นแต่ยกเลิกอย่างน้อย 24 ชม. ก่อนสิ้นสุดรอบ';

  @override
  String get premiumPurchaseRestored => 'กู้คืนการซื้อแล้ว';

  @override
  String get premiumNoActiveSubscription => 'ไม่พบสมาชิกที่ใช้งานอยู่';

  @override
  String get premiumPlanMonthly => 'รายเดือน';

  @override
  String get premiumPlanMonthlySubtitle => 'ยืดหยุ่น — ยกเลิกได้ทุกเมื่อ';

  @override
  String get premiumPlanYearly => 'รายปี';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'คุ้มที่สุด — ประหยัด $percent%';
  }

  @override
  String get premiumPlanLifetime => 'ตลอดชีพ';

  @override
  String get premiumPlanLifetimeSubtitle => 'จ่ายครั้งเดียว ใช้ได้ตลอดไป';

  @override
  String get premiumPlanPopular => 'ยอดนิยม';

  @override
  String get premiumOneTimePurchase => 'ซื้อครั้งเดียว';

  @override
  String get subscriptionSectionTitle => 'สมาชิก';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'อัปเกรดเป็น Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'รายเดือน $monthly · รายปี $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan ใช้งานได้ถึง $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan ใช้งานอยู่';
  }

  @override
  String get premiumRequired => 'ต้องใช้ Premium';

  @override
  String get upgradeToPremiumContinue =>
      'อัปเกรดเป็น Premium เพื่อดำเนินการต่อ';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'แผนฟรีอนุญาตสูงสุด $limit $label อัปเกรดเป็น Premium เพื่อเข้าถึงไม่จำกัด';
  }

  @override
  String get freemiumPartyRoleRequired => 'ต้องระบุบทบาทคู่ค้า';

  @override
  String get freemiumLabelSalesInvoices => 'ใบแจ้งหนี้ขาย';

  @override
  String get freemiumLabelPurchaseInvoices => 'ใบแจ้งหนี้ซื้อ';

  @override
  String get freemiumLabelEmployees => 'พนักงาน';

  @override
  String get freemiumLabelItems => 'สินค้า';

  @override
  String get freemiumLabelCategories => 'หมวดหมู่';

  @override
  String get freemiumLabelPaymentMethods => 'วิธีชำระเงิน';

  @override
  String get freemiumLabelCustomPartyRoles => 'บทบาทคู่ค้าแบบกำหนดเอง';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'คู่ค้าสำหรับ $role';
  }

  @override
  String get freemiumLabelOrganizations => 'องค์กร';

  @override
  String get freemiumPremiumReports => 'รายงานใช้ได้กับ Premium';

  @override
  String get freemiumPremiumBackupSync => 'สำรองและซิงค์ต้องใช้ Premium';

  @override
  String get freemiumPremiumPayroll => 'เงินเดือนต้องใช้ Premium';

  @override
  String get freemiumPremiumAttendance => 'การเข้างานต้องใช้ Premium';

  @override
  String get freemiumPremiumStock => 'การจัดการสต็อกต้องใช้ Premium';

  @override
  String get freemiumPremiumInvoiceExport => 'ดาวน์โหลดและพิมพ์ต้องใช้ Premium';

  @override
  String get shiftReminderOpeningTitle => 'แจ้งเตือนเปิดร้าน';

  @override
  String get shiftReminderOpeningMessage =>
      'คุณเปิดเครื่องบันทึกเงินสดวันนี้แล้วหรือยัง?';

  @override
  String get shiftReminderOpeningProceed => 'ใช่ เปิดเลย';

  @override
  String get shiftReminderClosingTitle => 'แจ้งเตือนปิดร้าน';

  @override
  String get shiftReminderClosingMessage =>
      'คุณปิดเครื่องบันทึกเงินสดวันนี้แล้วหรือยัง?';

  @override
  String get shiftReminderClosingProceed => 'ใช่ ปิดเลย';

  @override
  String get shiftReminderSkipToday => 'ข้ามวันนี้';

  @override
  String get shiftReminderOpeningNotificationTitle => 'แจ้งเตือนเปิดร้าน';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'คุณเปิดเครื่องบันทึกเงินสดวันนี้แล้วหรือยัง? แตะที่นี่หากยังต้องเปิด';

  @override
  String get shiftReminderClosingNotificationTitle => 'แจ้งเตือนปิดร้าน';

  @override
  String get shiftReminderClosingNotificationBody =>
      'คุณปิดเครื่องบันทึกเงินสดวันนี้แล้วหรือยัง? แตะที่นี่หากยังต้องปิด';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business จ่าย QR ให้ลูกค้า ลูกค้าให้เงินสด';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business จ่ายเงินสดให้ลูกค้า ลูกค้าจ่าย QR';
  }

  @override
  String get closePaymentExchange => 'แลกเปลี่ยนการชำระเงิน';

  @override
  String get closePayQrGetCashExchangeLabel =>
      'จ่าย QR → รับเงินสด (แลกเปลี่ยน)';

  @override
  String get closePayCashGetQrExchangeLabel =>
      'จ่ายเงินสด → รับ QR (แลกเปลี่ยน)';

  @override
  String get closePayQrGetCashDetail => 'จ่าย QR รับเงินสด';

  @override
  String get closePayCashGetQrDetail => 'จ่ายเงินสด รับ QR';

  @override
  String get faqSectionPremium => 'Premium และการเรียกเก็บเงิน';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium รวมอะไรบ้าง?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium ปลดล็อกใบแจ้งหนี้ไม่จำกัด รายงานครบ (P&L, งบ, การวิเคราะห์) สำรองและซิงค์ เงินเดือน การเข้างาน เครื่องมือสต็อก ส่งออก/พิมพ์ใบแจ้งหนี้ และองค์กรเพิ่มเติม ระดับฟรียังใช้ฟีเจอร์ POS หลักได้ภายในขีดจำกัดที่เหมาะสม';

  @override
  String get faqPremiumFreeTierQuestion => 'ระดับฟรีรวมอะไรบ้าง?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'สร้างใบแจ้งหนี้ขายและซื้อได้อย่างละ 10 ใบ พนักงาน 4 คน สินค้า 30 รายการ และขีดจำกัดอื่นเมื่อถึง การเปิด ปิด เครื่องคิดเลข และดูข้อมูลยังฟรี';

  @override
  String get faqPremiumRestoreQuestion => 'กู้คืนการซื้ออย่างไร?';

  @override
  String get faqPremiumRestoreAnswer =>
      'เปิด เพิ่มเติม → อัปเกรดเป็น Premium (หรือหน้าจ่ายเงิน) แล้วแตะ กู้คืนการซื้อ ใช้ Apple ID เดียวกับตอนสมัคร';

  @override
  String get faqPremiumCancelQuestion => 'ยกเลิกสมาชิกอย่างไร?';

  @override
  String get faqPremiumCancelAnswer =>
      'จัดการหรือยกเลิกใน การตั้งค่า iPhone → Apple ID → การสมัครสมาชิก ยังเข้าใช้ได้จนสิ้นสุดรอบที่ชำระแล้ว';

  @override
  String get faqDarkModeQuestion => 'เปิดโหมดมืดอย่างไร?';

  @override
  String get faqDarkModeAnswer =>
      'เปิด เพิ่มเติม → รูปลักษณ์ แล้วเปิด โหมดมืด เมื่ออุปกรณ์ใช้ธีมระบบ แอปจะตามอัตโนมัติ';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'การแจ้งเตือนเปิดและปิดคืออะไร?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName สามารถเตือนให้เปิดหรือปิดเครื่องบันทึกเงินสดรายวัน คุณดำเนินการต่อ ข้ามวันนี้ หรือปิดการแจ้งเตือนได้';
  }

  @override
  String get faqPartyRolesQuestion => 'บทบาทคู่ค้าคืออะไร?';

  @override
  String get faqPartyRolesAnswer =>
      'บทบาทคู่ค้าจัดประเภทผู้ติดต่อ เช่น ลูกค้า ผู้จัดหา ห้อง หรือพนักงาน ปรับแต่งที่ การดำเนินงาน → บทบาทคู่ค้า และเพิ่มคำอธิบายสั้นๆ ให้ทีม';

  @override
  String faqRateAppQuestion(String appName) {
    return 'ให้คะแนน $appName อย่างไร?';
  }

  @override
  String get faqRateAppAnswer =>
      'เปิด เพิ่มเติม → ให้คะแนนเรา เพื่อรีวิวบน App Store ความคิดเห็นของคุณช่วยปรับปรุงการเรียกเก็บเงินออฟไลน์';
}
