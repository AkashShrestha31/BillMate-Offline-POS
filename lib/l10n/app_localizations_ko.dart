// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get noInternetConnection => '인터넷에 연결되어 있지 않습니다.';

  @override
  String get formatException => '형식 예외';

  @override
  String get rememberMe => '로그인 유지';

  @override
  String get signIn => '로그인';

  @override
  String get passwordHint => '비밀번호 입력';

  @override
  String get forgetPassword => '로그인 정보를 잊으셨나요?';

  @override
  String get okay => '확인';

  @override
  String get success => '성공';

  @override
  String get hotel => '호텔';

  @override
  String get errorEncountered => '오류 발생';

  @override
  String get serverError => '서버 오류';

  @override
  String get requestFailed => '요청 실패';

  @override
  String get connectionTimedOut => '연결 시간 초과';

  @override
  String get password => '비밀번호';

  @override
  String get keepSignIn => '로그인 유지';

  @override
  String get enterPassword => '비밀번호 입력';

  @override
  String get enterValidPassword => '유효한 비밀번호를 입력하세요';

  @override
  String get skip => '건너뛰기';

  @override
  String get pleaseWait => '잠시 기다려 주세요 ....';

  @override
  String get enterValidUserName => '유효한 사용자 이름을 입력하세요.';

  @override
  String get userName => '사용자 이름';

  @override
  String get or => '또는';

  @override
  String get retry => '다시 시도';

  @override
  String get error => '오류';

  @override
  String get supportMessage => '관리자에게 문의하세요.';

  @override
  String get responseMessage404 => '404 오류';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return '버전 $version';
  }

  @override
  String get cancel => '취소';

  @override
  String get yes => '예';

  @override
  String get no => '아니오';

  @override
  String get close => '닫기';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get deleteOrganizationTitle => '조직을 삭제하시겠습니까?';

  @override
  String deleteOrganizationMessage(String name) {
    return '이 기기에서 $name을 제거합니다. 이 조직의 모든 로컬 데이터가 삭제됩니다.';
  }

  @override
  String get deleteOrganizationWarning => '이 작업은 취소할 수 없습니다.';

  @override
  String get organizationDeleted => '조직이 삭제되었습니다';

  @override
  String get confirm => '확인';

  @override
  String get done => '완료';

  @override
  String get next => '다음';

  @override
  String get getStarted => '시작하기';

  @override
  String get walkthroughDashboardTitle => '전체 비즈니스 한눈에';

  @override
  String get walkthroughDashboardDescription =>
      '오늘의 매출, 수익 및 미수 잔액 — 앱을 열면 한눈에 보는 대시보드.';

  @override
  String get walkthroughOfflineTitle => '인터넷 없이도 작동';

  @override
  String get walkthroughOfflineDescription =>
      '완전 오프라인으로 청구서 생성, 지출 기록 및 재고 관리. 온라인 시 자동 동기화.';

  @override
  String get walkthroughBillingTitle => '몇 초 만에 청구 및 판매';

  @override
  String get walkthroughBillingDescription =>
      '매출 및 매입 청구서, 주방 티켓이 있는 테이블 주문, 실시간 재고 — 모두 하나의 앱에서.';

  @override
  String get walkthroughStaffTitle => '직원, 급여 및 보고서';

  @override
  String get walkthroughStaffDescription =>
      '근태 및 급여 관리, P&L 및 급여명세서 PDF 내보내기 — 추가 도구 불필요.';

  @override
  String get walkthroughBackupTitle => '데이터, 항상 안전';

  @override
  String get walkthroughBackupDescription =>
      '원터치 Google Drive 백업으로 은행 수준 보안 — 데이터 보호 및 쉬운 복원.';

  @override
  String get walkthroughReadyTitle => '준비되면 바로';

  @override
  String get walkthroughReadyDescription =>
      '몇 분 만에 조직을 설정하고 오늘부터 더 스마트하게 운영하세요. 시작해 봅시다.';

  @override
  String get back => '뒤로';

  @override
  String get submit => '제출';

  @override
  String get continueAction => '계속';

  @override
  String get createAction => '생성';

  @override
  String get connectOrganizationTitle => '조직 연결';

  @override
  String get connectOrganizationSubtitle => '로그인할 조직을 선택하세요.';

  @override
  String get selectOrganization => '조직';

  @override
  String get selectOrganizationHint => '계속하려면 조직을 탭하세요';

  @override
  String get noSavedOrganizationsYet =>
      '아직 조직이 없습니다. 하나를 만들거나 아래 테스트 데이터를 사용하세요.';

  @override
  String get orgConnectOnceInfo => '이 앱을 비즈니스 계정에 연결합니다. 기기당 한 번만 설정하면 됩니다.';

  @override
  String organizationCodeLabel(String code) {
    return '코드: $code';
  }

  @override
  String get tryAgain => '다시 시도';

  @override
  String get warning => '경고';

  @override
  String get loading => '로딩 중…';

  @override
  String get comingSoon => '출시 예정';

  @override
  String get required => '필수';

  @override
  String get search => '검색';

  @override
  String get add => '추가';

  @override
  String get edit => '편집';

  @override
  String get remove => '제거';

  @override
  String get view => '보기';

  @override
  String get export => '내보내기';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => '가져오기';

  @override
  String get refresh => '새로고침';

  @override
  String get select => '선택';

  @override
  String get upload => '업로드';

  @override
  String get download => '다운로드';

  @override
  String get share => '공유';

  @override
  String get filter => '필터';

  @override
  String get sort => '정렬';

  @override
  String get apply => '적용';

  @override
  String get reset => '초기화';

  @override
  String get clear => '지우기';

  @override
  String get all => '전체';

  @override
  String get none => '없음';

  @override
  String get total => '합계';

  @override
  String get subtotal => '소계';

  @override
  String get grandTotal => '총합계';

  @override
  String get amount => '금액';

  @override
  String get quantity => '수량';

  @override
  String get rate => '단가';

  @override
  String get discount => '할인';

  @override
  String get paid => '결제 완료';

  @override
  String get unpaid => '미지급';

  @override
  String get credit => '외상';

  @override
  String get cash => '현금';

  @override
  String get date => '날짜';

  @override
  String get time => '시간';

  @override
  String get name => '이름';

  @override
  String get email => '이메일';

  @override
  String get phone => '전화';

  @override
  String get address => '주소';

  @override
  String get notes => '메모';

  @override
  String get description => '설명';

  @override
  String get status => '상태';

  @override
  String get type => '유형';

  @override
  String get category => '카테고리';

  @override
  String get party => '거래처';

  @override
  String get item => '항목';

  @override
  String get payment => '결제';

  @override
  String get settlement => '정산';

  @override
  String get opening => '기초';

  @override
  String get closing => '기말';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => '비용';

  @override
  String get revenue => '수익';

  @override
  String get profit => '이익';

  @override
  String get loss => '손실';

  @override
  String get sales => '매출';

  @override
  String get purchase => '구매';

  @override
  String get monthJan => '1월';

  @override
  String get monthFeb => '2월';

  @override
  String get monthMar => '3월';

  @override
  String get monthApr => '4월';

  @override
  String get monthMay => '5월';

  @override
  String get monthJun => '6월';

  @override
  String get monthJul => '7월';

  @override
  String get monthAug => '8월';

  @override
  String get monthSep => '9월';

  @override
  String get monthOct => '10월';

  @override
  String get monthNov => '11월';

  @override
  String get monthDec => '12월';

  @override
  String get more => '더보기';

  @override
  String get profile => '프로필';

  @override
  String get operations => '운영';

  @override
  String get operationManagement => '운영 관리';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => '직원 관리';

  @override
  String get employeeManagementSubtitle => '직원, 급여 및 근태';

  @override
  String get report => '보고서';

  @override
  String get reportSubtitle => '손익, 명세서 및 분석';

  @override
  String get helpAndSupport => '도움말 및 지원';

  @override
  String get preferences => '환경설정';

  @override
  String get dataAndBackup => '데이터 및 백업';

  @override
  String get privacyAndPolicies => '개인정보 및 정책';

  @override
  String get faq => '자주 묻는 질문';

  @override
  String get contactSupport => '지원팀 문의';

  @override
  String get rateUs => '평가해 주세요';

  @override
  String get rateUsSubtitle => 'BizTrack이 마음에 드시나요? Google Play에 리뷰를 남겨주세요';

  @override
  String get rateUsUnavailable => '스토어를 열 수 없습니다. 나중에 다시 시도해 주세요.';

  @override
  String get reportProblem => '문제 신고';

  @override
  String get contactUs => '문의하기';

  @override
  String get contactUsSubtitle => '지원, 피드백 또는 앱 관련 문의.';

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
  String get developerLabel => '개발자';

  @override
  String get emailCopiedToClipboard => '이메일이 클립보드에 복사됨';

  @override
  String get logout => '로그아웃';

  @override
  String get signOut => '로그아웃';

  @override
  String get settings => '설정';

  @override
  String get testData => '테스트 데이터';

  @override
  String get loginWithTestData => '테스트 데이터로 로그인';

  @override
  String get loginWithTestDataSubtitle => '데모 호텔 데이터를 불러오고 자동으로 로그인';

  @override
  String testDataLoginFailed(String error) {
    return '테스트 데이터를 불러올 수 없습니다: $error';
  }

  @override
  String get preparingTestData => '데모 데이터 준비 중…';

  @override
  String get regionAndCurrency => '지역 및 통화';

  @override
  String get reportingCurrency => '보고 통화';

  @override
  String get selectCurrency => '통화 선택';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · 예시 $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return '통화가 $code ($symbol)으로 설정되었습니다';
  }

  @override
  String currencyUpdateFailed(String error) {
    return '통화를 업데이트할 수 없습니다: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return '$appName 설정';
  }

  @override
  String get setupSubtitle => '조직 및 회계를 구성하세요 — 오프라인 사용을 위해 이 기기에 저장됩니다.';

  @override
  String get setupOrganizationName => '조직 이름';

  @override
  String get setupCompanyName => '회사 이름';

  @override
  String get setupBusinessType => '사업 유형';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => '호텔';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => '레스토랑';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => '호텔 & 레스토랑';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => '소매 / 상점';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => '카페 / 베이커리';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => '바 / 펍';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => '기타';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return '유형: $type';
  }

  @override
  String get organizationSettings => '조직';

  @override
  String get editOrganizationInfo => '조직 정보';

  @override
  String get editOrganizationInfoSubtitle =>
      '이 사업체가 앱에 표시되는 방식을 업데이트합니다. 조직 코드는 변경할 수 없습니다.';

  @override
  String get organizationCode => '조직 코드';

  @override
  String get organizationCodeReadOnly => '이 코드는 설정 후 고정됩니다.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => '조직 정보가 저장되었습니다';

  @override
  String get organizationInfoLoadFailed => '조직 정보를 불러올 수 없습니다';

  @override
  String organizationInfoSaveFailed(String error) {
    return '조직 정보를 저장할 수 없습니다: $error';
  }

  @override
  String get organizationTabGeneral => '일반';

  @override
  String get organizationTabRegional => '지역 및 회계';

  @override
  String get organizationRegionalSubtitle => '국가, 보고 통화 및 회계연도 날짜.';

  @override
  String get organizationTabAccounting => '회계';

  @override
  String get organizationAccountingSubtitle => '청구서 및 금액 표시 설정.';

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
  String get displayPrecision => '표시 정밀도';

  @override
  String get displayPrecisionRange => '0에서 5 사이의 숫자 입력';

  @override
  String get enableInvoiceReturns => '청구서 반품 활성화';

  @override
  String get enableInvoiceReturnsSubtitle => '결제된 청구서에서 반품 생성 허용.';

  @override
  String get saveChanges => '변경사항 저장';

  @override
  String get setupFullName => '전체 이름';

  @override
  String get setupConfirmPassword => '비밀번호 확인';

  @override
  String get setupBankName => '은행 이름';

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
  String get setupRegionStepTitle => '지역 및 통화';

  @override
  String get setupOrganizationStepTitle => '조직';

  @override
  String get setupOrganizationStepSubtitle => '앱에서 비즈니스가 표시되는 방식';

  @override
  String get setupAdminStepTitle => '관리자 계정';

  @override
  String get setupAdminStepSubtitle => '이 설치의 기본 사용자';

  @override
  String get setupAccountingStepTitle => '회계';

  @override
  String get setupAccountingStepSubtitle => '은행, 계정 과목표 및 회계 연도';

  @override
  String get setupCompleteSetup => '설정 완료';

  @override
  String fieldRequired(String field) {
    return '$field은(는) 필수입니다';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => '유효한 이메일 주소를 입력하세요';

  @override
  String passwordMinLength(int min) {
    return '비밀번호는 최소 $min자 이상이어야 합니다';
  }

  @override
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get setupFixValidationErrors => '계속하려면 아래 오류를 수정하세요';

  @override
  String get setupCompleteSuccess => '설정이 성공적으로 완료되었습니다';

  @override
  String get setupCompleteWithPdfSuccess => '설정 완료. PDF를 안전한 곳에 저장하세요.';

  @override
  String setupPdfFailed(String error) {
    return '설정이 완료되었지만 PDF를 저장할 수 없습니다: $error';
  }

  @override
  String get setupFailed => '설정을 완료할 수 없습니다. 다시 시도하세요.';

  @override
  String setupFailedWithDetails(String error) {
    return '설정 실패: $error';
  }

  @override
  String get regionAndCurrencySubtitle => '로케일 및 보고 통화.';

  @override
  String get country => '국가';

  @override
  String get currency => '통화';

  @override
  String get selectCountry => '국가 선택';

  @override
  String get language => '언어';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get languageChangeLaterHint => '나중에 설정에서 변경할 수 있습니다';

  @override
  String languageSelectionSubtitle(String appName) {
    return '$appName 사용 방법을 선택하세요. 나중에 설정에서 변경할 수 있습니다.';
  }

  @override
  String get searchLanguages => '언어 검색';

  @override
  String get languageSuggestedBadge => '추천';

  @override
  String continueInLanguage(String languageName) {
    return '$languageName으로 계속';
  }

  @override
  String get noLanguageMatches => '일치 항목 없음';

  @override
  String noLanguageMatchesForQuery(String query) {
    return '\"$query\"와(과) 일치하는 언어가 없습니다';
  }

  @override
  String get appearance => '모양';

  @override
  String get darkMode => '다크 모드';

  @override
  String get darkModeSubtitle => '앱 전체에 어두운 배경 사용';

  @override
  String get darkModeSystemSubtitle => '기기 테마 따름';

  @override
  String languageUpdated(String name) {
    return '언어가 $name으로 설정되었습니다';
  }

  @override
  String languageUpdateFailed(String error) {
    return '언어를 업데이트할 수 없습니다: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return '$appName에 오신 것을 환영합니다';
  }

  @override
  String forceUpdateMessage(String appName) {
    return '계속하려면 $appName의 최신 버전을 설치하세요.';
  }

  @override
  String generatedByApp(String appName) {
    return '$appName에서 생성됨';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName이란 무엇인가요?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName은 판매 및 구매 청구서, 거래처(고객 및 공급업체), 재고, 결제, 직원 및 일일 요약을 스마트폰이나 태블릿에서 관리할 수 있도록 도와줍니다.';
  }

  @override
  String faqIntro(String appName) {
    return '$appName에 대한 자주 묻는 질문에 대한 답변.';
  }

  @override
  String get chooseFromGallery => '갤러리에서 선택';

  @override
  String get takePhoto => '사진 찍기';

  @override
  String get photoLibrary => '사진 보관함';

  @override
  String get addPhoto => '사진 추가';

  @override
  String couldNotPickImage(String error) {
    return '이미지를 선택할 수 없습니다: $error';
  }

  @override
  String get unpaidAmount => '미결제 금액';

  @override
  String get unpaidBalance => '미결제';

  @override
  String unpaidColonAmount(String amount) {
    return '미결제: $amount';
  }

  @override
  String get previousUnpaid => '미결제';

  @override
  String get partyUnpaid => '미결제';

  @override
  String get loadingUnpaid => '미결제…';

  @override
  String get totalUnpaid => '미결제';

  @override
  String get unpaidAmountNotYetCollected => '미수금이 아직 수령되지 않았습니다.';

  @override
  String get partyUnpaidTabHint =>
      '직원을 열고, 사람을 선택한 다음 프로필에서 거래처 미수금을 탭하세요. 서버는 이 검색에 직원 ID가 필요합니다.';

  @override
  String get partySettlementUsesUnpaidTotal => '거래처 정산은 미수금 합계를 사용합니다.';

  @override
  String get selectPartyWithUnpaidFirst =>
      '먼저 정산 금액을 입력하세요 (또는 미수금이 있는 거래처를 선택하세요).';

  @override
  String get workspace => '워크스페이스';

  @override
  String get change => '변경';

  @override
  String get addMoreOrganization => '더 추가 +';

  @override
  String get connectAnotherOrganization => '다른 조직 연결';

  @override
  String get noSavedOrganizationsUseAddMore =>
      '아직 저장된 조직이 없습니다. 더 추가 +를 사용하여 연결하세요.';

  @override
  String get registerNewOrganizationTitleSignedIn => '새 조직을 등록하시겠습니까?';

  @override
  String get registerNewOrganizationTitle => '새 조직 등록?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      '로그아웃되고 설정 마법사가 처음부터 시작되어 이 기기에 새 사업체를 등록할 수 있습니다.\n\n이미 저장한 조직은 설정 후 목록에 유지됩니다.';

  @override
  String get registerNewOrganizationMessageLogin =>
      '이 기기에 새 사업체를 등록할 수 있도록 설정 마법사가 시작됩니다. 설정을 완료하여 생성하세요. 저장된 조직은 목록에 유지됩니다.';

  @override
  String get startSetup => '설정 시작';

  @override
  String get enterOrganizationCode => '조직 코드를 입력해 주세요';

  @override
  String get organizationNotFoundCheckCode =>
      '조직을 찾을 수 없습니다. 코드를 확인하고 다시 시도하세요.';

  @override
  String get organizationNotFound => '조직을 찾을 수 없습니다';

  @override
  String get couldNotVerifyOrganization => '조직을 확인할 수 없습니다';

  @override
  String noLocalDataCompleteSetup(String name) {
    return '$name에 대한 로컬 데이터가 없습니다. 먼저 이 조직의 설정을 완료하세요.';
  }

  @override
  String get welcomeBack => '다시 오신 것을 환영합니다';

  @override
  String get signInToContinue => '계속하려면 로그인하세요';

  @override
  String get enterEmail => '이메일 입력';

  @override
  String get pleaseEnterEmail => '이메일을 입력해 주세요';

  @override
  String get pleaseEnterValidEmail => '유효한 이메일을 입력해 주세요';

  @override
  String get enterEmailLocalPartOnly => '@ 앞 부분만 입력하세요';

  @override
  String get pleaseEnterPassword => '비밀번호를 입력해 주세요';

  @override
  String get logIn => '로그인';

  @override
  String get searchCountry => '국가 검색';

  @override
  String get searchCodeOrSymbol => '코드 또는 기호 검색';

  @override
  String get saveLoginDetailsTitle => '로그인 정보를 저장하시겠습니까?';

  @override
  String get saveLoginDetailsMessage =>
      '이 조직의 설정을 완료하려고 합니다.\n\n조직 코드, 조직 이름, 로그인 이메일 및 비밀번호가 포함된 PDF를 안전하게 다운로드하시겠습니까? 안전한 곳에 보관하세요 — 이 파일을 가진 누구든 로그인할 수 있습니다.';

  @override
  String get downloadPdfAndContinue => 'PDF 다운로드 및 계속';

  @override
  String get continueWithoutPdf => 'PDF 없이 계속';

  @override
  String get legalDisplayNameHint => '법적 / 표시 이름';

  @override
  String get chartOfAccounts => '계정 과목';

  @override
  String get fiscalYearStart => '회계연도 시작';

  @override
  String get fiscalYearEnd => '회계연도 종료';

  @override
  String get removeTestDataTitle => '테스트 데이터를 제거하시겠습니까?';

  @override
  String get removeTestDataMessageDemoOrg =>
      '모든 데모 판매, 구매, 연락처, 거래처, 재고 항목, 직원, 주류 계산기 제품 및 추가 데모 조직이 제거됩니다.\n\n데모 조직을 사용 중입니다 — 이후 자동으로 첫 번째 조직으로 전환됩니다.';

  @override
  String get removeTestDataMessageNormal =>
      '모든 데모 판매, 구매, 연락처, 거래처, 재고 항목, 직원 및 3개의 추가 데모 조직이 제거됩니다. 관리자 계정과 실제 설정 데이터는 유지됩니다.';

  @override
  String get removeTestDataWarning => '테스트 데이터를 다시 로드하지 않으면 되돌릴 수 없습니다.';

  @override
  String get removeTestData => '테스트 데이터 제거';

  @override
  String get keepTestData => '테스트 데이터 유지';

  @override
  String get demoDataRemoved => '데모 데이터가 제거되었습니다';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return '테스트 데이터가 제거되었습니다. $name(으)로 전환되었습니다.';
  }

  @override
  String get testDataRemoved => '테스트 데이터가 제거되었습니다';

  @override
  String couldNotRemoveTestData(String error) {
    return '테스트 데이터를 제거할 수 없습니다: $error';
  }

  @override
  String get loadTestDataTitle => '테스트 데이터를 로드하시겠습니까?';

  @override
  String get loadTestDataMessage =>
      '데모 연락처 최대 50개, 판매 전용 재고 항목 50개 및 구매 전용 재고 항목 50개와 샘플 판매, 구매, 결제, 재고, 마감 요약, 직원, 급여, 지난 15일간의 출석 및 계산기용 샘플 주류 제품이 추가됩니다.';

  @override
  String get loadTestData => '테스트 데이터 로드';

  @override
  String get testDataLoaded => '테스트 데이터가 로드되었습니다';

  @override
  String couldNotLoadTestData(String error) {
    return '테스트 데이터를 로드할 수 없습니다: $error';
  }

  @override
  String get demoTestData => '데모 테스트 데이터';

  @override
  String get importTestDataSubtitle => '모든 기능에 대한 테스트 데이터 가져오기';

  @override
  String get hideTestDataTitle => '이 조직의 테스트 데이터를 숨기시겠습니까?';

  @override
  String get hideTestDataMessage =>
      '계속하면 테스트 데이터 섹션이 이 조직의 모든 곳에서 숨겨집니다 (설정 포함). 앱을 재설치하거나 이 조직의 앱 데이터를 삭제해야만 다시 활성화할 수 있습니다.';

  @override
  String get hideTestDataWarning =>
      '이미 로드된 데모 데이터는 설정에서 제거할 때까지 데이터베이스에 남아 있습니다.';

  @override
  String get okHideTestData => '확인, 테스트 데이터 숨기기';

  @override
  String get testDataHiddenForOrg => '이 조직의 테스트 데이터가 숨겨졌습니다';

  @override
  String get hideTestDataTooltip => '이 조직의 테스트 데이터 숨기기';

  @override
  String get partyRolesTitle => '거래처 역할';

  @override
  String get partyRolesMoreSubtitle => '고객, 공급업체, 둘 다 및 더 많이';

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
  String get partyRoleCustomer => '고객';

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
  String get searchRoles => '역할 검색';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '역할 $count개',
      one: '역할 1개',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => '아직 역할이 없습니다';

  @override
  String get noRolesYetHint => '연락처에 고객, 공급업체, 둘 다 또는 사용자 지정 역할을 추가하세요.';

  @override
  String get addRole => '역할 추가';

  @override
  String get deleteRoleTitle => '역할 삭제';

  @override
  String deleteRoleConfirm(String name) {
    return '\"$name\"을(를) 삭제하시겠습니까? 되돌릴 수 없습니다.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '거래처 $partyCount개',
      one: '거래처 1개',
    );
    return '\"$name\"은(는) $_temp0에서 사용 중입니다. 해당 거래처를 다른 역할로 이전하거나 강제 삭제하여 잃어버리세요.';
  }

  @override
  String get transferParties => '거래처 이전';

  @override
  String get hardDeleteLoseParties => '강제 삭제 (거래처 손실)';

  @override
  String get hardDeleteRoleTitle => '강제 삭제하시겠습니까?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '거래처 $partyCount개',
      one: '거래처 1개',
    );
    return '이렇게 하면 \"$name\"과(와) 이에 할당된 모든 $_temp0가 영구적으로 삭제됩니다. 거래처 데이터는 복구할 수 없습니다.\n\n청구서나 결제에 연결된 거래처는 삭제되지 않을 수 있습니다 — 대신 이전을 사용하세요.';
  }

  @override
  String get deleteRoleAndParties => '역할 및 거래처 삭제';

  @override
  String get addAnotherRoleBeforeDelete => '이 역할을 삭제하기 전에 다른 역할을 추가하세요.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '거래처 $partyCount개',
      one: '거래처 1개',
    );
    return '$_temp0를 \"$fromRole\"에서 이동:';
  }

  @override
  String get transferAndDeleteRole => '이전 후 역할 삭제';

  @override
  String get builtInRole => '기본 제공';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '거래처 $count개',
      one: '거래처 1개',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => '아직 거래처가 없습니다';

  @override
  String get newRole => '새 역할';

  @override
  String get editRole => '역할 편집';

  @override
  String get defaultRolesCannotEdit => '기본 역할은 이름을 변경하거나 삭제할 수 없습니다.';

  @override
  String get roleNameLabel => '역할 이름 *';

  @override
  String get roleNameHint => '예: 고객';

  @override
  String get roleDescriptionLabel => '설명';

  @override
  String get roleDescriptionHint => '팀을 위한 짧은 메모';

  @override
  String get roleSortOrderLabel => '정렬 순서';

  @override
  String get roleSortOrderHint => '낮은 값이 목록에서 먼저 표시됩니다';

  @override
  String get roleCreated => '역할이 생성되었습니다';

  @override
  String get roleUpdated => '역할이 업데이트되었습니다';

  @override
  String get roleDeleted => '역할이 삭제되었습니다';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '거래처 $count개',
      one: '거래처 1개',
    );
    return '역할이 삭제되었습니다. $_temp0가 $targetRole(으)로 이동되었습니다.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '거래처 $count개',
      one: '거래처 1개',
    );
    return '역할과 $_temp0가 삭제되었습니다.';
  }

  @override
  String get privacyPolicyTitle => '개인정보 처리방침';

  @override
  String get termsAndConditions => '이용약관';

  @override
  String get logoutConfirmTitle => '로그아웃';

  @override
  String get logoutConfirmMessage => '계정에서 로그아웃하시겠습니까?';

  @override
  String get faqTapToExpand => '질문을 탭하여 펼치세요.';

  @override
  String get faqSectionGettingStarted => '시작하기';

  @override
  String get faqSectionLogin => '로그인';

  @override
  String get faqSectionNavigation => '내비게이션';

  @override
  String get faqSectionInvoices => '청구서';

  @override
  String get faqSectionPayments => '결제';

  @override
  String get faqSectionItemsStock => '항목 & 재고';

  @override
  String get faqSectionProfileEmployees => '프로필 & 직원';

  @override
  String get faqSectionDashboardReports => '대시보드 & 보고서';

  @override
  String get faqSectionSyncTroubleshooting => '동기화 & 문제 해결';

  @override
  String get faqNeedInternetQuestion => '인터넷이 필요한가요?';

  @override
  String get faqNeedInternetAnswer =>
      '첫 번째 로컬 설정 후 인터넷 없이 청구서, 항목 및 결제를 기록할 수 있습니다. 데이터는 기기에 저장됩니다. 서버와의 동기화는 선택 사항입니다.';

  @override
  String get faqFirstInstallQuestion => '첫 설치 시 무엇이 일어나나요?';

  @override
  String get faqFirstInstallAnswer =>
      '짧은 안내를 볼 수 있으며, 그 다음 로컬 설정 (조직, 회사, 로그인 이메일 및 비밀번호, 통화, 회계연도)을 합니다. 그 후 생성한 이메일과 비밀번호로 로그인하세요.';

  @override
  String get faqSignInCredentialsQuestion => '로그인에 무엇을 사용하나요?';

  @override
  String get faqSignInCredentialsAnswer =>
      '설정의 이메일 주소와 비밀번호입니다. 앱은 더 보기에서 로그아웃할 때까지 로그인 상태를 유지합니다.';

  @override
  String get faqLoggedOutQuestion => '왜 로그아웃되었나요?';

  @override
  String get faqLoggedOutAnswer =>
      '로그아웃을 선택하거나, 앱 데이터를 삭제하거나, 세션이 만료되었습니다. 동일한 자격 증명으로 다시 로그인하세요.';

  @override
  String get faqBottomTabsQuestion => '하단 탭은 무엇을 하나요?';

  @override
  String get faqBottomTabsAnswer =>
      '홈 — 대시보드 및 개요.\n판매 — 날짜별 판매 청구서.\n지출 — 구매 / 지출 청구서.\n중앙 버튼 — 거래처 (고객, 공급업체).\n더 보기 — 프로필, 보고서, 동기화, 도움말, 로그아웃.';

  @override
  String get faqCreateInvoiceQuestion => '판매 또는 구매 청구서를 어떻게 만드나요?';

  @override
  String get faqCreateInvoiceAnswer =>
      '판매 또는 지출을 열고, 달력에서 날짜를 선택하고, + 버튼을 탭하고, 항목과 금액을 추가하고, 필요한 경우 거래처를 선택한 다음 저장하거나 제출하세요.';

  @override
  String get faqInvoiceDetailsQuestion => '청구서 전체 내역을 어떻게 보나요?';

  @override
  String get faqInvoiceDetailsAnswer =>
      '목록에서 청구서를 탭하세요. 거래 세부 정보에 항목, 합계, 할인 및 결제가 표시됩니다. 거기서 인쇄, 공유, 복제 또는 결제할 수 있습니다.';

  @override
  String get faqZeroRateQuestion => '세부 정보에서 요금 또는 금액이 0으로 표시됨';

  @override
  String get faqZeroRateAnswer =>
      '이는 일반적으로 이전 저장에서 항목 또는 결제 데이터가 누락되었음을 의미합니다. 앱을 업데이트하고 필요한 경우 다시 생성하거나 정산하세요.';

  @override
  String get faqPartialPaymentQuestion => '부분 결제를 어떻게 기록하나요?';

  @override
  String get faqPartialPaymentAnswer =>
      '청구서 열기 → 거래 세부 정보 → 결제하기. 금액, 방법 및 날짜를 입력한 다음 정산 처리하세요.';

  @override
  String get faqMultiplePaymentQuestion => '다중 결제는 어떻게 작동하나요?';

  @override
  String get faqMultiplePaymentAnswer =>
      '다중 결제를 켜고, 편집을 탭하고, 합계를 현금, 카드, QR 등으로 분할하세요. 각 방법은 별도로 기록됩니다.';

  @override
  String get faqSplitPaymentSavedQuestion => '분할에서 하나의 결제만 저장됨';

  @override
  String get faqSplitPaymentSavedAnswer =>
      '최신 앱 버전으로 업데이트하세요. 이전 버전은 때때로 첫 번째 분할 항목만 저장했습니다. 미수금 잔액이 여전히 잘못된 경우 다시 정산하세요.';

  @override
  String get faqAddItemQuestion => '항목을 어떻게 추가하나요?';

  @override
  String get faqAddItemAnswer =>
      '판매 흐름 또는 빠른 추가에서 항목 추가를 사용하세요. 이름, 요금, 단위, 목적 및 선택적 사진 (JPEG/PNG/GIF/WebP, 최대 5MB)을 입력한 다음 항목 만들기를 누르세요.';

  @override
  String get faqCustomUnitQuestion => '사용자 정의 단위를 어떻게 추가하나요?';

  @override
  String get faqCustomUnitAnswer =>
      '항목 양식에서 단위를 탭 → 목록 하단에서 새 단위 만들기, 이름 (예: 리터, 상자)을 입력하고 만들기를 누르세요.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion => '이름을 변경했지만 프로필에 이전 이름이 표시됨';

  @override
  String get faqProfileNameAnswer =>
      '직원 기록을 편집하고 (로그인과 동일한 이메일) 저장하세요. 더 보기 탭과 대시보드가 업데이트되어야 합니다.';

  @override
  String get faqRevenueDetailsQuestion => '수익 세부 정보란 무엇인가요?';

  @override
  String get faqRevenueDetailsAnswer =>
      '일별 추세 차트, 순이익, 미수금 및 일별 판매 대 구매 분석이 있는 월별 보기입니다. 달력이나 월 칩으로 월을 변경하세요.';

  @override
  String get faqOtherReportsQuestion => '다른 보고서는 어디에 있나요?';

  @override
  String get faqOtherReportsAnswer =>
      '더 보기를 열고 역할에 액세스 권한이 있는 경우 보고서 (분석, 손익, 명세서 등) 아래를 확인하세요.';

  @override
  String get faqWhenSyncQuestion => '언제 동기화해야 하나요?';

  @override
  String get faqWhenSyncAnswer =>
      '관리자가 요청할 때와 안정적인 연결이 있을 때만. 동기화는 기기와 서버 간에 데이터를 전송하거나 수신합니다.';

  @override
  String get faqFabPositionQuestion => '+ 버튼이 판매 / 지출에서 너무 높게 보임';

  @override
  String get faqFabPositionAnswer =>
      '하단 탐색 바 위에 있습니다. 버튼이 기기의 콘텐츠와 겹치면 목록을 스크롤하거나 앱을 업데이트하세요.';

  @override
  String get faqHowLogoutQuestion => '어떻게 로그아웃하나요?';

  @override
  String get faqHowLogoutAnswer => '더 보기 → 설정 목록 하단의 로그아웃.';

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
  String get statisticsQuickOperationsSeeAll => '모두 보기';

  @override
  String get statisticsQuickOperationInvoice => '청구서';

  @override
  String get statisticsQuickOperationReports => '보고서';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => '현금 흐름';

  @override
  String get statisticsCashflowLast7Days => '현금 흐름 (최근 7일)';

  @override
  String get statisticsCashflowLast12Months => '현금 흐름 (최근 12개월)';

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
  String get profitAndLoss => '손익';

  @override
  String get statementReport => '명세서';

  @override
  String get analytics => '분석';

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
  String get partyPickerSubtitle => '이 판매는 누구를 위한 것인가요?';

  @override
  String partyPickerSearchHint(String role) {
    return '$role 검색…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return '새 $role 추가';
  }

  @override
  String get partyPickerSettled => '정산 완료';

  @override
  String get partyPickerSelectedLabel => '선택됨';

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
  String get itemSelectCategoryRequired => '카테고리를 선택하세요';

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
  String get closeSummaryTitle => '마감 요약';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint => '날짜를 선택하고 새로고침을 눌러 데이터를 불러오세요';

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
  String get closeTotalSales => '총 매출';

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
  String get closePayCashGetQr => '현금 결제 → QR 수령';

  @override
  String get closePayQrGetCash => 'QR 결제 → 현금 수령';

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
  String get closeExportData => '데이터 내보내기';

  @override
  String get closeExportComingSoon => '내보내기 기능이 여기에 구현됩니다';

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
  String get googleDriveBackupSectionTitle => '백업 및 동기화';

  @override
  String get googleDriveBackupTitle => 'Google Drive 백업';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Google Drive에 조직 데이터를 안전하게 백업하려면 로그인하세요.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return '$email(으)로 로그인';
  }

  @override
  String get googleDriveSignIn => 'Google로 로그인';

  @override
  String get googleDriveSignOut => '로그아웃';

  @override
  String get googleDriveBackupNow => '지금 백업';

  @override
  String get googleDriveSignInSuccess => 'Google Drive에 로그인됨';

  @override
  String get googleDriveSignOutSuccess => 'Google Drive에서 로그아웃됨';

  @override
  String get googleDriveSignInCancelled => 'Google 로그인이 취소됨';

  @override
  String get googleDriveBackupStarting => '백업 준비 중…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return '백업 업로드됨 ($tableCount개 테이블, $recordCount개 레코드)';
  }

  @override
  String get googleDriveBackupPluginError =>
      '백업하려면 앱을 완전히 재시작해야 합니다. 앱을 종료하고 다시 실행한 후 재시도하세요.';

  @override
  String googleDriveBackupFailed(String error) {
    return '백업 실패: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return '마지막 백업: $date';
  }

  @override
  String get backupSyncPageTitle => '백업 및 동기화';

  @override
  String get backupSyncGoogleAccount => 'Google 계정';

  @override
  String get backupSyncSignedInAs => '로그인 계정';

  @override
  String get backupSyncSignInHint => 'Google로 로그인하여 조직 데이터를 백업하세요.';

  @override
  String get backupSyncLastSyncTitle => '마지막 동기화';

  @override
  String get backupSyncLastSyncDate => '날짜 및 시간';

  @override
  String get backupSyncNeverSynced => '아직 업로드된 백업이 없습니다.';

  @override
  String get backupSyncOrganization => '조직';

  @override
  String get backupSyncTables => '백업된 테이블';

  @override
  String get backupSyncRecords => '백업된 레코드';

  @override
  String get backupSyncStatus => '상태';

  @override
  String get backupSyncStatusSuccess => '완료';

  @override
  String get backupSyncActiveOrganization => '현재 조직';

  @override
  String get backupSyncActiveOrganizationHint =>
      '백업은 현재 사용 중인 조직의 데이터를 업로드합니다.';

  @override
  String get backupSyncUnknownOrganization => '현재 조직';

  @override
  String get backupSyncInProgress => '동기화 진행 중';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return '단계: $step';
  }

  @override
  String get backupSyncStepExport => '로컬 데이터 내보내는 중';

  @override
  String backupSyncStepUploadTable(String table) {
    return '$table 업로드 중';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return '$file 업로드 중';
  }

  @override
  String backupSyncLastError(String error) {
    return '마지막 오류: $error';
  }

  @override
  String get backupSyncSignOutConfirm => '이 기기에서 Google Drive 로그아웃하시겠습니까?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Google Drive에 백업';

  @override
  String get moreBackupSyncTileSignedInNoSync => '로그인됨 · 아직 백업 없음';

  @override
  String get backupSyncConnected => '연결됨';

  @override
  String get backupSyncCompletedHint => '데이터가 Google Drive에 안전하게 백업되었습니다.';

  @override
  String get backupSyncPhaseExport => '내보내기';

  @override
  String get backupSyncPhaseUpload => '업로드';

  @override
  String get backupAutoSettingsTitle => 'Google Drive 설정';

  @override
  String get backupAutoBackupTitle => '자동 백업';

  @override
  String get backupAutoBackupHint => '기한이 되면 앱 시작 시 자동 백업';

  @override
  String get backupWifiOnlyTitle => 'Wi‑Fi에서만 백업';

  @override
  String get backupWifiOnlyHint => '자동 백업은 Wi‑Fi를 기다립니다';

  @override
  String get backupWifiOnlyContinue => '모바일 데이터 사용';

  @override
  String get backupAutoFrequencyTitle => '백업 빈도';

  @override
  String get backupAutoFrequencyOff => '끔';

  @override
  String get backupAutoFrequencyDaily => '매일';

  @override
  String get backupAutoFrequencyWeekly => '매주';

  @override
  String get backupAutoFrequencyMonthly => '매월';

  @override
  String get backupAutoSyncDirectionTitle => '자동 동기화';

  @override
  String get backupAutoDirectionUpload => '클라우드에 업로드';

  @override
  String get backupAutoDirectionDownload => '클라우드에서 다운로드';

  @override
  String get backupAutoDirectionBoth => '업로드 및 다운로드';

  @override
  String backupAutoLastUploaded(String detail) {
    return '마지막 자동 백업: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return '마지막 자동 복원: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return '마지막 자동 동기화 실패: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return '마지막 자동 동기화 건너뜀: $detail';
  }

  @override
  String get restoreAction => '복원';

  @override
  String get restoreFromGoogleDrive => 'Google Drive에서 복원';

  @override
  String get restoreFromGoogleDriveHint => '로그인하고 백업을 선택하여 이 기기에서 조직을 복원하세요.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '\"$name\"을(를) 복원하시겠습니까? 해당 조직의 로컬 데이터가 대체됩니다.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name 복원됨. 이제 로그인할 수 있습니다.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return '복원 실패: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty => 'Google Drive에서 백업을 찾을 수 없습니다.';

  @override
  String get restoreFromGoogleDriveStarting => '복원 시작 중…';

  @override
  String get restoreStepDownload => '백업 다운로드 중';

  @override
  String get restoreStepCreateDatabase => '데이터베이스 생성 중';

  @override
  String get restoreStepImport => '데이터 가져오는 중';

  @override
  String get restoreStepFinalize => '복원 완료 중';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return '마지막 동기화: $date';
  }

  @override
  String get security => '보안';

  @override
  String get appLockTitle => '앱 잠금';

  @override
  String get appLockSubtitle => '앱을 다시 열 때 PIN 또는 생체 인증 필요';

  @override
  String get appPin => '앱 PIN';

  @override
  String appPinSubtitle(int length) {
    return '$length자리 PIN으로 빠른 잠금 해제';
  }

  @override
  String get useBiometricUnlock => 'Face ID / 생체 인증 사용';

  @override
  String get useBiometricUnlockSubtitle => 'PIN 설정 후 지문 또는 Face ID로 잠금 해제';

  @override
  String get changeAppPin => 'PIN 변경';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'PIN 설정';

  @override
  String get confirmAppPin => 'PIN 확인';

  @override
  String get enterAppPin => 'PIN 입력';

  @override
  String get enterPasscode => '암호 입력';

  @override
  String tapDigitsToUnlock(int length) {
    return '잠금 해제하려면 $length자리를 탭하세요.';
  }

  @override
  String createPasscodeHint(int length) {
    return '이 조직용 $length자리 암호 선택';
  }

  @override
  String get confirmPasscodeHint => '확인을 위해 암호를 다시 입력';

  @override
  String createAppPinHint(int length) {
    return '이 조직용 $length자리 PIN 선택';
  }

  @override
  String get confirmAppPinHint => '확인을 위해 PIN을 다시 입력';

  @override
  String get appPinMismatch => 'PIN이 일치하지 않습니다. 다시 시도하세요.';

  @override
  String get appPinIncorrect => 'PIN이 올바르지 않습니다. 다시 시도하세요.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN이 올바르지 않습니다. $remaining번 더 시도할 수 있습니다.';
  }

  @override
  String get appPinLockoutMessage =>
      'PIN 입력 횟수를 초과했습니다. 이메일과 비밀번호로 로그인하여 PIN을 재설정하세요.';

  @override
  String get appPinSetSuccess => '이 조직의 PIN이 저장되었습니다';

  @override
  String get appPinRemoved => '앱 PIN이 제거되었습니다';

  @override
  String get appLockSettingsSaved => '앱 잠금 설정이 저장되었습니다';

  @override
  String get biometricUnlockReason => 'BizTrack 잠금 해제';

  @override
  String get biometricNotAvailable => '이 기기에서 생체 인증을 사용할 수 없습니다';

  @override
  String get biometricRequiresPin => '생체 인증을 활성화하기 전에 앱 PIN을 설정하세요';

  @override
  String get disableAppPinTitle => '앱 PIN을 제거하시겠습니까?';

  @override
  String get disableAppPinMessage => '이 조직의 Face ID / 생체 인증 잠금 해제도 꺼집니다.';

  @override
  String get verifyPinToRemoveTitle => 'PIN 입력';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return '앱 잠금을 제거하려면 $length자리 PIN 확인';
  }

  @override
  String get unlockApp => '앱 잠금 해제';

  @override
  String get usePinInstead => '대신 PIN 사용';

  @override
  String get useBiometricInstead => '생체 인증 사용';

  @override
  String get signInWithFaceId => 'Face ID로 로그인';

  @override
  String get signInWithFingerprint => '지문으로 로그인';

  @override
  String get signInWithBiometric => '생체 인증으로 로그인';

  @override
  String get signInWithPin => 'PIN으로 로그인';

  @override
  String get setUpQuickUnlock => 'PIN 빠른 로그인 설정';

  @override
  String get setUpFaceIdOrPin => 'Face ID 또는 PIN 설정';

  @override
  String get setUpFingerprintOrPin => '지문 또는 PIN 설정';

  @override
  String get setUpQuickUnlockSubtitle => '이 조직에 생체 인증 또는 PIN 사용';

  @override
  String quickUnlockAsUser(String email) {
    return '$email(으)로 빠른 로그인';
  }

  @override
  String get orContinueWithPassword => '또는 비밀번호로 로그인';

  @override
  String get setUpQuickUnlockAfterLoginTitle => '빠른 로그인을 활성화하시겠습니까?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      '다음에 더 빠르게 로그인하려면 Face ID, 지문 또는 PIN을 설정하세요. 나중에 설정에서 변경할 수 있습니다.';

  @override
  String get notNow => '나중에';

  @override
  String get setUpNow => '지금 설정';

  @override
  String get enableFaceIdTitle => 'Face ID를 활성화하시겠습니까?';

  @override
  String get enableFingerprintTitle => '지문을 활성화하시겠습니까?';

  @override
  String get enableBiometricTitle => '생체 인증을 활성화하시겠습니까?';

  @override
  String get enableBiometricAfterPinMessage =>
      'PIN과 함께 기기 생체 인증을 사용하여 더 빠르게 로그인.';

  @override
  String get useFaceIdUnlock => 'Face ID 사용';

  @override
  String get useFingerprintUnlock => '지문 사용';

  @override
  String get ok => '확인';

  @override
  String get reportPeriodYear => '년';

  @override
  String get reportPeriodMonth => '월';

  @override
  String get reportPeriodRange => '범위';

  @override
  String get reportPeriodDay => '일';

  @override
  String get reportPeriodFrom => '부터';

  @override
  String get reportPeriodTo => '까지';

  @override
  String get reportPeriod => '기간';

  @override
  String get reportAllPurchases => '전체 구매';

  @override
  String get reportBeforeTax => '세전';

  @override
  String get reportRevenueRetained => '유보 수익';

  @override
  String get reportHideDetails => '세부 정보 숨기기';

  @override
  String get reportShowDetails => '세부 정보 표시';

  @override
  String get reportSalesRevenue => '매출 수익';

  @override
  String get reportDiscountsGiven => '제공된 할인';

  @override
  String get reportNetRevenue => '순수익';

  @override
  String get reportOperatingExpenses => '영업비용';

  @override
  String get reportTotalExpenses => '총 비용';

  @override
  String get reportGrossProfit => '매출총이익';

  @override
  String get reportGrossProfitChart => '매출총이익';

  @override
  String get reportOperatingPlDisclaimer =>
      '세금, 감가상각, 급여 부채 미반영 — 영업 수준 손익 추정치.';

  @override
  String get reportContraLabel => '상대 계정';

  @override
  String get reportNoDataForPeriod => '선택한 기간에 데이터가 없습니다';

  @override
  String get reportRevenueVsExpenses => '수익 vs 비용';

  @override
  String get reportExpenseBreakdown => '비용 내역';

  @override
  String get reportExpenseFallback => '비용';

  @override
  String get reportGrossMarginPercent => '매출총이익률 %';

  @override
  String get reportRoomVsFnB => '객실 vs F&B';

  @override
  String get reportSegmentRoom => '객실';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => '주요 지표';

  @override
  String get reportIncomeStatement => '손익계산서';

  @override
  String get reportChartsSection => '차트';

  @override
  String get reportSegmentSummary => '세그먼트 요약';

  @override
  String get reportFailedToLoad => '보고서를 불러오지 못했습니다';

  @override
  String get reportOverview => '개요';

  @override
  String get reportOverviewCash => '현금';

  @override
  String get reportOverviewBank => '은행';

  @override
  String get reportMonthlyOpeningBalance => '월별 기초 잔액';

  @override
  String get reportOpeningBalanceHint => '매월 초 현금 보유액';

  @override
  String get reportCashInOut => '현금 유입 / 유출';

  @override
  String get reportCashIn => '현금 유입';

  @override
  String get reportCashOut => '현금 유출';

  @override
  String get reportBankReceiptsPayments => '은행 입금 / 출금';

  @override
  String get reportReceipts => '입금';

  @override
  String get reportPayments => '결제';

  @override
  String get reportDailyCashVsQr => '일일 현금 vs QR';

  @override
  String get reportSummariesSection => '요약';

  @override
  String get reportCashSummary => '현금 요약';

  @override
  String get reportBankSummary => '은행 요약';

  @override
  String get reportDailySummary => '일일 요약';

  @override
  String get reportTabPurchase => '구매';

  @override
  String get reportTabSales => '매출';

  @override
  String get reportTabDashboard => '대시보드';

  @override
  String get reportSingleDayTrend => '단일 일 — 일별 추세';

  @override
  String get reportFullYearTrend => '연간 — 월별 추세 차트';

  @override
  String reportYearLabel(String year) {
    return '$year년';
  }

  @override
  String reportJanDec(String year) {
    return '1월 – 12월 $year';
  }

  @override
  String get reportTotalPurchases => '총 구매';

  @override
  String get reportTotalSales => '총 매출';

  @override
  String get reportTotalInvoices => '총 청구서';

  @override
  String get reportUnpaidBalance => '미지급 잔액';

  @override
  String get reportAvgPerInvoice => '청구서당 평균';

  @override
  String get reportPerTransaction => '거래당';

  @override
  String reportMonthlySpend(String symbol) {
    return '월별 지출 ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return '월별 매출 ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => '월별 청구서 수';

  @override
  String reportTopItemsBySpend(String symbol) {
    return '지출 상위 항목 ($symbol)';
  }

  @override
  String get reportSpendByCategory => '카테고리별 지출';

  @override
  String get reportOtherCategory => '기타';

  @override
  String get reportSuppliers => '공급업체';

  @override
  String get reportTableSupplier => '공급업체';

  @override
  String get reportTableAmount => '금액';

  @override
  String get reportTableBills => '청구서';

  @override
  String get reportSalesTotal => '매출 합계';

  @override
  String get reportPurchaseTotal => '구매 합계';

  @override
  String get reportPositiveMargin => '플러스 마진';

  @override
  String get reportNegativeMargin => '마이너스 마진';

  @override
  String get reportGrossMargin => '매출총이익률';

  @override
  String get reportOfTotalSales => '총 매출 대비';

  @override
  String get reportFailedToLoadAnalytics => '분석을 불러오지 못했습니다';

  @override
  String get reportMarginKpi => '마진';

  @override
  String get reportExpensesKpi => '비용';

  @override
  String partyPickerNoResultsFor(String query) {
    return '\"$query\"에 대한 결과 없음';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return '$role 거래처를 찾을 수 없습니다';
  }

  @override
  String get partyPickerLoadParties => '거래처 불러오기';

  @override
  String get invoiceCashCustomer => '현금 고객';

  @override
  String get invoiceQuickAddItemsTitle => '빠른 항목 추가';

  @override
  String get invoiceQuickLoadingMenu => '메뉴 불러오는 중…';

  @override
  String get invoiceQuickInvoiceCreated => '청구서가 생성되었습니다';

  @override
  String get invoiceQuickAddAtLeastOneItem => '최소 한 개 항목을 추가하세요';

  @override
  String get invoiceQuickNoResults => '결과를 찾을 수 없습니다!';

  @override
  String get invoiceQuickNoItemsInCategory => '이 카테고리에 항목이 없습니다';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => '항목 추가';

  @override
  String get invoiceQuickLoadMore => '더 불러오기';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return '스크롤하여 더 불러오기 (페이지당 $count)';
  }

  @override
  String get invoiceQuickSupplierEmployee => '공급업체 / 직원';

  @override
  String get invoiceQuickEditItem => '항목 편집';

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
  String get closeSelectDateRange => '날짜 범위 선택';

  @override
  String get closeStartDate => '시작일';

  @override
  String get closeEndDate => '종료일';

  @override
  String get closeSelectBothDates => '시작일과 종료일을 모두 선택하세요';

  @override
  String get closeDeleteSummary => '요약 삭제';

  @override
  String get closeDeleteSummaryConfirm => '이 요약을 삭제하시겠습니까?';

  @override
  String get closeSelectDate => '날짜 선택';

  @override
  String get closeNoDataToExport => '내보낼 데이터가 없습니다';

  @override
  String get closeNoDataToShare => '공유할 데이터가 없습니다';

  @override
  String get closeNoDataToPrint => '인쇄할 데이터가 없습니다';

  @override
  String closePdfGenerateError(String error) {
    return 'PDF 생성 오류: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'PDF 공유 오류: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'PDF 인쇄 오류: $error';
  }

  @override
  String get closeExportPdf => 'PDF로 내보내기';

  @override
  String get closeSharePdf => 'PDF 공유';

  @override
  String get closePrint => '인쇄';

  @override
  String get closeExportOptions => '내보내기 옵션';

  @override
  String get closeExportPdfSubtitle => 'PDF 문서로 저장 또는 보기';

  @override
  String get closeSharePdfSubtitle => '앱 또는 이메일로 공유';

  @override
  String get closePrintSubtitle => '보고서 인쇄';

  @override
  String get closeDailyCashSummaryTitle => '일일 현금 요약';

  @override
  String get closeDailyCashSummaryReport => '일일 현금 요약 보고서';

  @override
  String closeGeneratedAt(String date) {
    return '생성일: $date';
  }

  @override
  String get closeTotalRecords => '총 기록 수';

  @override
  String get closeSummaryOverview => '요약 개요';

  @override
  String get closeAllRecords => '전체 기록';

  @override
  String closePeriodRange(String start, String end) {
    return '기간: $start ~ $end';
  }

  @override
  String get closeDetails => '세부 정보';

  @override
  String closePageN(int n) {
    return '$n페이지';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return '$total개 중 $shown개 표시';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return '불러옴: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => '객실 / 캐빈 / 직원';

  @override
  String reportPercentOfRevenue(String percent) {
    return '수익의 $percent%';
  }

  @override
  String get reportParties => '거래처';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — 일별 추세 차트';
  }

  @override
  String get invoiceQuickCart => '장바구니';

  @override
  String invoiceQuickCartWithCount(int count) {
    return '장바구니 ($count)';
  }

  @override
  String get invoiceQuickClearSearch => '검색 지우기';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => '요약 추가';

  @override
  String get closeSalesAmount => '매출 금액';

  @override
  String get closeClosingBalance => '마감 잔액';

  @override
  String get closeLostMoney => '분실 금액';

  @override
  String get closeDiscount => '할인';

  @override
  String get closeExpenses => '비용';

  @override
  String get closeUnpaid => '미납';

  @override
  String get closeTotalOpeningBalance => '총 기초 잔액';

  @override
  String get closeTotalSalesAmount => '총 매출 금액';

  @override
  String get closeTotalCashAmount => '총 현금 금액';

  @override
  String get closeTotalQrAmount => '총 QR 금액';

  @override
  String get closeTotalDiscount => '총 할인';

  @override
  String get closeTotalExpenses => '총 비용';

  @override
  String get closeTotalClosingBalance => '총 마감 잔액';

  @override
  String get closeTotalLostMoney => '총 분실 금액';

  @override
  String get closeTotalExtraAmount => '총 추가 금액';

  @override
  String get closeShowingCurrentMonth => '이번 달 데이터 표시';

  @override
  String get closeNoSummariesFound => '요약을 찾을 수 없습니다';

  @override
  String get closeNoSummariesAvailable => '사용 가능한 요약이 없습니다';

  @override
  String get closeTryAdjustingDateRange => '날짜 범위를 조정해 보세요';

  @override
  String get closeCreateFirstSummary => '시작하려면 첫 요약을 만드세요';

  @override
  String get closeClearFilter => '필터 지우기';

  @override
  String get closeFiltered => '필터됨';

  @override
  String closeFilteredWithRange(String range) {
    return '필터: $range';
  }

  @override
  String get closeSummarySingular => '요약';

  @override
  String get closeSummariesPlural => '요약';

  @override
  String get closeSummaryUpdatedSuccess => '요약이 업데이트되었습니다';

  @override
  String get closeSummaryDeletedSuccess => '요약이 삭제되었습니다';

  @override
  String premiumUnlockTitle(String appName) {
    return '$appName Premium 잠금 해제';
  }

  @override
  String get premiumTagline => '완전 오프라인 POS, 청구, 재고, 보고서 — 비즈니스를 위한 하나의 구독.';

  @override
  String get premiumFeatureUnlimitedInvoices => '무제한 청구서 및 영수증';

  @override
  String get premiumFeatureInventoryStock => '재고 및 스톡 추적';

  @override
  String get premiumFeatureReportsAnalytics => '매출 보고서 및 분석';

  @override
  String get premiumFeatureOfflineLocal => '오프라인 작동 — 데이터는 기기에 저장';

  @override
  String premiumContinueWith(String plan) {
    return '$plan(으)로 계속';
  }

  @override
  String get premiumRestorePurchases => '구매 복원';

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
      '결제는 Apple ID로 청구됩니다. 기간 종료 최소 24시간 전에 취소하지 않으면 구독이 자동 갱신됩니다.';

  @override
  String get premiumPurchaseRestored => '구매가 복원되었습니다.';

  @override
  String get premiumNoActiveSubscription => '활성 구독을 찾을 수 없습니다.';

  @override
  String get premiumPlanMonthly => '월간';

  @override
  String get premiumPlanMonthlySubtitle => '유연함 — 언제든 취소';

  @override
  String get premiumPlanYearly => '연간';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return '최고의 가치 — $percent% 절약';
  }

  @override
  String get premiumPlanLifetime => '평생';

  @override
  String get premiumPlanLifetimeSubtitle => '한 번 결제, 영구 보유';

  @override
  String get premiumPlanPopular => '인기';

  @override
  String get premiumOneTimePurchase => '일회성 구매';

  @override
  String get subscriptionSectionTitle => '구독';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Premium으로 업그레이드';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return '월간 $monthly · 연간 $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan $date까지 활성';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan 활성';
  }

  @override
  String get premiumRequired => 'Premium 필요';

  @override
  String get upgradeToPremiumContinue => '계속하려면 Premium으로 업그레이드하세요.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return '무료 플랜은 최대 $limit $label까지 허용됩니다. 무제한 액세스는 Premium으로 업그레이드하세요.';
  }

  @override
  String get freemiumPartyRoleRequired => '거래처 역할이 필요합니다.';

  @override
  String get freemiumLabelSalesInvoices => '매출 청구서';

  @override
  String get freemiumLabelPurchaseInvoices => '매입 청구서';

  @override
  String get freemiumLabelEmployees => '직원';

  @override
  String get freemiumLabelItems => '품목';

  @override
  String get freemiumLabelCategories => '카테고리';

  @override
  String get freemiumLabelPaymentMethods => '결제 수단';

  @override
  String get freemiumLabelCustomPartyRoles => '사용자 지정 거래처 역할';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return '$role용 거래처';
  }

  @override
  String get freemiumLabelOrganizations => '조직';

  @override
  String get freemiumPremiumReports => '보고서는 Premium에서 이용 가능합니다.';

  @override
  String get freemiumPremiumBackupSync => '백업 및 동기화에는 Premium이 필요합니다.';

  @override
  String get freemiumPremiumPayroll => '급여에는 Premium이 필요합니다.';

  @override
  String get freemiumPremiumAttendance => '근태에는 Premium이 필요합니다.';

  @override
  String get freemiumPremiumStock => '재고 관리에는 Premium이 필요합니다.';

  @override
  String get freemiumPremiumInvoiceExport => '다운로드 및 인쇄에는 Premium이 필요합니다.';

  @override
  String get shiftReminderOpeningTitle => '개점 알림';

  @override
  String get shiftReminderOpeningMessage => '오늘 금전 등록기를 열었습니까?';

  @override
  String get shiftReminderOpeningProceed => '예, 지금 열기';

  @override
  String get shiftReminderClosingTitle => '마감 알림';

  @override
  String get shiftReminderClosingMessage => '오늘 금전 등록기를 닫았습니까?';

  @override
  String get shiftReminderClosingProceed => '예, 지금 닫기';

  @override
  String get shiftReminderSkipToday => '오늘 건너뛰기';

  @override
  String get shiftReminderOpeningNotificationTitle => '개점 알림';

  @override
  String get shiftReminderOpeningNotificationBody =>
      '오늘 금전 등록기를 열었습니까? 아직 열어야 하면 여기를 탭하세요.';

  @override
  String get shiftReminderClosingNotificationTitle => '마감 알림';

  @override
  String get shiftReminderClosingNotificationBody =>
      '오늘 금전 등록기를 닫았습니까? 아직 닫아야 하면 여기를 탭하세요.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business가 고객에게 QR로 지불하고, 고객은 현금을 제공합니다.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business가 고객에게 현금을 지불하고, 고객은 QR 결제를 제공합니다.';
  }

  @override
  String get closePaymentExchange => '결제 교환';

  @override
  String get closePayQrGetCashExchangeLabel => 'QR 결제 → 현금 수령 (교환)';

  @override
  String get closePayCashGetQrExchangeLabel => '현금 결제 → QR 수령 (교환)';

  @override
  String get closePayQrGetCashDetail => 'QR 지불 후 현금 수령';

  @override
  String get closePayCashGetQrDetail => '현금 지불 후 QR 수령';

  @override
  String get faqSectionPremium => 'Premium 및 결제';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium에 무엇이 포함되나요?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium은 무제한 청구서, 전체 보고서(P&L, 명세서, 분석), 백업 및 동기화, 급여, 근태, 재고 도구, 청구서 내보내기/인쇄, 추가 조직을 제공합니다. 무료 등급에서도 핵심 POS 기능을 합리적 한도 내에서 사용할 수 있습니다.';

  @override
  String get faqPremiumFreeTierQuestion => '무료 등급에 무엇이 포함되나요?';

  @override
  String get faqPremiumFreeTierAnswer =>
      '매출 및 매입 청구서 각 10건, 직원 4명, 품목 30개 등을 만들 수 있으며 한도에 도달하면 다른 제한도 표시됩니다. 개점, 마감, 계산기, 데이터 탐색은 무료입니다.';

  @override
  String get faqPremiumRestoreQuestion => '구매를 어떻게 복원하나요?';

  @override
  String get faqPremiumRestoreAnswer =>
      '더보기 → Premium으로 업그레이드(또는 페이월)를 열고 구매 복원을 탭하세요. 구독 시 사용한 Apple ID를 사용하세요.';

  @override
  String get faqPremiumCancelQuestion => '구독을 어떻게 취소하나요?';

  @override
  String get faqPremiumCancelAnswer =>
      'iPhone 설정 → Apple ID → 구독에서 관리 또는 취소. 유료 기간 종료까지 액세스가 유지됩니다.';

  @override
  String get faqDarkModeQuestion => '다크 모드를 어떻게 켜나요?';

  @override
  String get faqDarkModeAnswer =>
      '더보기 → 모양을 열고 다크 모드를 활성화하세요. 기기가 시스템 테마를 사용하면 앱이 자동으로 따릅니다.';

  @override
  String get faqOpeningClosingReminderQuestion => '개점 및 마감 알림이란?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName이 일일 금전 등록기 개폐를 알려줄 수 있습니다. 계속, 오늘 건너뛰기 또는 알림 닫기가 가능합니다.';
  }

  @override
  String get faqPartyRolesQuestion => '거래처 역할이란?';

  @override
  String get faqPartyRolesAnswer =>
      '거래처 역할은 고객, 공급업체, 객실, 직원 등 연락처를 분류합니다. 운영 → 거래처 역할에서 사용자 지정하고 팀용 간단 설명을 추가하세요.';

  @override
  String faqRateAppQuestion(String appName) {
    return '$appName을 어떻게 평가하나요?';
  }

  @override
  String get faqRateAppAnswer =>
      '더보기 → 평가하기를 열어 App Store에 리뷰를 남기세요. 피드백은 오프라인 청구 개선에 도움이 됩니다.';
}
