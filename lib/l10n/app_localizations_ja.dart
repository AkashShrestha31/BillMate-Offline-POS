// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get noInternetConnection => 'インターネットに接続されていません。';

  @override
  String get formatException => 'フォーマット例外';

  @override
  String get rememberMe => 'ログイン情報を保存';

  @override
  String get signIn => 'サインイン';

  @override
  String get passwordHint => 'パスワードを入力';

  @override
  String get forgetPassword => 'ログイン情報をお忘れですか？';

  @override
  String get okay => 'OK';

  @override
  String get success => '成功';

  @override
  String get hotel => 'ホテル';

  @override
  String get errorEncountered => 'エラーが発生しました';

  @override
  String get serverError => 'サーバーエラー';

  @override
  String get requestFailed => 'リクエスト失敗';

  @override
  String get connectionTimedOut => '接続がタイムアウトしました';

  @override
  String get password => 'パスワード';

  @override
  String get keepSignIn => 'サインインを維持';

  @override
  String get enterPassword => 'パスワードを入力';

  @override
  String get enterValidPassword => '有効なパスワードを入力してください';

  @override
  String get skip => 'スキップ';

  @override
  String get pleaseWait => 'お待ちください…';

  @override
  String get enterValidUserName => '有効なユーザー名を入力してください。';

  @override
  String get userName => 'ユーザー名';

  @override
  String get or => 'または';

  @override
  String get retry => '再試行';

  @override
  String get error => 'エラー';

  @override
  String get supportMessage => '管理者にお問い合わせください。';

  @override
  String get responseMessage404 => '404エラー';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'バージョン $version';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get close => '閉じる';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get deleteOrganizationTitle => '組織を削除しますか？';

  @override
  String deleteOrganizationMessage(String name) {
    return '$name をこのデバイスから削除します。この組織のすべてのローカルデータが削除されます。';
  }

  @override
  String get deleteOrganizationWarning => 'この操作は元に戻せません。';

  @override
  String get organizationDeleted => '組織が削除されました';

  @override
  String get confirm => '確認';

  @override
  String get done => '完了';

  @override
  String get next => '次へ';

  @override
  String get getStarted => '始める';

  @override
  String get walkthroughDashboardTitle => 'ビジネス全体を一目で';

  @override
  String get walkthroughDashboardDescription =>
      '本日の売上、収益、未収残高 — アプリを開くとすぐに見えるダッシュボード。';

  @override
  String get walkthroughOfflineTitle => 'インターネットなしでも動作';

  @override
  String get walkthroughOfflineDescription =>
      '完全オフラインで請求書作成、経費記録、在庫管理。オンライン復帰時に自動同期。';

  @override
  String get walkthroughBillingTitle => '数秒で請求と販売';

  @override
  String get walkthroughBillingDescription =>
      '売上・仕入請求書、キッチンチケット付きテーブル注文、ライブ在庫 — すべて1つのアプリで。';

  @override
  String get walkthroughStaffTitle => 'スタッフ、給与、レポート';

  @override
  String get walkthroughStaffDescription =>
      '勤怠と給与を管理し、P&Lと給与明細をPDF出力 — 追加ツール不要。';

  @override
  String get walkthroughBackupTitle => 'データは常に安全';

  @override
  String get walkthroughBackupDescription =>
      'ワンタップGoogle Driveバックアップで銀行レベルのセキュリティ — データを保護し簡単に復元。';

  @override
  String get walkthroughReadyTitle => '準備ができたらすぐに';

  @override
  String get walkthroughReadyDescription =>
      '数分で組織をセットアップし、今日からスマートにビジネスを運営。始めましょう。';

  @override
  String get back => '戻る';

  @override
  String get submit => '送信';

  @override
  String get continueAction => '続ける';

  @override
  String get createAction => '作成';

  @override
  String get connectOrganizationTitle => '組織を接続する';

  @override
  String get connectOrganizationSubtitle => 'サインインする組織を選択してください。';

  @override
  String get selectOrganization => '組織';

  @override
  String get selectOrganizationHint => '組織をタップして続けてください';

  @override
  String get noSavedOrganizationsYet => '組織がまだありません。作成するか、下のテストデータを使用してください。';

  @override
  String get orgConnectOnceInfo =>
      'これはアプリをビジネスアカウントにリンクします。デバイスごとに一度だけ設定する必要があります。';

  @override
  String organizationCodeLabel(String code) {
    return 'コード: $code';
  }

  @override
  String get tryAgain => '再試行';

  @override
  String get warning => '警告';

  @override
  String get loading => '読み込み中…';

  @override
  String get comingSoon => '近日公開';

  @override
  String get required => '必須';

  @override
  String get search => '検索';

  @override
  String get add => '追加';

  @override
  String get edit => '編集';

  @override
  String get remove => '削除';

  @override
  String get view => '表示';

  @override
  String get export => 'エクスポート';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'インポート';

  @override
  String get refresh => '更新';

  @override
  String get select => '選択';

  @override
  String get upload => 'アップロード';

  @override
  String get download => 'ダウンロード';

  @override
  String get share => '共有';

  @override
  String get filter => 'フィルター';

  @override
  String get sort => '並び替え';

  @override
  String get apply => '適用';

  @override
  String get reset => 'リセット';

  @override
  String get clear => 'クリア';

  @override
  String get all => 'すべて';

  @override
  String get none => 'なし';

  @override
  String get total => '合計';

  @override
  String get subtotal => '小計';

  @override
  String get grandTotal => '総計';

  @override
  String get amount => '金額';

  @override
  String get quantity => '数量';

  @override
  String get rate => '単価';

  @override
  String get discount => '割引';

  @override
  String get paid => '支払済';

  @override
  String get unpaid => '未払い';

  @override
  String get credit => 'クレジット';

  @override
  String get cash => '現金';

  @override
  String get date => '日付';

  @override
  String get time => '時刻';

  @override
  String get name => '名前';

  @override
  String get email => 'メール';

  @override
  String get phone => '電話';

  @override
  String get address => '住所';

  @override
  String get notes => 'メモ';

  @override
  String get description => '説明';

  @override
  String get status => '状態';

  @override
  String get type => '種類';

  @override
  String get category => 'カテゴリ';

  @override
  String get party => '取引先';

  @override
  String get item => '品目';

  @override
  String get payment => '支払い';

  @override
  String get settlement => '決済';

  @override
  String get opening => '期首';

  @override
  String get closing => '期末';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => '経費';

  @override
  String get revenue => '収益';

  @override
  String get profit => '利益';

  @override
  String get loss => '損失';

  @override
  String get sales => '売上';

  @override
  String get purchase => '仕入';

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
  String get more => 'もっと見る';

  @override
  String get profile => 'プロフィール';

  @override
  String get operations => '運営';

  @override
  String get operationManagement => '運営管理';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => '従業員管理';

  @override
  String get employeeManagementSubtitle => 'スタッフ、給与、勤怠';

  @override
  String get report => 'レポート';

  @override
  String get reportSubtitle => '損益、報告書、分析';

  @override
  String get helpAndSupport => 'ヘルプとサポート';

  @override
  String get preferences => '設定';

  @override
  String get dataAndBackup => 'データとバックアップ';

  @override
  String get privacyAndPolicies => 'プライバシーとポリシー';

  @override
  String get faq => 'よくある質問';

  @override
  String get contactSupport => 'サポートに連絡';

  @override
  String get rateUs => '評価する';

  @override
  String get rateUsSubtitle => 'BizTrackを楽しんでいますか？Google Playでレビューを残してください';

  @override
  String get rateUsUnavailable => 'ストアを開けませんでした。後でもう一度お試しください。';

  @override
  String get reportProblem => '問題を報告';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get contactUsSubtitle => 'サポート、フィードバック、アプリに関するご質問はこちら。';

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
  String get developerLabel => '開発者';

  @override
  String get emailCopiedToClipboard => 'メールをクリップボードにコピーしました';

  @override
  String get logout => 'ログアウト';

  @override
  String get signOut => 'サインアウト';

  @override
  String get settings => '設定';

  @override
  String get testData => 'テストデータ';

  @override
  String get loginWithTestData => 'テストデータでログイン';

  @override
  String get loginWithTestDataSubtitle => 'デモホテルデータを読み込んで自動サインイン';

  @override
  String testDataLoginFailed(String error) {
    return 'テストデータを読み込めませんでした: $error';
  }

  @override
  String get preparingTestData => 'デモデータを準備中…';

  @override
  String get regionAndCurrency => '地域と通貨';

  @override
  String get reportingCurrency => '報告通貨';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · 例 $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return '通貨が $code ($symbol) に設定されました';
  }

  @override
  String currencyUpdateFailed(String error) {
    return '通貨を更新できませんでした: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return '$appName のセットアップ';
  }

  @override
  String get setupSubtitle => '組織と会計を設定してください — オフライン使用のためにこのデバイスに保存されます。';

  @override
  String get setupOrganizationName => '組織名';

  @override
  String get setupCompanyName => '会社名';

  @override
  String get setupBusinessType => 'ビジネスタイプ';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => 'ホテル';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => 'レストラン';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => 'ホテル＆レストラン';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => '小売 / ショップ';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'カフェ / ベーカリー';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'バー / パブ';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'その他';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'タイプ: $type';
  }

  @override
  String get organizationSettings => '組織';

  @override
  String get editOrganizationInfo => '組織情報';

  @override
  String get editOrganizationInfoSubtitle =>
      'このビジネスのアプリ上の表示方法を更新します。組織コードは変更できません。';

  @override
  String get organizationCode => '組織コード';

  @override
  String get organizationCodeReadOnly => 'このコードはセットアップ後に固定されます。';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => '組織情報が保存されました';

  @override
  String get organizationInfoLoadFailed => '組織情報を読み込めませんでした';

  @override
  String organizationInfoSaveFailed(String error) {
    return '組織情報を保存できませんでした: $error';
  }

  @override
  String get organizationTabGeneral => '一般';

  @override
  String get organizationTabRegional => '地域と会計';

  @override
  String get organizationRegionalSubtitle => '国、報告通貨、会計年度の日付。';

  @override
  String get organizationTabAccounting => '会計';

  @override
  String get organizationAccountingSubtitle => '請求書と金額表示の設定。';

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
  String get displayPrecision => '表示精度';

  @override
  String get displayPrecisionRange => '0から5の数字を入力';

  @override
  String get enableInvoiceReturns => '請求書返品を有効化';

  @override
  String get enableInvoiceReturnsSubtitle => '支払済み請求書からの返品作成を許可。';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get setupFullName => 'フルネーム';

  @override
  String get setupConfirmPassword => 'パスワードを確認';

  @override
  String get setupBankName => '銀行名';

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
  String get setupRegionStepTitle => '地域と通貨';

  @override
  String get setupOrganizationStepTitle => '組織';

  @override
  String get setupOrganizationStepSubtitle => 'アプリでのビジネスの表示方法';

  @override
  String get setupAdminStepTitle => '管理者アカウント';

  @override
  String get setupAdminStepSubtitle => 'このインストールの主要ユーザー';

  @override
  String get setupAccountingStepTitle => '会計';

  @override
  String get setupAccountingStepSubtitle => '銀行、勘定科目表、会計年度';

  @override
  String get setupCompleteSetup => 'セットアップを完了';

  @override
  String fieldRequired(String field) {
    return '$field は必須です';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => '有効なメールアドレスを入力してください';

  @override
  String passwordMinLength(int min) {
    return 'パスワードは$min文字以上である必要があります';
  }

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get setupFixValidationErrors => '続けるには以下のエラーを修正してください';

  @override
  String get setupCompleteSuccess => 'セットアップが正常に完了しました';

  @override
  String get setupCompleteWithPdfSuccess => 'セットアップ完了。PDFを安全な場所に保存してください。';

  @override
  String setupPdfFailed(String error) {
    return 'セットアップは完了しましたが、PDFを保存できませんでした: $error';
  }

  @override
  String get setupFailed => 'セットアップを完了できませんでした。再試行してください。';

  @override
  String setupFailedWithDetails(String error) {
    return 'セットアップ失敗: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'ロケールとレポート通貨。';

  @override
  String get country => '国';

  @override
  String get currency => '通貨';

  @override
  String get selectCountry => '国を選択';

  @override
  String get language => '言語';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get languageChangeLaterHint => '後から設定で変更できます';

  @override
  String languageSelectionSubtitle(String appName) {
    return '$appName の使い方を選択してください。後から設定で変更できます。';
  }

  @override
  String get searchLanguages => '言語を検索';

  @override
  String get languageSuggestedBadge => 'おすすめ';

  @override
  String continueInLanguage(String languageName) {
    return '$languageName で続行';
  }

  @override
  String get noLanguageMatches => '一致なし';

  @override
  String noLanguageMatchesForQuery(String query) {
    return '\"$query\" に一致する言語がありません';
  }

  @override
  String get appearance => '外観';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get darkModeSubtitle => 'アプリ全体でダーク背景を使用';

  @override
  String get darkModeSystemSubtitle => 'デバイスのテーマに従う';

  @override
  String languageUpdated(String name) {
    return '言語が $name に設定されました';
  }

  @override
  String languageUpdateFailed(String error) {
    return '言語を更新できませんでした: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return '$appName へようこそ';
  }

  @override
  String forceUpdateMessage(String appName) {
    return '続行するには $appName の最新バージョンをインストールしてください。';
  }

  @override
  String generatedByApp(String appName) {
    return '$appName で作成';
  }

  @override
  String whatIsApp(String appName) {
    return '$appName とは？';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName は、売上・仕入れ請求書、取引先（顧客・仕入先）、在庫、支払い、従業員、日次サマリーをスマートフォンやタブレットから管理できます。';
  }

  @override
  String faqIntro(String appName) {
    return '$appName に関するよくある質問への回答。';
  }

  @override
  String get chooseFromGallery => 'ギャラリーから選択';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get photoLibrary => 'フォトライブラリ';

  @override
  String get addPhoto => '写真を追加';

  @override
  String couldNotPickImage(String error) {
    return '画像を選択できませんでした: $error';
  }

  @override
  String get unpaidAmount => '未払い 金額';

  @override
  String get unpaidBalance => '未払い';

  @override
  String unpaidColonAmount(String amount) {
    return '未払い: $amount';
  }

  @override
  String get previousUnpaid => '未払い';

  @override
  String get partyUnpaid => '未払い';

  @override
  String get loadingUnpaid => '未払い…';

  @override
  String get totalUnpaid => '未払い';

  @override
  String get unpaidAmountNotYetCollected => '未払い金額がまだ回収されていません。';

  @override
  String get partyUnpaidTabHint =>
      '従業員を開き、人物を選択し、プロフィールの取引先未払いをタップしてください。サーバーはこの検索に従業員IDが必要です。';

  @override
  String get partySettlementUsesUnpaidTotal => '取引先の精算は未払い合計を使用します。';

  @override
  String get selectPartyWithUnpaidFirst =>
      'まず精算金額を入力してください（または未払いのある取引先を選択してください）。';

  @override
  String get workspace => 'ワークスペース';

  @override
  String get change => '変更';

  @override
  String get addMoreOrganization => 'さらに追加 +';

  @override
  String get connectAnotherOrganization => '別の組織を接続';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'まだ保存された組織がありません。さらに追加 +を使用して接続してください。';

  @override
  String get registerNewOrganizationTitleSignedIn => '新しい組織を登録しますか？';

  @override
  String get registerNewOrganizationTitle => '新しい組織を登録しますか？';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'サインアウトされ、このデバイスに新しいビジネスを登録できるようにセットアップウィザードが最初から始まります。\n\nすでに保存した組織はセットアップ後もリストに残ります。';

  @override
  String get registerNewOrganizationMessageLogin =>
      'このデバイスに新しいビジネスを登録できるようにセットアップウィザードが始まります。作成するにはセットアップを完了してください。保存された組織はリストに残ります。';

  @override
  String get startSetup => 'セットアップを開始';

  @override
  String get enterOrganizationCode => '組織コードを入力してください';

  @override
  String get organizationNotFoundCheckCode =>
      '組織が見つかりませんでした。コードを確認して再試行してください。';

  @override
  String get organizationNotFound => '組織が見つかりません';

  @override
  String get couldNotVerifyOrganization => '組織を確認できませんでした';

  @override
  String noLocalDataCompleteSetup(String name) {
    return '$nameのローカルデータがありません。まずこの組織のセットアップを完了してください。';
  }

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get signInToContinue => '続けるにはサインインしてください';

  @override
  String get enterEmail => 'メールを入力';

  @override
  String get pleaseEnterEmail => 'メールアドレスを入力してください';

  @override
  String get pleaseEnterValidEmail => '有効なメールアドレスを入力してください';

  @override
  String get enterEmailLocalPartOnly => '@より前の部分のみ入力してください';

  @override
  String get pleaseEnterPassword => 'パスワードを入力してください';

  @override
  String get logIn => 'ログイン';

  @override
  String get searchCountry => '国を検索';

  @override
  String get searchCodeOrSymbol => 'コードまたは記号を検索';

  @override
  String get saveLoginDetailsTitle => 'ログイン情報を保存しますか？';

  @override
  String get saveLoginDetailsMessage =>
      'この組織のセットアップを完了しようとしています。\n\n組織コード、組織名、ログインメール、パスワードを含むPDFを安全にダウンロードしますか？安全な場所に保管してください — このファイルを持っている人は誰でもサインインできます。';

  @override
  String get downloadPdfAndContinue => 'PDFをダウンロードして続ける';

  @override
  String get continueWithoutPdf => 'PDFなしで続ける';

  @override
  String get legalDisplayNameHint => '法的 / 表示名';

  @override
  String get chartOfAccounts => '勘定科目表';

  @override
  String get fiscalYearStart => '会計年度開始';

  @override
  String get fiscalYearEnd => '会計年度終了';

  @override
  String get removeTestDataTitle => 'テストデータを削除しますか？';

  @override
  String get removeTestDataMessageDemoOrg =>
      'すべてのデモ販売、購入、連絡先、取引先、在庫品目、スタッフ、酒類計算機製品、追加のデモ組織が削除されます。\n\nデモ組織を使用中です — その後、自動的に最初の組織に切り替えられます。';

  @override
  String get removeTestDataMessageNormal =>
      'すべてのデモ販売、購入、連絡先、取引先、在庫品目、スタッフ、3つの追加デモ組織が削除されます。管理者アカウントと実際のセットアップデータは保持されます。';

  @override
  String get removeTestDataWarning => 'テストデータを再ロードしない限り、元に戻すことはできません。';

  @override
  String get removeTestData => 'テストデータを削除';

  @override
  String get keepTestData => 'テストデータを保持';

  @override
  String get demoDataRemoved => 'デモデータが削除されました';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'テストデータが削除されました。$nameに切り替えました。';
  }

  @override
  String get testDataRemoved => 'テストデータが削除されました';

  @override
  String couldNotRemoveTestData(String error) {
    return 'テストデータを削除できませんでした: $error';
  }

  @override
  String get loadTestDataTitle => 'テストデータをロードしますか？';

  @override
  String get loadTestDataMessage =>
      'デモ連絡先最大50件、販売専用在庫品目50件と購入専用50件、サンプル販売、購入、支払い、在庫、締め括り要約、スタッフ、給与、過去15日間の出勤、計算機用サンプル酒類製品が追加されます。';

  @override
  String get loadTestData => 'テストデータをロード';

  @override
  String get testDataLoaded => 'テストデータがロードされました';

  @override
  String couldNotLoadTestData(String error) {
    return 'テストデータをロードできませんでした: $error';
  }

  @override
  String get demoTestData => 'デモテストデータ';

  @override
  String get importTestDataSubtitle => 'すべての機能のテストデータをインポート';

  @override
  String get hideTestDataTitle => 'この組織のテストデータを非表示にしますか？';

  @override
  String get hideTestDataMessage =>
      '続けると、テストデータセクションがこの組織のすべての場所で非表示になります（セットアップを含む）。アプリを再インストールするか、この組織のアプリデータを削除することでのみ再度有効にできます。';

  @override
  String get hideTestDataWarning => 'すでにロードされたデモデータは、設定から削除するまでデータベースに残ります。';

  @override
  String get okHideTestData => 'OK、テストデータを非表示';

  @override
  String get testDataHiddenForOrg => 'この組織のテストデータが非表示になりました';

  @override
  String get hideTestDataTooltip => 'この組織のテストデータを非表示';

  @override
  String get partyRolesTitle => '取引先の役割';

  @override
  String get partyRolesMoreSubtitle => '顧客、仕入先、両方、およびその他';

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
  String get partyRoleCustomer => '顧客';

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
  String get searchRoles => '役割を検索';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の役割',
      one: '1件の役割',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'まだ役割がありません';

  @override
  String get noRolesYetHint => '連絡先に顧客、仕入先、両方、またはカスタム役割を追加してください。';

  @override
  String get addRole => '役割を追加';

  @override
  String get deleteRoleTitle => '役割を削除';

  @override
  String deleteRoleConfirm(String name) {
    return '「$name」を削除しますか？元に戻すことはできません。';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount件の取引先',
      one: '1件の取引先',
    );
    return '「$name」は$_temp0で使用されています。それらの取引先を別の役割に転送するか、強制削除して失ってください。';
  }

  @override
  String get transferParties => '取引先を転送';

  @override
  String get hardDeleteLoseParties => '強制削除（取引先を失う）';

  @override
  String get hardDeleteRoleTitle => '強制削除しますか？';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount件の取引先',
      one: '1件の取引先',
    );
    return 'これにより「$name」と割り当てられた$_temp0すべてが永久に削除されます。取引先データは復元できません。\n\n請求書または支払いに関連する取引先は削除できない場合があります — 代わりに転送を使用してください。';
  }

  @override
  String get deleteRoleAndParties => '役割と取引先を削除';

  @override
  String get addAnotherRoleBeforeDelete => 'この役割を削除する前に別の役割を追加してください。';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount件の取引先',
      one: '1件の取引先',
    );
    return '「$fromRole」から$_temp0を移動:';
  }

  @override
  String get transferAndDeleteRole => '転送して役割を削除';

  @override
  String get builtInRole => '組み込み';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の取引先',
      one: '1件の取引先',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'まだ取引先がありません';

  @override
  String get newRole => '新しい役割';

  @override
  String get editRole => '役割を編集';

  @override
  String get defaultRolesCannotEdit => 'デフォルトの役割は名前変更や削除ができません。';

  @override
  String get roleNameLabel => '役割名 *';

  @override
  String get roleNameHint => '例：顧客';

  @override
  String get roleDescriptionLabel => '説明';

  @override
  String get roleDescriptionHint => 'チームへの短いメモ';

  @override
  String get roleSortOrderLabel => '並び順';

  @override
  String get roleSortOrderHint => '小さい値がリストで先に表示されます';

  @override
  String get roleCreated => '役割が作成されました';

  @override
  String get roleUpdated => '役割が更新されました';

  @override
  String get roleDeleted => '役割が削除されました';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の取引先',
      one: '1件の取引先',
    );
    return '役割が削除されました。$_temp0が$targetRoleに移動されました。';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の取引先',
      one: '1件の取引先',
    );
    return '役割と$_temp0が削除されました。';
  }

  @override
  String get privacyPolicyTitle => 'プライバシーポリシー';

  @override
  String get termsAndConditions => '利用規約';

  @override
  String get logoutConfirmTitle => 'ログアウト';

  @override
  String get logoutConfirmMessage => 'アカウントからログアウトしてよろしいですか？';

  @override
  String get faqTapToExpand => '質問をタップして展開してください。';

  @override
  String get faqSectionGettingStarted => 'はじめに';

  @override
  String get faqSectionLogin => 'ログイン';

  @override
  String get faqSectionNavigation => 'ナビゲーション';

  @override
  String get faqSectionInvoices => '請求書';

  @override
  String get faqSectionPayments => '支払い';

  @override
  String get faqSectionItemsStock => '品目と在庫';

  @override
  String get faqSectionProfileEmployees => 'プロフィールと従業員';

  @override
  String get faqSectionDashboardReports => 'ダッシュボードとレポート';

  @override
  String get faqSectionSyncTroubleshooting => '同期とトラブルシューティング';

  @override
  String get faqNeedInternetQuestion => 'インターネットは必要ですか？';

  @override
  String get faqNeedInternetAnswer =>
      '初回ローカルセットアップ後は、インターネットなしで請求書、品目、支払いを記録できます。データはデバイスに保存されます。サーバーとの同期はオプションです。';

  @override
  String get faqFirstInstallQuestion => '初回インストール時は何が起きますか？';

  @override
  String get faqFirstInstallAnswer =>
      '短いチュートリアルが表示される場合があり、その後ローカルセットアップ（組織、会社、ログインメールとパスワード、通貨、会計年度）が行われます。その後、作成したメールとパスワードでサインインしてください。';

  @override
  String get faqSignInCredentialsQuestion => 'サインインに何を使いますか？';

  @override
  String get faqSignInCredentialsAnswer =>
      'セットアップのメールアドレスとパスワードです。アプリはその他からログアウトするまでサインイン状態を維持します。';

  @override
  String get faqLoggedOutQuestion => 'なぜログアウトされましたか？';

  @override
  String get faqLoggedOutAnswer =>
      'ログアウトを選択したか、アプリデータを削除したか、セッションが期限切れになりました。同じ認証情報で再サインインしてください。';

  @override
  String get faqBottomTabsQuestion => '下部タブは何をしますか？';

  @override
  String get faqBottomTabsAnswer =>
      'ホーム — ダッシュボードと概要。\n販売 — 日付別販売請求書。\n経費 — 購入 / 経費請求書。\n中央ボタン — 取引先（顧客、仕入先）。\nその他 — プロフィール、レポート、同期、ヘルプ、ログアウト。';

  @override
  String get faqCreateInvoiceQuestion => '販売または購入請求書をどのように作成しますか？';

  @override
  String get faqCreateInvoiceAnswer =>
      '販売または経費を開き、カレンダーで日付を選択し、+ボタンをタップし、品目と金額を追加し、必要に応じて取引先を選択して、保存または送信してください。';

  @override
  String get faqInvoiceDetailsQuestion => '請求書の詳細をどのように表示しますか？';

  @override
  String get faqInvoiceDetailsAnswer =>
      'リストで請求書をタップしてください。取引詳細に行品目、合計、割引、支払いが表示されます。そこから印刷、共有、複製、または支払いができます。';

  @override
  String get faqZeroRateQuestion => '詳細でレートまたは金額がゼロと表示される';

  @override
  String get faqZeroRateAnswer =>
      'これは通常、古い保存で行または支払いデータが欠落していたことを意味します。アプリを更新して、必要に応じて再作成または精算してください。';

  @override
  String get faqPartialPaymentQuestion => '部分支払いをどのように記録しますか？';

  @override
  String get faqPartialPaymentAnswer =>
      '請求書を開く → 取引詳細 → 支払いを行う。金額、方法、日付を入力して精算を処理してください。';

  @override
  String get faqMultiplePaymentQuestion => '複数支払いはどのように機能しますか？';

  @override
  String get faqMultiplePaymentAnswer =>
      '複数支払いをオンにして、編集をタップし、合計を現金、カード、QRなどに分割してください。各方法は別々に記録されます。';

  @override
  String get faqSplitPaymentSavedQuestion => '分割から1つの支払いのみ保存された';

  @override
  String get faqSplitPaymentSavedAnswer =>
      '最新のアプリバージョンに更新してください。古いバージョンは最初の分割行のみを保存することがありました。未払い残高がまだ間違っている場合は再精算してください。';

  @override
  String get faqAddItemQuestion => '品目をどのように追加しますか？';

  @override
  String get faqAddItemAnswer =>
      '販売フローまたはクイック追加から品目を追加を使用してください。名前、レート、単位、目的、オプションの写真（JPEG/PNG/GIF/WebP、最大5MB）を入力して品目を作成してください。';

  @override
  String get faqCustomUnitQuestion => 'カスタム単位をどのように追加しますか？';

  @override
  String get faqCustomUnitAnswer =>
      '品目フォームで、単位をタップ → リスト下部の新しい単位を作成、名前（例：リットル、箱）を入力して作成してください。';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion => '名前を変更したがプロフィールに古い名前が表示される';

  @override
  String get faqProfileNameAnswer =>
      '従業員レコードを編集して（ログインと同じメール）保存してください。その他タブとダッシュボードが更新されるはずです。';

  @override
  String get faqRevenueDetailsQuestion => '収益詳細とは何ですか？';

  @override
  String get faqRevenueDetailsAnswer =>
      '日次トレンドグラフ、純利益、未収売掛金、日別販売対購入の内訳を含む月次ビューです。カレンダーまたは月チップで月を変更してください。';

  @override
  String get faqOtherReportsQuestion => '他のレポートはどこにありますか？';

  @override
  String get faqOtherReportsAnswer =>
      'その他を開き、役割にアクセス権がある場合はレポート（分析、損益計算書など）の下を確認してください。';

  @override
  String get faqWhenSyncQuestion => 'いつ同期すべきですか？';

  @override
  String get faqWhenSyncAnswer =>
      '管理者に求められたときと、安定した接続がある場合のみ。同期はデバイスとサーバー間でデータを送受信します。';

  @override
  String get faqFabPositionQuestion => '+ボタンが販売 / 経費で高すぎる';

  @override
  String get faqFabPositionAnswer =>
      '下部ナビゲーションバーの上にあります。ボタンがデバイスのコンテンツと重なる場合は、リストをスクロールするかアプリを更新してください。';

  @override
  String get faqHowLogoutQuestion => 'どのようにログアウトしますか？';

  @override
  String get faqHowLogoutAnswer => 'その他 → 設定リストの一番下のログアウト。';

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
  String get statisticsQuickOperationsSeeAll => 'すべて表示';

  @override
  String get statisticsQuickOperationInvoice => '請求書';

  @override
  String get statisticsQuickOperationReports => 'レポート';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'キャッシュフロー';

  @override
  String get statisticsCashflowLast7Days => 'キャッシュフロー（過去7日間）';

  @override
  String get statisticsCashflowLast12Months => 'キャッシュフロー（過去12か月）';

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
  String get profitAndLoss => '損益';

  @override
  String get statementReport => '報告書';

  @override
  String get analytics => '分析';

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
  String get partyPickerSubtitle => 'この売上は誰向けですか？';

  @override
  String partyPickerSearchHint(String role) {
    return '$roleを検索…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return '新しい$roleを追加';
  }

  @override
  String get partyPickerSettled => '精算済み';

  @override
  String get partyPickerSelectedLabel => '選択済み';

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
  String get itemSelectCategoryRequired => 'カテゴリを選択してください';

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
  String get closeSummaryTitle => '締めサマリー';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint => '日付を選択し、更新をタップしてデータを読み込み';

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
  String get closeTotalSales => '売上合計';

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
  String get closePayCashGetQr => '現金支払い → QR受取';

  @override
  String get closePayQrGetCash => 'QR支払い → 現金受取';

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
  String get closeExportData => 'データをエクスポート';

  @override
  String get closeExportComingSoon => 'エクスポート機能はここに実装されます';

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
  String get googleDriveBackupSectionTitle => 'バックアップと同期';

  @override
  String get googleDriveBackupTitle => 'Google Driveバックアップ';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Google Driveに組織データを安全にバックアップするにはサインインしてください。';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return '$emailとしてサインイン';
  }

  @override
  String get googleDriveSignIn => 'Googleでサインイン';

  @override
  String get googleDriveSignOut => 'サインアウト';

  @override
  String get googleDriveBackupNow => '今すぐバックアップ';

  @override
  String get googleDriveSignInSuccess => 'Google Driveにサインインしました';

  @override
  String get googleDriveSignOutSuccess => 'Google Driveからサインアウトしました';

  @override
  String get googleDriveSignInCancelled => 'Googleサインインがキャンセルされました';

  @override
  String get googleDriveBackupStarting => 'バックアップを準備中…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'バックアップをアップロードしました（$tableCountテーブル、$recordCountレコード）';
  }

  @override
  String get googleDriveBackupPluginError =>
      'バックアップにはアプリの完全再起動が必要です。アプリを終了して再起動し、再試行してください。';

  @override
  String googleDriveBackupFailed(String error) {
    return 'バックアップ失敗: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return '最終バックアップ: $date';
  }

  @override
  String get backupSyncPageTitle => 'バックアップと同期';

  @override
  String get backupSyncGoogleAccount => 'Googleアカウント';

  @override
  String get backupSyncSignedInAs => 'サインイン中';

  @override
  String get backupSyncSignInHint => 'Googleでサインインして組織データをバックアップしてください。';

  @override
  String get backupSyncLastSyncTitle => '最終同期';

  @override
  String get backupSyncLastSyncDate => '日時';

  @override
  String get backupSyncNeverSynced => 'まだバックアップがアップロードされていません。';

  @override
  String get backupSyncOrganization => '組織';

  @override
  String get backupSyncTables => 'バックアップされたテーブル';

  @override
  String get backupSyncRecords => 'バックアップされたレコード';

  @override
  String get backupSyncStatus => 'ステータス';

  @override
  String get backupSyncStatusSuccess => '完了';

  @override
  String get backupSyncActiveOrganization => '現在の組織';

  @override
  String get backupSyncActiveOrganizationHint =>
      'バックアップは現在使用中の組織のデータをアップロードします。';

  @override
  String get backupSyncUnknownOrganization => '現在の組織';

  @override
  String get backupSyncInProgress => '同期中';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'ステップ: $step';
  }

  @override
  String get backupSyncStepExport => 'ローカルデータをエクスポート中';

  @override
  String backupSyncStepUploadTable(String table) {
    return '$tableをアップロード中';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return '$fileをアップロード中';
  }

  @override
  String backupSyncLastError(String error) {
    return '最後のエラー: $error';
  }

  @override
  String get backupSyncSignOutConfirm => 'このデバイスでGoogle Driveからサインアウトしますか？';

  @override
  String get moreBackupSyncTileNeverSynced => 'Google Driveにバックアップ';

  @override
  String get moreBackupSyncTileSignedInNoSync => 'サインイン済み · バックアップなし';

  @override
  String get backupSyncConnected => '接続済み';

  @override
  String get backupSyncCompletedHint => 'データはGoogle Driveに安全にバックアップされています。';

  @override
  String get backupSyncPhaseExport => 'エクスポート';

  @override
  String get backupSyncPhaseUpload => 'アップロード';

  @override
  String get backupAutoSettingsTitle => 'Google Drive設定';

  @override
  String get backupAutoBackupTitle => '自動バックアップ';

  @override
  String get backupAutoBackupHint => '期限が来たらアプリ起動時に自動バックアップ';

  @override
  String get backupWifiOnlyTitle => 'Wi‑Fiのみでバックアップ';

  @override
  String get backupWifiOnlyHint => '自動バックアップはWi‑Fiを待機します';

  @override
  String get backupWifiOnlyContinue => 'モバイルデータを使用';

  @override
  String get backupAutoFrequencyTitle => 'バックアップ頻度';

  @override
  String get backupAutoFrequencyOff => 'オフ';

  @override
  String get backupAutoFrequencyDaily => '毎日';

  @override
  String get backupAutoFrequencyWeekly => '毎週';

  @override
  String get backupAutoFrequencyMonthly => '毎月';

  @override
  String get backupAutoSyncDirectionTitle => '自動同期';

  @override
  String get backupAutoDirectionUpload => 'クラウドにアップロード';

  @override
  String get backupAutoDirectionDownload => 'クラウドからダウンロード';

  @override
  String get backupAutoDirectionBoth => 'アップロードとダウンロード';

  @override
  String backupAutoLastUploaded(String detail) {
    return '最後の自動バックアップ: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return '最後の自動復元: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return '最後の自動同期失敗: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return '最後の自動同期スキップ: $detail';
  }

  @override
  String get restoreAction => '復元';

  @override
  String get restoreFromGoogleDrive => 'Google Driveから復元';

  @override
  String get restoreFromGoogleDriveHint =>
      'サインインしてバックアップを選び、このデバイスで組織を復元してください。';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '「$name」を復元しますか？その組織のローカルデータが置き換わります。';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$nameを復元しました。サインインできます。';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return '復元失敗: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty => 'Google Driveにバックアップが見つかりません。';

  @override
  String get restoreFromGoogleDriveStarting => '復元を開始中…';

  @override
  String get restoreStepDownload => 'バックアップをダウンロード中';

  @override
  String get restoreStepCreateDatabase => 'データベース作成中';

  @override
  String get restoreStepImport => 'データをインポート中';

  @override
  String get restoreStepFinalize => '復元を完了中';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return '最終同期: $date';
  }

  @override
  String get security => 'セキュリティ';

  @override
  String get appLockTitle => 'アプリロック';

  @override
  String get appLockSubtitle => 'アプリを再度開く際にPINまたは生体認証が必要';

  @override
  String get appPin => 'アプリPIN';

  @override
  String appPinSubtitle(int length) {
    return '$length桁のPINでクイックロック解除';
  }

  @override
  String get useBiometricUnlock => 'Face ID / 生体認証を使用';

  @override
  String get useBiometricUnlockSubtitle => 'PIN設定後、指紋またはFace IDでロック解除';

  @override
  String get changeAppPin => 'PINを変更';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'PINを設定';

  @override
  String get confirmAppPin => 'PINを確認';

  @override
  String get enterAppPin => 'PINを入力';

  @override
  String get enterPasscode => 'パスコードを入力';

  @override
  String tapDigitsToUnlock(int length) {
    return 'ロック解除するには$length桁をタップ。';
  }

  @override
  String createPasscodeHint(int length) {
    return 'この組織用の$length桁パスコードを選択';
  }

  @override
  String get confirmPasscodeHint => '確認のためパスコードを再入力';

  @override
  String createAppPinHint(int length) {
    return 'この組織用の$length桁PINを選択';
  }

  @override
  String get confirmAppPinHint => '確認のためPINを再入力';

  @override
  String get appPinMismatch => 'PINが一致しません。もう一度お試しください。';

  @override
  String get appPinIncorrect => 'PINが正しくありません。もう一度お試しください。';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PINが正しくありません。残り$remaining回試せます。';
  }

  @override
  String get appPinLockoutMessage =>
      'PINの入力回数が上限を超えました。メールとパスワードでサインインしてPINをリセットしてください。';

  @override
  String get appPinSetSuccess => 'この組織のPINを保存しました';

  @override
  String get appPinRemoved => 'アプリPINを削除しました';

  @override
  String get appLockSettingsSaved => 'アプリロック設定を保存しました';

  @override
  String get biometricUnlockReason => 'BizTrackのロック解除';

  @override
  String get biometricNotAvailable => 'このデバイスでは生体認証を利用できません';

  @override
  String get biometricRequiresPin => '生体認証を有効にする前にアプリPINを設定してください';

  @override
  String get disableAppPinTitle => 'アプリPINを削除しますか？';

  @override
  String get disableAppPinMessage => 'この組織のFace ID / 生体認証ロック解除もオフになります。';

  @override
  String get verifyPinToRemoveTitle => 'PINを入力';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'アプリロックを解除するには$length桁PINを確認';
  }

  @override
  String get unlockApp => 'アプリのロック解除';

  @override
  String get usePinInstead => 'PINを使用';

  @override
  String get useBiometricInstead => '生体認証を使用';

  @override
  String get signInWithFaceId => 'Face IDでサインイン';

  @override
  String get signInWithFingerprint => '指紋でサインイン';

  @override
  String get signInWithBiometric => '生体認証でサインイン';

  @override
  String get signInWithPin => 'PINでサインイン';

  @override
  String get setUpQuickUnlock => 'PINクイックサインインを設定';

  @override
  String get setUpFaceIdOrPin => 'Face IDまたはPINを設定';

  @override
  String get setUpFingerprintOrPin => '指紋またはPINを設定';

  @override
  String get setUpQuickUnlockSubtitle => 'この組織で生体認証またはPINを使用';

  @override
  String quickUnlockAsUser(String email) {
    return '$emailとしてクイックサインイン';
  }

  @override
  String get orContinueWithPassword => 'またはパスワードでサインイン';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'クイックサインインを有効にしますか？';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      '次回の高速サインインのためFace ID、指紋、またはPINを設定。後から設定で変更できます。';

  @override
  String get notNow => '後で';

  @override
  String get setUpNow => '今すぐ設定';

  @override
  String get enableFaceIdTitle => 'Face IDを有効にしますか？';

  @override
  String get enableFingerprintTitle => '指紋を有効にしますか？';

  @override
  String get enableBiometricTitle => '生体認証を有効にしますか？';

  @override
  String get enableBiometricAfterPinMessage =>
      'PINと一緒にデバイスの生体認証を使って、より速くサインイン。';

  @override
  String get useFaceIdUnlock => 'Face IDを使用';

  @override
  String get useFingerprintUnlock => '指紋を使用';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => '年';

  @override
  String get reportPeriodMonth => '月';

  @override
  String get reportPeriodRange => '範囲';

  @override
  String get reportPeriodDay => '日';

  @override
  String get reportPeriodFrom => '開始';

  @override
  String get reportPeriodTo => '終了';

  @override
  String get reportPeriod => '期間';

  @override
  String get reportAllPurchases => 'すべての仕入';

  @override
  String get reportBeforeTax => '税引前';

  @override
  String get reportRevenueRetained => '留保収益';

  @override
  String get reportHideDetails => '詳細を非表示';

  @override
  String get reportShowDetails => '詳細を表示';

  @override
  String get reportSalesRevenue => '売上高';

  @override
  String get reportDiscountsGiven => '付与した割引';

  @override
  String get reportNetRevenue => '純収益';

  @override
  String get reportOperatingExpenses => '営業費用';

  @override
  String get reportTotalExpenses => '経費合計';

  @override
  String get reportGrossProfit => '粗利益';

  @override
  String get reportGrossProfitChart => '粗利益';

  @override
  String get reportOperatingPlDisclaimer => '税金、減価償却、給与負債は未計上 — 営業レベルの損益概算。';

  @override
  String get reportContraLabel => '相手勘定';

  @override
  String get reportNoDataForPeriod => '選択した期間のデータがありません';

  @override
  String get reportRevenueVsExpenses => '収益 vs 経費';

  @override
  String get reportExpenseBreakdown => '経費内訳';

  @override
  String get reportExpenseFallback => '経費';

  @override
  String get reportGrossMarginPercent => '粗利益率 %';

  @override
  String get reportRoomVsFnB => '客室 vs 飲食';

  @override
  String get reportSegmentRoom => '客室';

  @override
  String get reportSegmentFnB => '飲食';

  @override
  String get reportKeyMetrics => '主要指標';

  @override
  String get reportIncomeStatement => '損益計算書';

  @override
  String get reportChartsSection => 'グラフ';

  @override
  String get reportSegmentSummary => 'セグメントサマリー';

  @override
  String get reportFailedToLoad => 'レポートの読み込みに失敗しました';

  @override
  String get reportOverview => '概要';

  @override
  String get reportOverviewCash => '現金';

  @override
  String get reportOverviewBank => '銀行';

  @override
  String get reportMonthlyOpeningBalance => '月次開始残高';

  @override
  String get reportOpeningBalanceHint => '各月月初の現金残高';

  @override
  String get reportCashInOut => '現金入出金';

  @override
  String get reportCashIn => '現金入金';

  @override
  String get reportCashOut => '現金出金';

  @override
  String get reportBankReceiptsPayments => '銀行入金 / 出金';

  @override
  String get reportReceipts => '入金';

  @override
  String get reportPayments => '支払い';

  @override
  String get reportDailyCashVsQr => '日次現金 vs QR';

  @override
  String get reportSummariesSection => 'サマリー';

  @override
  String get reportCashSummary => '現金サマリー';

  @override
  String get reportBankSummary => '銀行サマリー';

  @override
  String get reportDailySummary => '日次サマリー';

  @override
  String get reportTabPurchase => '仕入';

  @override
  String get reportTabSales => '売上';

  @override
  String get reportTabDashboard => 'ダッシュボード';

  @override
  String get reportSingleDayTrend => '単日 — 日次トレンド';

  @override
  String get reportFullYearTrend => '通年 — 月次トレンドグラフ';

  @override
  String reportYearLabel(String year) {
    return '$year年';
  }

  @override
  String reportJanDec(String year) {
    return '1月 – 12月 $year';
  }

  @override
  String get reportTotalPurchases => '仕入合計';

  @override
  String get reportTotalSales => '売上合計';

  @override
  String get reportTotalInvoices => '請求書合計';

  @override
  String get reportUnpaidBalance => '未払い残高';

  @override
  String get reportAvgPerInvoice => '請求書あたり平均';

  @override
  String get reportPerTransaction => '取引あたり';

  @override
  String reportMonthlySpend(String symbol) {
    return '月次支出 ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return '月次売上 ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => '月別請求書数';

  @override
  String reportTopItemsBySpend(String symbol) {
    return '支出上位商品 ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'カテゴリ別支出';

  @override
  String get reportOtherCategory => 'その他';

  @override
  String get reportSuppliers => '仕入先';

  @override
  String get reportTableSupplier => '仕入先';

  @override
  String get reportTableAmount => '金額';

  @override
  String get reportTableBills => '請求書';

  @override
  String get reportSalesTotal => '売上合計';

  @override
  String get reportPurchaseTotal => '仕入合計';

  @override
  String get reportPositiveMargin => 'プラスマージン';

  @override
  String get reportNegativeMargin => 'マイナスマージン';

  @override
  String get reportGrossMargin => '粗利益率';

  @override
  String get reportOfTotalSales => '総売上に対する割合';

  @override
  String get reportFailedToLoadAnalytics => '分析の読み込みに失敗しました';

  @override
  String get reportMarginKpi => 'マージン';

  @override
  String get reportExpensesKpi => '経費';

  @override
  String partyPickerNoResultsFor(String query) {
    return '「$query」の結果がありません';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return '$roleの取引先が見つかりません';
  }

  @override
  String get partyPickerLoadParties => '取引先を読み込む';

  @override
  String get invoiceCashCustomer => '現金顧客';

  @override
  String get invoiceQuickAddItemsTitle => 'クイック追加';

  @override
  String get invoiceQuickLoadingMenu => 'メニューを読み込み中…';

  @override
  String get invoiceQuickInvoiceCreated => '請求書を作成しました';

  @override
  String get invoiceQuickAddAtLeastOneItem => '少なくとも1点追加してください';

  @override
  String get invoiceQuickNoResults => '結果が見つかりません！';

  @override
  String get invoiceQuickNoItemsInCategory => 'このカテゴリに商品がありません';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => '商品を追加';

  @override
  String get invoiceQuickLoadMore => 'さらに読み込む';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'スクロールでさらに読み込む（1ページ $count 件）';
  }

  @override
  String get invoiceQuickSupplierEmployee => '仕入先 / 従業員';

  @override
  String get invoiceQuickEditItem => '商品を編集';

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
  String get closeSelectDateRange => '日付範囲を選択';

  @override
  String get closeStartDate => '開始日';

  @override
  String get closeEndDate => '終了日';

  @override
  String get closeSelectBothDates => '開始日と終了日の両方を選択してください';

  @override
  String get closeDeleteSummary => 'サマリーを削除';

  @override
  String get closeDeleteSummaryConfirm => 'このサマリーを削除してもよろしいですか？';

  @override
  String get closeSelectDate => '日付を選択';

  @override
  String get closeNoDataToExport => 'エクスポートするデータがありません';

  @override
  String get closeNoDataToShare => '共有するデータがありません';

  @override
  String get closeNoDataToPrint => '印刷するデータがありません';

  @override
  String closePdfGenerateError(String error) {
    return 'PDF生成エラー: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'PDF共有エラー: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'PDF印刷エラー: $error';
  }

  @override
  String get closeExportPdf => 'PDFとしてエクスポート';

  @override
  String get closeSharePdf => 'PDFを共有';

  @override
  String get closePrint => '印刷';

  @override
  String get closeExportOptions => 'エクスポートオプション';

  @override
  String get closeExportPdfSubtitle => 'PDFドキュメントとして保存または表示';

  @override
  String get closeSharePdfSubtitle => 'アプリまたはメールで共有';

  @override
  String get closePrintSubtitle => 'レポートを印刷';

  @override
  String get closeDailyCashSummaryTitle => '日次キャッシュサマリー';

  @override
  String get closeDailyCashSummaryReport => '日次キャッシュサマリーレポート';

  @override
  String closeGeneratedAt(String date) {
    return '生成日時: $date';
  }

  @override
  String get closeTotalRecords => '記録合計';

  @override
  String get closeSummaryOverview => 'サマリー概要';

  @override
  String get closeAllRecords => 'すべての記録';

  @override
  String closePeriodRange(String start, String end) {
    return '期間: $start ～ $end';
  }

  @override
  String get closeDetails => '詳細';

  @override
  String closePageN(int n) {
    return '$nページ';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return '$total 件中 $shown 件を表示';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return '読み込み済み: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => '客室 / キャビン / 従業員';

  @override
  String reportPercentOfRevenue(String percent) {
    return '収益の $percent%';
  }

  @override
  String get reportParties => '取引先';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — 日次トレンドグラフ';
  }

  @override
  String get invoiceQuickCart => 'カート';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'カート ($count)';
  }

  @override
  String get invoiceQuickClearSearch => '検索をクリア';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'サマリーを追加';

  @override
  String get closeSalesAmount => '売上金額';

  @override
  String get closeClosingBalance => '締め残高';

  @override
  String get closeLostMoney => '不足金';

  @override
  String get closeDiscount => '割引';

  @override
  String get closeExpenses => '経費';

  @override
  String get closeUnpaid => '未払い';

  @override
  String get closeTotalOpeningBalance => '開始残高合計';

  @override
  String get closeTotalSalesAmount => '売上金額合計';

  @override
  String get closeTotalCashAmount => '現金合計';

  @override
  String get closeTotalQrAmount => 'QR合計';

  @override
  String get closeTotalDiscount => '割引合計';

  @override
  String get closeTotalExpenses => '経費合計';

  @override
  String get closeTotalClosingBalance => '締め残高合計';

  @override
  String get closeTotalLostMoney => '不足金合計';

  @override
  String get closeTotalExtraAmount => '追加金額合計';

  @override
  String get closeShowingCurrentMonth => '今月のデータを表示中';

  @override
  String get closeNoSummariesFound => 'サマリーが見つかりません';

  @override
  String get closeNoSummariesAvailable => 'サマリーがありません';

  @override
  String get closeTryAdjustingDateRange => '日付範囲を調整してください';

  @override
  String get closeCreateFirstSummary => '最初のサマリーを作成してください';

  @override
  String get closeClearFilter => 'フィルターをクリア';

  @override
  String get closeFiltered => 'フィルター適用中';

  @override
  String closeFilteredWithRange(String range) {
    return 'フィルター: $range';
  }

  @override
  String get closeSummarySingular => 'サマリー';

  @override
  String get closeSummariesPlural => 'サマリー';

  @override
  String get closeSummaryUpdatedSuccess => 'サマリーを更新しました';

  @override
  String get closeSummaryDeletedSuccess => 'サマリーを削除しました';

  @override
  String premiumUnlockTitle(String appName) {
    return '$appName Premium を解除';
  }

  @override
  String get premiumTagline => '完全オフラインPOS、請求、在庫、レポート — ビジネス向けの1つのサブスクリプション。';

  @override
  String get premiumFeatureUnlimitedInvoices => '請求書・レシート無制限';

  @override
  String get premiumFeatureInventoryStock => '在庫・ストック管理';

  @override
  String get premiumFeatureReportsAnalytics => '売上レポートと分析';

  @override
  String get premiumFeatureOfflineLocal => 'オフライン動作 — データは端末内に保存';

  @override
  String premiumContinueWith(String plan) {
    return '$plan で続行';
  }

  @override
  String get premiumRestorePurchases => '購入を復元';

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
      'お支払いは Apple ID に請求されます。期間終了の24時間前までにキャンセルしない限り、サブスクリプションは自動更新されます。';

  @override
  String get premiumPurchaseRestored => '購入を復元しました。';

  @override
  String get premiumNoActiveSubscription => '有効なサブスクリプションが見つかりません。';

  @override
  String get premiumPlanMonthly => '月額';

  @override
  String get premiumPlanMonthlySubtitle => '柔軟 — いつでも解約可能';

  @override
  String get premiumPlanYearly => '年額';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'お得 — $percent% お得';
  }

  @override
  String get premiumPlanLifetime => '永久';

  @override
  String get premiumPlanLifetimeSubtitle => '一度の支払いで永久利用';

  @override
  String get premiumPlanPopular => '人気';

  @override
  String get premiumOneTimePurchase => '買い切り';

  @override
  String get subscriptionSectionTitle => 'サブスクリプション';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Premium にアップグレード';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return '月額 $monthly · 年額 $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan 有効期限 $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan 有効';
  }

  @override
  String get premiumRequired => 'Premium が必要です';

  @override
  String get upgradeToPremiumContinue => '続行するには Premium にアップグレードしてください。';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return '無料プランは $limit $label まで。無制限アクセスには Premium にアップグレード。';
  }

  @override
  String get freemiumPartyRoleRequired => '取引先ロールが必要です。';

  @override
  String get freemiumLabelSalesInvoices => '売上請求書';

  @override
  String get freemiumLabelPurchaseInvoices => '仕入請求書';

  @override
  String get freemiumLabelEmployees => '従業員';

  @override
  String get freemiumLabelItems => '商品';

  @override
  String get freemiumLabelCategories => 'カテゴリ';

  @override
  String get freemiumLabelPaymentMethods => '支払い方法';

  @override
  String get freemiumLabelCustomPartyRoles => 'カスタム取引先ロール';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return '$role の取引先';
  }

  @override
  String get freemiumLabelOrganizations => '組織';

  @override
  String get freemiumPremiumReports => 'レポートは Premium で利用可能です。';

  @override
  String get freemiumPremiumBackupSync => 'バックアップと同期には Premium が必要です。';

  @override
  String get freemiumPremiumPayroll => '給与には Premium が必要です。';

  @override
  String get freemiumPremiumAttendance => '勤怠には Premium が必要です。';

  @override
  String get freemiumPremiumStock => '在庫管理には Premium が必要です。';

  @override
  String get freemiumPremiumInvoiceExport => 'ダウンロードと印刷には Premium が必要です。';

  @override
  String get shiftReminderOpeningTitle => '開店リマインダー';

  @override
  String get shiftReminderOpeningMessage => '今日のレジを開けましたか？';

  @override
  String get shiftReminderOpeningProceed => 'はい、今すぐ開ける';

  @override
  String get shiftReminderClosingTitle => '閉店リマインダー';

  @override
  String get shiftReminderClosingMessage => '今日のレジを閉めましたか？';

  @override
  String get shiftReminderClosingProceed => 'はい、今すぐ閉める';

  @override
  String get shiftReminderSkipToday => '今日はスキップ';

  @override
  String get shiftReminderOpeningNotificationTitle => '開店リマインダー';

  @override
  String get shiftReminderOpeningNotificationBody =>
      '今日のレジを開けましたか？まだ開ける場合はここをタップ。';

  @override
  String get shiftReminderClosingNotificationTitle => '閉店リマインダー';

  @override
  String get shiftReminderClosingNotificationBody =>
      '今日のレジを閉めましたか？まだ閉める場合はここをタップ。';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business が顧客に QR で支払い、顧客が現金を提供します。';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business が顧客に現金を支払い、顧客が QR 決済を提供します。';
  }

  @override
  String get closePaymentExchange => '決済交換';

  @override
  String get closePayQrGetCashExchangeLabel => 'QR支払い → 現金受取（交換）';

  @override
  String get closePayCashGetQrExchangeLabel => '現金支払い → QR受取（交換）';

  @override
  String get closePayQrGetCashDetail => 'QR支払いで現金受取';

  @override
  String get closePayCashGetQrDetail => '現金支払いでQR受取';

  @override
  String get faqSectionPremium => 'Premium と請求';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Premium には何が含まれますか？';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium では請求書無制限、完全レポート（P&L、明細、分析）、バックアップと同期、給与、勤怠、在庫ツール、請求書のエクスポート/印刷、追加組織が利用できます。無料枠でも主要POS機能を公正な制限内で利用できます。';

  @override
  String get faqPremiumFreeTierQuestion => '無料枠には何が含まれますか？';

  @override
  String get faqPremiumFreeTierAnswer =>
      '売上・仕入請求書各10件、従業員4名、商品30件など作成可能で、上限に達すると他の制限も表示されます。開店・閉店、電卓、データ閲覧は無料のままです。';

  @override
  String get faqPremiumRestoreQuestion => '購入を復元するには？';

  @override
  String get faqPremiumRestoreAnswer =>
      'その他 → Premium にアップグレード（またはペイウォール）を開き、購入を復元をタップ。購読時と同じ Apple ID を使用してください。';

  @override
  String get faqPremiumCancelQuestion => 'サブスクリプションを解約するには？';

  @override
  String get faqPremiumCancelAnswer =>
      'iPhone の設定 → Apple ID → サブスクリプションで管理または解約。支払い期間終了までアクセスできます。';

  @override
  String get faqDarkModeQuestion => 'ダークモードをオンにするには？';

  @override
  String get faqDarkModeAnswer =>
      'その他 → 外観を開き、ダークモードを有効に。デバイスがシステムテーマの場合、アプリは自動で従います。';

  @override
  String get faqOpeningClosingReminderQuestion => '開店・閉店リマインダーとは？';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName は日次レジの開閉をリマインドできます。続行、今日スキップ、または閉じることができます。';
  }

  @override
  String get faqPartyRolesQuestion => '取引先ロールとは？';

  @override
  String get faqPartyRolesAnswer =>
      '取引先ロールは顧客、仕入先、部屋、従業員などの連絡先を分類します。運用 → 取引先ロールでカスタマイズし、チーム向けの短い説明を追加できます。';

  @override
  String faqRateAppQuestion(String appName) {
    return '$appName を評価するには？';
  }

  @override
  String get faqRateAppAnswer =>
      'その他 → 評価する を開き App Store でレビューを投稿。フィードバックはオフライン請求の改善に役立ちます。';
}
