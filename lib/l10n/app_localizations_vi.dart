// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get noInternetConnection => 'Không có kết nối Internet.';

  @override
  String get formatException => 'Ngoại lệ định dạng';

  @override
  String get rememberMe => 'Ghi nhớ tôi';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get passwordHint => 'Nhập mật khẩu';

  @override
  String get forgetPassword => 'Quên thông tin đăng nhập?';

  @override
  String get okay => 'OK';

  @override
  String get success => 'Thành công';

  @override
  String get hotel => 'khách sạn';

  @override
  String get errorEncountered => 'Đã xảy ra lỗi';

  @override
  String get serverError => 'Lỗi máy chủ';

  @override
  String get requestFailed => 'Yêu cầu thất bại';

  @override
  String get connectionTimedOut => 'Kết nối hết thời gian';

  @override
  String get password => 'Mật khẩu';

  @override
  String get keepSignIn => 'Duy trì đăng nhập';

  @override
  String get enterPassword => 'Nhập mật khẩu';

  @override
  String get enterValidPassword => 'Nhập mật khẩu hợp lệ';

  @override
  String get skip => 'BỎ QUA';

  @override
  String get pleaseWait => 'Vui lòng chờ ....';

  @override
  String get enterValidUserName => 'Nhập tên người dùng hợp lệ.';

  @override
  String get userName => 'Tên người dùng';

  @override
  String get or => 'Hoặc';

  @override
  String get retry => 'Thử lại';

  @override
  String get error => 'Lỗi';

  @override
  String get supportMessage => 'Vui lòng liên hệ quản trị viên.';

  @override
  String get responseMessage404 => 'Lỗi 404';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get cancel => 'Hủy';

  @override
  String get yes => 'Có';

  @override
  String get no => 'Không';

  @override
  String get close => 'Đóng';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get deleteOrganizationTitle => 'Xóa tổ chức?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'Xóa $name khỏi thiết bị này. Tất cả dữ liệu cục bộ của tổ chức này sẽ bị xóa.';
  }

  @override
  String get deleteOrganizationWarning => 'Thao tác này không thể hoàn tác.';

  @override
  String get organizationDeleted => 'Đã xóa tổ chức';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get done => 'Xong';

  @override
  String get next => 'Tiếp theo';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get walkthroughDashboardTitle =>
      'Toàn bộ doanh nghiệp trong một cái nhìn';

  @override
  String get walkthroughDashboardDescription =>
      'Doanh số hôm nay, doanh thu và công nợ — tất cả trên bảng điều khiển rõ ràng khi mở ứng dụng.';

  @override
  String get walkthroughOfflineTitle => 'Hoạt động không cần internet';

  @override
  String get walkthroughOfflineDescription =>
      'Tạo hóa đơn, ghi chi phí và quản lý kho hoàn toàn ngoại tuyến. Tự động đồng bộ khi trực tuyến.';

  @override
  String get walkthroughBillingTitle => 'Lập hóa đơn và bán trong vài giây';

  @override
  String get walkthroughBillingDescription =>
      'Hóa đơn bán và mua, đơn bàn với phiếu bếp, và tồn kho trực tiếp — tất cả trong một ứng dụng.';

  @override
  String get walkthroughStaffTitle => 'Nhân viên, lương & báo cáo';

  @override
  String get walkthroughStaffDescription =>
      'Quản lý chấm công và lương, xuất P&L và phiếu lương PDF — không cần công cụ thêm.';

  @override
  String get walkthroughBackupTitle => 'Dữ liệu của bạn, luôn an toàn';

  @override
  String get walkthroughBackupDescription =>
      'Bảo mật cấp ngân hàng với sao lưu Google Drive một chạm — dữ liệu được bảo vệ và dễ khôi phục.';

  @override
  String get walkthroughReadyTitle => 'Sẵn sàng khi bạn sẵn sàng';

  @override
  String get walkthroughReadyDescription =>
      'Thiết lập tổ chức trong vài phút và vận hành thông minh hơn từ hôm nay. Bắt đầu thôi.';

  @override
  String get back => 'Quay lại';

  @override
  String get submit => 'Gửi';

  @override
  String get continueAction => 'Tiếp tục';

  @override
  String get createAction => 'Tạo';

  @override
  String get connectOrganizationTitle => 'Kết nối tổ chức của bạn';

  @override
  String get connectOrganizationSubtitle => 'Chọn một tổ chức để đăng nhập.';

  @override
  String get selectOrganization => 'Tổ chức';

  @override
  String get selectOrganizationHint => 'Nhấn vào tổ chức để tiếp tục';

  @override
  String get noSavedOrganizationsYet =>
      'Chưa có tổ chức nào. Tạo một tổ chức hoặc sử dụng dữ liệu thử nghiệm bên dưới.';

  @override
  String get orgConnectOnceInfo =>
      'Điều này liên kết ứng dụng với tài khoản doanh nghiệp của bạn. Bạn chỉ cần thiết lập một lần trên mỗi thiết bị.';

  @override
  String organizationCodeLabel(String code) {
    return 'Mã: $code';
  }

  @override
  String get tryAgain => 'Thử lại';

  @override
  String get warning => 'CẢNH BÁO';

  @override
  String get loading => 'Đang tải…';

  @override
  String get comingSoon => 'Sắp ra mắt';

  @override
  String get required => 'Bắt buộc';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get add => 'Thêm';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get remove => 'Xóa';

  @override
  String get view => 'Xem';

  @override
  String get export => 'Xuất';

  @override
  String get exportAsPdf => 'Xuất dưới dạng PDF';

  @override
  String get sharePdf => 'Chia sẻ PDF';

  @override
  String get partyExportPdfTooltip => 'Xuất PDF';

  @override
  String get import => 'Nhập';

  @override
  String get refresh => 'Làm mới';

  @override
  String get select => 'Chọn';

  @override
  String get upload => 'Tải lên';

  @override
  String get download => 'Tải xuống';

  @override
  String get share => 'Chia sẻ';

  @override
  String get filter => 'Lọc';

  @override
  String get sort => 'Sắp xếp';

  @override
  String get apply => 'Áp dụng';

  @override
  String get reset => 'Đặt lại';

  @override
  String get clear => 'Xóa';

  @override
  String get all => 'Tất cả';

  @override
  String get none => 'Không có';

  @override
  String get total => 'Tổng';

  @override
  String get subtotal => 'Tổng phụ';

  @override
  String get grandTotal => 'Tổng Cộng';

  @override
  String get amount => 'Số tiền';

  @override
  String get quantity => 'Số lượng';

  @override
  String get rate => 'Đơn giá';

  @override
  String get discount => 'Chiết khấu';

  @override
  String get paid => 'Đã thanh toán';

  @override
  String get unpaid => 'Chưa thanh toán';

  @override
  String get credit => 'Tín dụng';

  @override
  String get cash => 'Tiền mặt';

  @override
  String get date => 'Ngày';

  @override
  String get time => 'Giờ';

  @override
  String get name => 'Tên';

  @override
  String get email => 'E-mail';

  @override
  String get phone => 'Điện thoại';

  @override
  String get address => 'Địa chỉ';

  @override
  String get notes => 'Ghi chú';

  @override
  String get description => 'Mô tả';

  @override
  String get status => 'Trạng thái';

  @override
  String get type => 'Loại';

  @override
  String get category => 'Danh mục';

  @override
  String get party => 'Đối tác';

  @override
  String get item => 'Mặt hàng';

  @override
  String get payment => 'Thanh toán';

  @override
  String get settlement => 'Quyết toán';

  @override
  String get opening => 'Đầu kỳ';

  @override
  String get closing => 'Cuối kỳ';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'Chi phí';

  @override
  String get revenue => 'Doanh thu';

  @override
  String get profit => 'Lợi nhuận';

  @override
  String get loss => 'Lỗ';

  @override
  String get sales => 'Bán hàng';

  @override
  String get purchase => 'Mua hàng';

  @override
  String get monthJan => 'Th1';

  @override
  String get monthFeb => 'Th2';

  @override
  String get monthMar => 'Th3';

  @override
  String get monthApr => 'Th4';

  @override
  String get monthMay => 'Th5';

  @override
  String get monthJun => 'Th6';

  @override
  String get monthJul => 'Th7';

  @override
  String get monthAug => 'Th8';

  @override
  String get monthSep => 'Th9';

  @override
  String get monthOct => 'Th10';

  @override
  String get monthNov => 'Th11';

  @override
  String get monthDec => 'Th12';

  @override
  String get more => 'Thêm';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get operations => 'Vận hành';

  @override
  String get operationManagement => 'Quản lý vận hành';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'Quản lý nhân viên';

  @override
  String get employeeManagementSubtitle => 'Nhân viên, lương và chấm công';

  @override
  String get report => 'Báo cáo';

  @override
  String get reportSubtitle => 'Lãi lỗ, báo cáo và phân tích';

  @override
  String get helpAndSupport => 'Trợ giúp và hỗ trợ';

  @override
  String get preferences => 'Tùy chọn';

  @override
  String get dataAndBackup => 'Dữ liệu & Sao lưu';

  @override
  String get privacyAndPolicies => 'Quyền riêng tư và chính sách';

  @override
  String get faq => 'Câu hỏi thường gặp';

  @override
  String get contactSupport => 'Liên hệ hỗ trợ';

  @override
  String get rateUs => 'Đánh giá chúng tôi';

  @override
  String get rateUsSubtitle =>
      'Bạn thích BizTrack không? Để lại đánh giá trên Google Play';

  @override
  String get rateUsUnavailable =>
      'Không thể mở cửa hàng. Vui lòng thử lại sau.';

  @override
  String get reportProblem => 'Báo lỗi';

  @override
  String get contactUs => 'Liên hệ';

  @override
  String get contactUsSubtitle => 'Hỗ trợ, phản hồi hoặc câu hỏi về ứng dụng.';

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
  String get developerLabel => 'Nhà phát triển';

  @override
  String get emailCopiedToClipboard => 'Đã sao chép email vào clipboard';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get settings => 'Cài đặt';

  @override
  String get testData => 'Dữ liệu thử nghiệm';

  @override
  String get loginWithTestData => 'Đăng nhập với dữ liệu thử nghiệm';

  @override
  String get loginWithTestDataSubtitle =>
      'Tải dữ liệu khách sạn demo và đăng nhập tự động';

  @override
  String testDataLoginFailed(String error) {
    return 'Không thể tải dữ liệu thử nghiệm: $error';
  }

  @override
  String get preparingTestData => 'Đang chuẩn bị dữ liệu demo…';

  @override
  String get regionAndCurrency => 'Khu vực và tiền tệ';

  @override
  String get reportingCurrency => 'Tiền tệ báo cáo';

  @override
  String get selectCurrency => 'Chọn tiền tệ';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · ví dụ $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'Tiền tệ được đặt thành $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'Không thể cập nhật tiền tệ: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'Thiết lập $appName';
  }

  @override
  String get setupSubtitle =>
      'Cấu hình tổ chức và kế toán của bạn — được lưu trên thiết bị này để sử dụng ngoại tuyến.';

  @override
  String get setupOrganizationName => 'Tên tổ chức';

  @override
  String get setupCompanyName => 'Tên công ty';

  @override
  String get setupBusinessType => 'Loại hình kinh doanh';

  @override
  String get selectBusinessType => 'Chọn loại hình kinh doanh';

  @override
  String get businessTypeHotel => 'Khách sạn';

  @override
  String get businessTypeHotelSubtitle => 'Phòng, khách và quầy lễ tân';

  @override
  String get businessTypeRestaurant => 'Nhà hàng';

  @override
  String get businessTypeRestaurantSubtitle => 'Đặt món tại chỗ, bếp và bàn';

  @override
  String get businessTypeHotelRestaurant => 'Khách sạn & Nhà hàng';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Phòng khách sạn và nhà hàng cùng nhau';

  @override
  String get businessTypeRetail => 'Bán lẻ / Cửa hàng';

  @override
  String get businessTypeRetailSubtitle => 'Sản phẩm, hàng tồn và thanh toán';

  @override
  String get businessTypeCafe => 'Café / Tiệm bánh';

  @override
  String get businessTypeCafeSubtitle => 'Cà phê, bánh ngọt và đồ ăn nhẹ';

  @override
  String get businessTypeBar => 'Quán bar / quán rượu';

  @override
  String get businessTypeBarSubtitle =>
      'Thực đơn đồ uống, tab & bán hàng tại quầy bar';

  @override
  String get businessTypeOther => 'Khác';

  @override
  String get businessTypeOtherSubtitle =>
      'Thiết lập tùy chỉnh cho bất kỳ doanh nghiệp nào';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'Loại: $type';
  }

  @override
  String get organizationSettings => 'Tổ chức';

  @override
  String get editOrganizationInfo => 'Thông tin tổ chức';

  @override
  String get editOrganizationInfoSubtitle =>
      'Cập nhật cách doanh nghiệp này hiển thị trong ứng dụng. Mã tổ chức không thể thay đổi.';

  @override
  String get organizationCode => 'Mã tổ chức';

  @override
  String get organizationCodeReadOnly =>
      'Mã này được cố định sau khi thiết lập.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'Thông tin tổ chức đã được lưu';

  @override
  String get organizationInfoLoadFailed => 'Không thể tải thông tin tổ chức';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'Không thể lưu thông tin tổ chức: $error';
  }

  @override
  String get organizationTabGeneral => 'Chung';

  @override
  String get organizationTabRegional => 'Khu vực & tài chính';

  @override
  String get organizationRegionalSubtitle =>
      'Quốc gia, tiền tệ báo cáo và ngày năm tài chính.';

  @override
  String get organizationTabAccounting => 'Kế toán';

  @override
  String get organizationAccountingSubtitle =>
      'Cài đặt hóa đơn và hiển thị số tiền.';

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
  String get displayPrecision => 'Độ chính xác hiển thị';

  @override
  String get displayPrecisionRange => 'Nhập số từ 0 đến 5';

  @override
  String get enableInvoiceReturns => 'Bật trả hàng hóa đơn';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'Cho phép tạo trả hàng từ hóa đơn đã thanh toán.';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get setupFullName => 'Họ và tên';

  @override
  String get setupConfirmPassword => 'Xác nhận mật khẩu';

  @override
  String get setupBankName => 'Tên ngân hàng';

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
  String get setupRegionStepTitle => 'Khu vực và tiền tệ';

  @override
  String get setupOrganizationStepTitle => 'Tổ chức';

  @override
  String get setupOrganizationStepSubtitle =>
      'Cách doanh nghiệp của bạn hiển thị trong ứng dụng';

  @override
  String get setupAdminStepTitle => 'Tài khoản quản trị';

  @override
  String get setupAdminStepSubtitle => 'Người dùng chính cho lần cài đặt này';

  @override
  String get setupAccountingStepTitle => 'Kế toán';

  @override
  String get setupAccountingStepSubtitle =>
      'Ngân hàng, danh mục tài khoản và năm tài chính';

  @override
  String get setupCompleteSetup => 'Hoàn tất cài đặt';

  @override
  String fieldRequired(String field) {
    return '$field là bắt buộc';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'Nhập địa chỉ email hợp lệ';

  @override
  String passwordMinLength(int min) {
    return 'Mật khẩu phải có ít nhất $min ký tự';
  }

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get setupFixValidationErrors =>
      'Vui lòng sửa các lỗi bên dưới để tiếp tục';

  @override
  String get setupCompleteSuccess => 'Cài đặt hoàn tất thành công';

  @override
  String get setupCompleteWithPdfSuccess =>
      'Cài đặt hoàn tất. Lưu PDF ở nơi an toàn.';

  @override
  String setupPdfFailed(String error) {
    return 'Cài đặt hoàn tất, nhưng không thể lưu PDF: $error';
  }

  @override
  String get setupFailed => 'Không thể hoàn tất cài đặt. Vui lòng thử lại.';

  @override
  String setupFailedWithDetails(String error) {
    return 'Cài đặt thất bại: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'Cài đặt vùng và tiền tệ báo cáo.';

  @override
  String get country => 'Quốc gia';

  @override
  String get currency => 'Tiền tệ';

  @override
  String get selectCountry => 'Chọn quốc gia';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get languageChangeLaterHint => 'Bạn có thể thay đổi sau trong cài đặt';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'Chọn cách bạn muốn sử dụng $appName. Bạn có thể thay đổi sau trong Cài đặt.';
  }

  @override
  String get searchLanguages => 'Tìm ngôn ngữ';

  @override
  String get languageSuggestedBadge => 'ĐỀ XUẤT';

  @override
  String continueInLanguage(String languageName) {
    return 'Tiếp tục bằng $languageName';
  }

  @override
  String get noLanguageMatches => 'Không có kết quả';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'Không có ngôn ngữ nào khớp với \"$query\"';
  }

  @override
  String get appearance => 'Giao diện';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get darkModeSubtitle => 'Dùng nền tối trong toàn ứng dụng';

  @override
  String get darkModeSystemSubtitle => 'Theo giao diện thiết bị';

  @override
  String languageUpdated(String name) {
    return 'Ngôn ngữ được đặt thành $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'Không thể cập nhật ngôn ngữ: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'Chào mừng đến với $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'Vui lòng cài đặt phiên bản mới nhất của $appName để tiếp tục.';
  }

  @override
  String generatedByApp(String appName) {
    return 'Được tạo bởi $appName';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName là gì?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName giúp bạn quản lý hóa đơn bán hàng và mua hàng, đối tác (khách hàng và nhà cung cấp), tồn kho, thanh toán, nhân viên và tóm tắt hàng ngày — từ điện thoại hoặc máy tính bảng của bạn.';
  }

  @override
  String faqIntro(String appName) {
    return 'Câu trả lời cho các câu hỏi thường gặp về $appName.';
  }

  @override
  String get chooseFromGallery => 'Chọn từ Thư viện';

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get photoLibrary => 'Thư viện ảnh';

  @override
  String get addPhoto => 'Thêm ảnh';

  @override
  String couldNotPickImage(String error) {
    return 'Không thể chọn ảnh: $error';
  }

  @override
  String get unpaidAmount => 'Chưa thanh toán Số tiền';

  @override
  String get unpaidBalance => 'Chưa thanh toán';

  @override
  String unpaidColonAmount(String amount) {
    return 'Chưa thanh toán: $amount';
  }

  @override
  String get previousUnpaid => 'Chưa thanh toán';

  @override
  String get partyUnpaid => 'Chưa thanh toán';

  @override
  String get loadingUnpaid => 'Chưa thanh toán…';

  @override
  String get totalUnpaid => 'Chưa thanh toán';

  @override
  String get unpaidAmountNotYetCollected =>
      'Số tiền chưa thanh toán chưa được thu.';

  @override
  String get partyUnpaidTabHint =>
      'Mở Nhân viên, chọn một người, sau đó nhấn Đối tác chưa thanh toán trên hồ sơ của họ. Máy chủ cần ID nhân viên để tìm kiếm này.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'Thanh toán đối tác sử dụng tổng số chưa thanh toán.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'Nhập số tiền thanh toán trước (hoặc chọn đối tác có số tiền chưa thanh toán).';

  @override
  String get workspace => 'Không gian làm việc';

  @override
  String get change => 'Thay đổi';

  @override
  String get addMoreOrganization => 'Thêm +';

  @override
  String get connectAnotherOrganization => 'Kết nối tổ chức khác';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'Chưa có tổ chức đã lưu. Dùng Thêm + để kết nối.';

  @override
  String get registerNewOrganizationTitleSignedIn => 'Đăng ký tổ chức mới?';

  @override
  String get registerNewOrganizationTitle => 'Đăng ký tổ chức mới?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'Bạn sẽ đăng xuất và trình hướng dẫn thiết lập sẽ bắt đầu từ đầu để bạn có thể đăng ký doanh nghiệp mới trên thiết bị này.\n\nCác tổ chức bạn đã lưu sẽ vẫn còn trong danh sách sau khi thiết lập.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'Trình hướng dẫn thiết lập sẽ bắt đầu để bạn có thể đăng ký doanh nghiệp mới trên thiết bị này. Hoàn tất thiết lập để tạo nó; các tổ chức đã lưu của bạn vẫn còn trong danh sách.';

  @override
  String get startSetup => 'Bắt đầu thiết lập';

  @override
  String get enterOrganizationCode => 'Vui lòng nhập mã tổ chức của bạn';

  @override
  String get organizationNotFoundCheckCode =>
      'Không tìm thấy tổ chức. Kiểm tra mã và thử lại.';

  @override
  String get organizationNotFound => 'Không tìm thấy tổ chức';

  @override
  String get couldNotVerifyOrganization => 'Không thể xác minh tổ chức';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'Không có dữ liệu cục bộ cho $name. Hoàn tất thiết lập cho tổ chức này trước.';
  }

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get signInToContinue => 'Đăng nhập để tiếp tục';

  @override
  String get enterEmail => 'Nhập email';

  @override
  String get pleaseEnterEmail => 'Vui lòng nhập email của bạn';

  @override
  String get pleaseEnterValidEmail => 'Vui lòng nhập email hợp lệ';

  @override
  String get enterEmailLocalPartOnly => 'Chỉ nhập phần trước @';

  @override
  String get pleaseEnterPassword => 'Vui lòng nhập mật khẩu của bạn';

  @override
  String get logIn => 'ĐĂNG NHẬP';

  @override
  String get searchCountry => 'Tìm kiếm quốc gia';

  @override
  String get searchCodeOrSymbol => 'Tìm kiếm mã hoặc ký hiệu';

  @override
  String get saveLoginDetailsTitle => 'Lưu thông tin đăng nhập?';

  @override
  String get saveLoginDetailsMessage =>
      'Bạn sắp hoàn tất thiết lập cho tổ chức này.\n\nBạn có muốn tải xuống an toàn một PDF với mã tổ chức, tên tổ chức, email đăng nhập và mật khẩu không? Lưu trữ ở nơi an toàn — bất kỳ ai có tệp này đều có thể đăng nhập.';

  @override
  String get downloadPdfAndContinue => 'Tải PDF & tiếp tục';

  @override
  String get continueWithoutPdf => 'Tiếp tục không có PDF';

  @override
  String get legalDisplayNameHint => 'Tên pháp lý / hiển thị';

  @override
  String get chartOfAccounts => 'Sơ đồ tài khoản';

  @override
  String get fiscalYearStart => 'Bắt đầu năm tài chính';

  @override
  String get fiscalYearEnd => 'Kết thúc năm tài chính';

  @override
  String get removeTestDataTitle => 'Xóa dữ liệu thử nghiệm?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'Tất cả doanh số demo, mua hàng, liên hệ, đối tác, mặt hàng tồn kho, nhân viên, sản phẩm máy tính rượu và các tổ chức demo thêm sẽ bị xóa.\n\nBạn đang ở tổ chức demo — sau đó bạn sẽ được chuyển về tổ chức đầu tiên tự động.';

  @override
  String get removeTestDataMessageNormal =>
      'Tất cả doanh số demo, mua hàng, liên hệ, đối tác, mặt hàng tồn kho, nhân viên và 3 tổ chức demo thêm sẽ bị xóa. Tài khoản quản trị viên và dữ liệu thiết lập thực của bạn vẫn nguyên vẹn.';

  @override
  String get removeTestDataWarning =>
      'Không thể hoàn tác trừ khi tải lại dữ liệu thử nghiệm.';

  @override
  String get removeTestData => 'Xóa dữ liệu thử nghiệm';

  @override
  String get keepTestData => 'Giữ dữ liệu thử nghiệm';

  @override
  String get demoDataRemoved => 'Đã xóa dữ liệu demo';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'Đã xóa dữ liệu thử nghiệm. Đã chuyển sang $name.';
  }

  @override
  String get testDataRemoved => 'Đã xóa dữ liệu thử nghiệm';

  @override
  String couldNotRemoveTestData(String error) {
    return 'Không thể xóa dữ liệu thử nghiệm: $error';
  }

  @override
  String get loadTestDataTitle => 'Tải dữ liệu thử nghiệm?';

  @override
  String get loadTestDataMessage =>
      'Điều này sẽ thêm tối đa 50 liên hệ demo, 50 mặt hàng tồn kho chỉ bán và 50 chỉ mua, cộng với doanh số, mua hàng, thanh toán, tồn kho, tóm tắt đóng cửa, nhân viên, lương, điểm danh cho 15 ngày qua và sản phẩm rượu mẫu cho máy tính.';

  @override
  String get loadTestData => 'Tải dữ liệu thử nghiệm';

  @override
  String get testDataLoaded => 'Đã tải dữ liệu thử nghiệm';

  @override
  String couldNotLoadTestData(String error) {
    return 'Không thể tải dữ liệu thử nghiệm: $error';
  }

  @override
  String get demoTestData => 'Dữ liệu thử nghiệm demo';

  @override
  String get importTestDataSubtitle =>
      'Nhập dữ liệu thử nghiệm cho tất cả tính năng';

  @override
  String get hideTestDataTitle => 'Ẩn dữ liệu thử nghiệm cho tổ chức này?';

  @override
  String get hideTestDataMessage =>
      'Nếu bạn tiếp tục, phần Dữ liệu thử nghiệm sẽ bị ẩn ở mọi nơi trong tổ chức này (bao gồm cả thiết lập). Bạn chỉ có thể bật lại bằng cách cài đặt lại hoặc xóa dữ liệu ứng dụng cho tổ chức này.';

  @override
  String get hideTestDataWarning =>
      'Dữ liệu demo đã tải sẽ ở lại trong cơ sở dữ liệu cho đến khi bạn xóa nó khỏi cài đặt.';

  @override
  String get okHideTestData => 'OK, ẩn dữ liệu thử nghiệm';

  @override
  String get testDataHiddenForOrg => 'Đã ẩn Dữ liệu thử nghiệm cho tổ chức này';

  @override
  String get hideTestDataTooltip => 'Ẩn dữ liệu thử nghiệm cho tổ chức này';

  @override
  String get partyRolesTitle => 'Vai trò đối tác';

  @override
  String get partyRolesMoreSubtitle =>
      'Khách hàng, nhà cung cấp, cả hai & thêm';

  @override
  String get exploreCustomizeTitle => 'Tùy chỉnh các tính năng';

  @override
  String get exploreCustomizeSubtitle =>
      'Hiển thị hoặc ẩn các phím tắt trên màn hình chính của bạn. Chỉ những tính năng mà tổ chức của bạn có thể truy cập mới được liệt kê.';

  @override
  String get exploreVisibleOnDashboard => 'Hiển thị trên bảng điều khiển';

  @override
  String get exploreHiddenOnDashboard => 'Ẩn trên bảng điều khiển';

  @override
  String get partiesTitle => 'Đối tác';

  @override
  String get partySearchByName => 'Tìm kiếm theo tên…';

  @override
  String get partySortBy => 'Sắp xếp theo:';

  @override
  String get partySortLatest => 'Mới nhất';

  @override
  String get partySortAmountHighLow => 'Số tiền: Cao đến thấp';

  @override
  String get partySortAmountLowHigh => 'Số tiền: Thấp đến cao';

  @override
  String get partySortNameAZ => 'Tên: A đến Z';

  @override
  String get partySortNameZA => 'Tên: Z đến A';

  @override
  String get partyAddNew => 'Thêm đối tác mới';

  @override
  String get partyEdit => 'Chỉnh sửa đối tác';

  @override
  String get partyUpdate => 'Cập nhật đối tác';

  @override
  String get partyNameLabel => 'Tên đối tác*';

  @override
  String get partyNameHint => 'Nhập tên đối tác';

  @override
  String get partyNewNameLabel => 'Tên đối tác mới*';

  @override
  String get partyNewNameHint => 'Nhập tên đối tác mới';

  @override
  String get partyRoleLabel => 'Vai trò đối tác *';

  @override
  String get partyTapToSelect => 'Nhấn để chọn';

  @override
  String get partySelectRoleValidation => 'Vui lòng chọn vai trò';

  @override
  String get partyEnterNameValidation => 'Vui lòng nhập tên đối tác';

  @override
  String get partyBasicInfo => 'Thông tin cơ bản';

  @override
  String get partyAdditionalInfo => 'Thông tin bổ sung';

  @override
  String get partyEmail => 'Email đối tác';

  @override
  String get partyEmailHint => 'Nhập địa chỉ email';

  @override
  String get partyPhone => 'Số điện thoại';

  @override
  String get partyPhoneHint => 'Nhập số điện thoại';

  @override
  String get partyAddress => 'Địa chỉ đối tác';

  @override
  String get partyAddressHint => 'Nhập địa chỉ';

  @override
  String get partyRoleCustomer => 'Khách hàng';

  @override
  String get partyRoleSupplier => 'Nhà cung cấp';

  @override
  String get partyRoleRoom => 'Phòng';

  @override
  String get partyRoleCabin => 'Cabin';

  @override
  String get partyRoleEmployee => 'Nhân viên';

  @override
  String get partyRoleBoth => 'Cả hai';

  @override
  String get partyDefaultAccount => 'Tài khoản mặc định';

  @override
  String get partyLoyaltyProgram => 'Chương trình khách hàng thân thiết';

  @override
  String get partyLoyaltyPoints => 'Điểm trung thành';

  @override
  String get partySelectDefaultAccount => 'Chọn tài khoản mặc định';

  @override
  String get partySelectLoyaltyProgram =>
      'Chọn chương trình khách hàng thân thiết';

  @override
  String get partyCreateNewProgram => 'Tạo chương trình mới';

  @override
  String get partySelectPartyRole => 'Chọn vai trò đối tác';

  @override
  String get partyAccountDebtors => 'Phải thu';

  @override
  String get partyAccountCreditors => 'Phải trả';

  @override
  String get partyBothRoleHint =>
      '“Cả hai” nghĩa là đối tác này chỉ xuất hiện trong Khách hàng và Nhà cung cấp — không phải Phòng, Cabin hoặc Nhân viên.';

  @override
  String get partyValidNumber => 'Vui lòng nhập số hợp lệ';

  @override
  String get partyValidAmount => 'Vui lòng nhập số tiền hợp lệ';

  @override
  String get searchRoles => 'Tìm kiếm vai trò';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vai trò',
      one: '1 vai trò',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'Chưa có vai trò';

  @override
  String get noRolesYetHint =>
      'Thêm Khách hàng, Nhà cung cấp, Cả hai hoặc vai trò tùy chỉnh cho liên hệ.';

  @override
  String get addRole => 'Thêm vai trò';

  @override
  String get deleteRoleTitle => 'Xóa vai trò';

  @override
  String deleteRoleConfirm(String name) {
    return 'Xóa \"$name\"? Không thể hoàn tác.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount đối tác',
      one: '1 đối tác',
    );
    return '\"$name\" đang được sử dụng bởi $_temp0. Chuyển các đối tác đó sang vai trò khác, hoặc xóa cứng và mất họ.';
  }

  @override
  String get transferParties => 'Chuyển đối tác';

  @override
  String get hardDeleteLoseParties => 'Xóa cứng (mất đối tác)';

  @override
  String get hardDeleteRoleTitle => 'Xóa cứng?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount đối tác',
      one: '1 đối tác',
    );
    return 'Điều này sẽ xóa vĩnh viễn \"$name\" và tất cả $_temp0 được gán cho nó. Dữ liệu đối tác không thể phục hồi.\n\nCác đối tác được liên kết với hóa đơn hoặc thanh toán có thể không xóa được — hãy dùng Chuyển thay thế.';
  }

  @override
  String get deleteRoleAndParties => 'Xóa vai trò và đối tác';

  @override
  String get addAnotherRoleBeforeDelete =>
      'Thêm vai trò khác trước khi xóa cái này.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount đối tác',
      one: '1 đối tác',
    );
    return 'Di chuyển $_temp0 từ \"$fromRole\" đến:';
  }

  @override
  String get transferAndDeleteRole => 'Chuyển và xóa vai trò';

  @override
  String get builtInRole => 'Tích hợp sẵn';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count đối tác',
      one: '1 đối tác',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'Chưa có đối tác';

  @override
  String get newRole => 'Vai trò mới';

  @override
  String get editRole => 'Chỉnh sửa vai trò';

  @override
  String get defaultRolesCannotEdit =>
      'Vai trò mặc định không thể đổi tên hoặc xóa.';

  @override
  String get roleNameLabel => 'Tên vai trò *';

  @override
  String get roleNameHint => 'vd. Khách hàng';

  @override
  String get roleDescriptionLabel => 'Mô tả';

  @override
  String get roleDescriptionHint => 'Ghi chú ngắn cho nhóm của bạn';

  @override
  String get roleSortOrderLabel => 'Thứ tự sắp xếp';

  @override
  String get roleSortOrderHint =>
      'Giá trị thấp hơn hiển thị trước trong danh sách';

  @override
  String get roleCreated => 'Đã tạo vai trò';

  @override
  String get roleUpdated => 'Đã cập nhật vai trò';

  @override
  String get roleDeleted => 'Đã xóa vai trò';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count đối tác',
      one: '1 đối tác',
    );
    return 'Đã xóa vai trò. $_temp0 đã chuyển sang $targetRole.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count đối tác',
      one: '1 đối tác',
    );
    return 'Đã xóa vai trò và $_temp0.';
  }

  @override
  String get privacyPolicyTitle => 'Chính sách Bảo mật';

  @override
  String get termsAndConditions => 'Điều khoản & Điều kiện';

  @override
  String get logoutConfirmTitle => 'Đăng xuất';

  @override
  String get logoutConfirmMessage =>
      'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản của mình không?';

  @override
  String get faqTapToExpand => 'Nhấn vào câu hỏi để mở rộng.';

  @override
  String get faqSectionGettingStarted => 'Bắt đầu';

  @override
  String get faqSectionLogin => 'Đăng nhập';

  @override
  String get faqSectionNavigation => 'Điều hướng';

  @override
  String get faqSectionInvoices => 'Hóa đơn';

  @override
  String get faqSectionPayments => 'Thanh toán';

  @override
  String get faqSectionItemsStock => 'Mặt hàng & tồn kho';

  @override
  String get faqSectionProfileEmployees => 'Hồ sơ & nhân viên';

  @override
  String get faqSectionDashboardReports => 'Bảng điều khiển & báo cáo';

  @override
  String get faqSectionSyncTroubleshooting => 'Đồng bộ & xử lý sự cố';

  @override
  String get faqNeedInternetQuestion => 'Tôi có cần internet không?';

  @override
  String get faqNeedInternetAnswer =>
      'Sau khi thiết lập cục bộ lần đầu, bạn có thể ghi lại hóa đơn, mặt hàng và thanh toán mà không cần internet. Dữ liệu ở lại trên thiết bị của bạn. Đồng bộ với máy chủ là tùy chọn.';

  @override
  String get faqFirstInstallQuestion => 'Điều gì xảy ra khi cài đặt lần đầu?';

  @override
  String get faqFirstInstallAnswer =>
      'Bạn có thể thấy hướng dẫn ngắn, sau đó là thiết lập cục bộ (tổ chức, công ty, email và mật khẩu đăng nhập, tiền tệ, năm tài chính). Sau đó đăng nhập bằng email và mật khẩu bạn đã tạo.';

  @override
  String get faqSignInCredentialsQuestion => 'Tôi dùng gì để đăng nhập?';

  @override
  String get faqSignInCredentialsAnswer =>
      'Địa chỉ email và mật khẩu từ thiết lập. Ứng dụng giữ bạn đăng nhập cho đến khi bạn đăng xuất từ Thêm.';

  @override
  String get faqLoggedOutQuestion => 'Tại sao tôi bị đăng xuất?';

  @override
  String get faqLoggedOutAnswer =>
      'Bạn đã chọn Đăng xuất, xóa dữ liệu ứng dụng hoặc phiên đã hết hạn. Đăng nhập lại với cùng thông tin xác thực.';

  @override
  String get faqBottomTabsQuestion => 'Các tab dưới cùng làm gì?';

  @override
  String get faqBottomTabsAnswer =>
      'Trang chủ — bảng điều khiển và tổng quan.\nDoanh số — hóa đơn bán hàng theo ngày.\nChi phí — hóa đơn mua hàng / chi phí.\nNút trung tâm — Đối tác (khách hàng, nhà cung cấp).\nThêm — hồ sơ, báo cáo, đồng bộ, trợ giúp, đăng xuất.';

  @override
  String get faqCreateInvoiceQuestion =>
      'Làm thế nào để tạo hóa đơn bán hàng hoặc mua hàng?';

  @override
  String get faqCreateInvoiceAnswer =>
      'Mở Doanh số hoặc Chi phí, chọn ngày trên lịch, nhấn nút +, thêm mặt hàng và số tiền, chọn đối tác nếu cần, sau đó lưu hoặc gửi.';

  @override
  String get faqInvoiceDetailsQuestion =>
      'Làm thế nào để xem chi tiết hóa đơn đầy đủ?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'Nhấn vào bất kỳ hóa đơn nào trong danh sách. Chi tiết giao dịch hiển thị các mục hàng, tổng, chiết khấu và thanh toán. Bạn có thể in, chia sẻ, sao chép hoặc thanh toán từ đó.';

  @override
  String get faqZeroRateQuestion =>
      'Tỷ lệ hoặc số tiền hiển thị bằng không trong chi tiết';

  @override
  String get faqZeroRateAnswer =>
      'Điều này thường có nghĩa là dữ liệu dòng hoặc thanh toán bị thiếu trong các lần lưu cũ. Cập nhật ứng dụng và tạo lại hoặc thanh toán nếu cần.';

  @override
  String get faqPartialPaymentQuestion =>
      'Làm thế nào để ghi lại thanh toán một phần?';

  @override
  String get faqPartialPaymentAnswer =>
      'Mở hóa đơn → Chi tiết giao dịch → Thực hiện thanh toán. Nhập số tiền, phương thức và ngày, sau đó Xử lý thanh toán.';

  @override
  String get faqMultiplePaymentQuestion =>
      'Thanh toán nhiều lần hoạt động như thế nào?';

  @override
  String get faqMultiplePaymentAnswer =>
      'Bật Thanh toán nhiều lần, nhấn chỉnh sửa và chia tổng số cho Tiền mặt, Thẻ, QR, v.v. Mỗi phương thức được ghi riêng biệt.';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'Chỉ một thanh toán được lưu từ một lần chia';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'Cập nhật lên phiên bản ứng dụng mới nhất. Các phiên bản cũ đôi khi chỉ lưu dòng chia đầu tiên. Thanh toán lại nếu số dư chưa thanh toán vẫn sai.';

  @override
  String get faqAddItemQuestion => 'Làm thế nào để thêm mặt hàng?';

  @override
  String get faqAddItemAnswer =>
      'Sử dụng Thêm mặt hàng từ luồng bán hàng hoặc thêm nhanh. Nhập tên, tỷ lệ, đơn vị, mục đích và ảnh tùy chọn (JPEG/PNG/GIF/WebP, tối đa 5 MB), sau đó Tạo mặt hàng.';

  @override
  String get faqCustomUnitQuestion => 'Làm thế nào để thêm đơn vị tùy chỉnh?';

  @override
  String get faqCustomUnitAnswer =>
      'Trên biểu mẫu mặt hàng, nhấn Đơn vị → Tạo đơn vị mới ở cuối danh sách, nhập tên (vd. Lít, Hộp) và Tạo.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'Tôi đã thay đổi tên nhưng hồ sơ vẫn hiển thị tên cũ';

  @override
  String get faqProfileNameAnswer =>
      'Chỉnh sửa hồ sơ nhân viên của bạn (cùng email với đăng nhập) và lưu. Tab Thêm và bảng điều khiển sẽ cập nhật.';

  @override
  String get faqRevenueDetailsQuestion => 'Chi tiết Doanh thu là gì?';

  @override
  String get faqRevenueDetailsAnswer =>
      'Chế độ xem hàng tháng với biểu đồ xu hướng hàng ngày, lợi nhuận ròng, khoản phải thu chưa thanh toán và phân tích doanh số so với mua hàng theo từng ngày. Thay đổi tháng bằng lịch hoặc chip tháng.';

  @override
  String get faqOtherReportsQuestion => 'Các báo cáo khác ở đâu?';

  @override
  String get faqOtherReportsAnswer =>
      'Mở Thêm và xem trong Báo cáo (Phân tích, Lãi & Lỗ, Báo cáo, v.v.) nếu vai trò của bạn có quyền truy cập.';

  @override
  String get faqWhenSyncQuestion => 'Khi nào tôi nên đồng bộ?';

  @override
  String get faqWhenSyncAnswer =>
      'Chỉ khi quản trị viên của bạn yêu cầu và khi bạn có kết nối ổn định. Đồng bộ gửi hoặc nhận dữ liệu giữa thiết bị và máy chủ.';

  @override
  String get faqFabPositionQuestion =>
      'Nút + trông quá cao trên Doanh số / Chi phí';

  @override
  String get faqFabPositionAnswer =>
      'Nó nằm phía trên thanh điều hướng dưới cùng. Cuộn danh sách hoặc cập nhật ứng dụng nếu nút chồng lên nội dung trên thiết bị của bạn.';

  @override
  String get faqHowLogoutQuestion => 'Làm thế nào để đăng xuất?';

  @override
  String get faqHowLogoutAnswer => 'Thêm → Đăng xuất ở cuối danh sách cài đặt.';

  @override
  String get statisticsGoodMorning => 'Chào buổi sáng';

  @override
  String get statisticsGoodAfternoon => 'Chào buổi chiều';

  @override
  String get statisticsGoodEvening => 'Buổi tối vui vẻ';

  @override
  String get statisticsDefaultUser => 'người dùng';

  @override
  String get statisticsCheckConnection =>
      'Vui lòng kiểm tra kết nối của bạn và thử lại.';

  @override
  String get statisticsCouldNotLoadProfile => 'Không thể tải hồ sơ';

  @override
  String get statisticsCouldNotLoadData => 'Không thể tải dữ liệu';

  @override
  String get statisticsPeriodDay => 'Ngày';

  @override
  String get statisticsPeriodMonth => 'Tháng';

  @override
  String get statisticsPeriodYear => 'Năm';

  @override
  String get statisticsSelectedPeriod => 'Khoảng thời gian đã chọn';

  @override
  String get statisticsSelectMonth => 'Chọn tháng';

  @override
  String get statisticsSelectMonthSubtitle => 'Chọn tháng để lọc dữ liệu';

  @override
  String get statisticsQuickOperations => 'Quick Operations';

  @override
  String get statisticsQuickOperationsSeeAll => 'Xem tất cả';

  @override
  String get statisticsQuickOperationInvoice => 'Hóa đơn';

  @override
  String get statisticsQuickOperationReports => 'Báo cáo';

  @override
  String get statisticsAnnualRevenue => 'Doanh thu hàng năm';

  @override
  String get statisticsCashflow => 'Dòng tiền';

  @override
  String get statisticsCashflowLast7Days => 'Dòng tiền (7 ngày qua)';

  @override
  String get statisticsCashflowLast12Months => 'Dòng tiền (12 tháng qua)';

  @override
  String get statisticsDaily => 'Hằng ngày';

  @override
  String get statisticsMonthly => 'hàng tháng';

  @override
  String get statisticsOverall => 'Tổng thể';

  @override
  String get statisticsLast7Days => 'Last 7 Days';

  @override
  String get statisticsLast12Months => 'Last 12 Months';

  @override
  String get statisticsAllYears => 'Tất cả các năm';

  @override
  String get statisticsNoDataAvailable => 'Không có sẵn dữ liệu';

  @override
  String get statisticsMoneyIn => 'Tiền vào';

  @override
  String get statisticsMoneyOut => 'Tiền ra';

  @override
  String get statisticsIncome => 'Thu nhập';

  @override
  String get statisticsExpenses => 'Chi phí';

  @override
  String get statisticsSalesSummary => 'Tóm tắt doanh số';

  @override
  String get statisticsPurchaseSummary => 'Tóm tắt mua hàng';

  @override
  String get statisticsTotalSales => 'Tổng doanh thu';

  @override
  String get statisticsTotalIncome => 'Tổng thu nhập';

  @override
  String get statisticsTotalUnpaid => 'Tổng số chưa thanh toán';

  @override
  String get statisticsTotalPurchase => 'Tổng số tiền mua';

  @override
  String get statisticsPaidPurchase => 'Mua trả phí';

  @override
  String get statisticsUnpaidPurchase => 'Mua hàng chưa thanh toán';

  @override
  String get statisticsEmployeeDashboard => 'Bảng điều khiển nhân viên';

  @override
  String get statisticsDefaultEmployee => 'Người lao động';

  @override
  String get statisticsDefaultDepartment => 'Phòng';

  @override
  String get statisticsDefaultPosition => 'Chức vụ';

  @override
  String get statisticsCurrentMonth => 'Tháng hiện tại';

  @override
  String get statisticsStatus => 'Trạng thái';

  @override
  String get statisticsActive => 'Tích cực';

  @override
  String get statisticsWelcome => 'Chào mừng';

  @override
  String get statisticsEmployeeWelcomeMessage =>
      'Bạn đang đăng nhập như một nhân viên. Sử dụng menu điều hướng để truy cập các tính năng có sẵn.';

  @override
  String get statisticsRevenueDetails => 'Chi tiết doanh thu';

  @override
  String get statisticsEmployeeDetails => 'Chi tiết nhân viên';

  @override
  String get statisticsChangeMonth => 'Thay đổi tháng';

  @override
  String get statisticsFilterChartsSubtitle => 'Lọc biểu đồ và phân tích';

  @override
  String get statisticsDailyTrend => 'Xu hướng hàng ngày';

  @override
  String get statisticsDailyActivity => 'Hoạt động hàng ngày';

  @override
  String get statisticsNoDataForMonth => 'Không có dữ liệu cho tháng này';

  @override
  String get statisticsNetProfit => 'Lợi nhuận ròng';

  @override
  String get statisticsMonthReceivables => 'Tháng phải thu';

  @override
  String get statisticsMonthRevenue => 'Doanh thu tháng';

  @override
  String get statisticsMonthExpenses => 'Chi phí tháng';

  @override
  String get statisticsNoDailyEntries =>
      'Không có mục nhập hàng ngày trong tháng này';

  @override
  String get statisticsDailySalesBreakdown => 'Phân tích doanh số hàng ngày';

  @override
  String get statisticsDailyBreakdown => 'Phân tích hàng ngày';

  @override
  String get statisticsAdvance => 'Nâng cao';

  @override
  String get statisticsExploreFeatures => 'Khám phá tính năng';

  @override
  String get statisticsShowOrHideFeatures => 'Hiển thị hoặc ẩn các tính năng';

  @override
  String get statisticsAllFeaturesHidden =>
      'Tất cả các tính năng khám phá đều bị ẩn';

  @override
  String get statisticsNoFeaturesForOrg =>
      'Không có tính năng nào dành cho tổ chức của bạn';

  @override
  String get statisticsTapTuneToShow =>
      'Nhấn vào biểu tượng giai điệu ở trên để hiển thị lại các phím tắt.';

  @override
  String get statisticsMenuCheck => 'Đối chiếu';

  @override
  String get statisticsMenuEmployee => 'Người lao động';

  @override
  String get statisticsMenuOrder => 'Đặt hàng';

  @override
  String get statisticsMenuInventory => 'Items';

  @override
  String get statisticsMenuCustomers => 'Khách hàng';

  @override
  String get statisticsMenuCalculator => 'Liquor prices';

  @override
  String get statisticsMenuQuickExpenses => 'nhanh chóng\nChi phí';

  @override
  String get statisticsMenuQuickSales => 'nhanh chóng\nbán hàng';

  @override
  String get statisticsMenuAddEmployee => 'Thêm\nnhân viên';

  @override
  String get statisticsMenuAddParty => 'Thêm\nđối tác';

  @override
  String get statisticsMenuAddEmployeeSingle => 'Thêm nhân viên';

  @override
  String get statisticsMenuAddPartySingle => 'Thêm đối tác';

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
    return '$amount đã thu thập';
  }

  @override
  String statisticsMetricPaid(String amount) {
    return '$amount đã thanh toán';
  }

  @override
  String statisticsMoneyInAmount(String amount) {
    return 'Tiền vào: $amount';
  }

  @override
  String statisticsMoneyOutAmount(String amount) {
    return 'Tiền ra: $amount';
  }

  @override
  String statisticsDayTooltip(String day, String amount) {
    return 'Ngày $day\n$amount';
  }

  @override
  String statisticsProfitMargin(String percent) {
    return '$percent% ký quỹ';
  }

  @override
  String get invoiceCommonActions => 'hành động';

  @override
  String get invoiceCommonSearchItems => 'Tìm kiếm các mục';

  @override
  String get invoiceCommonSearchItemsSubtitle => 'Tìm kiếm các mục cụ thể';

  @override
  String get invoiceCommonAddNewInvoice => 'Thêm hóa đơn mới';

  @override
  String get invoiceCommonAddSalesInvoiceSubtitle => 'Tạo hóa đơn bán hàng mới';

  @override
  String get invoiceCommonAddPurchaseInvoiceSubtitle =>
      'Tạo hóa đơn mua hàng mới';

  @override
  String get invoiceCommonSelectMonthYear => 'Chọn Tháng/Năm';

  @override
  String get invoiceCommonSelectMonthYearSubtitle =>
      'Chuyển đến một tháng cụ thể';

  @override
  String get invoiceCommonSelectMonthAndYear => 'Chọn Tháng & Năm';

  @override
  String get invoiceCommonFilterByDate => 'Lọc theo ngày';

  @override
  String get invoiceCommonFilterByDateRange => 'Lọc theo phạm vi ngày';

  @override
  String get invoiceCommonCloseSearch => 'Đóng tìm kiếm';

  @override
  String get invoiceCommonSelectAll => 'Chọn tất cả';

  @override
  String get invoiceCommonToday => 'Hôm nay';

  @override
  String get invoiceCommonTotalQuantity => 'Tổng số lượng';

  @override
  String get invoiceCommonTotalAmount => 'Tổng số tiền';

  @override
  String get invoiceCommonTotal => 'Tổng cộng';

  @override
  String get invoiceCommonSearchForItems => 'Tìm kiếm các mục';

  @override
  String get invoiceCommonNoItemsFound => 'Không tìm thấy mục nào';

  @override
  String get invoiceCommonUnknownItem => 'Mục không xác định';

  @override
  String get invoiceCommonNotAvailable => 'không áp dụng';

  @override
  String get invoiceSalesCouldNotLoad => 'Không thể tải doanh số bán hàng';

  @override
  String get invoiceSalesNoFound => 'Không tìm thấy doanh số bán hàng';

  @override
  String get invoiceSalesSelectDate => 'Chọn ngày để xem Doanh số bán hàng';

  @override
  String get invoiceSalesNoInvoicesFound => 'Không tìm thấy hóa đơn';

  @override
  String get invoiceSalesSelectDateLegacy => 'Chọn ngày để xem hóa đơn';

  @override
  String get invoicePurchaseCouldNotLoad => 'Không thể tải chi phí';

  @override
  String get invoicePurchaseNoFound => 'Không tìm thấy giao dịch mua nào';

  @override
  String get invoicePurchaseSelectDate => 'Chọn ngày để xem giao dịch mua';

  @override
  String get invoiceWeekdaySun => 'Mặt trời';

  @override
  String get invoiceWeekdayMon => 'Thứ hai';

  @override
  String get invoiceWeekdayTue => 'thứ ba';

  @override
  String get invoiceWeekdayWed => 'Thứ tư';

  @override
  String get invoiceWeekdayThu => 'Thứ năm';

  @override
  String get invoiceWeekdayFri => 'Thứ sáu';

  @override
  String get invoiceWeekdaySat => 'Đã ngồi';

  @override
  String invoiceCommonSelectedCount(int count) {
    return '$count Đã chọn';
  }

  @override
  String invoiceCommonQtyLabel(String qty) {
    return 'Số lượng: $qty';
  }

  @override
  String invoiceCommonInvoiceLabel(String number) {
    return 'Hóa đơn: $number';
  }

  @override
  String invoiceCommonCustomerLabel(String name) {
    return 'Khách hàng: $name';
  }

  @override
  String invoiceCommonSupplierLabel(String name) {
    return 'Nhà cung cấp: $name';
  }

  @override
  String invoiceCommonSearchingFor(String query) {
    return 'Đang tìm kiếm \"$query\"...';
  }

  @override
  String invoiceCommonSearchItemsHint(String scope) {
    return 'Tìm kiếm các mục trong $scope...';
  }

  @override
  String invoiceCommonSalesSearchPrompt(String scope) {
    return 'Nhập tên mặt hàng để tìm tất cả doanh số bán hàng\ntrong $scope';
  }

  @override
  String invoiceCommonPurchaseSearchPrompt(String scope) {
    return 'Nhập tên mặt hàng để tìm tất cả các giao dịch mua\ntrong $scope';
  }

  @override
  String invoiceCommonSalesNoMatch(String query, String scope) {
    return 'Không bán \"$query\"\nở $scope';
  }

  @override
  String invoiceCommonPurchaseNoMatch(String query, String scope) {
    return 'Không mua \"$query\"\nở $scope';
  }

  @override
  String invoiceCommonEmptyForDate(String date) {
    return 'cho $date';
  }

  @override
  String invoiceFoundSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lần bán',
      one: '1 lần bán',
    );
    return 'Đã tìm thấy $_temp0';
  }

  @override
  String invoiceFoundPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lần mua hàng',
      one: '1 lần mua hàng',
    );
    return 'Đã tìm thấy $_temp0';
  }

  @override
  String invoiceDateSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doanh số',
      one: '1 lần bán',
    );
    return '$_temp0';
  }

  @override
  String invoiceDatePurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lần mua hàng',
      one: '1 lần mua',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hóa đơn',
      one: '1 hóa đơn',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hóa đơn',
      one: '1 hóa đơn',
    );
    return 'Xóa $_temp0';
  }

  @override
  String invoiceDeleteMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hóa đơn đã chọn',
      one: '1 hóa đơn đã chọn',
    );
    return 'Bạn có chắc chắn muốn xóa $_temp0 không? Không thể hoàn tác hành động này.';
  }

  @override
  String get contacts => 'Danh bạ';

  @override
  String get categories => 'Thể loại';

  @override
  String get manageStaff => 'Quản lý nhân viên';

  @override
  String get payroll => 'Bảng lương';

  @override
  String get attendance => 'Sự tham dự';

  @override
  String get profitAndLoss => 'Lãi lỗ';

  @override
  String get statementReport => 'Báo cáo';

  @override
  String get analytics => 'Phân tích';

  @override
  String get loggedOut => 'Đã đăng xuất';

  @override
  String organizationCodeDisplay(String code) {
    return 'Mã số: $code';
  }

  @override
  String get moreDataSynchronization => 'Đồng bộ hóa dữ liệu';

  @override
  String get moreSendDataToClient => 'Gửi dữ liệu cho khách hàng';

  @override
  String get moreSendDataToClientSubtitle =>
      'Tải dữ liệu máy chủ lên máy khách';

  @override
  String get moreSendDataToClientWarning =>
      'Hành động này sẽ thay thế cơ sở dữ liệu máy khách hiện tại bằng dữ liệu từ máy chủ. Tất cả những thay đổi gần đây của khách hàng có thể bị mất.';

  @override
  String get moreSendDataToClientConfirm =>
      'Bạn có chắc chắn muốn gửi dữ liệu cho khách hàng không?';

  @override
  String get moreFetchDataFromClient => 'Lấy dữ liệu từ khách hàng';

  @override
  String get moreFetchDataFromClientSubtitle =>
      'Tải dữ liệu khách hàng về máy chủ';

  @override
  String get moreFetchDataFromClientWarning =>
      'Hành động này sẽ thay thế cơ sở dữ liệu máy chủ hiện tại bằng dữ liệu từ máy khách. Tất cả những thay đổi máy chủ gần đây có thể bị mất.';

  @override
  String get moreFetchDataFromClientConfirm =>
      'Bạn có chắc chắn muốn tìm nạp dữ liệu từ máy khách không?';

  @override
  String get notifications => 'Thông báo';

  @override
  String get openingReminder => 'Lời nhắc mở đầu';

  @override
  String get closingReminder => 'Lời nhắc đóng cửa';

  @override
  String get activityReminder => 'Sales & purchase reminder';

  @override
  String get openingTime => 'Giờ mở cửa';

  @override
  String get closingTime => 'Giờ đóng cửa';

  @override
  String get activityReminderTime => 'Reminder time';

  @override
  String get notificationSettingsSaved => 'Đã lưu cài đặt thông báo';

  @override
  String get notificationPermissionHint =>
      'Cho phép thông báo (và báo thức trên Android) để lời nhắc hoạt động khi đóng ứng dụng';

  @override
  String dailyAtTime(String time) {
    return 'Hàng ngày lúc $time';
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
  String get invoiceCommonYesterday => 'Hôm qua';

  @override
  String invoiceCommonTodayAt(String time) {
    return 'Hôm nay, $time';
  }

  @override
  String invoiceCommonDaysAgo(int count) {
    return '$count ngày trước';
  }

  @override
  String invoiceReturnCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lần trả hàng',
      one: '1 lần trả hàng',
    );
    return '$_temp0';
  }

  @override
  String get checkoutSelectParty => 'Chọn đối tác';

  @override
  String get partyPickerSubtitle => 'Bán hàng này cho ai?';

  @override
  String partyPickerSearchHint(String role) {
    return 'Tìm $role…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'Thêm $role mới';
  }

  @override
  String get partyPickerSettled => 'Đã thanh toán';

  @override
  String get partyPickerSelectedLabel => 'ĐÃ CHỌN';

  @override
  String get checkoutCartSummary => 'Tóm tắt giỏ hàng';

  @override
  String get checkoutNoItemsInCart => 'Không có mặt hàng nào trong giỏ hàng';

  @override
  String get checkoutSearchHere => 'Tìm kiếm ở đây';

  @override
  String get checkoutCreateInvoice => 'Tạo hóa đơn';

  @override
  String get checkoutEditInvoice => 'Chỉnh sửa hóa đơn';

  @override
  String get checkoutSaveInvoice => 'Lưu hóa đơn';

  @override
  String get checkoutInvoiceSummary => 'Tóm tắt hóa đơn';

  @override
  String get checkoutEstimate => 'Ước lượng';

  @override
  String get checkoutBasicInformation => 'Thông tin cơ bản';

  @override
  String get checkoutAddItems => 'Thêm mục';

  @override
  String get checkoutItemsSection => 'Mặt hàng';

  @override
  String get checkoutPartyRequired => 'Đối tác *';

  @override
  String get checkoutPartyInformation => 'Thông tin đối tác';

  @override
  String get checkoutBillSummary => 'Tóm tắt hóa đơn';

  @override
  String get checkoutBillSummaryHint => 'Nhấn để biết tính toán chi tiết hơn.';

  @override
  String get checkoutItemTotal => 'Tổng số mặt hàng';

  @override
  String checkoutLoyaltyDiscount(String percent) {
    return 'Giảm giá trung thành ($percent%)';
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
    return '- Giảm giá ($percent%)';
  }

  @override
  String get checkoutTapToEdit => 'Nhấn để chỉnh sửa';

  @override
  String get checkoutTotalAmount => 'Tổng số tiền';

  @override
  String get checkoutPaymentMode => 'Record payment';

  @override
  String get checkoutPaymentModeHint =>
      'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.';

  @override
  String get checkoutNetSalesAmount => 'Số tiền bán hàng ròng';

  @override
  String get checkoutConfirmCheckout => 'Xác nhận thanh toán';

  @override
  String get checkoutEditDiscount => 'Chỉnh sửa giảm giá';

  @override
  String get checkoutPercentage => 'Tỷ lệ phần trăm';

  @override
  String get checkoutDiscard => 'Loại bỏ';

  @override
  String get checkoutPartialPayment => 'Thanh toán một phần';

  @override
  String get checkoutPartialPaymentBanner =>
      'Bằng cách kích hoạt Thanh toán một phần, khách hàng sẽ có thể thanh toán số tiền ít hơn Tổng số tiền được lập hóa đơn.';

  @override
  String get checkoutPleaseEnterAmounts => 'Vui lòng nhập số tiền tương ứng:';

  @override
  String get checkoutPartialPaymentEqualHint =>
      'Vì không có người dùng nào được chỉ định nên tổng số tiền phải bằng tổng số tiền được lập hoá đơn.';

  @override
  String checkoutOverGrandTotalBy(String amount) {
    return 'Tổng cộng vượt quá: $amount';
  }

  @override
  String checkoutRemainingUnpaid(String amount) {
    return 'Còn lại (chưa thanh toán từ Tổng cộng): $amount';
  }

  @override
  String get checkoutConfirmPayment => 'Xác nhận thanh toán';

  @override
  String get checkoutUnpaidCredit => 'Chưa thanh toán / Tín dụng';

  @override
  String get checkoutAddAtLeastOneLine =>
      'Thêm ít nhất một mục hàng để xem ước tính';

  @override
  String get checkoutMultiplePayment => 'Thanh toán nhiều lần';

  @override
  String get checkoutPaymentStatus => 'Trạng thái thanh toán';

  @override
  String get checkoutPaymentMethods => 'Phương thức thanh toán';

  @override
  String get checkoutPaymentMethod => 'Phương thức thanh toán';

  @override
  String get checkoutTenderAmount => 'Số tiền đấu thầu';

  @override
  String get checkoutLoadingPaymentMethods =>
      'Đang tải phương thức thanh toán…';

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
  String get stockSearchByDateHint => 'Tìm kiếm theo ngày hoặc tháng…';

  @override
  String get stockNoMatches => 'Không có kết quả phù hợp';

  @override
  String get stockTryDifferentSearch => 'Hãy thử một cụm từ tìm kiếm khác';

  @override
  String get stockTryAnotherSearch => 'Hãy thử tìm kiếm khác';

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
    return 'Số lượng $qty';
  }

  @override
  String stockCardSummary(String records, String items, String locations) {
    return '$records bản ghi · $items mục · $locations vị trí';
  }

  @override
  String get stockFilterTitle => 'Filter stock reconciliation';

  @override
  String get stockBatchNumber => 'Số lô';

  @override
  String get stockLocation => 'Vị trí';

  @override
  String get stockOptionalHint => 'Không bắt buộc';

  @override
  String get stockApplyFilters => 'Áp dụng bộ lọc';

  @override
  String get stockClearFields => 'Xóa các trường';

  @override
  String get stockDeleteAllTooltip => 'Xóa tất cả hàng trong ngày này';

  @override
  String get stockNoItemsFound => 'Không tìm thấy mặt hàng có sẵn';

  @override
  String get stockNoItemsSubtitle =>
      'Hãy thử các bộ lọc khác hoặc ngày báo cáo khác.';

  @override
  String get stockAdjustFilters => 'Điều chỉnh bộ lọc';

  @override
  String get stockSearchItemHint => 'Tìm kiếm mặt hàng, lô, vị trí…';

  @override
  String get stockEditQuantities => 'Chỉnh sửa số lượng';

  @override
  String get stockNoChangesDetected => 'Không phát hiện thấy thay đổi nào';

  @override
  String stockErrorPreparingChanges(String error) {
    return 'Lỗi chuẩn bị thay đổi: $error';
  }

  @override
  String get stockUpdateSuccessful => 'Cập nhật thành công!';

  @override
  String get stockSummary => 'Bản tóm tắt';

  @override
  String get stockTotalRequested => 'Tổng số yêu cầu';

  @override
  String get stockSuccessfullyUpdated => 'Đã cập nhật thành công';

  @override
  String get stockFailed => 'Thất bại';

  @override
  String get stockUpdateFailed => 'Cập nhật không thành công';

  @override
  String get stockClearAllQuantitiesTitle => 'Xóa tất cả số lượng?';

  @override
  String get stockClearAllQuantitiesMessage =>
      'Thao tác này sẽ đặt lại tất cả số lượng về 0. Bạn có chắc chắn không?';

  @override
  String get stockClearAll => 'Xóa tất cả';

  @override
  String get stockUpdatingQuantities => 'Cập nhật số lượng hàng tồn...';

  @override
  String get stockEditQuantitiesTitle => 'Chỉnh sửa số lượng hàng tồn kho';

  @override
  String stockReportingDate(String date) {
    return 'Ngày báo cáo: $date';
  }

  @override
  String stockTotalItemsHint(String count) {
    return 'Tổng số mặt hàng: $count • Cập nhật số lượng khi cần thiết';
  }

  @override
  String get stockItemName => 'Tên mặt hàng';

  @override
  String stockBatchPrefix(String batch) {
    return 'Lô: $batch';
  }

  @override
  String get stockDeleteConfirmTitle => 'Xác nhận xóa';

  @override
  String get stockDeleteConfirmIntro =>
      'Bạn sắp xóa vĩnh viễn tất cả các mặt hàng trong kho vào ngày sau:';

  @override
  String get stockDeleteConfirmWarning =>
      'Không thể hoàn tác hành động này. Tất cả hồ sơ chứng khoán cho ngày này sẽ bị xóa vĩnh viễn.';

  @override
  String get stockNoInternetRetry =>
      'Không có kết nối internet. Vui lòng kiểm tra kết nối của bạn và thử lại.';

  @override
  String get itemsTitle => 'Mặt hàng';

  @override
  String get itemAddSheetTitle => 'Thêm mục';

  @override
  String get itemSingleAdd => 'Thêm một lần';

  @override
  String get itemBulkAdd => 'Thêm hàng loạt';

  @override
  String get itemBulkAddTitle => 'Thêm hàng loạt mục';

  @override
  String get itemEditTitle => 'Chỉnh sửa mục';

  @override
  String get itemAddTitle => 'Thêm mục';

  @override
  String get itemCreateButton => 'Tạo mục';

  @override
  String get itemUpdateButton => 'Cập nhật mục';

  @override
  String get itemDeleteTitle => 'Xóa mục';

  @override
  String itemDeleteConfirm(String name) {
    return 'Bạn có chắc chắn muốn xóa \"$name\" không?';
  }

  @override
  String get itemDeletedSuccess => 'Đã xóa mục thành công';

  @override
  String get itemCreatedSuccess => 'Mục được tạo thành công';

  @override
  String get itemUpdatedSuccess => 'Mục được cập nhật thành công';

  @override
  String get itemLoading => 'Đang tải các mục...';

  @override
  String get itemErrorTitle => 'Ối! Đã xảy ra lỗi';

  @override
  String get itemTryAgain => 'Thử lại';

  @override
  String get itemSearchHint => 'Tìm kiếm các mục';

  @override
  String get itemNoItemsFound => 'Không tìm thấy mục nào';

  @override
  String get itemTryAdjustSearch =>
      'Hãy thử điều chỉnh cụm từ tìm kiếm của bạn';

  @override
  String get itemNoItemsAvailable => 'Không có mặt hàng nào';

  @override
  String get itemAddToGetStarted => 'Thêm các mục để bắt đầu';

  @override
  String get itemNoMoreItems => 'Không còn mục nào nữa';

  @override
  String get itemPurposeBoth => 'Cả hai';

  @override
  String get itemPurposePurchases => 'Mua hàng';

  @override
  String get itemTypeProduct => 'Sản phẩm';

  @override
  String get itemTypeService => 'Dịch vụ';

  @override
  String get itemTypeInventory => 'Hàng tồn kho';

  @override
  String get itemPhotoTitle => 'Ảnh sản phẩm';

  @override
  String get itemPhotoHint => 'Bấm vào đây để chọn hoặc tải ảnh lên';

  @override
  String get itemPhotoFormats => 'JPEG, PNG, GIF hoặc WebP · tối đa 5MB';

  @override
  String get itemAddPhoto => 'Thêm ảnh';

  @override
  String get itemPhotoLibrary => 'Thư viện ảnh';

  @override
  String get itemPhotoLibraryHint => 'Chọn từ ảnh của bạn';

  @override
  String get itemTakePhoto => 'Chụp ảnh';

  @override
  String get itemUploadGallery => 'Tải lên từ thư viện';

  @override
  String get itemUploadGalleryHint => 'Duyệt tập tin trên thiết bị này';

  @override
  String get itemTypeLabel => 'Kiểu';

  @override
  String get itemTypeField => 'Loại mặt hàng';

  @override
  String get itemNameLabel => 'Tên mặt hàng';

  @override
  String get itemNameHint => 'Nhập tên mặt hàng';

  @override
  String get itemBarcodeLabel => 'Mã vạch / Mã QR';

  @override
  String get itemBarcodeField => 'Mã vạch/mã QR';

  @override
  String get itemBarcodeHint => 'Quét từ thanh ứng dụng hoặc dán';

  @override
  String get itemSkuLabel => 'SKU (optional)';

  @override
  String get itemSkuField => 'SKU';

  @override
  String get itemSkuHint => 'Product code — optional';

  @override
  String get itemPickerSearchHint => 'Search items by name or SKU…';

  @override
  String get itemRateLabel => 'Tỷ lệ';

  @override
  String get itemUnitLabel => 'Đơn vị';

  @override
  String get itemPurposeLabel => 'Mục đích';

  @override
  String get itemSelectUnit => 'Chọn đơn vị';

  @override
  String get itemSelectPurpose => 'Chọn mục đích';

  @override
  String get itemSelectCategory => 'Chọn danh mục';

  @override
  String get itemSelectType => 'Chọn loại';

  @override
  String get itemSelectItemType => 'Chọn loại mục';

  @override
  String get itemSearchUnits => 'Đơn vị tìm kiếm…';

  @override
  String get itemSearchPurpose => 'Mục đích tìm kiếm…';

  @override
  String get itemSearchCategories => 'Tìm kiếm danh mục…';

  @override
  String get itemCreateCustomUnit => 'Tạo đơn vị tùy chỉnh';

  @override
  String get itemUnitName => 'Tên đơn vị';

  @override
  String get itemUnitNameHint => 'ví dụ: Lít, Hộp, Mảnh';

  @override
  String get itemValidationName => 'Vui lòng nhập tên mặt hàng';

  @override
  String get itemValidationRate => 'Vui lòng nhập tỷ lệ';

  @override
  String get itemValidationNumber => 'Vui lòng nhập số hợp lệ';

  @override
  String get itemSelectUnitRequired => 'Vui lòng chọn một đơn vị';

  @override
  String get itemSelectPurposeRequired => 'Vui lòng chọn mục đích';

  @override
  String get itemSelectCategoryRequired => 'Vui lòng chọn danh mục';

  @override
  String get itemImageMissing => 'Tệp hình ảnh bị thiếu';

  @override
  String get itemImageFormatError => 'Sử dụng JPEG, PNG, GIF hoặc WebP';

  @override
  String get itemImageSizeError =>
      'Hình ảnh phải có kích thước từ 5 MB trở xuống';

  @override
  String get itemScanBarcode => 'Quét mã vạch';

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
    return 'Tên điền từ danh mục: $name';
  }

  @override
  String get itemBarcodePasteHint =>
      'Không tìm thấy tên sản phẩm - mã được dán dưới dạng tên. Chỉnh sửa nếu cần.';

  @override
  String get itemBulkRefillTooltip => 'Nạp lại đầu vào trước đó';

  @override
  String get itemBulkAddRow => 'Thêm hàng';

  @override
  String itemBulkRowLabel(String index) {
    return 'Mục $index';
  }

  @override
  String get itemBulkNameRequired => 'Yêu cầu tên';

  @override
  String get itemBulkInvalidNumber => 'Số không hợp lệ';

  @override
  String get itemBulkCreating => 'Đang tạo…';

  @override
  String get itemBulkCreateItems => 'Tạo mục';

  @override
  String itemBulkCreatedCount(String count) {
    return '$count mục đã được tạo';
  }

  @override
  String itemBulkCreateFailed(String error) {
    return 'Không tạo được mục: $error';
  }

  @override
  String get itemBulkNoDraft => 'Không tìm thấy bản nháp đã lưu';

  @override
  String get itemBulkInvalidDraft => 'Định dạng bản nháp đã lưu không hợp lệ';

  @override
  String get itemBulkDraftRestored => 'Đã khôi phục bản nháp trước đó';

  @override
  String get itemBulkDraftRestoreFailed =>
      'Không thể khôi phục bản nháp đã lưu';

  @override
  String get itemBulkAtLeastOne => 'Thêm ít nhất một mục';

  @override
  String get itemBulkCategoriesLoading => 'Đang tải danh mục, vui lòng thử lại';

  @override
  String get itemBulkLoadingCategories => 'Đang tải danh mục…';

  @override
  String get inventoryTitle => 'Phân tích hàng tồn kho';

  @override
  String get inventorySubtitle =>
      'Theo dõi chuyển động chứng khoán theo thời gian thực';

  @override
  String get inventorySearchHint => 'Tìm kiếm các mục...';

  @override
  String get inventorySold => 'Đã bán';

  @override
  String get inventoryPurchased => 'Đã mua';

  @override
  String get catNoCategories => 'Không có danh mục. Nhấn vào + để tạo.';

  @override
  String get catLoadCategories => 'Tải danh mục';

  @override
  String get catCreated => 'Đã tạo danh mục';

  @override
  String get catRenamed => 'Đã đổi tên danh mục';

  @override
  String get catDeleted => 'Đã xóa danh mục';

  @override
  String catDeletedBulk(int count) {
    return '$count categories deleted';
  }

  @override
  String get catNewTitle => 'Danh mục mới';

  @override
  String get catRenameTitle => 'Đổi tên danh mục';

  @override
  String get catNewName => 'Tên mới';

  @override
  String get catRename => 'Đổi tên';

  @override
  String get catDeleteTitle => 'Xóa danh mục';

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
    return 'Xóa \"$name\"?';
  }

  @override
  String get catDeleteLinkedHint =>
      'Các mục được liên kết. Bạn có thể buộc xóa để hủy liên kết chúng.';

  @override
  String get catForceDelete => 'Buộc xóa';

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
    return '$count mục';
  }

  @override
  String get contactFavoritesOnly => 'Chỉ mục yêu thích';

  @override
  String get contactShowAll => 'Hiển thị tất cả địa chỉ liên hệ';

  @override
  String get contactSearchHint => 'Tìm kiếm tên, số điện thoại, email…';

  @override
  String get contactNoConnection => 'Không có kết nối';

  @override
  String get contactCheckNetwork => 'Hãy kiểm tra mạng của bạn và thử lại.';

  @override
  String get contactSomethingWrong => 'Đã xảy ra lỗi';

  @override
  String get contactNoContacts => 'Không có liên hệ';

  @override
  String get contactNoFavorites =>
      'Không có trận đấu yêu thích nào. Tắt bộ lọc dấu sao hoặc thêm mục yêu thích vào một liên hệ.';

  @override
  String get contactTrySearchOrAdd =>
      'Hãy thử tìm kiếm khác hoặc nhấn vào + để thêm liên hệ.';

  @override
  String get contactEndOfList => 'Cuối danh sách';

  @override
  String get contactNewTooltip => 'Liên hệ mới';

  @override
  String get contactLoading => 'Đang tải địa chỉ liên hệ…';

  @override
  String get contactUnknown => 'Không xác định';

  @override
  String get contactCallTooltip => 'Gọi';

  @override
  String get contactEditTitle => 'Chỉnh sửa liên hệ';

  @override
  String get contactNewTitle => 'Liên hệ mới';

  @override
  String get contactSelectTitle => 'Chọn liên hệ';

  @override
  String get contactDeleteTitle => 'Xóa liên hệ?';

  @override
  String get contactDeleteUndo => 'Không thể hoàn tác hành động này.';

  @override
  String get contactNameRequired => 'Tên là bắt buộc';

  @override
  String get contactNameLabel => 'Tên *';

  @override
  String get contactNameHint => 'Tên liên hệ';

  @override
  String get contactPhoneHint => '+977-9841234567';

  @override
  String get contactEmailHint => 'email@example.com';

  @override
  String get contactCategoryHint => 'ví dụ. kinh doanh, tổng hợp, vip';

  @override
  String get contactCompanyHint => 'Tên công ty';

  @override
  String get contactFavorite => 'Yêu thích';

  @override
  String get contactCannotCall =>
      'Không thể thực hiện cuộc gọi trên thiết bị này';

  @override
  String get contactPermissionDenied =>
      'Quyền liên hệ đã bị từ chối. Bạn có thể kích hoạt nó trong Cài đặt.';

  @override
  String get contactPermissionRequired =>
      'Cần có quyền liên hệ để nhập từ điện thoại';

  @override
  String get contactImported => 'Liên hệ được nhập từ điện thoại';

  @override
  String get contactCreated => 'Đã tạo liên hệ';

  @override
  String get contactUpdated => 'Đã cập nhật liên hệ';

  @override
  String get contactDeleted => 'Đã xóa liên hệ';

  @override
  String get contactImportSearchHint =>
      'Tìm kiếm theo tên, số điện thoại, email, công ty';

  @override
  String get contactImportNoResults => 'Không tìm thấy địa chỉ liên hệ nào';

  @override
  String get checkoutMultiplePaymentHint =>
      'BẬT tính năng này nếu khách hàng thanh toán qua nhiều phương thức thanh toán.';

  @override
  String get checkoutFillRemainingBalance => 'Điền vào số dư còn lại';

  @override
  String get checkoutEnterAtLeastOnePayment =>
      'Nhập ít nhất một số tiền thanh toán';

  @override
  String get checkoutPaymentsExceedTotal =>
      'Tổng số tiền thanh toán không thể vượt quá tổng số tiền';

  @override
  String checkoutSentAs(String api) {
    return 'Đã gửi dưới dạng: $api';
  }

  @override
  String get paymentCard => 'Thẻ';

  @override
  String get paymentQr => 'QR';

  @override
  String get paymentBank => 'Ngân hàng';

  @override
  String get paymentTransfer => 'Chuyển khoản';

  @override
  String get paymentBankTransfer => 'Chuyển khoản ngân hàng';

  @override
  String get paymentSettlement => 'giải quyết';

  @override
  String get paymentCheque => 'Kiểm tra';

  @override
  String get paymentDigital => 'Điện tử';

  @override
  String get paymentDigitalQr => 'Kỹ thuật số (QR)';

  @override
  String get closeSummaryTitle => 'Tổng kết đóng ca';

  @override
  String get closeTabDashboard => 'Trang tổng quan';

  @override
  String get closeTabCredits => 'Tín dụng';

  @override
  String get closeWelcome => 'Chào mừng đến với Tóm tắt kết thúc';

  @override
  String get closeSelectDateHint => 'Chọn ngày và nhấn làm mới để tải dữ liệu';

  @override
  String get closeLoadingDashboard => 'Đang tải dữ liệu trang tổng quan...';

  @override
  String get closeDataDeleted => 'Đã xóa dữ liệu';

  @override
  String closeErrorPrefix(String message) {
    return 'Lỗi: $message';
  }

  @override
  String get closeExtraAmount => 'Số tiền bổ sung';

  @override
  String get closeExtraAmountDesc =>
      'Tiền mặt bổ sung hoặc các khoản điều chỉnh được ghi nhận cho ngày kết thúc này.';

  @override
  String get closeLostAmount => 'Số tiền bị mất';

  @override
  String get closeLostAmountDesc =>
      'Thiếu tiền mặt hoặc chênh lệch được gắn cờ trong giai đoạn này.';

  @override
  String get closeTapForDetails => 'Nhấn để biết chi tiết';

  @override
  String get closeAmountLabel => 'Chốt ca';

  @override
  String get closeAmountFormula => 'Công thức số tiền chốt ca';

  @override
  String get closeFormulaExpression =>
      'Doanh thu tiền mặt - Chi phí tiền mặt = Số tiền cuối kỳ';

  @override
  String get closeCashSales => 'Bán hàng bằng tiền mặt';

  @override
  String get closeCashExpenses => 'Chi phí tiền mặt';

  @override
  String get closeClosingAmount => 'Số tiền chốt ca';

  @override
  String get closeWhatThisMeans => 'Điều này có nghĩa là gì:';

  @override
  String get closeClosingMeaning =>
      'Đây là số tiền mặt phải có trong sổ đăng ký/ngăn kéo của bạn vào cuối ngày. Nó đại diện cho tất cả tiền mặt nhận được trừ đi tất cả tiền mặt được chi ra.';

  @override
  String get closeQuickStats => 'Thống kê nhanh';

  @override
  String get closeTapCardHint => 'Nhấn vào một thẻ để xem mô tả ngắn';

  @override
  String get closeOpeningBalance => 'Số dư đầu kỳ';

  @override
  String get closeTotalSales => 'Tổng doanh thu';

  @override
  String get closeQrAmount => 'Số tiền QR';

  @override
  String get closeCashAmount => 'Số tiền mặt';

  @override
  String get closeSalesDiscount => 'Giảm giá bán hàng';

  @override
  String get closeCreditQr => 'QR tín dụng';

  @override
  String get closeCreditCash => 'Tín dụng Tiền mặt';

  @override
  String get closeCreditDiscount => 'Giảm giá tín dụng';

  @override
  String get closePayCashGetQr => 'Trả tiền mặt → Nhận QR';

  @override
  String get closePayQrGetCash => 'Trả QR → Nhận tiền mặt';

  @override
  String get closePaymentMix => 'Hỗn hợp thanh toán';

  @override
  String get closePaymentMixHint =>
      'Nhấn vào tiền mặt hoặc kỹ thuật số · thanh hiển thị tỷ lệ bán hàng';

  @override
  String get closeCashVsDigitalTooltip =>
      'Tỷ trọng tiền mặt so với kỹ thuật số trong doanh số bán hàng';

  @override
  String closeSalesShareDesc(String label, String percent) {
    return '$label chiếm $percent% tổng doanh số bán hàng trong ngày này.';
  }

  @override
  String closeSalesLabel(String label) {
    return '$label doanh số bán hàng';
  }

  @override
  String get closeNoTransactions => 'Không có giao dịch nào';

  @override
  String get closeRecentTransactions => 'Giao dịch gần đây';

  @override
  String get closeViewAll => 'Xem tất cả';

  @override
  String get closeNoPurchases => 'Không có giao dịch mua nào';

  @override
  String get closeRecentPurchases => 'Mua hàng gần đây';

  @override
  String get closeNoSalesDate => 'Không có doanh số bán hàng cho ngày này';

  @override
  String get closeNoSalesHint =>
      'Doanh số bán hàng sẽ hiển thị ở đây sau khi chúng được ghi lại.';

  @override
  String get closeRoomSales => 'Bán phòng';

  @override
  String get closeEmployeeSales => 'nhân viên bán hàng';

  @override
  String get closeOtherSales => 'other doanh số bán hàng';

  @override
  String closeSectionCount(String title, String count) {
    return '$title ($count)';
  }

  @override
  String closeDiscountShort(String amount) {
    return 'Đĩa: $amount';
  }

  @override
  String closePercentOff(String percent) {
    return '$percent% giảm giá';
  }

  @override
  String get closePending => 'Chưa giải quyết';

  @override
  String get closeNoCreditPayments => 'Không thanh toán tín dụng';

  @override
  String get closeNoCreditHint => 'Thanh toán tín dụng sẽ xuất hiện ở đây';

  @override
  String get closeViewStatistics => 'Xem thống kê';

  @override
  String get closeExportData => 'Xuất dữ liệu';

  @override
  String get closeExportComingSoon =>
      'Tính năng xuất sẽ được triển khai tại đây';

  @override
  String get closeHintOpeningBalance => 'Vị thế tiền mặt vào đầu ngày đã chọn.';

  @override
  String get closeHintTotalSales =>
      'Tổng của tất cả doanh số bán hàng được ghi lại cho ngày này.';

  @override
  String get closeHintQrAmount =>
      'Thanh toán nhận được qua QR hoặc phương thức kỹ thuật số.';

  @override
  String get closeHintCashAmount => 'Phần tiền bán được trong ngày.';

  @override
  String get closeHintCashExpenses => 'Tiền mặt thanh toán chi phí trong ngày.';

  @override
  String get closeHintSalesDiscount =>
      'Giảm giá áp dụng cho doanh số bán hàng.';

  @override
  String get closeHintCreditQr => 'Bộ sưu tập QR liên quan đến tín dụng.';

  @override
  String get closeHintCreditCash =>
      'Chuyển động tiền mặt liên quan đến tín dụng.';

  @override
  String get closeHintCreditDiscount =>
      'Giảm giá áp dụng cho các giao dịch tín dụng.';

  @override
  String get closeHintPayCashGetQr =>
      'Trao đổi nơi thanh toán tiền mặt và nhận tín dụng QR.';

  @override
  String get closeHintPayQrGetCash =>
      'Trao đổi nơi thanh toán QR và nhận tiền mặt.';

  @override
  String get closeOpeningAmount => 'Số tiền mở';

  @override
  String get closeCurrentAmount => 'Số tiền hiện tại';

  @override
  String get closeSaveReport => 'Lưu báo cáo';

  @override
  String get closeUpdateSummary => 'Tóm tắt cập nhật';

  @override
  String get closeExists => 'tồn tại';

  @override
  String get closeExistingDataInfo =>
      'Bạn có thể xem hoặc sửa đổi dữ liệu hiện có';

  @override
  String get closeEnterOpeningAmount => 'Vui lòng nhập số tiền mở';

  @override
  String get closeEnterValidAmount => 'Vui lòng nhập số tiền hợp lệ';

  @override
  String get closeAmountCannotBeNegative => 'Amount cannot be negative';

  @override
  String get googleDriveBackupSectionTitle => 'Sao lưu & Đồng bộ';

  @override
  String get googleDriveBackupTitle => 'Sao lưu Google Drive';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Đăng nhập để sao lưu an toàn dữ liệu tổ chức trên Google Drive.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'Đăng nhập với $email';
  }

  @override
  String get googleDriveSignIn => 'Đăng nhập Google';

  @override
  String get googleDriveSignOut => 'Đăng xuất';

  @override
  String get googleDriveBackupNow => 'Sao lưu ngay';

  @override
  String get googleDriveSignInSuccess => 'Đã đăng nhập Google Drive';

  @override
  String get googleDriveSignOutSuccess => 'Đã đăng xuất Google Drive';

  @override
  String get googleDriveSignInCancelled => 'Đã hủy đăng nhập Google';

  @override
  String get googleDriveBackupStarting => 'Đang chuẩn bị sao lưu…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'Đã tải lên sao lưu ($tableCount bảng, $recordCount bản ghi)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'Sao lưu cần khởi động lại ứng dụng hoàn toàn. Đóng ứng dụng, mở lại và thử lại.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'Sao lưu thất bại: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'Sao lưu gần nhất: $date';
  }

  @override
  String get backupSyncPageTitle => 'Sao lưu & Đồng bộ';

  @override
  String get backupSyncGoogleAccount => 'Tài khoản Google';

  @override
  String get backupSyncSignedInAs => 'Đăng nhập với';

  @override
  String get backupSyncSignInHint =>
      'Đăng nhập Google để sao lưu dữ liệu tổ chức.';

  @override
  String get backupSyncLastSyncTitle => 'Đồng bộ gần nhất';

  @override
  String get backupSyncLastSyncDate => 'Ngày giờ';

  @override
  String get backupSyncNeverSynced => 'Chưa có bản sao lưu nào được tải lên.';

  @override
  String get backupSyncOrganization => 'Tổ chức';

  @override
  String get backupSyncTables => 'Bảng đã sao lưu';

  @override
  String get backupSyncRecords => 'Bản ghi đã sao lưu';

  @override
  String get backupSyncStatus => 'Trạng thái';

  @override
  String get backupSyncStatusSuccess => 'Hoàn tất';

  @override
  String get backupSyncActiveOrganization => 'Tổ chức hiện tại';

  @override
  String get backupSyncActiveOrganizationHint =>
      'Sao lưu tải lên dữ liệu của tổ chức bạn đang dùng.';

  @override
  String get backupSyncUnknownOrganization => 'Tổ chức hiện tại';

  @override
  String get backupSyncInProgress => 'Đang đồng bộ';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'Bước: $step';
  }

  @override
  String get backupSyncStepExport => 'Đang xuất dữ liệu cục bộ';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'Đang tải lên $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'Đang tải lên $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'Lỗi gần nhất: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'Đăng xuất Google Drive trên thiết bị này?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Sao lưu lên Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync => 'Đã đăng nhập · Chưa sao lưu';

  @override
  String get backupSyncConnected => 'Đã kết nối';

  @override
  String get backupSyncCompletedHint =>
      'Dữ liệu của bạn đã được sao lưu an toàn trên Google Drive.';

  @override
  String get backupSyncPhaseExport => 'Xuất';

  @override
  String get backupSyncPhaseUpload => 'Tải lên';

  @override
  String get backupAutoSettingsTitle => 'Cài đặt Google Drive';

  @override
  String get backupAutoBackupTitle => 'Sao lưu tự động';

  @override
  String get backupAutoBackupHint => 'Sao lưu tự động khi mở ứng dụng đến hạn';

  @override
  String get backupWifiOnlyTitle => 'Chỉ sao lưu qua Wi‑Fi';

  @override
  String get backupWifiOnlyHint => 'Sao lưu tự động chờ Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => 'Dùng dữ liệu di động';

  @override
  String get backupAutoFrequencyTitle => 'Tần suất sao lưu';

  @override
  String get backupAutoFrequencyOff => 'Tắt';

  @override
  String get backupAutoFrequencyDaily => 'Hàng ngày';

  @override
  String get backupAutoFrequencyWeekly => 'Hàng tuần';

  @override
  String get backupAutoFrequencyMonthly => 'Hàng tháng';

  @override
  String get backupAutoSyncDirectionTitle => 'Đồng bộ tự động';

  @override
  String get backupAutoDirectionUpload => 'Tải lên đám mây';

  @override
  String get backupAutoDirectionDownload => 'Tải xuống từ đám mây';

  @override
  String get backupAutoDirectionBoth => 'Tải lên & tải xuống';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'Sao lưu tự động gần nhất: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'Khôi phục tự động gần nhất: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'Đồng bộ tự động gần nhất thất bại: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'Đồng bộ tự động gần nhất bỏ qua: $detail';
  }

  @override
  String get restoreAction => 'Khôi phục';

  @override
  String get restoreFromGoogleDrive => 'Khôi phục từ Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'Đăng nhập và chọn bản sao lưu để khôi phục tổ chức trên thiết bị này.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return 'Khôi phục \"$name\"? Sẽ thay thế dữ liệu cục bộ của tổ chức đó.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return 'Đã khôi phục $name. Bạn có thể đăng nhập.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'Khôi phục thất bại: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'Không tìm thấy sao lưu trong Google Drive.';

  @override
  String get restoreFromGoogleDriveStarting => 'Đang bắt đầu khôi phục…';

  @override
  String get restoreStepDownload => 'Đang tải sao lưu';

  @override
  String get restoreStepCreateDatabase => 'Đang tạo cơ sở dữ liệu';

  @override
  String get restoreStepImport => 'Đang nhập dữ liệu';

  @override
  String get restoreStepFinalize => 'Đang hoàn tất khôi phục';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'Đồng bộ gần nhất: $date';
  }

  @override
  String get security => 'Bảo mật';

  @override
  String get appLockTitle => 'Khóa ứng dụng';

  @override
  String get appLockSubtitle =>
      'Yêu cầu PIN hoặc sinh trắc khi mở lại ứng dụng';

  @override
  String get appPin => 'PIN ứng dụng';

  @override
  String appPinSubtitle(int length) {
    return 'Mở khóa nhanh bằng PIN $length chữ số';
  }

  @override
  String get useBiometricUnlock => 'Dùng Face ID / sinh trắc';

  @override
  String get useBiometricUnlockSubtitle =>
      'Mở khóa bằng vân tay hoặc Face ID sau khi đặt PIN';

  @override
  String get changeAppPin => 'Đổi PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'Đặt PIN';

  @override
  String get confirmAppPin => 'Xác nhận PIN';

  @override
  String get enterAppPin => 'Nhập PIN';

  @override
  String get enterPasscode => 'Nhập mã';

  @override
  String tapDigitsToUnlock(int length) {
    return 'Chạm $length chữ số bất kỳ để mở khóa.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'Chọn mã $length chữ số cho tổ chức này';
  }

  @override
  String get confirmPasscodeHint => 'Nhập lại mã để xác nhận';

  @override
  String createAppPinHint(int length) {
    return 'Chọn PIN $length chữ số cho tổ chức này';
  }

  @override
  String get confirmAppPinHint => 'Nhập lại PIN để xác nhận';

  @override
  String get appPinMismatch => 'PIN không khớp. Thử lại.';

  @override
  String get appPinIncorrect => 'PIN không đúng. Thử lại.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN không đúng. Còn $remaining lần thử.';
  }

  @override
  String get appPinLockoutMessage =>
      'Quá nhiều lần PIN sai. Đăng nhập bằng email và mật khẩu để đặt lại PIN.';

  @override
  String get appPinSetSuccess => 'Đã lưu PIN cho tổ chức này';

  @override
  String get appPinRemoved => 'Đã xóa PIN ứng dụng';

  @override
  String get appLockSettingsSaved => 'Đã lưu cài đặt khóa ứng dụng';

  @override
  String get biometricUnlockReason => 'Mở khóa BizTrack';

  @override
  String get biometricNotAvailable =>
      'Sinh trắc không khả dụng trên thiết bị này';

  @override
  String get biometricRequiresPin => 'Đặt PIN ứng dụng trước khi bật sinh trắc';

  @override
  String get disableAppPinTitle => 'Xóa PIN ứng dụng?';

  @override
  String get disableAppPinMessage =>
      'Face ID / mở khóa sinh trắc cũng sẽ tắt cho tổ chức này.';

  @override
  String get verifyPinToRemoveTitle => 'Nhập PIN';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'Xác nhận PIN $length chữ số để gỡ khóa ứng dụng';
  }

  @override
  String get unlockApp => 'Mở khóa ứng dụng';

  @override
  String get usePinInstead => 'Dùng PIN thay thế';

  @override
  String get useBiometricInstead => 'Dùng sinh trắc';

  @override
  String get signInWithFaceId => 'Đăng nhập Face ID';

  @override
  String get signInWithFingerprint => 'Đăng nhập vân tay';

  @override
  String get signInWithBiometric => 'Đăng nhập sinh trắc';

  @override
  String get signInWithPin => 'Đăng nhập PIN';

  @override
  String get setUpQuickUnlock => 'Đặt đăng nhập nhanh bằng PIN';

  @override
  String get setUpFaceIdOrPin => 'Đặt Face ID hoặc PIN';

  @override
  String get setUpFingerprintOrPin => 'Đặt vân tay hoặc PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'Dùng sinh trắc hoặc PIN cho tổ chức này';

  @override
  String quickUnlockAsUser(String email) {
    return 'Đăng nhập nhanh với $email';
  }

  @override
  String get orContinueWithPassword => 'hoặc đăng nhập bằng mật khẩu';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'Bật đăng nhập nhanh?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'Đặt Face ID, vân tay hoặc PIN để đăng nhập nhanh hơn lần sau. Có thể đổi sau trong Cài đặt.';

  @override
  String get notNow => 'Không phải bây giờ';

  @override
  String get setUpNow => 'Đặt ngay';

  @override
  String get enableFaceIdTitle => 'Bật Face ID?';

  @override
  String get enableFingerprintTitle => 'Bật vân tay?';

  @override
  String get enableBiometricTitle => 'Bật sinh trắc?';

  @override
  String get enableBiometricAfterPinMessage =>
      'Dùng sinh trắc thiết bị cùng PIN để đăng nhập nhanh hơn.';

  @override
  String get useFaceIdUnlock => 'Dùng Face ID';

  @override
  String get useFingerprintUnlock => 'Dùng vân tay';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => 'Năm';

  @override
  String get reportPeriodMonth => 'Tháng';

  @override
  String get reportPeriodRange => 'Khoảng';

  @override
  String get reportPeriodDay => 'Ngày';

  @override
  String get reportPeriodFrom => 'Từ';

  @override
  String get reportPeriodTo => 'Đến';

  @override
  String get reportPeriod => 'Kỳ';

  @override
  String get reportAllPurchases => 'Tất cả mua hàng';

  @override
  String get reportBeforeTax => 'Trước thuế';

  @override
  String get reportRevenueRetained => 'Doanh thu giữ lại';

  @override
  String get reportHideDetails => 'Ẩn chi tiết';

  @override
  String get reportShowDetails => 'Hiện chi tiết';

  @override
  String get reportSalesRevenue => 'Doanh thu bán hàng';

  @override
  String get reportDiscountsGiven => 'Chiết khấu đã cho';

  @override
  String get reportNetRevenue => 'Doanh thu thuần';

  @override
  String get reportOperatingExpenses => 'Chi phí hoạt động';

  @override
  String get reportTotalExpenses => 'Tổng chi phí';

  @override
  String get reportGrossProfit => 'Lợi nhuận gộp';

  @override
  String get reportGrossProfitChart => 'Lợi nhuận gộp';

  @override
  String get reportOperatingPlDisclaimer =>
      'Chưa tính thuế, khấu hao và lương — ước tính lãi lỗ cấp vận hành.';

  @override
  String get reportContraLabel => 'Đối ứng';

  @override
  String get reportNoDataForPeriod => 'Không có dữ liệu cho kỳ đã chọn';

  @override
  String get reportRevenueVsExpenses => 'Doanh thu vs chi phí';

  @override
  String get reportExpenseBreakdown => 'Phân tích chi phí';

  @override
  String get reportExpenseFallback => 'Chi phí';

  @override
  String get reportGrossMarginPercent => 'Biên lợi nhuận gộp %';

  @override
  String get reportRoomVsFnB => 'Phòng vs F&B';

  @override
  String get reportSegmentRoom => 'Phòng';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'Chỉ số chính';

  @override
  String get reportIncomeStatement => 'Báo cáo kết quả kinh doanh';

  @override
  String get reportChartsSection => 'Biểu đồ';

  @override
  String get reportSegmentSummary => 'Tổng kết phân khúc';

  @override
  String get reportFailedToLoad => 'Không tải được báo cáo';

  @override
  String get reportOverview => 'Tổng quan';

  @override
  String get reportOverviewCash => 'Tiền mặt';

  @override
  String get reportOverviewBank => 'Ngân hàng';

  @override
  String get reportMonthlyOpeningBalance => 'Số dư đầu tháng';

  @override
  String get reportOpeningBalanceHint => 'Tiền mặt đầu mỗi tháng';

  @override
  String get reportCashInOut => 'Tiền mặt vào / ra';

  @override
  String get reportCashIn => 'Tiền mặt vào';

  @override
  String get reportCashOut => 'Tiền mặt ra';

  @override
  String get reportBankReceiptsPayments => 'Thu/chi ngân hàng';

  @override
  String get reportReceipts => 'Thu';

  @override
  String get reportPayments => 'Thanh toán';

  @override
  String get reportDailyCashVsQr => 'Tiền mặt hàng ngày vs QR';

  @override
  String get reportSummariesSection => 'Tổng kết';

  @override
  String get reportCashSummary => 'Tổng kết tiền mặt';

  @override
  String get reportBankSummary => 'Tổng kết ngân hàng';

  @override
  String get reportDailySummary => 'Tổng kết hàng ngày';

  @override
  String get reportTabPurchase => 'Mua hàng';

  @override
  String get reportTabSales => 'Bán hàng';

  @override
  String get reportTabDashboard => 'Bảng điều khiển';

  @override
  String get reportSingleDayTrend => 'Một ngày — xu hướng ngày';

  @override
  String get reportFullYearTrend => 'Cả năm — biểu đồ xu hướng theo tháng';

  @override
  String reportYearLabel(String year) {
    return 'Năm $year';
  }

  @override
  String reportJanDec(String year) {
    return 'Th1 – Th12 $year';
  }

  @override
  String get reportTotalPurchases => 'Tổng mua hàng';

  @override
  String get reportTotalSales => 'Tổng doanh thu';

  @override
  String get reportTotalInvoices => 'Tổng hóa đơn';

  @override
  String get reportUnpaidBalance => 'Số dư chưa thanh toán';

  @override
  String get reportAvgPerInvoice => 'TB/hóa đơn';

  @override
  String get reportPerTransaction => 'Mỗi giao dịch';

  @override
  String reportMonthlySpend(String symbol) {
    return 'Chi tiêu tháng ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'Doanh thu tháng ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'Số hóa đơn theo tháng';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'Món chi nhiều nhất ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'Chi tiêu theo danh mục';

  @override
  String get reportOtherCategory => 'Khác';

  @override
  String get reportSuppliers => 'Nhà cung cấp';

  @override
  String get reportTableSupplier => 'Nhà cung cấp';

  @override
  String get reportTableAmount => 'Số tiền';

  @override
  String get reportTableBills => 'Hóa đơn';

  @override
  String get reportSalesTotal => 'Tổng bán hàng';

  @override
  String get reportPurchaseTotal => 'Tổng mua hàng';

  @override
  String get reportPositiveMargin => 'Biên dương';

  @override
  String get reportNegativeMargin => 'Biên âm';

  @override
  String get reportGrossMargin => 'Biên lợi nhuận gộp';

  @override
  String get reportOfTotalSales => 'Của tổng doanh thu';

  @override
  String get reportFailedToLoadAnalytics => 'Không tải được phân tích';

  @override
  String get reportMarginKpi => 'Biên';

  @override
  String get reportExpensesKpi => 'Chi phí';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'Không có kết quả cho \"$query\"';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'Không tìm thấy đối tác $role';
  }

  @override
  String get partyPickerLoadParties => 'Tải đối tác';

  @override
  String get invoiceCashCustomer => 'Khách trả tiền mặt';

  @override
  String get invoiceQuickAddItemsTitle => 'Thêm món nhanh';

  @override
  String get invoiceQuickLoadingMenu => 'Đang tải thực đơn…';

  @override
  String get invoiceQuickInvoiceCreated => 'Đã tạo hóa đơn';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'Thêm ít nhất một món';

  @override
  String get invoiceQuickNoResults => 'Không tìm thấy kết quả!';

  @override
  String get invoiceQuickNoItemsInCategory => 'Không có món trong danh mục này';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'Thêm món';

  @override
  String get invoiceQuickLoadMore => 'Tải thêm';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'Cuộn để tải thêm ($count/trang)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'Nhà cung cấp / Nhân viên';

  @override
  String get invoiceQuickEditItem => 'Sửa món';

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
  String get closeSelectDateRange => 'Chọn khoảng ngày';

  @override
  String get closeStartDate => 'Ngày bắt đầu';

  @override
  String get closeEndDate => 'Ngày kết thúc';

  @override
  String get closeSelectBothDates =>
      'Vui lòng chọn cả ngày bắt đầu và kết thúc';

  @override
  String get closeDeleteSummary => 'Xóa tổng kết';

  @override
  String get closeDeleteSummaryConfirm => 'Bạn có chắc muốn xóa tổng kết này?';

  @override
  String get closeSelectDate => 'Chọn ngày';

  @override
  String get closeNoDataToExport => 'Không có dữ liệu để xuất';

  @override
  String get closeNoDataToShare => 'Không có dữ liệu để chia sẻ';

  @override
  String get closeNoDataToPrint => 'Không có dữ liệu để in';

  @override
  String closePdfGenerateError(String error) {
    return 'Lỗi tạo PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'Lỗi chia sẻ PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'Lỗi in PDF: $error';
  }

  @override
  String get closeExportPdf => 'Xuất PDF';

  @override
  String get closeSharePdf => 'Chia sẻ PDF';

  @override
  String get closePrint => 'In';

  @override
  String get closeExportOptions => 'Tùy chọn xuất';

  @override
  String get closeExportPdfSubtitle => 'Lưu hoặc xem dưới dạng tài liệu PDF';

  @override
  String get closeSharePdfSubtitle => 'Chia sẻ qua ứng dụng hoặc email';

  @override
  String get closePrintSubtitle => 'In báo cáo';

  @override
  String get closeDailyCashSummaryTitle => 'Tổng kết tiền mặt hàng ngày';

  @override
  String get closeDailyCashSummaryReport =>
      'Báo cáo tổng kết tiền mặt hàng ngày';

  @override
  String closeGeneratedAt(String date) {
    return 'Tạo lúc: $date';
  }

  @override
  String get closeTotalRecords => 'Tổng số bản ghi';

  @override
  String get closeSummaryOverview => 'Tổng quan';

  @override
  String get closeAllRecords => 'Tất cả bản ghi';

  @override
  String closePeriodRange(String start, String end) {
    return 'Kỳ: từ $start đến $end';
  }

  @override
  String get closeDetails => 'Chi tiết';

  @override
  String closePageN(int n) {
    return 'Trang $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'Hiển thị $shown/$total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'Đã tải: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'Phòng / Cabin / Nhân viên';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent% doanh thu';
  }

  @override
  String get reportParties => 'Đối tác';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — biểu đồ xu hướng theo ngày';
  }

  @override
  String get invoiceQuickCart => 'Giỏ hàng';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'Giỏ hàng ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'Xóa tìm kiếm';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'Thêm tóm tắt';

  @override
  String get closeSalesAmount => 'Doanh thu bán hàng';

  @override
  String get closeClosingBalance => 'Số dư cuối kỳ';

  @override
  String get closeLostMoney => 'Tiền mất';

  @override
  String get closeDiscount => 'Giảm giá';

  @override
  String get closeExpenses => 'Chi phí';

  @override
  String get closeUnpaid => 'Chưa thanh toán';

  @override
  String get closeTotalOpeningBalance => 'Tổng số dư đầu kỳ';

  @override
  String get closeTotalSalesAmount => 'Tổng doanh thu';

  @override
  String get closeTotalCashAmount => 'Tổng tiền mặt';

  @override
  String get closeTotalQrAmount => 'Tổng QR';

  @override
  String get closeTotalDiscount => 'Tổng giảm giá';

  @override
  String get closeTotalExpenses => 'Tổng chi phí';

  @override
  String get closeTotalClosingBalance => 'Tổng số dư cuối kỳ';

  @override
  String get closeTotalLostMoney => 'Tổng tiền mất';

  @override
  String get closeTotalExtraAmount => 'Tổng số tiền thêm';

  @override
  String get closeShowingCurrentMonth => 'Hiển thị dữ liệu tháng hiện tại';

  @override
  String get closeNoSummariesFound => 'Không tìm thấy tóm tắt';

  @override
  String get closeNoSummariesAvailable => 'Không có tóm tắt';

  @override
  String get closeTryAdjustingDateRange => 'Hãy thử điều chỉnh khoảng ngày';

  @override
  String get closeCreateFirstSummary => 'Tạo tóm tắt đầu tiên để bắt đầu';

  @override
  String get closeClearFilter => 'Xóa bộ lọc';

  @override
  String get closeFiltered => 'Đã lọc';

  @override
  String closeFilteredWithRange(String range) {
    return 'Đã lọc: $range';
  }

  @override
  String get closeSummarySingular => 'Tóm tắt';

  @override
  String get closeSummariesPlural => 'Tóm tắt';

  @override
  String get closeSummaryUpdatedSuccess => 'Cập nhật tóm tắt thành công';

  @override
  String get closeSummaryDeletedSuccess => 'Xóa tóm tắt thành công';

  @override
  String premiumUnlockTitle(String appName) {
    return 'Mở khóa $appName Premium';
  }

  @override
  String get premiumTagline =>
      'POS offline đầy đủ, hóa đơn, kho hàng và báo cáo — một gói đăng ký cho doanh nghiệp của bạn.';

  @override
  String get premiumFeatureUnlimitedInvoices =>
      'Hóa đơn và biên lai không giới hạn';

  @override
  String get premiumFeatureInventoryStock => 'Kho hàng và theo dõi tồn kho';

  @override
  String get premiumFeatureReportsAnalytics => 'Báo cáo bán hàng và phân tích';

  @override
  String get premiumFeatureOfflineLocal =>
      'Hoạt động offline — dữ liệu lưu cục bộ';

  @override
  String premiumContinueWith(String plan) {
    return 'Tiếp tục với $plan';
  }

  @override
  String get premiumRestorePurchases => 'Khôi phục giao dịch';

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
      'Thanh toán được tính vào Apple ID của bạn. Gói đăng ký tự gia hạn trừ khi hủy ít nhất 24 giờ trước khi hết hạn.';

  @override
  String get premiumPurchaseRestored => 'Đã khôi phục giao dịch.';

  @override
  String get premiumNoActiveSubscription =>
      'Không tìm thấy gói đăng ký đang hoạt động.';

  @override
  String get premiumPlanMonthly => 'Hàng tháng';

  @override
  String get premiumPlanMonthlySubtitle => 'Linh hoạt — hủy bất cứ lúc nào';

  @override
  String get premiumPlanYearly => 'Hàng năm';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'Giá trị tốt nhất — tiết kiệm $percent%';
  }

  @override
  String get premiumPlanLifetime => 'Trọn đời';

  @override
  String get premiumPlanLifetimeSubtitle => 'Trả một lần, dùng mãi mãi';

  @override
  String get premiumPlanPopular => 'Phổ biến';

  @override
  String get premiumOneTimePurchase => 'Mua một lần';

  @override
  String get subscriptionSectionTitle => 'Đăng ký';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Nâng cấp lên Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'Tháng $monthly · Năm $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan hoạt động đến $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan đang hoạt động';
  }

  @override
  String get premiumRequired => 'Cần Premium';

  @override
  String get upgradeToPremiumContinue => 'Nâng cấp lên Premium để tiếp tục.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'Gói miễn phí cho phép tối đa $limit $label. Nâng cấp Premium để truy cập không giới hạn.';
  }

  @override
  String get freemiumPartyRoleRequired => 'Vai trò đối tác là bắt buộc.';

  @override
  String get freemiumLabelSalesInvoices => 'hóa đơn bán';

  @override
  String get freemiumLabelPurchaseInvoices => 'hóa đơn mua';

  @override
  String get freemiumLabelEmployees => 'nhân viên';

  @override
  String get freemiumLabelItems => 'mặt hàng';

  @override
  String get freemiumLabelCategories => 'danh mục';

  @override
  String get freemiumLabelPaymentMethods => 'phương thức thanh toán';

  @override
  String get freemiumLabelCustomPartyRoles => 'vai trò đối tác tùy chỉnh';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'đối tác cho $role';
  }

  @override
  String get freemiumLabelOrganizations => 'tổ chức';

  @override
  String get freemiumPremiumReports => 'Báo cáo có sẵn với Premium.';

  @override
  String get freemiumPremiumBackupSync => 'Sao lưu và đồng bộ cần Premium.';

  @override
  String get freemiumPremiumPayroll => 'Lương cần Premium.';

  @override
  String get freemiumPremiumAttendance => 'Chấm công cần Premium.';

  @override
  String get freemiumPremiumStock => 'Quản lý kho cần Premium.';

  @override
  String get freemiumPremiumInvoiceExport => 'Tải xuống và in cần Premium.';

  @override
  String get shiftReminderOpeningTitle => 'Nhắc mở ca';

  @override
  String get shiftReminderOpeningMessage => 'Bạn đã mở sổ quỹ hôm nay chưa?';

  @override
  String get shiftReminderOpeningProceed => 'Có, mở ngay';

  @override
  String get shiftReminderClosingTitle => 'Nhắc đóng ca';

  @override
  String get shiftReminderClosingMessage => 'Bạn đã đóng sổ quỹ hôm nay chưa?';

  @override
  String get shiftReminderClosingProceed => 'Có, đóng ngay';

  @override
  String get shiftReminderSkipToday => 'Bỏ qua hôm nay';

  @override
  String get shiftReminderOpeningNotificationTitle => 'Nhắc mở ca';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'Bạn đã mở sổ quỹ hôm nay chưa? Chạm vào đây nếu vẫn cần mở.';

  @override
  String get shiftReminderClosingNotificationTitle => 'Nhắc đóng ca';

  @override
  String get shiftReminderClosingNotificationBody =>
      'Bạn đã đóng sổ quỹ hôm nay chưa? Chạm vào đây nếu vẫn cần đóng.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business trả QR cho khách; khách đưa tiền mặt.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business trả tiền mặt cho khách; khách thanh toán QR.';
  }

  @override
  String get closePaymentExchange => 'Đổi phương thức thanh toán';

  @override
  String get closePayQrGetCashExchangeLabel => 'Trả QR → Nhận tiền mặt (đổi)';

  @override
  String get closePayCashGetQrExchangeLabel => 'Trả tiền mặt → Nhận QR (đổi)';

  @override
  String get closePayQrGetCashDetail => 'Trả QR, nhận tiền mặt';

  @override
  String get closePayCashGetQrDetail => 'Trả tiền mặt, nhận QR';

  @override
  String get faqSectionPremium => 'Premium và thanh toán';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium bao gồm gì?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium mở khóa hóa đơn không giới hạn, báo cáo đầy đủ (P&L, sao kê, phân tích), sao lưu và đồng bộ, lương, chấm công, công cụ kho, xuất/in hóa đơn và tổ chức bổ sung. Gói miễn phí vẫn dùng được POS cốt lõi trong giới hạn hợp lý.';

  @override
  String get faqPremiumFreeTierQuestion => 'Gói miễn phí bao gồm gì?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'Bạn có thể tạo tối đa 10 hóa đơn bán và 10 mua, 4 nhân viên, 30 mặt hàng và các giới hạn khác khi đạt ngưỡng. Mở ca, đóng ca, máy tính và duyệt dữ liệu vẫn miễn phí.';

  @override
  String get faqPremiumRestoreQuestion => 'Làm sao khôi phục giao dịch?';

  @override
  String get faqPremiumRestoreAnswer =>
      'Mở Thêm → Nâng cấp Premium (hoặc paywall) và chạm Khôi phục giao dịch. Dùng cùng Apple ID khi đăng ký.';

  @override
  String get faqPremiumCancelQuestion => 'Làm sao hủy đăng ký?';

  @override
  String get faqPremiumCancelAnswer =>
      'Quản lý hoặc hủy trong Cài đặt iPhone → Apple ID → Đăng ký. Bạn vẫn truy cập đến hết kỳ đã trả.';

  @override
  String get faqDarkModeQuestion => 'Làm sao bật chế độ tối?';

  @override
  String get faqDarkModeAnswer =>
      'Mở Thêm → Giao diện và bật Chế độ tối. Khi thiết bị dùng giao diện hệ thống, ứng dụng tự theo.';

  @override
  String get faqOpeningClosingReminderQuestion => 'Nhắc mở và đóng ca là gì?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName có thể nhắc bạn mở hoặc đóng sổ quỹ hàng ngày. Bạn có thể tiếp tục, bỏ qua hôm nay hoặc tắt nhắc.';
  }

  @override
  String get faqPartyRolesQuestion => 'Vai trò đối tác là gì?';

  @override
  String get faqPartyRolesAnswer =>
      'Vai trò đối tác phân loại liên hệ như khách hàng, nhà cung cấp, phòng hoặc nhân viên. Tùy chỉnh tại Vận hành → Vai trò đối tác và thêm mô tả ngắn cho đội.';

  @override
  String faqRateAppQuestion(String appName) {
    return 'Làm sao đánh giá $appName?';
  }

  @override
  String get faqRateAppAnswer =>
      'Mở Thêm → Đánh giá chúng tôi để để lại nhận xét trên App Store. Phản hồi của bạn giúp cải thiện hóa đơn offline.';
}
