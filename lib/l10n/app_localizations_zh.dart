// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get noInternetConnection => '无网络连接。';

  @override
  String get formatException => '格式异常';

  @override
  String get rememberMe => '记住我';

  @override
  String get signIn => '登录';

  @override
  String get passwordHint => '请输入密码';

  @override
  String get forgetPassword => '忘记登录信息？';

  @override
  String get okay => '好的';

  @override
  String get success => '成功';

  @override
  String get hotel => '酒店';

  @override
  String get errorEncountered => '遇到错误';

  @override
  String get serverError => '服务器错误';

  @override
  String get requestFailed => '请求失败';

  @override
  String get connectionTimedOut => '连接超时';

  @override
  String get password => '密码';

  @override
  String get keepSignIn => '保持登录';

  @override
  String get enterPassword => '请输入密码';

  @override
  String get enterValidPassword => '请输入有效密码';

  @override
  String get skip => '跳过';

  @override
  String get pleaseWait => '请稍候 ....';

  @override
  String get enterValidUserName => '请输入有效的用户名。';

  @override
  String get userName => '用户名';

  @override
  String get or => '或';

  @override
  String get retry => '重试';

  @override
  String get error => '错误';

  @override
  String get supportMessage => '请联系管理员。';

  @override
  String get responseMessage404 => '404错误';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return '版本 $version';
  }

  @override
  String get cancel => '取消';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get close => '关闭';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get deleteOrganizationTitle => '删除组织？';

  @override
  String deleteOrganizationMessage(String name) {
    return '从此设备移除 $name。该组织的所有本地数据将被删除。';
  }

  @override
  String get deleteOrganizationWarning => '此操作无法撤销。';

  @override
  String get organizationDeleted => '组织已移除';

  @override
  String get confirm => '确认';

  @override
  String get done => '完成';

  @override
  String get next => '下一步';

  @override
  String get getStarted => '开始使用';

  @override
  String get walkthroughDashboardTitle => '一览整个业务';

  @override
  String get walkthroughDashboardDescription => '今日销售、收入和未结余额——打开应用即可一目了然。';

  @override
  String get walkthroughOfflineTitle => '无网络也能用';

  @override
  String get walkthroughOfflineDescription => '完全离线创建发票、记录支出和管理库存。上线后自动同步。';

  @override
  String get walkthroughBillingTitle => '数秒内开票和销售';

  @override
  String get walkthroughBillingDescription =>
      '销售和采购发票、带厨房小票的桌台订单和实时库存——尽在一个应用中。';

  @override
  String get walkthroughStaffTitle => '员工、工资与报表';

  @override
  String get walkthroughStaffDescription => '管理考勤和工资，导出损益表和工资单 PDF——无需额外工具。';

  @override
  String get walkthroughBackupTitle => '您的数据，始终安全';

  @override
  String get walkthroughBackupDescription =>
      '一键 Google Drive 备份，银行级安全——数据受保护且易于恢复。';

  @override
  String get walkthroughReadyTitle => '您准备好了就开始';

  @override
  String get walkthroughReadyDescription => '几分钟内完成组织设置，从今天开始更智能地经营。让我们开始吧。';

  @override
  String get back => '返回';

  @override
  String get submit => '提交';

  @override
  String get continueAction => '继续';

  @override
  String get createAction => '创建';

  @override
  String get connectOrganizationTitle => '连接您的组织';

  @override
  String get connectOrganizationSubtitle => '选择一个组织以登录。';

  @override
  String get selectOrganization => '组织';

  @override
  String get selectOrganizationHint => '点击组织以继续';

  @override
  String get noSavedOrganizationsYet => '暂无组织。请创建一个或使用下方的测试数据。';

  @override
  String get orgConnectOnceInfo => '这将应用程序与您的业务账户关联。每台设备只需设置一次。';

  @override
  String organizationCodeLabel(String code) {
    return '代码：$code';
  }

  @override
  String get tryAgain => '重试';

  @override
  String get warning => '警告';

  @override
  String get loading => '加载中…';

  @override
  String get comingSoon => '即将推出';

  @override
  String get required => '必填';

  @override
  String get search => '搜索';

  @override
  String get add => '添加';

  @override
  String get edit => '编辑';

  @override
  String get remove => '移除';

  @override
  String get view => '查看';

  @override
  String get export => '导出';

  @override
  String get exportAsPdf => '导出为 PDF';

  @override
  String get sharePdf => '分享 PDF';

  @override
  String get partyExportPdfTooltip => '导出PDF';

  @override
  String get import => '导入';

  @override
  String get refresh => '刷新';

  @override
  String get select => '选择';

  @override
  String get upload => '上传';

  @override
  String get download => '下载';

  @override
  String get share => '分享';

  @override
  String get filter => '筛选';

  @override
  String get sort => '排序';

  @override
  String get apply => '应用';

  @override
  String get reset => '重置';

  @override
  String get clear => '清除';

  @override
  String get all => '全部';

  @override
  String get none => '无';

  @override
  String get total => '合计';

  @override
  String get subtotal => '小计';

  @override
  String get grandTotal => '总计';

  @override
  String get amount => '金额';

  @override
  String get quantity => '数量';

  @override
  String get rate => '单价';

  @override
  String get discount => '折扣';

  @override
  String get paid => '已付';

  @override
  String get unpaid => '未付';

  @override
  String get credit => '信用';

  @override
  String get cash => '现金';

  @override
  String get date => '日期';

  @override
  String get time => '时间';

  @override
  String get name => '名称';

  @override
  String get email => '电子邮件';

  @override
  String get phone => '电话';

  @override
  String get address => '地址';

  @override
  String get notes => '备注';

  @override
  String get description => '描述';

  @override
  String get status => '状态';

  @override
  String get type => '类型';

  @override
  String get category => '类别';

  @override
  String get party => '往来方';

  @override
  String get item => '项目';

  @override
  String get payment => '付款';

  @override
  String get settlement => '结算';

  @override
  String get opening => '期初';

  @override
  String get closing => '期末';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => '支出';

  @override
  String get revenue => '收入';

  @override
  String get profit => '利润';

  @override
  String get loss => '亏损';

  @override
  String get sales => '销售';

  @override
  String get purchase => '采购';

  @override
  String get monthJan => '1月';

  @override
  String get monthFeb => '2月';

  @override
  String get monthMar => '3月';

  @override
  String get monthApr => '4月';

  @override
  String get monthMay => '5月';

  @override
  String get monthJun => '6月';

  @override
  String get monthJul => '7月';

  @override
  String get monthAug => '8月';

  @override
  String get monthSep => '9月';

  @override
  String get monthOct => '10月';

  @override
  String get monthNov => '11月';

  @override
  String get monthDec => '12月';

  @override
  String get more => '更多';

  @override
  String get profile => '个人资料';

  @override
  String get operations => '运营';

  @override
  String get operationManagement => '运营管理';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => '员工管理';

  @override
  String get employeeManagementSubtitle => '员工、工资和考勤';

  @override
  String get report => '报告';

  @override
  String get reportSubtitle => '损益、报表和分析';

  @override
  String get helpAndSupport => '帮助与支持';

  @override
  String get preferences => '偏好设置';

  @override
  String get dataAndBackup => '数据与备份';

  @override
  String get privacyAndPolicies => '隐私与政策';

  @override
  String get faq => '常见问题';

  @override
  String get contactSupport => '联系支持';

  @override
  String get rateUs => '给我们评分';

  @override
  String get rateUsSubtitle => '喜欢 BizTrack 吗？在 Google Play 留下评论';

  @override
  String get rateUsUnavailable => '无法打开商店。请稍后重试。';

  @override
  String get reportProblem => '报告问题';

  @override
  String get contactUs => '联系我们';

  @override
  String get contactUsSubtitle => '如需支持、反馈或咨询应用相关问题，请联系我们。';

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
  String get developerLabel => '开发者';

  @override
  String get emailCopiedToClipboard => '邮箱已复制到剪贴板';

  @override
  String get logout => '退出登录';

  @override
  String get signOut => '退出';

  @override
  String get settings => '设置';

  @override
  String get testData => '测试数据';

  @override
  String get loginWithTestData => '使用测试数据登录';

  @override
  String get loginWithTestDataSubtitle => '加载演示酒店数据并自动登录';

  @override
  String testDataLoginFailed(String error) {
    return '无法加载测试数据：$error';
  }

  @override
  String get preparingTestData => '正在准备演示数据…';

  @override
  String get regionAndCurrency => '地区与货币';

  @override
  String get reportingCurrency => '报告货币';

  @override
  String get selectCurrency => '选择货币';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · 示例 $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return '货币已设为 $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return '无法更新货币：$error';
  }

  @override
  String setupAppTitle(String appName) {
    return '设置 $appName';
  }

  @override
  String get setupSubtitle => '配置您的组织和账务 — 存储在此设备上以供离线使用。';

  @override
  String get setupOrganizationName => '组织名称';

  @override
  String get setupCompanyName => '公司名称';

  @override
  String get setupBusinessType => '业务类型';

  @override
  String get selectBusinessType => '选择业务类型';

  @override
  String get businessTypeHotel => '酒店';

  @override
  String get businessTypeHotelSubtitle => '客房、宾客和前台';

  @override
  String get businessTypeRestaurant => '餐厅';

  @override
  String get businessTypeRestaurantSubtitle => '堂食、厨房和餐桌订单';

  @override
  String get businessTypeHotelRestaurant => '酒店 & 餐厅';

  @override
  String get businessTypeHotelRestaurantSubtitle => '酒店房间和餐厅在一起';

  @override
  String get businessTypeRetail => '零售 / 商店';

  @override
  String get businessTypeRetailSubtitle => '产品、库存和结账';

  @override
  String get businessTypeCafe => '咖啡馆 / 烘焙店';

  @override
  String get businessTypeCafeSubtitle => '咖啡、糕点和小吃';

  @override
  String get businessTypeBar => '酒吧 / 酒馆';

  @override
  String get businessTypeBarSubtitle => '饮品菜单、标签和酒吧销售';

  @override
  String get businessTypeOther => '其他';

  @override
  String get businessTypeOtherSubtitle => '适合任何企业的自定义设置';

  @override
  String organizationBusinessTypeLabel(String type) {
    return '类型：$type';
  }

  @override
  String get organizationSettings => '组织';

  @override
  String get editOrganizationInfo => '组织信息';

  @override
  String get editOrganizationInfoSubtitle => '更新此业务在应用中的显示方式。组织代码不可更改。';

  @override
  String get organizationCode => '组织代码';

  @override
  String get organizationCodeReadOnly => '此代码在设置后固定。';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => '组织信息已保存';

  @override
  String get organizationInfoLoadFailed => '无法加载组织信息';

  @override
  String organizationInfoSaveFailed(String error) {
    return '无法保存组织信息：$error';
  }

  @override
  String get organizationTabGeneral => '常规';

  @override
  String get organizationTabRegional => '区域与财务';

  @override
  String get organizationRegionalSubtitle => '国家、报告货币和财年日期。';

  @override
  String get organizationTabAccounting => '会计';

  @override
  String get organizationAccountingSubtitle => '发票和金额显示设置。';

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
  String get displayPrecision => '显示精度';

  @override
  String get displayPrecisionRange => '输入 0 到 5 之间的数字';

  @override
  String get enableInvoiceReturns => '启用发票退货';

  @override
  String get enableInvoiceReturnsSubtitle => '允许从已付发票创建退货。';

  @override
  String get saveChanges => '保存更改';

  @override
  String get setupFullName => '全名';

  @override
  String get setupConfirmPassword => '确认密码';

  @override
  String get setupBankName => '银行名称';

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
  String get setupRegionStepTitle => '地区与货币';

  @override
  String get setupOrganizationStepTitle => '组织';

  @override
  String get setupOrganizationStepSubtitle => '您的业务在应用中的显示方式';

  @override
  String get setupAdminStepTitle => '管理员账户';

  @override
  String get setupAdminStepSubtitle => '此安装的主要用户';

  @override
  String get setupAccountingStepTitle => '账务';

  @override
  String get setupAccountingStepSubtitle => '银行、会计科目表和财年';

  @override
  String get setupCompleteSetup => '完成设置';

  @override
  String fieldRequired(String field) {
    return '$field 为必填项';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => '请输入有效的电子邮件地址';

  @override
  String passwordMinLength(int min) {
    return '密码至少需要 $min 个字符';
  }

  @override
  String get passwordsDoNotMatch => '密码不匹配';

  @override
  String get setupFixValidationErrors => '请修正以下错误后继续';

  @override
  String get setupCompleteSuccess => '设置成功完成';

  @override
  String get setupCompleteWithPdfSuccess => '设置完成。请将PDF保存在安全位置。';

  @override
  String setupPdfFailed(String error) {
    return '设置已完成，但无法保存PDF：$error';
  }

  @override
  String get setupFailed => '无法完成设置。请重试。';

  @override
  String setupFailedWithDetails(String error) {
    return '设置失败：$error';
  }

  @override
  String get regionAndCurrencySubtitle => '区域设置和报告货币。';

  @override
  String get country => '国家';

  @override
  String get currency => '货币';

  @override
  String get selectCountry => '选择国家';

  @override
  String get language => '语言';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get languageChangeLaterHint => '您可以稍后在设置中更改';

  @override
  String languageSelectionSubtitle(String appName) {
    return '选择您希望如何使用 $appName。您稍后可以在设置中更改。';
  }

  @override
  String get searchLanguages => '搜索语言';

  @override
  String get languageSuggestedBadge => '推荐';

  @override
  String continueInLanguage(String languageName) {
    return '继续使用 $languageName';
  }

  @override
  String get noLanguageMatches => '无匹配项';

  @override
  String noLanguageMatchesForQuery(String query) {
    return '没有与 \"$query\" 匹配的语言';
  }

  @override
  String get appearance => '外观';

  @override
  String get darkMode => '深色模式';

  @override
  String get darkModeSubtitle => '在整个应用中使用深色背景';

  @override
  String get darkModeSystemSubtitle => '跟随设备主题';

  @override
  String languageUpdated(String name) {
    return '语言已设为 $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return '无法更新语言：$error';
  }

  @override
  String welcomeToApp(String appName) {
    return '欢迎使用 $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return '请安装最新版本的 $appName 以继续使用。';
  }

  @override
  String generatedByApp(String appName) {
    return '由 $appName 生成';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName 是什么？';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName 帮助您管理销售和采购发票、往来方（客户和供应商）、库存、付款、员工及每日汇总 — 通过您的手机或平板电脑。';
  }

  @override
  String faqIntro(String appName) {
    return '关于 $appName 常见问题的解答。';
  }

  @override
  String get chooseFromGallery => '从相册选择';

  @override
  String get takePhoto => '拍照';

  @override
  String get photoLibrary => '照片库';

  @override
  String get addPhoto => '添加照片';

  @override
  String couldNotPickImage(String error) {
    return '无法选择图片：$error';
  }

  @override
  String get unpaidAmount => '未付金额';

  @override
  String get unpaidBalance => '未付';

  @override
  String unpaidColonAmount(String amount) {
    return '未付: $amount';
  }

  @override
  String get previousUnpaid => '未付';

  @override
  String get partyUnpaid => '未付';

  @override
  String get loadingUnpaid => '未付…';

  @override
  String get totalUnpaid => '未付';

  @override
  String get unpaidAmountNotYetCollected => '未付金额尚未收取。';

  @override
  String get partyUnpaidTabHint =>
      '打开员工，选择一个人，然后点击其个人资料中的往来方未付款。服务器需要员工 ID 进行此搜索。';

  @override
  String get partySettlementUsesUnpaidTotal => '往来方结算使用未付总额。';

  @override
  String get selectPartyWithUnpaidFirst => '请先输入结算金额（或选择有未付款的往来方）。';

  @override
  String get workspace => '工作区';

  @override
  String get change => '更改';

  @override
  String get addMoreOrganization => '添加更多 +';

  @override
  String get connectAnotherOrganization => '连接另一个组织';

  @override
  String get noSavedOrganizationsUseAddMore => '暂无保存的组织。使用添加更多 + 连接一个。';

  @override
  String get registerNewOrganizationTitleSignedIn => '注册新组织？';

  @override
  String get registerNewOrganizationTitle => '注册新组织？';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      '您将退出登录，设置向导将从头开始，以便您在此设备上注册新业务。\n\n您已保存的组织在设置后将保留在列表中。';

  @override
  String get registerNewOrganizationMessageLogin =>
      '设置向导将启动，以便您在此设备上注册新业务。完成设置以创建它；您保存的组织将保留在列表中。';

  @override
  String get startSetup => '开始设置';

  @override
  String get enterOrganizationCode => '请输入您的组织代码';

  @override
  String get organizationNotFoundCheckCode => '未找到组织。请检查代码后重试。';

  @override
  String get organizationNotFound => '未找到组织';

  @override
  String get couldNotVerifyOrganization => '无法验证组织';

  @override
  String noLocalDataCompleteSetup(String name) {
    return '$name 没有本地数据。请先完成此组织的设置。';
  }

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get signInToContinue => '登录以继续';

  @override
  String get enterEmail => '输入电子邮件';

  @override
  String get pleaseEnterEmail => '请输入您的电子邮件';

  @override
  String get pleaseEnterValidEmail => '请输入有效的电子邮件';

  @override
  String get enterEmailLocalPartOnly => '仅输入 @ 之前的部分';

  @override
  String get pleaseEnterPassword => '请输入您的密码';

  @override
  String get logIn => '登录';

  @override
  String get searchCountry => '搜索国家';

  @override
  String get searchCodeOrSymbol => '搜索代码或符号';

  @override
  String get saveLoginDetailsTitle => '保存登录详情？';

  @override
  String get saveLoginDetailsMessage =>
      '您即将完成此组织的设置。\n\n是否安全下载包含您的组织代码、组织名称、登录电子邮件和密码的 PDF？请存放在安全的地方 — 任何拥有此文件的人都可以登录。';

  @override
  String get downloadPdfAndContinue => '下载 PDF 并继续';

  @override
  String get continueWithoutPdf => '不下载 PDF 继续';

  @override
  String get legalDisplayNameHint => '法定 / 显示名称';

  @override
  String get chartOfAccounts => '会计科目表';

  @override
  String get fiscalYearStart => '财政年度开始';

  @override
  String get fiscalYearEnd => '财政年度结束';

  @override
  String get removeTestDataTitle => '删除测试数据？';

  @override
  String get removeTestDataMessageDemoOrg =>
      '所有演示销售、采购、联系人、往来方、库存项目、员工、酒类计算器产品和额外演示组织将被删除。\n\n您在演示组织上 — 此后将自动切换回您的第一个组织。';

  @override
  String get removeTestDataMessageNormal =>
      '所有演示销售、采购、联系人、往来方、库存项目、员工和 3 个额外演示组织将被删除。您的管理员帐户和实际设置数据保持不变。';

  @override
  String get removeTestDataWarning => '除非重新加载测试数据，否则无法撤销。';

  @override
  String get removeTestData => '删除测试数据';

  @override
  String get keepTestData => '保留测试数据';

  @override
  String get demoDataRemoved => '演示数据已删除';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return '测试数据已删除。已切换到 $name。';
  }

  @override
  String get testDataRemoved => '测试数据已删除';

  @override
  String couldNotRemoveTestData(String error) {
    return '无法删除测试数据：$error';
  }

  @override
  String get loadTestDataTitle => '加载测试数据？';

  @override
  String get loadTestDataMessage =>
      '这将添加最多 50 个演示联系人、50 个仅销售和 50 个仅采购库存项目，以及示例销售、采购、付款、库存、期末摘要、员工、薪资、过去 15 天的考勤和计算器的示例酒类产品。';

  @override
  String get loadTestData => '加载测试数据';

  @override
  String get testDataLoaded => '测试数据已加载';

  @override
  String couldNotLoadTestData(String error) {
    return '无法加载测试数据：$error';
  }

  @override
  String get demoTestData => '演示测试数据';

  @override
  String get importTestDataSubtitle => '导入所有功能的测试数据';

  @override
  String get hideTestDataTitle => '隐藏此组织的测试数据？';

  @override
  String get hideTestDataMessage =>
      '如果继续，测试数据部分将在此组织的所有地方隐藏（包括设置）。只能通过重新安装或清除此组织的应用数据来重新启用。';

  @override
  String get hideTestDataWarning => '已加载的演示数据将保留在数据库中，直到您从设置中删除它。';

  @override
  String get okHideTestData => '确定，隐藏测试数据';

  @override
  String get testDataHiddenForOrg => '此组织的测试数据已隐藏';

  @override
  String get hideTestDataTooltip => '隐藏此组织的测试数据';

  @override
  String get partyRolesTitle => '往来方角色';

  @override
  String get partyRolesMoreSubtitle => '客户、供应商、两者及更多';

  @override
  String get exploreCustomizeTitle => '定制功能';

  @override
  String get exploreCustomizeSubtitle => '在主屏幕上显示或隐藏快捷方式。仅列出您的组织可以访问的功能。';

  @override
  String get exploreVisibleOnDashboard => '在仪表板上可见';

  @override
  String get exploreHiddenOnDashboard => '在仪表板上隐藏';

  @override
  String get partiesTitle => '往来方';

  @override
  String get partySearchByName => '按名称搜索…';

  @override
  String get partySortBy => '排序：';

  @override
  String get partySortLatest => '最新';

  @override
  String get partySortAmountHighLow => '金额：从高到低';

  @override
  String get partySortAmountLowHigh => '金额：从低到高';

  @override
  String get partySortNameAZ => '名称：A 到 Z';

  @override
  String get partySortNameZA => '名称：Z 到 A';

  @override
  String get partyAddNew => '添加新往来方';

  @override
  String get partyEdit => '编辑往来方';

  @override
  String get partyUpdate => '更新往来方';

  @override
  String get partyNameLabel => '往来方名称*';

  @override
  String get partyNameHint => '输入往来方名称';

  @override
  String get partyNewNameLabel => '新往来方名称*';

  @override
  String get partyNewNameHint => '输入新往来方名称';

  @override
  String get partyRoleLabel => '往来方角色 *';

  @override
  String get partyTapToSelect => '点击选择';

  @override
  String get partySelectRoleValidation => '请选择角色';

  @override
  String get partyEnterNameValidation => '请输入往来方名称';

  @override
  String get partyBasicInfo => '基本信息';

  @override
  String get partyAdditionalInfo => '附加信息';

  @override
  String get partyEmail => '往来方邮箱';

  @override
  String get partyEmailHint => '输入邮箱地址';

  @override
  String get partyPhone => '电话号码';

  @override
  String get partyPhoneHint => '输入电话号码';

  @override
  String get partyAddress => '往来方地址';

  @override
  String get partyAddressHint => '输入地址';

  @override
  String get partyRoleCustomer => '客户';

  @override
  String get partyRoleSupplier => '供应商';

  @override
  String get partyRoleRoom => '房间';

  @override
  String get partyRoleCabin => '包间';

  @override
  String get partyRoleEmployee => '员工';

  @override
  String get partyRoleBoth => '两者';

  @override
  String get partyDefaultAccount => '默认账户';

  @override
  String get partyLoyaltyProgram => '忠诚度计划';

  @override
  String get partyLoyaltyPoints => '忠诚度积分';

  @override
  String get partySelectDefaultAccount => '选择默认账户';

  @override
  String get partySelectLoyaltyProgram => '选择忠诚度计划';

  @override
  String get partyCreateNewProgram => '创建新计划';

  @override
  String get partySelectPartyRole => '选择往来方角色';

  @override
  String get partyAccountDebtors => '应收';

  @override
  String get partyAccountCreditors => '应付';

  @override
  String get partyBothRoleHint => '“两者”表示该往来方仅出现在客户和供应商下，不会出现在房间、包间或员工下。';

  @override
  String get partyValidNumber => '请输入有效号码';

  @override
  String get partyValidAmount => '请输入有效金额';

  @override
  String get searchRoles => '搜索角色';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个角色',
      one: '1 个角色',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => '暂无角色';

  @override
  String get noRolesYetHint => '为联系人添加客户、供应商、两者或自定义角色。';

  @override
  String get addRole => '添加角色';

  @override
  String get deleteRoleTitle => '删除角色';

  @override
  String deleteRoleConfirm(String name) {
    return '删除“$name”？此操作无法撤销。';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount 个往来方',
      one: '1 个往来方',
    );
    return '“$name”被$_temp0使用。将这些往来方转移到另一个角色，或强制删除并丢失它们。';
  }

  @override
  String get transferParties => '转移往来方';

  @override
  String get hardDeleteLoseParties => '强制删除（丢失往来方）';

  @override
  String get hardDeleteRoleTitle => '强制删除？';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount 个往来方',
      one: '1 个往来方',
    );
    return '这将永久删除“$name”及其分配的所有$_temp0。往来方数据无法恢复。\n\n与发票或付款关联的往来方可能无法删除 — 请改用转移。';
  }

  @override
  String get deleteRoleAndParties => '删除角色和往来方';

  @override
  String get addAnotherRoleBeforeDelete => '删除此角色前请先添加另一个角色。';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount 个往来方',
      one: '1 个往来方',
    );
    return '将$_temp0从“$fromRole”移至：';
  }

  @override
  String get transferAndDeleteRole => '转移并删除角色';

  @override
  String get builtInRole => '内置';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个往来方',
      one: '1 个往来方',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => '暂无往来方';

  @override
  String get newRole => '新角色';

  @override
  String get editRole => '编辑角色';

  @override
  String get defaultRolesCannotEdit => '默认角色不能重命名或删除。';

  @override
  String get roleNameLabel => '角色名称 *';

  @override
  String get roleNameHint => '例：客户';

  @override
  String get roleDescriptionLabel => '描述';

  @override
  String get roleDescriptionHint => '给团队的简短备注';

  @override
  String get roleSortOrderLabel => '排序顺序';

  @override
  String get roleSortOrderHint => '较小的值在列表中排在前面';

  @override
  String get roleCreated => '角色已创建';

  @override
  String get roleUpdated => '角色已更新';

  @override
  String get roleDeleted => '角色已删除';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个往来方',
      one: '1 个往来方',
    );
    return '角色已删除。$_temp0已移至 $targetRole。';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个往来方',
      one: '1 个往来方',
    );
    return '角色和$_temp0已删除。';
  }

  @override
  String get privacyPolicyTitle => '隐私政策';

  @override
  String get termsAndConditions => '条款和条件';

  @override
  String get logoutConfirmTitle => '登出';

  @override
  String get logoutConfirmMessage => '确定要从您的帐户退出吗？';

  @override
  String get faqTapToExpand => '点击问题展开。';

  @override
  String get faqSectionGettingStarted => '入门';

  @override
  String get faqSectionLogin => '登录';

  @override
  String get faqSectionNavigation => '导航';

  @override
  String get faqSectionInvoices => '发票';

  @override
  String get faqSectionPayments => '付款';

  @override
  String get faqSectionItemsStock => '项目和库存';

  @override
  String get faqSectionProfileEmployees => '个人资料和员工';

  @override
  String get faqSectionDashboardReports => '仪表板和报告';

  @override
  String get faqSectionSyncTroubleshooting => '同步和故障排除';

  @override
  String get faqNeedInternetQuestion => '我需要互联网吗？';

  @override
  String get faqNeedInternetAnswer =>
      '首次本地设置后，您可以在没有互联网的情况下记录发票、项目和付款。数据保留在您的设备上。与服务器同步是可选的。';

  @override
  String get faqFirstInstallQuestion => '首次安装时会发生什么？';

  @override
  String get faqFirstInstallAnswer =>
      '您可能会看到简短的引导，然后是本地设置（组织、公司、登录电子邮件和密码、货币、财政年度）。之后，使用您创建的电子邮件和密码登录。';

  @override
  String get faqSignInCredentialsQuestion => '我用什么登录？';

  @override
  String get faqSignInCredentialsAnswer =>
      '设置中的电子邮件地址和密码。应用将保持您的登录状态，直到您从更多退出。';

  @override
  String get faqLoggedOutQuestion => '为什么我被退出了？';

  @override
  String get faqLoggedOutAnswer => '您选择了退出，清除了应用数据，或会话已过期。使用相同的凭据重新登录。';

  @override
  String get faqBottomTabsQuestion => '底部标签页有什么功能？';

  @override
  String get faqBottomTabsAnswer =>
      '主页 — 仪表板和概览。\n销售 — 按日期的销售发票。\n支出 — 采购 / 支出发票。\n中央按钮 — 往来方（客户、供应商）。\n更多 — 个人资料、报告、同步、帮助、退出。';

  @override
  String get faqCreateInvoiceQuestion => '如何创建销售或采购发票？';

  @override
  String get faqCreateInvoiceAnswer =>
      '打开销售或支出，在日历上选择日期，点击 + 按钮，添加项目和金额，如需要选择往来方，然后保存或提交。';

  @override
  String get faqInvoiceDetailsQuestion => '如何查看完整的发票详情？';

  @override
  String get faqInvoiceDetailsAnswer =>
      '点击列表中的任意发票。交易详情显示行项目、总计、折扣和付款。您可以从那里打印、共享、复制或付款。';

  @override
  String get faqZeroRateQuestion => '详情中费率或金额显示为零';

  @override
  String get faqZeroRateAnswer => '这通常意味着旧保存中行或付款数据丢失。更新应用并根据需要重新创建或结算。';

  @override
  String get faqPartialPaymentQuestion => '如何记录部分付款？';

  @override
  String get faqPartialPaymentAnswer => '打开发票 → 交易详情 → 进行付款。输入金额、方式和日期，然后处理结算。';

  @override
  String get faqMultiplePaymentQuestion => '多重付款如何运作？';

  @override
  String get faqMultiplePaymentAnswer =>
      '开启多重付款，点击编辑，将总额分配给现金、卡、二维码等。每种方式单独记录。';

  @override
  String get faqSplitPaymentSavedQuestion => '分割中只保存了一笔付款';

  @override
  String get faqSplitPaymentSavedAnswer =>
      '更新到最新应用版本。旧版本有时只保存第一个分割行。如果未付余额仍然错误，请再次结算。';

  @override
  String get faqAddItemQuestion => '如何添加项目？';

  @override
  String get faqAddItemAnswer =>
      '使用销售流程或快速添加中的添加项目。输入名称、费率、单位、用途和可选照片（JPEG/PNG/GIF/WebP，最大 5MB），然后创建项目。';

  @override
  String get faqCustomUnitQuestion => '如何添加自定义单位？';

  @override
  String get faqCustomUnitAnswer =>
      '在项目表单上，点击单位 → 列表底部的创建新单位，输入名称（例如：升、箱），然后创建。';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion => '我更改了名称，但个人资料仍显示旧名称';

  @override
  String get faqProfileNameAnswer => '编辑您的员工记录（与登录相同的电子邮件）并保存。更多标签页和仪表板应该会更新。';

  @override
  String get faqRevenueDetailsQuestion => '收入详情是什么？';

  @override
  String get faqRevenueDetailsAnswer =>
      '包含每日趋势图、净利润、未收应收款和逐日销售对采购分析的月度视图。用日历或月份筹码更改月份。';

  @override
  String get faqOtherReportsQuestion => '其他报告在哪里？';

  @override
  String get faqOtherReportsAnswer => '打开更多，在报告（分析、损益、报表等）下查找，如果您的角色有访问权限。';

  @override
  String get faqWhenSyncQuestion => '我应该什么时候同步？';

  @override
  String get faqWhenSyncAnswer => '只有在管理员要求并且有稳定连接时。同步在设备和服务器之间发送或接收数据。';

  @override
  String get faqFabPositionQuestion => '+ 按钮在销售 / 支出中看起来太高';

  @override
  String get faqFabPositionAnswer => '它位于底部导航栏上方。如果按钮与设备上的内容重叠，请滚动列表或更新应用。';

  @override
  String get faqHowLogoutQuestion => '如何退出？';

  @override
  String get faqHowLogoutAnswer => '更多 → 设置列表底部的退出。';

  @override
  String get statisticsGoodMorning => '早上好';

  @override
  String get statisticsGoodAfternoon => '下午好';

  @override
  String get statisticsGoodEvening => '晚上好';

  @override
  String get statisticsDefaultUser => '用户';

  @override
  String get statisticsCheckConnection => '请检查您的连接并重试。';

  @override
  String get statisticsCouldNotLoadProfile => '无法加载配置文件';

  @override
  String get statisticsCouldNotLoadData => '无法加载数据';

  @override
  String get statisticsPeriodDay => '天';

  @override
  String get statisticsPeriodMonth => '月';

  @override
  String get statisticsPeriodYear => '年';

  @override
  String get statisticsSelectedPeriod => '选定期间';

  @override
  String get statisticsSelectMonth => '选择月份';

  @override
  String get statisticsSelectMonthSubtitle => '选择一个月来过滤数据';

  @override
  String get statisticsQuickOperations => 'Quick Operations';

  @override
  String get statisticsQuickOperationsSeeAll => '查看全部';

  @override
  String get statisticsQuickOperationInvoice => '发票';

  @override
  String get statisticsQuickOperationReports => '报表';

  @override
  String get statisticsAnnualRevenue => '年收入';

  @override
  String get statisticsCashflow => '现金流';

  @override
  String get statisticsCashflowLast7Days => '现金流（近7天）';

  @override
  String get statisticsCashflowLast12Months => '现金流（近12个月）';

  @override
  String get statisticsDaily => '日常的';

  @override
  String get statisticsMonthly => '每月';

  @override
  String get statisticsOverall => '全面的';

  @override
  String get statisticsLast7Days => 'Last 7 Days';

  @override
  String get statisticsLast12Months => 'Last 12 Months';

  @override
  String get statisticsAllYears => '所有年份';

  @override
  String get statisticsNoDataAvailable => '无可用数据';

  @override
  String get statisticsMoneyIn => '资金投入';

  @override
  String get statisticsMoneyOut => '钱出';

  @override
  String get statisticsIncome => '收入';

  @override
  String get statisticsExpenses => '开支';

  @override
  String get statisticsSalesSummary => '销售总结';

  @override
  String get statisticsPurchaseSummary => '购买总结';

  @override
  String get statisticsTotalSales => '总销售额';

  @override
  String get statisticsTotalIncome => '总收入';

  @override
  String get statisticsTotalUnpaid => '未付总额';

  @override
  String get statisticsTotalPurchase => '购买总额';

  @override
  String get statisticsPaidPurchase => '付费购买';

  @override
  String get statisticsUnpaidPurchase => '未付款购买';

  @override
  String get statisticsEmployeeDashboard => '员工仪表板';

  @override
  String get statisticsDefaultEmployee => '员工';

  @override
  String get statisticsDefaultDepartment => '部门';

  @override
  String get statisticsDefaultPosition => '位置';

  @override
  String get statisticsCurrentMonth => '本月';

  @override
  String get statisticsStatus => '地位';

  @override
  String get statisticsActive => '积极的';

  @override
  String get statisticsWelcome => '欢迎';

  @override
  String get statisticsEmployeeWelcomeMessage => '您以员工身份登录。使用导航菜单访问可用功能。';

  @override
  String get statisticsRevenueDetails => '收入详情';

  @override
  String get statisticsEmployeeDetails => '员工详情';

  @override
  String get statisticsChangeMonth => '更改月份';

  @override
  String get statisticsFilterChartsSubtitle => '过滤图表和细分';

  @override
  String get statisticsDailyTrend => '每日趋势';

  @override
  String get statisticsDailyActivity => '日常活动';

  @override
  String get statisticsNoDataForMonth => '本月无数据';

  @override
  String get statisticsNetProfit => '纯利';

  @override
  String get statisticsMonthReceivables => '月应收账款';

  @override
  String get statisticsMonthRevenue => '月收入';

  @override
  String get statisticsMonthExpenses => '每月费用';

  @override
  String get statisticsNoDailyEntries => '本月没有每日条目';

  @override
  String get statisticsDailySalesBreakdown => '每日销售明细';

  @override
  String get statisticsDailyBreakdown => '每日细分';

  @override
  String get statisticsAdvance => '进步';

  @override
  String get statisticsExploreFeatures => '探索功能';

  @override
  String get statisticsShowOrHideFeatures => '显示或隐藏功能';

  @override
  String get statisticsAllFeaturesHidden => '所有探索功能均已隐藏';

  @override
  String get statisticsNoFeaturesForOrg => '没有适合您的组织的功能';

  @override
  String get statisticsTapTuneToShow => '点击上面的调谐图标即可再次显示快捷方式。';

  @override
  String get statisticsMenuCheck => '对账';

  @override
  String get statisticsMenuEmployee => '员工';

  @override
  String get statisticsMenuOrder => '命令';

  @override
  String get statisticsMenuInventory => 'Items';

  @override
  String get statisticsMenuCustomers => '顾客';

  @override
  String get statisticsMenuCalculator => 'Liquor prices';

  @override
  String get statisticsMenuQuickExpenses => '快\n费用';

  @override
  String get statisticsMenuQuickSales => '快\n销售';

  @override
  String get statisticsMenuAddEmployee => '添加\n员工';

  @override
  String get statisticsMenuAddParty => '添加\n往来方';

  @override
  String get statisticsMenuAddEmployeeSingle => '添加员工';

  @override
  String get statisticsMenuAddPartySingle => '添加往来方';

  @override
  String statisticsGreeting(String greeting, String name) {
    return '$greeting，$name';
  }

  @override
  String statisticsEmployeeGreeting(String greeting, String name) {
    return '$greeting，$name！';
  }

  @override
  String statisticsDepartmentPosition(String department, String position) {
    return '$department • $position';
  }

  @override
  String statisticsMetricCollected(String amount) {
    return '$amount 已收集';
  }

  @override
  String statisticsMetricPaid(String amount) {
    return '$amount 已付款';
  }

  @override
  String statisticsMoneyInAmount(String amount) {
    return '资金投入：$amount';
  }

  @override
  String statisticsMoneyOutAmount(String amount) {
    return '钱出：$amount';
  }

  @override
  String statisticsDayTooltip(String day, String amount) {
    return '日 $day\n$amount';
  }

  @override
  String statisticsProfitMargin(String percent) {
    return '$percent% 保证金';
  }

  @override
  String get invoiceCommonActions => '行动';

  @override
  String get invoiceCommonSearchItems => '搜索项目';

  @override
  String get invoiceCommonSearchItemsSubtitle => '搜索特定项目';

  @override
  String get invoiceCommonAddNewInvoice => '添加新发票';

  @override
  String get invoiceCommonAddSalesInvoiceSubtitle => '创建新的销售发票';

  @override
  String get invoiceCommonAddPurchaseInvoiceSubtitle => '创建新的采购发票';

  @override
  String get invoiceCommonSelectMonthYear => '选择月/年';

  @override
  String get invoiceCommonSelectMonthYearSubtitle => '跳转到特定月份';

  @override
  String get invoiceCommonSelectMonthAndYear => '选择月份和年份';

  @override
  String get invoiceCommonFilterByDate => '按日期过滤';

  @override
  String get invoiceCommonFilterByDateRange => '按日期范围过滤';

  @override
  String get invoiceCommonCloseSearch => '关闭搜索';

  @override
  String get invoiceCommonSelectAll => '选择全部';

  @override
  String get invoiceCommonToday => '今天';

  @override
  String get invoiceCommonTotalQuantity => '总量';

  @override
  String get invoiceCommonTotalAmount => '总金额';

  @override
  String get invoiceCommonTotal => '全部的';

  @override
  String get invoiceCommonSearchForItems => '搜索项目';

  @override
  String get invoiceCommonNoItemsFound => '没有找到物品';

  @override
  String get invoiceCommonUnknownItem => '未知物品';

  @override
  String get invoiceCommonNotAvailable => '不适用';

  @override
  String get invoiceSalesCouldNotLoad => '无法加载销售';

  @override
  String get invoiceSalesNoFound => '没有找到销售';

  @override
  String get invoiceSalesSelectDate => '选择日期查看销售情况';

  @override
  String get invoiceSalesNoInvoicesFound => '没有找到发票';

  @override
  String get invoiceSalesSelectDateLegacy => '选择查看发票的日期';

  @override
  String get invoicePurchaseCouldNotLoad => '无法加载费用';

  @override
  String get invoicePurchaseNoFound => '没有找到购买的商品';

  @override
  String get invoicePurchaseSelectDate => '选择日期查看购买情况';

  @override
  String get invoiceWeekdaySun => '太阳';

  @override
  String get invoiceWeekdayMon => '周一';

  @override
  String get invoiceWeekdayTue => '星期二';

  @override
  String get invoiceWeekdayWed => '周三';

  @override
  String get invoiceWeekdayThu => '星期四';

  @override
  String get invoiceWeekdayFri => '周五';

  @override
  String get invoiceWeekdaySat => '星期六';

  @override
  String invoiceCommonSelectedCount(int count) {
    return '$count 已选择';
  }

  @override
  String invoiceCommonQtyLabel(String qty) {
    return '数量：$qty';
  }

  @override
  String invoiceCommonInvoiceLabel(String number) {
    return '发票：$number';
  }

  @override
  String invoiceCommonCustomerLabel(String name) {
    return '客户：$name';
  }

  @override
  String invoiceCommonSupplierLabel(String name) {
    return '供应商：$name';
  }

  @override
  String invoiceCommonSearchingFor(String query) {
    return '正在搜索“$query”...';
  }

  @override
  String invoiceCommonSearchItemsHint(String scope) {
    return '搜索 $scope 中的项目...';
  }

  @override
  String invoiceCommonSalesSearchPrompt(String scope) {
    return '输入商品名称即可查找所有销售\n在 $scope';
  }

  @override
  String invoiceCommonPurchaseSearchPrompt(String scope) {
    return '输入商品名称即可查找所有购买的商品\n在 $scope';
  }

  @override
  String invoiceCommonSalesNoMatch(String query, String scope) {
    return '没有销售“$query”\n在 $scope';
  }

  @override
  String invoiceCommonPurchaseNoMatch(String query, String scope) {
    return '没有购买“$query”\n在 $scope';
  }

  @override
  String invoiceCommonEmptyForDate(String date) {
    return '对于 $date';
  }

  @override
  String invoiceFoundSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 笔销售',
      one: '1 笔销售',
    );
    return '找到 $_temp0';
  }

  @override
  String invoiceFoundPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 笔采购',
      one: '1 笔采购',
    );
    return '找到 $_temp0';
  }

  @override
  String invoiceDateSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 笔销售',
      one: '1 笔销售',
    );
    return '$_temp0';
  }

  @override
  String invoiceDatePurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 笔采购',
      one: '1 笔采购',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张发票',
      one: '1 张发票',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张发票',
      one: '1 张发票',
    );
    return '删除 $_temp0';
  }

  @override
  String invoiceDeleteMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张选中的发票',
      one: '1 张选中的发票',
    );
    return '确定要删除 $_temp0吗？此操作无法撤销。';
  }

  @override
  String get contacts => '联系方式';

  @override
  String get categories => '类别';

  @override
  String get manageStaff => '管理员工';

  @override
  String get payroll => '工资单';

  @override
  String get attendance => '出席率';

  @override
  String get profitAndLoss => '损益';

  @override
  String get statementReport => '报表';

  @override
  String get analytics => '分析';

  @override
  String get loggedOut => '已注销';

  @override
  String organizationCodeDisplay(String code) {
    return '代码：$code';
  }

  @override
  String get moreDataSynchronization => '数据同步';

  @override
  String get moreSendDataToClient => '发送数据给客户端';

  @override
  String get moreSendDataToClientSubtitle => '将服务器数据上传到客户端';

  @override
  String get moreSendDataToClientWarning =>
      '此操作将用服务器中的数据替换当前客户端数据库。所有最近的客户端更改都可能会丢失。';

  @override
  String get moreSendDataToClientConfirm => '您确定要向客户端发送数据吗？';

  @override
  String get moreFetchDataFromClient => '从客户端获取数据';

  @override
  String get moreFetchDataFromClientSubtitle => '下载客户端数据到服务器';

  @override
  String get moreFetchDataFromClientWarning =>
      '此操作将用来自客户端的数据替换当前服务器数据库。所有最近的服务器更改可能会丢失。';

  @override
  String get moreFetchDataFromClientConfirm => '您确定要从客户端获取数据吗？';

  @override
  String get notifications => '通知';

  @override
  String get openingReminder => '开仓提醒';

  @override
  String get closingReminder => '关闭提醒';

  @override
  String get activityReminder => 'Sales & purchase reminder';

  @override
  String get openingTime => '开放时间';

  @override
  String get closingTime => '关门时间';

  @override
  String get activityReminderTime => 'Reminder time';

  @override
  String get notificationSettingsSaved => '通知设置已保存';

  @override
  String get notificationPermissionHint =>
      '允许通知（以及 Android 上的闹钟），以便在应用程序关闭时提醒起作用';

  @override
  String dailyAtTime(String time) {
    return '每日 $time';
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
  String get invoiceCommonYesterday => '昨天';

  @override
  String invoiceCommonTodayAt(String time) {
    return '今天，$time';
  }

  @override
  String invoiceCommonDaysAgo(int count) {
    return '$count 天前';
  }

  @override
  String invoiceReturnCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 笔退货',
      one: '1 笔退货',
    );
    return '$_temp0';
  }

  @override
  String get checkoutSelectParty => '选择往来方';

  @override
  String get partyPickerSubtitle => '此销售属于谁？';

  @override
  String partyPickerSearchHint(String role) {
    return '搜索$role…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return '添加新$role';
  }

  @override
  String get partyPickerSettled => '已结清';

  @override
  String get partyPickerSelectedLabel => '已选';

  @override
  String get checkoutCartSummary => '购物车摘要';

  @override
  String get checkoutNoItemsInCart => '购物车中没有商品';

  @override
  String get checkoutSearchHere => '在这里搜索';

  @override
  String get checkoutCreateInvoice => '创建发票';

  @override
  String get checkoutEditInvoice => '编辑发票';

  @override
  String get checkoutSaveInvoice => '保存发票';

  @override
  String get checkoutInvoiceSummary => '发票摘要';

  @override
  String get checkoutEstimate => '估计';

  @override
  String get checkoutBasicInformation => '基本信息';

  @override
  String get checkoutAddItems => '添加项目';

  @override
  String get checkoutItemsSection => '项目';

  @override
  String get checkoutPartyRequired => '往来方 *';

  @override
  String get checkoutPartyInformation => '往来方信息';

  @override
  String get checkoutBillSummary => '法案摘要';

  @override
  String get checkoutBillSummaryHint => '点击了解更详细的计算。';

  @override
  String get checkoutItemTotal => '项目总计';

  @override
  String checkoutLoyaltyDiscount(String percent) {
    return '忠诚度折扣 ($percent%)';
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
    return '- 折扣 ($percent%)';
  }

  @override
  String get checkoutTapToEdit => '点击进行编辑';

  @override
  String get checkoutTotalAmount => '总金额';

  @override
  String get checkoutPaymentMode => 'Record payment';

  @override
  String get checkoutPaymentModeHint =>
      'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.';

  @override
  String get checkoutNetSalesAmount => '净销售额';

  @override
  String get checkoutConfirmCheckout => '确认结账';

  @override
  String get checkoutEditDiscount => '编辑折扣';

  @override
  String get checkoutPercentage => '百分比';

  @override
  String get checkoutDiscard => '丢弃';

  @override
  String get checkoutPartialPayment => '部分付款';

  @override
  String get checkoutPartialPaymentBanner => '通过激活部分付款，客户将能够支付少于总账单金额的金额。';

  @override
  String get checkoutPleaseEnterAmounts => '请输入相应金额：';

  @override
  String get checkoutPartialPaymentEqualHint => '由于未分配用户，因此总金额应等于总计费金额。';

  @override
  String checkoutOverGrandTotalBy(String amount) {
    return '总计超过：$amount';
  }

  @override
  String checkoutRemainingUnpaid(String amount) {
    return '剩余金额（总计中未支付）：$amount';
  }

  @override
  String get checkoutConfirmPayment => '确认付款';

  @override
  String get checkoutUnpaidCredit => '未付款/贷方';

  @override
  String get checkoutAddAtLeastOneLine => '添加至少一项订单项以查看估算';

  @override
  String get checkoutMultiplePayment => '多次付款';

  @override
  String get checkoutPaymentStatus => '付款状态';

  @override
  String get checkoutPaymentMethods => '付款方式';

  @override
  String get checkoutPaymentMethod => '付款方式';

  @override
  String get checkoutTenderAmount => '投标金额';

  @override
  String get checkoutLoadingPaymentMethods => '正在加载付款方式...';

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
  String get stockSearchByDateHint => '按日期或月份搜索...';

  @override
  String get stockNoMatches => '没有匹配项';

  @override
  String get stockTryDifferentSearch => '尝试不同的搜索词';

  @override
  String get stockTryAnotherSearch => '尝试其他搜索';

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
    return '数量 $qty';
  }

  @override
  String stockCardSummary(String records, String items, String locations) {
    return '$records 记录 · $items 项目 · $locations 位置';
  }

  @override
  String get stockFilterTitle => 'Filter stock reconciliation';

  @override
  String get stockBatchNumber => '批号';

  @override
  String get stockLocation => '地点';

  @override
  String get stockOptionalHint => '选修的';

  @override
  String get stockApplyFilters => '应用过滤器';

  @override
  String get stockClearFields => '清除字段';

  @override
  String get stockDeleteAllTooltip => '删除该日期的所有库存';

  @override
  String get stockNoItemsFound => '没有找到库存商品';

  @override
  String get stockNoItemsSubtitle => '尝试不同的过滤器或其他报告日期。';

  @override
  String get stockAdjustFilters => '调整过滤器';

  @override
  String get stockSearchItemHint => '搜索项目、批次、位置...';

  @override
  String get stockEditQuantities => '编辑数量';

  @override
  String get stockNoChangesDetected => '未检测到任何变化';

  @override
  String stockErrorPreparingChanges(String error) {
    return '准备更改时出错：$error';
  }

  @override
  String get stockUpdateSuccessful => '更新成功！';

  @override
  String get stockSummary => '概括';

  @override
  String get stockTotalRequested => '请求总数';

  @override
  String get stockSuccessfullyUpdated => '更新成功';

  @override
  String get stockFailed => '失败的';

  @override
  String get stockUpdateFailed => '更新失败';

  @override
  String get stockClearAllQuantitiesTitle => '清除所有数量？';

  @override
  String get stockClearAllQuantitiesMessage => '这会将所有数量重置为 0。您确定吗？';

  @override
  String get stockClearAll => '全部清除';

  @override
  String get stockUpdatingQuantities => '正在更新库存数量...';

  @override
  String get stockEditQuantitiesTitle => '编辑库存数量';

  @override
  String stockReportingDate(String date) {
    return '报告日期：$date';
  }

  @override
  String stockTotalItemsHint(String count) {
    return '商品总数：$count • 根据需要更新数量';
  }

  @override
  String get stockItemName => '商品名称';

  @override
  String stockBatchPrefix(String batch) {
    return '批次：$batch';
  }

  @override
  String get stockDeleteConfirmTitle => '确认删除';

  @override
  String get stockDeleteConfirmIntro => '您将永久删除以下日期的所有库存商品：';

  @override
  String get stockDeleteConfirmWarning => '此操作无法撤消。该日期的所有库存记录将被永久删除。';

  @override
  String get stockNoInternetRetry => '没有互联网连接。请检查您的连接并重试。';

  @override
  String get itemsTitle => '项目';

  @override
  String get itemAddSheetTitle => '添加项目';

  @override
  String get itemSingleAdd => '单次添加';

  @override
  String get itemBulkAdd => '批量添加';

  @override
  String get itemBulkAddTitle => '批量添加项目';

  @override
  String get itemEditTitle => '编辑项目';

  @override
  String get itemAddTitle => '添加项目';

  @override
  String get itemCreateButton => '创建项目';

  @override
  String get itemUpdateButton => '更新项目';

  @override
  String get itemDeleteTitle => '删除项目';

  @override
  String itemDeleteConfirm(String name) {
    return '您确定要删除“$name”吗？';
  }

  @override
  String get itemDeletedSuccess => '项目删除成功';

  @override
  String get itemCreatedSuccess => '项目创建成功';

  @override
  String get itemUpdatedSuccess => '项目更新成功';

  @override
  String get itemLoading => '正在加载项目...';

  @override
  String get itemErrorTitle => '哎呀！出了点问题';

  @override
  String get itemTryAgain => '再试一次';

  @override
  String get itemSearchHint => '搜索项目';

  @override
  String get itemNoItemsFound => '没有找到物品';

  @override
  String get itemTryAdjustSearch => '尝试调整您的搜索词';

  @override
  String get itemNoItemsAvailable => '没有可用的项目';

  @override
  String get itemAddToGetStarted => '添加项目以开始使用';

  @override
  String get itemNoMoreItems => '没有更多物品';

  @override
  String get itemPurposeBoth => '两个都';

  @override
  String get itemPurposePurchases => '购买';

  @override
  String get itemTypeProduct => '产品';

  @override
  String get itemTypeService => '服务';

  @override
  String get itemTypeInventory => '存货';

  @override
  String get itemPhotoTitle => '物品照片';

  @override
  String get itemPhotoHint => '单击此处选择或上传照片';

  @override
  String get itemPhotoFormats => 'JPEG、PNG、GIF 或 WebP · 最大 5MB';

  @override
  String get itemAddPhoto => '添加照片';

  @override
  String get itemPhotoLibrary => '图片库';

  @override
  String get itemPhotoLibraryHint => '从您的照片中选择';

  @override
  String get itemTakePhoto => '拍张照片';

  @override
  String get itemUploadGallery => '从图库上传';

  @override
  String get itemUploadGalleryHint => '浏览此设备上的文件';

  @override
  String get itemTypeLabel => '类型';

  @override
  String get itemTypeField => '物品类型';

  @override
  String get itemNameLabel => '商品名称';

  @override
  String get itemNameHint => '输入商品名称';

  @override
  String get itemBarcodeLabel => '条形码/二维码';

  @override
  String get itemBarcodeField => '条形码/二维码';

  @override
  String get itemBarcodeHint => '从应用栏扫描或粘贴';

  @override
  String get itemSkuLabel => 'SKU (optional)';

  @override
  String get itemSkuField => 'SKU';

  @override
  String get itemSkuHint => 'Product code — optional';

  @override
  String get itemPickerSearchHint => 'Search items by name or SKU…';

  @override
  String get itemRateLabel => '速度';

  @override
  String get itemUnitLabel => '单元';

  @override
  String get itemPurposeLabel => '目的';

  @override
  String get itemSelectUnit => '选择单位';

  @override
  String get itemSelectPurpose => '选择目的';

  @override
  String get itemSelectCategory => '选择类别';

  @override
  String get itemSelectType => '选择类型';

  @override
  String get itemSelectItemType => '选择项目类型';

  @override
  String get itemSearchUnits => '搜索单位...';

  @override
  String get itemSearchPurpose => '搜索目的...';

  @override
  String get itemSearchCategories => '搜索类别...';

  @override
  String get itemCreateCustomUnit => '创建自定义单位';

  @override
  String get itemUnitName => '单位名称';

  @override
  String get itemUnitNameHint => '例如，升、盒、件';

  @override
  String get itemValidationName => '请输入商品名称';

  @override
  String get itemValidationRate => '请输入费率';

  @override
  String get itemValidationNumber => '请输入有效号码';

  @override
  String get itemSelectUnitRequired => '请选择单位';

  @override
  String get itemSelectPurposeRequired => '请选择目的';

  @override
  String get itemSelectCategoryRequired => '请选择类别';

  @override
  String get itemImageMissing => '图像文件丢失';

  @override
  String get itemImageFormatError => '使用 JPEG、PNG、GIF 或 WebP';

  @override
  String get itemImageSizeError => '图片必须为 5MB 或更小';

  @override
  String get itemScanBarcode => '扫描条码';

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
    return '名称从目录中填写：$name';
  }

  @override
  String get itemBarcodePasteHint => '未找到产品名称 - 代码已粘贴为名称。如果需要的话进行编辑。';

  @override
  String get itemBulkRefillTooltip => '重新填写之前的输入';

  @override
  String get itemBulkAddRow => '添加行';

  @override
  String itemBulkRowLabel(String index) {
    return '项目 $index';
  }

  @override
  String get itemBulkNameRequired => '姓名必填';

  @override
  String get itemBulkInvalidNumber => '号码无效';

  @override
  String get itemBulkCreating => '创造……';

  @override
  String get itemBulkCreateItems => '创建项目';

  @override
  String itemBulkCreatedCount(String count) {
    return '已创建 $count 项';
  }

  @override
  String itemBulkCreateFailed(String error) {
    return '无法创建项目：$error';
  }

  @override
  String get itemBulkNoDraft => '未找到已保存的草稿';

  @override
  String get itemBulkInvalidDraft => '保存的草稿格式无效';

  @override
  String get itemBulkDraftRestored => '恢复之前的草稿';

  @override
  String get itemBulkDraftRestoreFailed => '无法恢复保存的草稿';

  @override
  String get itemBulkAtLeastOne => '添加至少一项';

  @override
  String get itemBulkCategoriesLoading => '类别正在加载，请重试';

  @override
  String get itemBulkLoadingCategories => '正在加载类别...';

  @override
  String get inventoryTitle => '库存分析';

  @override
  String get inventorySubtitle => '实时股票走势跟踪';

  @override
  String get inventorySearchHint => '搜索项目...';

  @override
  String get inventorySold => '卖';

  @override
  String get inventoryPurchased => '已购买';

  @override
  String get catNoCategories => '没有类别。点击 + 进行创建。';

  @override
  String get catLoadCategories => '负载类别';

  @override
  String get catCreated => '类别已创建';

  @override
  String get catRenamed => '类别已重命名';

  @override
  String get catDeleted => '类别已删除';

  @override
  String catDeletedBulk(int count) {
    return '$count categories deleted';
  }

  @override
  String get catNewTitle => '新类别';

  @override
  String get catRenameTitle => '重命名类别';

  @override
  String get catNewName => '新名称';

  @override
  String get catRename => '重命名';

  @override
  String get catDeleteTitle => '删除类别';

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
    return '删除“$name”？';
  }

  @override
  String get catDeleteLinkedHint => '项目已链接。您可以强制删除以取消它们的链接。';

  @override
  String get catForceDelete => '强制删除';

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
    return '$count 项目';
  }

  @override
  String get contactFavoritesOnly => '仅限收藏夹';

  @override
  String get contactShowAll => '显示所有联系人';

  @override
  String get contactSearchHint => '搜索姓名、电话、电子邮件...';

  @override
  String get contactNoConnection => '无连接';

  @override
  String get contactCheckNetwork => '检查您的网络并重试。';

  @override
  String get contactSomethingWrong => '出了点问题';

  @override
  String get contactNoContacts => '没有联系人';

  @override
  String get contactNoFavorites => '没有最喜欢的比赛。关闭明星过滤器或在联系人中添加收藏夹。';

  @override
  String get contactTrySearchOrAdd => '尝试不同的搜索或点击 + 添加联系人。';

  @override
  String get contactEndOfList => '列表末尾';

  @override
  String get contactNewTooltip => '新联系人';

  @override
  String get contactLoading => '正在加载联系人...';

  @override
  String get contactUnknown => '未知';

  @override
  String get contactCallTooltip => '称呼';

  @override
  String get contactEditTitle => '编辑联系人';

  @override
  String get contactNewTitle => '新联系人';

  @override
  String get contactSelectTitle => '选择联系人';

  @override
  String get contactDeleteTitle => '删除联系方式？';

  @override
  String get contactDeleteUndo => '此操作无法撤消。';

  @override
  String get contactNameRequired => '姓名为必填项';

  @override
  String get contactNameLabel => '姓名 *';

  @override
  String get contactNameHint => '联系人姓名';

  @override
  String get contactPhoneHint => '+977-9841234567';

  @override
  String get contactEmailHint => '电子邮件@example.com';

  @override
  String get contactCategoryHint => '例如商务、普通、vip';

  @override
  String get contactCompanyHint => '公司名称';

  @override
  String get contactFavorite => '最喜欢的';

  @override
  String get contactCannotCall => '无法在此设备上拨打电话';

  @override
  String get contactPermissionDenied => '联系权限被拒绝。您可以在“设置”中启用它。';

  @override
  String get contactPermissionRequired => '从手机导入需要联系人权限';

  @override
  String get contactImported => '从手机导入的联系人';

  @override
  String get contactCreated => '已创建联系人';

  @override
  String get contactUpdated => '联系方式已更新';

  @override
  String get contactDeleted => '联系方式已删除';

  @override
  String get contactImportSearchHint => '按姓名、电话、电子邮件、公司搜索';

  @override
  String get contactImportNoResults => '未找到联系人';

  @override
  String get checkoutMultiplePaymentHint => '如果客户通过多种付款方式付款，请打开此选项。';

  @override
  String get checkoutFillRemainingBalance => '填写剩余余额';

  @override
  String get checkoutEnterAtLeastOnePayment => '输入至少一笔付款金额';

  @override
  String get checkoutPaymentsExceedTotal => '付款总额不能超过总金额';

  @override
  String checkoutSentAs(String api) {
    return '发送为：$api';
  }

  @override
  String get paymentCard => '卡片';

  @override
  String get paymentQr => 'QR';

  @override
  String get paymentBank => '银行';

  @override
  String get paymentTransfer => '转移';

  @override
  String get paymentBankTransfer => '银行转账';

  @override
  String get paymentSettlement => '沉降';

  @override
  String get paymentCheque => '查看';

  @override
  String get paymentDigital => '数字的';

  @override
  String get paymentDigitalQr => '数字（二维码）';

  @override
  String get closeSummaryTitle => '结账汇总';

  @override
  String get closeTabDashboard => '仪表板';

  @override
  String get closeTabCredits => '制作人员';

  @override
  String get closeWelcome => '欢迎来到总结总结';

  @override
  String get closeSelectDateHint => '选择日期并点击刷新以加载数据';

  @override
  String get closeLoadingDashboard => '正在加载仪表板数据...';

  @override
  String get closeDataDeleted => '数据已删除';

  @override
  String closeErrorPrefix(String message) {
    return '错误：$message';
  }

  @override
  String get closeExtraAmount => '额外金额';

  @override
  String get closeExtraAmountDesc => '该截止日记录的额外现金或调整。';

  @override
  String get closeLostAmount => '丢失金额';

  @override
  String get closeLostAmountDesc => '此期间标记有现金短缺或差异。';

  @override
  String get closeTapForDetails => '点击查看详情';

  @override
  String get closeAmountLabel => '日结';

  @override
  String get closeAmountFormula => '日结金额公式';

  @override
  String get closeFormulaExpression => '现金销售 - 现金支出 = 日结金额';

  @override
  String get closeCashSales => '现金销售';

  @override
  String get closeCashExpenses => '现金支出';

  @override
  String get closeClosingAmount => '日结金额';

  @override
  String get closeWhatThisMeans => '这意味着什么：';

  @override
  String get closeClosingMeaning =>
      '这是一天结束时您的收银机/抽屉中应有的现金金额。它代表所有收到的现金减去所有支付的现金。';

  @override
  String get closeQuickStats => '快速统计';

  @override
  String get closeTapCardHint => '点击卡片即可查看简短说明';

  @override
  String get closeOpeningBalance => '期初余额';

  @override
  String get closeTotalSales => '销售总额';

  @override
  String get closeQrAmount => '二维码金额';

  @override
  String get closeCashAmount => '现金金额';

  @override
  String get closeSalesDiscount => '销售折扣';

  @override
  String get closeCreditQr => '信用二维码';

  @override
  String get closeCreditCash => '信用现金';

  @override
  String get closeCreditDiscount => '信用折扣';

  @override
  String get closePayCashGetQr => '支付现金 → 收取二维码';

  @override
  String get closePayQrGetCash => '二维码支付 → 收取现金';

  @override
  String get closePaymentMix => '支付组合';

  @override
  String get closePaymentMixHint => '点击现金或数字·条形图显示销售份额';

  @override
  String get closeCashVsDigitalTooltip => '现金与数字销售份额';

  @override
  String closeSalesShareDesc(String label, String percent) {
    return '$label 占当天总销售额的 $percent%。';
  }

  @override
  String closeSalesLabel(String label) {
    return '$label 销售';
  }

  @override
  String get closeNoTransactions => '没有可用的交易';

  @override
  String get closeRecentTransactions => '最近交易';

  @override
  String get closeViewAll => '查看全部';

  @override
  String get closeNoPurchases => '没有可用的购买';

  @override
  String get closeRecentPurchases => '最近购买的商品';

  @override
  String get closeNoSalesDate => '该日期没有销售';

  @override
  String get closeNoSalesHint => '销售记录后将显示在此处。';

  @override
  String get closeRoomSales => '客房销售';

  @override
  String get closeEmployeeSales => '员工销售';

  @override
  String get closeOtherSales => '其他销售';

  @override
  String closeSectionCount(String title, String count) {
    return '$title ($count)';
  }

  @override
  String closeDiscountShort(String amount) {
    return '光盘：$amount';
  }

  @override
  String closePercentOff(String percent) {
    return '$percent% 折扣';
  }

  @override
  String get closePending => '待办的';

  @override
  String get closeNoCreditPayments => '无信用付款';

  @override
  String get closeNoCreditHint => '信用付款将出现在这里';

  @override
  String get closeViewStatistics => '查看统计数据';

  @override
  String get closeExportData => '导出数据';

  @override
  String get closeExportComingSoon => '导出功能将在此处实现';

  @override
  String get closeHintOpeningBalance => '所选日期开始时的现金头寸。';

  @override
  String get closeHintTotalSales => '该日期记录的所有销售额的总和。';

  @override
  String get closeHintQrAmount => '通过二维码或数字方式收到的付款。';

  @override
  String get closeHintCashAmount => '当日销售额的现金部分。';

  @override
  String get closeHintCashExpenses => '白天支出的现金支付。';

  @override
  String get closeHintSalesDiscount => '折扣适用于销售。';

  @override
  String get closeHintCreditQr => '信用相关的二维码收款。';

  @override
  String get closeHintCreditCash => '与信贷相关的现金流动。';

  @override
  String get closeHintCreditDiscount => '信用交易适用折扣。';

  @override
  String get closeHintPayCashGetQr => '支付现金并收到二维码信用的兑换。';

  @override
  String get closeHintPayQrGetCash => '支付 QR 并收到现金的交易所。';

  @override
  String get closeOpeningAmount => '开仓金额';

  @override
  String get closeCurrentAmount => '当前金额';

  @override
  String get closeSaveReport => '保存报告';

  @override
  String get closeUpdateSummary => '更新摘要';

  @override
  String get closeExists => '存在';

  @override
  String get closeExistingDataInfo => '您可以查看或修改现有数据';

  @override
  String get closeEnterOpeningAmount => '请输入开仓金额';

  @override
  String get closeEnterValidAmount => '请输入有效金额';

  @override
  String get closeAmountCannotBeNegative => 'Amount cannot be negative';

  @override
  String get googleDriveBackupSectionTitle => '备份与同步';

  @override
  String get googleDriveBackupTitle => 'Google Drive 备份';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      '登录以在 Google Drive 安全备份组织数据。';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return '已登录为 $email';
  }

  @override
  String get googleDriveSignIn => '使用 Google 登录';

  @override
  String get googleDriveSignOut => '退出登录';

  @override
  String get googleDriveBackupNow => '立即备份';

  @override
  String get googleDriveSignInSuccess => '已登录 Google Drive';

  @override
  String get googleDriveSignOutSuccess => '已退出 Google Drive';

  @override
  String get googleDriveSignInCancelled => '已取消 Google 登录';

  @override
  String get googleDriveBackupStarting => '正在准备备份…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return '已上传备份（$tableCount 个表，$recordCount 条记录）';
  }

  @override
  String get googleDriveBackupPluginError => '备份需要完全重启应用。请关闭应用，重新打开后再试。';

  @override
  String googleDriveBackupFailed(String error) {
    return '备份失败：$error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return '上次备份：$date';
  }

  @override
  String get backupSyncPageTitle => '备份与同步';

  @override
  String get backupSyncGoogleAccount => 'Google 账号';

  @override
  String get backupSyncSignedInAs => '登录为';

  @override
  String get backupSyncSignInHint => '使用 Google 登录以备份组织数据。';

  @override
  String get backupSyncLastSyncTitle => '上次同步';

  @override
  String get backupSyncLastSyncDate => '日期和时间';

  @override
  String get backupSyncNeverSynced => '尚未上传备份。';

  @override
  String get backupSyncOrganization => '组织';

  @override
  String get backupSyncTables => '已备份表';

  @override
  String get backupSyncRecords => '已备份记录';

  @override
  String get backupSyncStatus => '状态';

  @override
  String get backupSyncStatusSuccess => '已完成';

  @override
  String get backupSyncActiveOrganization => '当前组织';

  @override
  String get backupSyncActiveOrganizationHint => '备份会上传您当前使用的组织数据。';

  @override
  String get backupSyncUnknownOrganization => '当前组织';

  @override
  String get backupSyncInProgress => '同步进行中';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return '步骤：$step';
  }

  @override
  String get backupSyncStepExport => '正在导出本地数据';

  @override
  String backupSyncStepUploadTable(String table) {
    return '正在上传 $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return '正在上传 $file';
  }

  @override
  String backupSyncLastError(String error) {
    return '上次错误：$error';
  }

  @override
  String get backupSyncSignOutConfirm => '在此设备上退出 Google Drive？';

  @override
  String get moreBackupSyncTileNeverSynced => '备份到 Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync => '已登录 · 尚无备份';

  @override
  String get backupSyncConnected => '已连接';

  @override
  String get backupSyncCompletedHint => '您的数据已安全备份到 Google Drive。';

  @override
  String get backupSyncPhaseExport => '导出';

  @override
  String get backupSyncPhaseUpload => '上传';

  @override
  String get backupAutoSettingsTitle => 'Google Drive 设置';

  @override
  String get backupAutoBackupTitle => '自动备份';

  @override
  String get backupAutoBackupHint => '到期时在应用启动时自动备份';

  @override
  String get backupWifiOnlyTitle => '仅通过 Wi‑Fi 备份';

  @override
  String get backupWifiOnlyHint => '自动备份等待 Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => '使用移动数据';

  @override
  String get backupAutoFrequencyTitle => '备份频率';

  @override
  String get backupAutoFrequencyOff => '关闭';

  @override
  String get backupAutoFrequencyDaily => '每天';

  @override
  String get backupAutoFrequencyWeekly => '每周';

  @override
  String get backupAutoFrequencyMonthly => '每月';

  @override
  String get backupAutoSyncDirectionTitle => '自动同步';

  @override
  String get backupAutoDirectionUpload => '上传到云端';

  @override
  String get backupAutoDirectionDownload => '从云端下载';

  @override
  String get backupAutoDirectionBoth => '上传和下载';

  @override
  String backupAutoLastUploaded(String detail) {
    return '上次自动备份：$detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return '上次自动恢复：$detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return '上次自动同步失败：$detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return '上次自动同步已跳过：$detail';
  }

  @override
  String get restoreAction => '恢复';

  @override
  String get restoreFromGoogleDrive => '从 Google Drive 恢复';

  @override
  String get restoreFromGoogleDriveHint => '登录并选择备份以在此设备上恢复组织。';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '恢复「$name」？这将替换该组织的本地数据。';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '已恢复 $name。您现在可以登录。';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return '恢复失败：$error';
  }

  @override
  String get restoreFromGoogleDriveEmpty => '在 Google Drive 中未找到备份。';

  @override
  String get restoreFromGoogleDriveStarting => '正在开始恢复…';

  @override
  String get restoreStepDownload => '正在下载备份';

  @override
  String get restoreStepCreateDatabase => '正在创建数据库';

  @override
  String get restoreStepImport => '正在导入数据';

  @override
  String get restoreStepFinalize => '正在完成恢复';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return '上次同步：$date';
  }

  @override
  String get security => '安全';

  @override
  String get appLockTitle => '应用锁定';

  @override
  String get appLockSubtitle => '重新打开应用时需要 PIN 或生物识别';

  @override
  String get appPin => '应用 PIN';

  @override
  String appPinSubtitle(int length) {
    return '使用 $length 位 PIN 快速解锁';
  }

  @override
  String get useBiometricUnlock => '使用 Face ID / 生物识别';

  @override
  String get useBiometricUnlockSubtitle => '设置 PIN 后使用指纹或 Face ID 解锁';

  @override
  String get changeAppPin => '更改 PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => '设置 PIN';

  @override
  String get confirmAppPin => '确认 PIN';

  @override
  String get enterAppPin => '输入 PIN';

  @override
  String get enterPasscode => '输入密码';

  @override
  String tapDigitsToUnlock(int length) {
    return '点击任意 $length 位数字解锁。';
  }

  @override
  String createPasscodeHint(int length) {
    return '为此组织选择 $length 位密码';
  }

  @override
  String get confirmPasscodeHint => '再次输入密码以确认';

  @override
  String createAppPinHint(int length) {
    return '为此组织选择 $length 位 PIN';
  }

  @override
  String get confirmAppPinHint => '再次输入 PIN 以确认';

  @override
  String get appPinMismatch => 'PIN 不匹配，请重试。';

  @override
  String get appPinIncorrect => 'PIN 不正确，请重试。';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN 不正确，还剩 $remaining 次尝试。';
  }

  @override
  String get appPinLockoutMessage => 'PIN 错误次数过多。请使用邮箱和密码登录以重置 PIN。';

  @override
  String get appPinSetSuccess => '已为此组织保存 PIN';

  @override
  String get appPinRemoved => '已移除应用 PIN';

  @override
  String get appLockSettingsSaved => '已保存应用锁定设置';

  @override
  String get biometricUnlockReason => '解锁 BizTrack';

  @override
  String get biometricNotAvailable => '此设备不支持生物识别';

  @override
  String get biometricRequiresPin => '启用生物识别前请先设置应用 PIN';

  @override
  String get disableAppPinTitle => '移除应用 PIN？';

  @override
  String get disableAppPinMessage => '此组织的 Face ID / 生物识别解锁也将关闭。';

  @override
  String get verifyPinToRemoveTitle => '输入 PIN';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return '确认 $length 位 PIN 以移除应用锁定';
  }

  @override
  String get unlockApp => '解锁应用';

  @override
  String get usePinInstead => '改用 PIN';

  @override
  String get useBiometricInstead => '使用生物识别';

  @override
  String get signInWithFaceId => '使用 Face ID 登录';

  @override
  String get signInWithFingerprint => '使用指纹登录';

  @override
  String get signInWithBiometric => '使用生物识别登录';

  @override
  String get signInWithPin => '使用 PIN 登录';

  @override
  String get setUpQuickUnlock => '设置 PIN 快速登录';

  @override
  String get setUpFaceIdOrPin => '设置 Face ID 或 PIN';

  @override
  String get setUpFingerprintOrPin => '设置指纹或 PIN';

  @override
  String get setUpQuickUnlockSubtitle => '为此组织使用生物识别或 PIN';

  @override
  String quickUnlockAsUser(String email) {
    return '以 $email 快速登录';
  }

  @override
  String get orContinueWithPassword => '或使用密码登录';

  @override
  String get setUpQuickUnlockAfterLoginTitle => '启用快速登录？';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      '设置 Face ID、指纹或 PIN，以便下次更快登录。可在设置中稍后更改。';

  @override
  String get notNow => '以后再说';

  @override
  String get setUpNow => '立即设置';

  @override
  String get enableFaceIdTitle => '启用 Face ID？';

  @override
  String get enableFingerprintTitle => '启用指纹？';

  @override
  String get enableBiometricTitle => '启用生物识别？';

  @override
  String get enableBiometricAfterPinMessage => '将设备生物识别与 PIN 一起使用，以便更快登录。';

  @override
  String get useFaceIdUnlock => '使用 Face ID';

  @override
  String get useFingerprintUnlock => '使用指纹';

  @override
  String get ok => '确定';

  @override
  String get reportPeriodYear => '年';

  @override
  String get reportPeriodMonth => '月';

  @override
  String get reportPeriodRange => '范围';

  @override
  String get reportPeriodDay => '日';

  @override
  String get reportPeriodFrom => '从';

  @override
  String get reportPeriodTo => '至';

  @override
  String get reportPeriod => '期间';

  @override
  String get reportAllPurchases => '全部采购';

  @override
  String get reportBeforeTax => '税前';

  @override
  String get reportRevenueRetained => '留存收入';

  @override
  String get reportHideDetails => '隐藏详情';

  @override
  String get reportShowDetails => '显示详情';

  @override
  String get reportSalesRevenue => '销售收入';

  @override
  String get reportDiscountsGiven => '已给折扣';

  @override
  String get reportNetRevenue => '净收入';

  @override
  String get reportOperatingExpenses => '营业费用';

  @override
  String get reportTotalExpenses => '费用合计';

  @override
  String get reportGrossProfit => '毛利润';

  @override
  String get reportGrossProfitChart => '毛利润';

  @override
  String get reportOperatingPlDisclaimer => '尚未计入税费、折旧及薪酬负债 — 营业层面损益估算。';

  @override
  String get reportContraLabel => '对冲';

  @override
  String get reportNoDataForPeriod => '所选期间无数据';

  @override
  String get reportRevenueVsExpenses => '收入 vs 费用';

  @override
  String get reportExpenseBreakdown => '费用明细';

  @override
  String get reportExpenseFallback => '费用';

  @override
  String get reportGrossMarginPercent => '毛利率 %';

  @override
  String get reportRoomVsFnB => '客房 vs 餐饮';

  @override
  String get reportSegmentRoom => '客房';

  @override
  String get reportSegmentFnB => '餐饮';

  @override
  String get reportKeyMetrics => '关键指标';

  @override
  String get reportIncomeStatement => '损益表';

  @override
  String get reportChartsSection => '图表';

  @override
  String get reportSegmentSummary => '分部汇总';

  @override
  String get reportFailedToLoad => '加载报告失败';

  @override
  String get reportOverview => '概览';

  @override
  String get reportOverviewCash => '现金';

  @override
  String get reportOverviewBank => '银行';

  @override
  String get reportMonthlyOpeningBalance => '月初余额';

  @override
  String get reportOpeningBalanceHint => '每月月初现金状况';

  @override
  String get reportCashInOut => '现金收支';

  @override
  String get reportCashIn => '现金收入';

  @override
  String get reportCashOut => '现金支出';

  @override
  String get reportBankReceiptsPayments => '银行收付';

  @override
  String get reportReceipts => '收款';

  @override
  String get reportPayments => '付款';

  @override
  String get reportDailyCashVsQr => '每日现金 vs QR';

  @override
  String get reportSummariesSection => '汇总';

  @override
  String get reportCashSummary => '现金汇总';

  @override
  String get reportBankSummary => '银行汇总';

  @override
  String get reportDailySummary => '每日汇总';

  @override
  String get reportTabPurchase => '采购';

  @override
  String get reportTabSales => '销售';

  @override
  String get reportTabDashboard => '仪表盘';

  @override
  String get reportSingleDayTrend => '单日 — 每日趋势';

  @override
  String get reportFullYearTrend => '全年 — 月度趋势图';

  @override
  String reportYearLabel(String year) {
    return '$year年';
  }

  @override
  String reportJanDec(String year) {
    return '1月 – 12月 $year';
  }

  @override
  String get reportTotalPurchases => '采购合计';

  @override
  String get reportTotalSales => '销售合计';

  @override
  String get reportTotalInvoices => '发票合计';

  @override
  String get reportUnpaidBalance => '未付余额';

  @override
  String get reportAvgPerInvoice => '每张发票平均';

  @override
  String get reportPerTransaction => '每笔交易';

  @override
  String reportMonthlySpend(String symbol) {
    return '月支出 ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return '月销售额 ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => '按月发票数量';

  @override
  String reportTopItemsBySpend(String symbol) {
    return '支出排名项目 ($symbol)';
  }

  @override
  String get reportSpendByCategory => '按类别支出';

  @override
  String get reportOtherCategory => '其他';

  @override
  String get reportSuppliers => '供应商';

  @override
  String get reportTableSupplier => '供应商';

  @override
  String get reportTableAmount => '金额';

  @override
  String get reportTableBills => '账单';

  @override
  String get reportSalesTotal => '销售合计';

  @override
  String get reportPurchaseTotal => '采购合计';

  @override
  String get reportPositiveMargin => '正利润率';

  @override
  String get reportNegativeMargin => '负利润率';

  @override
  String get reportGrossMargin => '毛利率';

  @override
  String get reportOfTotalSales => '占销售总额';

  @override
  String get reportFailedToLoadAnalytics => '加载分析失败';

  @override
  String get reportMarginKpi => '利润率';

  @override
  String get reportExpensesKpi => '费用';

  @override
  String partyPickerNoResultsFor(String query) {
    return '未找到“$query”的结果';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return '未找到$role往来单位';
  }

  @override
  String get partyPickerLoadParties => '加载往来单位';

  @override
  String get invoiceCashCustomer => '现金客户';

  @override
  String get invoiceQuickAddItemsTitle => '快速添加项目';

  @override
  String get invoiceQuickLoadingMenu => '正在加载菜单…';

  @override
  String get invoiceQuickInvoiceCreated => '发票已创建';

  @override
  String get invoiceQuickAddAtLeastOneItem => '请至少添加一项';

  @override
  String get invoiceQuickNoResults => '未找到结果！';

  @override
  String get invoiceQuickNoItemsInCategory => '该分类下无项目';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => '添加项目';

  @override
  String get invoiceQuickLoadMore => '加载更多';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return '滚动加载更多（每页 $count 项）';
  }

  @override
  String get invoiceQuickSupplierEmployee => '供应商 / 员工';

  @override
  String get invoiceQuickEditItem => '编辑项目';

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
  String get closeSelectDateRange => '选择日期范围';

  @override
  String get closeStartDate => '开始日期';

  @override
  String get closeEndDate => '结束日期';

  @override
  String get closeSelectBothDates => '请选择开始和结束日期';

  @override
  String get closeDeleteSummary => '删除汇总';

  @override
  String get closeDeleteSummaryConfirm => '确定要删除此汇总吗？';

  @override
  String get closeSelectDate => '选择日期';

  @override
  String get closeNoDataToExport => '没有可导出的数据';

  @override
  String get closeNoDataToShare => '没有可分享的数据';

  @override
  String get closeNoDataToPrint => '没有可打印的数据';

  @override
  String closePdfGenerateError(String error) {
    return '生成 PDF 出错：$error';
  }

  @override
  String closePdfShareError(String error) {
    return '分享 PDF 出错：$error';
  }

  @override
  String closePdfPrintError(String error) {
    return '打印 PDF 出错：$error';
  }

  @override
  String get closeExportPdf => '导出为 PDF';

  @override
  String get closeSharePdf => '分享 PDF';

  @override
  String get closePrint => '打印';

  @override
  String get closeExportOptions => '导出选项';

  @override
  String get closeExportPdfSubtitle => '保存或查看 PDF 文档';

  @override
  String get closeSharePdfSubtitle => '通过应用或电子邮件分享';

  @override
  String get closePrintSubtitle => '打印报告';

  @override
  String get closeDailyCashSummaryTitle => '每日现金汇总';

  @override
  String get closeDailyCashSummaryReport => '每日现金汇总报告';

  @override
  String closeGeneratedAt(String date) {
    return '生成时间：$date';
  }

  @override
  String get closeTotalRecords => '记录总数';

  @override
  String get closeSummaryOverview => '汇总概览';

  @override
  String get closeAllRecords => '全部记录';

  @override
  String closePeriodRange(String start, String end) {
    return '期间：$start 至 $end';
  }

  @override
  String get closeDetails => '详情';

  @override
  String closePageN(int n) {
    return '第$n页';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return '显示 $shown / $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return '已加载：$count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => '客房 / 舱位 / 员工';

  @override
  String reportPercentOfRevenue(String percent) {
    return '占收入 $percent%';
  }

  @override
  String get reportParties => '往来单位';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — 每日趋势图';
  }

  @override
  String get invoiceQuickCart => '购物车';

  @override
  String invoiceQuickCartWithCount(int count) {
    return '购物车 ($count)';
  }

  @override
  String get invoiceQuickClearSearch => '清除搜索';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => '添加摘要';

  @override
  String get closeSalesAmount => '销售额';

  @override
  String get closeClosingBalance => '期末余额';

  @override
  String get closeLostMoney => '丢失金额';

  @override
  String get closeDiscount => '折扣';

  @override
  String get closeExpenses => '支出';

  @override
  String get closeUnpaid => '未付';

  @override
  String get closeTotalOpeningBalance => '期初余额合计';

  @override
  String get closeTotalSalesAmount => '销售总额';

  @override
  String get closeTotalCashAmount => '现金总额';

  @override
  String get closeTotalQrAmount => 'QR总额';

  @override
  String get closeTotalDiscount => '折扣合计';

  @override
  String get closeTotalExpenses => '支出合计';

  @override
  String get closeTotalClosingBalance => '期末余额合计';

  @override
  String get closeTotalLostMoney => '丢失金额合计';

  @override
  String get closeTotalExtraAmount => '额外金额合计';

  @override
  String get closeShowingCurrentMonth => '显示本月数据';

  @override
  String get closeNoSummariesFound => '未找到摘要';

  @override
  String get closeNoSummariesAvailable => '暂无摘要';

  @override
  String get closeTryAdjustingDateRange => '请尝试调整日期范围';

  @override
  String get closeCreateFirstSummary => '创建第一个摘要以开始';

  @override
  String get closeClearFilter => '清除筛选';

  @override
  String get closeFiltered => '已筛选';

  @override
  String closeFilteredWithRange(String range) {
    return '已筛选：$range';
  }

  @override
  String get closeSummarySingular => '摘要';

  @override
  String get closeSummariesPlural => '摘要';

  @override
  String get closeSummaryUpdatedSuccess => '摘要更新成功';

  @override
  String get closeSummaryDeletedSuccess => '摘要删除成功';

  @override
  String premiumUnlockTitle(String appName) {
    return '解锁 $appName Premium';
  }

  @override
  String get premiumTagline => '完整离线 POS、开票、库存和报表 — 一项订阅满足您的业务需求。';

  @override
  String get premiumFeatureUnlimitedInvoices => '无限发票和收据';

  @override
  String get premiumFeatureInventoryStock => '库存与进销存跟踪';

  @override
  String get premiumFeatureReportsAnalytics => '销售报表与分析';

  @override
  String get premiumFeatureOfflineLocal => '离线可用 — 数据保存在本地';

  @override
  String premiumContinueWith(String plan) {
    return '继续使用 $plan';
  }

  @override
  String get premiumRestorePurchases => '恢复购买';

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
      '费用将从您的 Apple ID 扣款。除非在周期结束前至少 24 小时取消，否则订阅将自动续订。';

  @override
  String get premiumPurchaseRestored => '购买已恢复。';

  @override
  String get premiumNoActiveSubscription => '未找到有效订阅。';

  @override
  String get premiumPlanMonthly => '月付';

  @override
  String get premiumPlanMonthlySubtitle => '灵活 — 随时取消';

  @override
  String get premiumPlanYearly => '年付';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return '最划算 — 节省 $percent%';
  }

  @override
  String get premiumPlanLifetime => '终身';

  @override
  String get premiumPlanLifetimeSubtitle => '一次付费，永久使用';

  @override
  String get premiumPlanPopular => '热门';

  @override
  String get premiumOneTimePurchase => '一次性购买';

  @override
  String get subscriptionSectionTitle => '订阅';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => '升级到 Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return '月付 $monthly · 年付 $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan 有效至 $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan 已激活';
  }

  @override
  String get premiumRequired => '需要 Premium';

  @override
  String get upgradeToPremiumContinue => '升级到 Premium 以继续。';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return '免费版最多允许 $limit $label。升级到 Premium 可无限制使用。';
  }

  @override
  String get freemiumPartyRoleRequired => '必须选择往来方角色。';

  @override
  String get freemiumLabelSalesInvoices => '销售发票';

  @override
  String get freemiumLabelPurchaseInvoices => '采购发票';

  @override
  String get freemiumLabelEmployees => '员工';

  @override
  String get freemiumLabelItems => '商品';

  @override
  String get freemiumLabelCategories => '分类';

  @override
  String get freemiumLabelPaymentMethods => '支付方式';

  @override
  String get freemiumLabelCustomPartyRoles => '自定义往来方角色';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return '$role 的往来方';
  }

  @override
  String get freemiumLabelOrganizations => '组织';

  @override
  String get freemiumPremiumReports => '报表需 Premium 才能使用。';

  @override
  String get freemiumPremiumBackupSync => '备份与同步需要 Premium。';

  @override
  String get freemiumPremiumPayroll => '工资功能需要 Premium。';

  @override
  String get freemiumPremiumAttendance => '考勤需要 Premium。';

  @override
  String get freemiumPremiumStock => '库存管理需要 Premium。';

  @override
  String get freemiumPremiumInvoiceExport => '下载和打印需要 Premium。';

  @override
  String get shiftReminderOpeningTitle => '开店提醒';

  @override
  String get shiftReminderOpeningMessage => '今天的收银台开了吗？';

  @override
  String get shiftReminderOpeningProceed => '是，现在开店';

  @override
  String get shiftReminderClosingTitle => '关店提醒';

  @override
  String get shiftReminderClosingMessage => '今天的收银台关了吗？';

  @override
  String get shiftReminderClosingProceed => '是，现在关店';

  @override
  String get shiftReminderSkipToday => '今天跳过';

  @override
  String get shiftReminderOpeningNotificationTitle => '开店提醒';

  @override
  String get shiftReminderOpeningNotificationBody => '今天的收银台开了吗？若仍需开店，请点按此处。';

  @override
  String get shiftReminderClosingNotificationTitle => '关店提醒';

  @override
  String get shiftReminderClosingNotificationBody => '今天的收银台关了吗？若仍需关店，请点按此处。';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business 向客户支付二维码；客户提供现金。';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business 向客户支付现金；客户提供二维码付款。';
  }

  @override
  String get closePaymentExchange => '支付互换';

  @override
  String get closePayQrGetCashExchangeLabel => '二维码支付 → 收取现金（互换）';

  @override
  String get closePayCashGetQrExchangeLabel => '支付现金 → 收取二维码（互换）';

  @override
  String get closePayQrGetCashDetail => '二维码支付收现金';

  @override
  String get closePayCashGetQrDetail => '现金支付收二维码';

  @override
  String get faqSectionPremium => 'Premium 与账单';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium 包含哪些内容？';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium 解锁无限发票、完整报表（损益、对账单、分析）、备份与同步、工资、考勤、库存工具、发票导出/打印以及额外组织。免费版仍可在合理限制内使用核心 POS 功能。';

  @override
  String get faqPremiumFreeTierQuestion => '免费版包含什么？';

  @override
  String get faqPremiumFreeTierAnswer =>
      '最多可创建 10 张销售和 10 张采购发票、4 名员工、30 个商品，达到上限时会显示其他限制。开店、关店、计算器和浏览数据仍免费。';

  @override
  String get faqPremiumRestoreQuestion => '如何恢复购买？';

  @override
  String get faqPremiumRestoreAnswer =>
      '打开更多 → 升级到 Premium（或付费墙），点按恢复购买。请使用订阅时的同一 Apple ID。';

  @override
  String get faqPremiumCancelQuestion => '如何取消订阅？';

  @override
  String get faqPremiumCancelAnswer =>
      '在 iPhone 设置 → Apple ID → 订阅 中管理或取消。付费周期结束前仍可访问。';

  @override
  String get faqDarkModeQuestion => '如何开启深色模式？';

  @override
  String get faqDarkModeAnswer => '打开更多 → 外观，启用深色模式。设备使用系统主题时，应用会自动跟随。';

  @override
  String get faqOpeningClosingReminderQuestion => '什么是开店和关店提醒？';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName 可提醒您开启或关闭每日收银台。您可以继续、今天跳过或关闭提醒。';
  }

  @override
  String get faqPartyRolesQuestion => '什么是往来方角色？';

  @override
  String get faqPartyRolesAnswer =>
      '往来方角色用于分类客户、供应商、房间或员工等联系人。可在运营 → 往来方角色 中自定义，并为团队添加简短说明。';

  @override
  String faqRateAppQuestion(String appName) {
    return '如何评价 $appName？';
  }

  @override
  String get faqRateAppAnswer =>
      '打开更多 → 为我们评分，在 App Store 留下评价。您的反馈有助于我们改进离线开票体验。';
}
