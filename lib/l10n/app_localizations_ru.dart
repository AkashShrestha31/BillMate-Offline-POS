// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get noInternetConnection => 'Нет подключения к интернету.';

  @override
  String get formatException => 'Исключение формата';

  @override
  String get rememberMe => 'Запомнить меня';

  @override
  String get signIn => 'Войти';

  @override
  String get passwordHint => 'Введите пароль';

  @override
  String get forgetPassword => 'Забыли данные для входа?';

  @override
  String get okay => 'Хорошо';

  @override
  String get success => 'Успех';

  @override
  String get hotel => 'отель';

  @override
  String get errorEncountered => 'Обнаружена ошибка';

  @override
  String get serverError => 'Ошибка сервера';

  @override
  String get requestFailed => 'Запрос не выполнен';

  @override
  String get connectionTimedOut => 'Время соединения истекло';

  @override
  String get password => 'Пароль';

  @override
  String get keepSignIn => 'Оставаться в системе';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get enterValidPassword => 'Введите корректный пароль';

  @override
  String get skip => 'ПРОПУСТИТЬ';

  @override
  String get pleaseWait => 'Пожалуйста, подождите ....';

  @override
  String get enterValidUserName => 'Введите корректное имя пользователя.';

  @override
  String get userName => 'Имя пользователя';

  @override
  String get or => 'Или';

  @override
  String get retry => 'Повторить';

  @override
  String get error => 'Ошибка';

  @override
  String get supportMessage => 'Пожалуйста, обратитесь к администратору.';

  @override
  String get responseMessage404 => 'Ошибка 404';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get close => 'Закрыть';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteOrganizationTitle => 'Удалить организацию?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'Удалить $name с этого устройства. Все локальные данные этой организации будут удалены.';
  }

  @override
  String get deleteOrganizationWarning => 'Это невозможно отменить.';

  @override
  String get organizationDeleted => 'Организация удалена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get done => 'Готово';

  @override
  String get next => 'Далее';

  @override
  String get getStarted => 'Начать';

  @override
  String get walkthroughDashboardTitle => 'Весь бизнес с первого взгляда';

  @override
  String get walkthroughDashboardDescription =>
      'Продажи сегодня, выручка и задолженности — всё на понятной панели при открытии приложения.';

  @override
  String get walkthroughOfflineTitle => 'Работает без интернета';

  @override
  String get walkthroughOfflineDescription =>
      'Создавайте счета, учитывайте расходы и управляйте складом офлайн. Всё синхронизируется автоматически при подключении.';

  @override
  String get walkthroughBillingTitle =>
      'Выставляйте счета и продавайте за секунды';

  @override
  String get walkthroughBillingDescription =>
      'Счета продаж и закупок, заказы столов с кухонными тикетами и склад в реальном времени — всё в одном приложении.';

  @override
  String get walkthroughStaffTitle => 'Персонал, зарплата и отчёты';

  @override
  String get walkthroughStaffDescription =>
      'Управляйте посещаемостью и зарплатой, экспортируйте P&L и расчётные листы в PDF — без дополнительных инструментов.';

  @override
  String get walkthroughBackupTitle => 'Ваши данные всегда в безопасности';

  @override
  String get walkthroughBackupDescription =>
      'Банковский уровень безопасности с резервным копированием Google Drive в одно касание — данные защищены и легко восстанавливаются.';

  @override
  String get walkthroughReadyTitle => 'Готовы, когда вы готовы';

  @override
  String get walkthroughReadyDescription =>
      'Настройте организацию за минуты и управляйте бизнесом умнее уже сегодня. Начнём.';

  @override
  String get back => 'Назад';

  @override
  String get submit => 'Отправить';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get createAction => 'Создать';

  @override
  String get connectOrganizationTitle => 'Подключить организацию';

  @override
  String get connectOrganizationSubtitle => 'Выберите организацию для входа.';

  @override
  String get selectOrganization => 'Организации';

  @override
  String get selectOrganizationHint =>
      'Нажмите на организацию, чтобы продолжить';

  @override
  String get noSavedOrganizationsYet =>
      'Организаций пока нет. Создайте одну или используйте тестовые данные ниже.';

  @override
  String get orgConnectOnceInfo =>
      'Это связывает приложение с вашим бизнес-аккаунтом. Вам нужно настроить это только один раз на каждом устройстве.';

  @override
  String organizationCodeLabel(String code) {
    return 'Код: $code';
  }

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get warning => 'ПРЕДУПРЕЖДЕНИЕ';

  @override
  String get loading => 'Загрузка…';

  @override
  String get comingSoon => 'Скоро';

  @override
  String get required => 'Обязательно';

  @override
  String get search => 'Поиск';

  @override
  String get add => 'Добавить';

  @override
  String get edit => 'Редактировать';

  @override
  String get remove => 'Удалить';

  @override
  String get view => 'Просмотр';

  @override
  String get export => 'Экспорт';

  @override
  String get exportAsPdf => 'Экспортировать в PDF';

  @override
  String get sharePdf => 'Поделиться PDF-файлом';

  @override
  String get partyExportPdfTooltip => 'Экспорт PDF';

  @override
  String get import => 'Импорт';

  @override
  String get refresh => 'Обновить';

  @override
  String get select => 'Выбрать';

  @override
  String get upload => 'Загрузить';

  @override
  String get download => 'Скачать';

  @override
  String get share => 'Поделиться';

  @override
  String get filter => 'Фильтр';

  @override
  String get sort => 'Сортировка';

  @override
  String get apply => 'Применить';

  @override
  String get reset => 'Сбросить';

  @override
  String get clear => 'Очистить';

  @override
  String get all => 'Все';

  @override
  String get none => 'Нет';

  @override
  String get total => 'Итого';

  @override
  String get subtotal => 'Промежуточный итог';

  @override
  String get grandTotal => 'Общий итог';

  @override
  String get amount => 'Сумма';

  @override
  String get quantity => 'Количество';

  @override
  String get rate => 'Ставка';

  @override
  String get discount => 'Скидка';

  @override
  String get paid => 'Оплачено';

  @override
  String get unpaid => 'Не оплачено';

  @override
  String get credit => 'Кредит';

  @override
  String get cash => 'Наличные';

  @override
  String get date => 'Дата';

  @override
  String get time => 'Время';

  @override
  String get name => 'Имя';

  @override
  String get email => 'Эл. почта';

  @override
  String get phone => 'Телефон';

  @override
  String get address => 'Адрес';

  @override
  String get notes => 'Заметки';

  @override
  String get description => 'Описание';

  @override
  String get status => 'Статус';

  @override
  String get type => 'Тип';

  @override
  String get category => 'Категория';

  @override
  String get party => 'Сторона';

  @override
  String get item => 'Товар';

  @override
  String get payment => 'Платёж';

  @override
  String get settlement => 'Расчёт';

  @override
  String get opening => 'Открытие';

  @override
  String get closing => 'Закрытие';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'Расход';

  @override
  String get revenue => 'Выручка';

  @override
  String get profit => 'Прибыль';

  @override
  String get loss => 'Убыток';

  @override
  String get sales => 'Продажи';

  @override
  String get purchase => 'Закупка';

  @override
  String get monthJan => 'Янв';

  @override
  String get monthFeb => 'Фев';

  @override
  String get monthMar => 'Мар';

  @override
  String get monthApr => 'Апр';

  @override
  String get monthMay => 'Май';

  @override
  String get monthJun => 'Июн';

  @override
  String get monthJul => 'Июл';

  @override
  String get monthAug => 'Авг';

  @override
  String get monthSep => 'Сен';

  @override
  String get monthOct => 'Окт';

  @override
  String get monthNov => 'Ноя';

  @override
  String get monthDec => 'Дек';

  @override
  String get more => 'Ещё';

  @override
  String get profile => 'Профиль';

  @override
  String get operations => 'Операции';

  @override
  String get operationManagement => 'Управление операциями';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'Управление сотрудниками';

  @override
  String get employeeManagementSubtitle => 'Персонал, зарплата и посещаемость';

  @override
  String get report => 'Отчёт';

  @override
  String get reportSubtitle => 'Прибыли и убытки, отчёты и аналитика';

  @override
  String get helpAndSupport => 'Помощь и поддержка';

  @override
  String get preferences => 'Настройки';

  @override
  String get dataAndBackup => 'Данные и резервное копирование';

  @override
  String get privacyAndPolicies => 'Конфиденциальность и политики';

  @override
  String get faq => 'Вопросы и ответы';

  @override
  String get contactSupport => 'Связаться с поддержкой';

  @override
  String get rateUs => 'Оцените нас';

  @override
  String get rateUsSubtitle =>
      'Нравится BizTrack? Оставьте отзыв в Google Play';

  @override
  String get rateUsUnavailable =>
      'Не удалось открыть магазин. Попробуйте позже.';

  @override
  String get reportProblem => 'Сообщить о проблеме';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get contactUsSubtitle =>
      'Поддержка, отзывы или вопросы по приложению.';

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
  String get developerLabel => 'Разработчик';

  @override
  String get emailCopiedToClipboard => 'Email скопирован в буфер обмена';

  @override
  String get logout => 'Выйти';

  @override
  String get signOut => 'Выход';

  @override
  String get settings => 'Настройки';

  @override
  String get testData => 'Тестовые данные';

  @override
  String get loginWithTestData => 'Войти с тестовыми данными';

  @override
  String get loginWithTestDataSubtitle =>
      'Загрузить демонстрационные данные отеля и войти автоматически';

  @override
  String testDataLoginFailed(String error) {
    return 'Не удалось загрузить тестовые данные: $error';
  }

  @override
  String get preparingTestData => 'Подготовка демонстрационных данных…';

  @override
  String get regionAndCurrency => 'Регион и валюта';

  @override
  String get reportingCurrency => 'Валюта отчётности';

  @override
  String get selectCurrency => 'Выбрать валюту';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · пример $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'Валюта установлена: $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'Не удалось обновить валюту: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'Настройка $appName';
  }

  @override
  String get setupSubtitle =>
      'Настройте вашу организацию и бухгалтерию — хранится на этом устройстве для использования без интернета.';

  @override
  String get setupOrganizationName => 'Название организации';

  @override
  String get setupCompanyName => 'Название компании';

  @override
  String get setupBusinessType => 'Тип бизнеса';

  @override
  String get selectBusinessType => 'Выберите тип бизнеса';

  @override
  String get businessTypeHotel => 'Отель';

  @override
  String get businessTypeHotelSubtitle => 'Номера, гости и стойка регистрации';

  @override
  String get businessTypeRestaurant => 'Ресторан';

  @override
  String get businessTypeRestaurantSubtitle => 'Заказ обедов, кухни и стола';

  @override
  String get businessTypeHotelRestaurant => 'Отель и ресторан';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Гостиничные номера и ресторан вместе';

  @override
  String get businessTypeRetail => 'Розница / Магазин';

  @override
  String get businessTypeRetailSubtitle =>
      'Продукты, наличие и оформление заказа';

  @override
  String get businessTypeCafe => 'Кафе / Пекарня';

  @override
  String get businessTypeCafeSubtitle => 'Кофе, выпечка и легкие закуски';

  @override
  String get businessTypeBar => 'Бар / Паб';

  @override
  String get businessTypeBarSubtitle =>
      'Меню напитков, вкладки и продажи в баре';

  @override
  String get businessTypeOther => 'Другое';

  @override
  String get businessTypeOtherSubtitle =>
      'Индивидуальная настройка для любого бизнеса';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'Тип: $type';
  }

  @override
  String get organizationSettings => 'Организация';

  @override
  String get editOrganizationInfo => 'Информация об организации';

  @override
  String get editOrganizationInfoSubtitle =>
      'Обновите отображение этого бизнеса в приложении. Код организации нельзя изменить.';

  @override
  String get organizationCode => 'Код организации';

  @override
  String get organizationCodeReadOnly =>
      'Этот код фиксируется после настройки.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'Информация об организации сохранена';

  @override
  String get organizationInfoLoadFailed =>
      'Не удалось загрузить информацию об организации';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'Не удалось сохранить информацию об организации: $error';
  }

  @override
  String get organizationTabGeneral => 'Общие';

  @override
  String get organizationTabRegional => 'Региональные и финансовые';

  @override
  String get organizationRegionalSubtitle =>
      'Страна, отчётная валюта и даты финансового года.';

  @override
  String get organizationTabAccounting => 'Учёт';

  @override
  String get organizationAccountingSubtitle =>
      'Настройки счетов и отображения сумм.';

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
  String get displayPrecision => 'Точность отображения';

  @override
  String get displayPrecisionRange => 'Введите число от 0 до 5';

  @override
  String get enableInvoiceReturns => 'Включить возвраты по счетам';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'Разрешить создавать возвраты из оплаченных счетов.';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get setupFullName => 'Полное имя';

  @override
  String get setupConfirmPassword => 'Подтвердить пароль';

  @override
  String get setupBankName => 'Название банка';

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
  String get setupRegionStepTitle => 'Регион и валюта';

  @override
  String get setupOrganizationStepTitle => 'Организация';

  @override
  String get setupOrganizationStepSubtitle =>
      'Как ваш бизнес отображается в приложении';

  @override
  String get setupAdminStepTitle => 'Аккаунт администратора';

  @override
  String get setupAdminStepSubtitle =>
      'Основной пользователь для данной установки';

  @override
  String get setupAccountingStepTitle => 'Бухгалтерия';

  @override
  String get setupAccountingStepSubtitle =>
      'Банк, план счетов и финансовый год';

  @override
  String get setupCompleteSetup => 'Завершить настройку';

  @override
  String fieldRequired(String field) {
    return '$field обязателен';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress =>
      'Введите действительный адрес электронной почты';

  @override
  String passwordMinLength(int min) {
    return 'Пароль должен содержать не менее $min символов';
  }

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get setupFixValidationErrors =>
      'Пожалуйста, исправьте ошибки ниже, чтобы продолжить';

  @override
  String get setupCompleteSuccess => 'Настройка успешно завершена';

  @override
  String get setupCompleteWithPdfSuccess =>
      'Настройка завершена. Сохраните PDF в надёжном месте.';

  @override
  String setupPdfFailed(String error) {
    return 'Настройка завершена, но PDF не удалось сохранить: $error';
  }

  @override
  String get setupFailed =>
      'Настройку не удалось завершить. Пожалуйста, попробуйте снова.';

  @override
  String setupFailedWithDetails(String error) {
    return 'Настройка не выполнена: $error';
  }

  @override
  String get regionAndCurrencySubtitle =>
      'Региональные настройки и валюта отчётности.';

  @override
  String get country => 'Страна';

  @override
  String get currency => 'Валюта';

  @override
  String get selectCountry => 'Выбрать страну';

  @override
  String get language => 'Язык';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get languageChangeLaterHint =>
      'Вы можете изменить его позже в настройках';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'Выберите, как вы хотите использовать $appName. Это можно изменить позже в настройках.';
  }

  @override
  String get searchLanguages => 'Поиск языков';

  @override
  String get languageSuggestedBadge => 'РЕКОМЕНДУЕТСЯ';

  @override
  String continueInLanguage(String languageName) {
    return 'Продолжить на $languageName';
  }

  @override
  String get noLanguageMatches => 'Нет совпадений';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'Нет языка, соответствующего \"$query\"';
  }

  @override
  String get appearance => 'Внешний вид';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get darkModeSubtitle => 'Тёмный фон во всём приложении';

  @override
  String get darkModeSystemSubtitle => 'Следует теме устройства';

  @override
  String languageUpdated(String name) {
    return 'Язык установлен: $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'Не удалось обновить язык: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'Добро пожаловать в $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'Установите последнюю версию $appName, чтобы продолжить.';
  }

  @override
  String generatedByApp(String appName) {
    return 'Создано в $appName';
  }

  @override
  String whatIsApp(String appName) {
    return 'Что такое $appName?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName помогает вам управлять счетами продаж и закупок, контрагентами (клиентами и поставщиками), запасами, платежами, сотрудниками и ежедневными сводками — с телефона или планшета.';
  }

  @override
  String faqIntro(String appName) {
    return 'Ответы на часто задаваемые вопросы о $appName.';
  }

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get photoLibrary => 'Библиотека фото';

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String couldNotPickImage(String error) {
    return 'Не удалось выбрать изображение: $error';
  }

  @override
  String get unpaidAmount => 'Не оплачено Сумма';

  @override
  String get unpaidBalance => 'Не оплачено';

  @override
  String unpaidColonAmount(String amount) {
    return 'Не оплачено: $amount';
  }

  @override
  String get previousUnpaid => 'Не оплачено';

  @override
  String get partyUnpaid => 'Не оплачено';

  @override
  String get loadingUnpaid => 'Не оплачено…';

  @override
  String get totalUnpaid => 'Не оплачено';

  @override
  String get unpaidAmountNotYetCollected =>
      'Неоплаченная сумма ещё не получена.';

  @override
  String get partyUnpaidTabHint =>
      'Откройте Сотрудники, выберите человека, затем нажмите Долг контрагента в его профиле. Серверу нужен ID сотрудника для этого поиска.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'Расчёт с контрагентом использует общую сумму долга.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'Сначала введите сумму расчёта (или выберите контрагента с долгом).';

  @override
  String get workspace => 'Рабочее пространство';

  @override
  String get change => 'Изменить';

  @override
  String get addMoreOrganization => 'Добавить ещё +';

  @override
  String get connectAnotherOrganization => 'Подключить другую организацию';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'Сохранённых организаций пока нет. Используйте Добавить ещё + для подключения.';

  @override
  String get registerNewOrganizationTitleSignedIn =>
      'Зарегистрировать новую организацию?';

  @override
  String get registerNewOrganizationTitle =>
      'Зарегистрировать новую организацию?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'Вы выйдете из системы, и мастер настройки начнётся заново, чтобы зарегистрировать новый бизнес на этом устройстве.\n\nУже сохранённые организации останутся в списке после настройки.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'Мастер настройки запустится для регистрации нового бизнеса на этом устройстве. Завершите настройку для создания; сохранённые организации останутся в списке.';

  @override
  String get startSetup => 'Начать настройку';

  @override
  String get enterOrganizationCode => 'Введите код вашей организации';

  @override
  String get organizationNotFoundCheckCode =>
      'Организация не найдена. Проверьте код и попробуйте снова.';

  @override
  String get organizationNotFound => 'Организация не найдена';

  @override
  String get couldNotVerifyOrganization => 'Не удалось проверить организацию';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'Нет локальных данных для $name. Сначала завершите настройку этой организации.';
  }

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get signInToContinue => 'Войдите для продолжения';

  @override
  String get enterEmail => 'Введите email';

  @override
  String get pleaseEnterEmail => 'Пожалуйста, введите ваш email';

  @override
  String get pleaseEnterValidEmail => 'Введите действительный email';

  @override
  String get enterEmailLocalPartOnly => 'Введите только часть до @';

  @override
  String get pleaseEnterPassword => 'Пожалуйста, введите ваш пароль';

  @override
  String get logIn => 'ВОЙТИ';

  @override
  String get searchCountry => 'Поиск страны';

  @override
  String get searchCodeOrSymbol => 'Поиск кода или символа';

  @override
  String get saveLoginDetailsTitle => 'Сохранить данные для входа?';

  @override
  String get saveLoginDetailsMessage =>
      'Вы собираетесь завершить настройку этой организации.\n\nХотите безопасно скачать PDF с кодом организации, её названием, email и паролем? Храните в надёжном месте — любой, у кого есть этот файл, может войти.';

  @override
  String get downloadPdfAndContinue => 'Скачать PDF и продолжить';

  @override
  String get continueWithoutPdf => 'Продолжить без PDF';

  @override
  String get legalDisplayNameHint => 'Юридическое / отображаемое имя';

  @override
  String get chartOfAccounts => 'План счетов';

  @override
  String get fiscalYearStart => 'Начало финансового года';

  @override
  String get fiscalYearEnd => 'Конец финансового года';

  @override
  String get removeTestDataTitle => 'Удалить тестовые данные?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'Все демо-продажи, покупки, контакты, контрагенты, товары, сотрудники, продукты калькулятора алкоголя и дополнительные демо-организации будут удалены.\n\nВы в демо-организации — после этого вы автоматически переключитесь на первую организацию.';

  @override
  String get removeTestDataMessageNormal =>
      'Все демо-продажи, покупки, контакты, контрагенты, товары, сотрудники и 3 дополнительные демо-организации будут удалены. Аккаунт администратора и реальные данные настройки сохранятся.';

  @override
  String get removeTestDataWarning =>
      'Это нельзя отменить без повторной загрузки тестовых данных.';

  @override
  String get removeTestData => 'Удалить тестовые данные';

  @override
  String get keepTestData => 'Сохранить тестовые данные';

  @override
  String get demoDataRemoved => 'Демо-данные удалены';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'Тестовые данные удалены. Переключено на $name.';
  }

  @override
  String get testDataRemoved => 'Тестовые данные удалены';

  @override
  String couldNotRemoveTestData(String error) {
    return 'Не удалось удалить тестовые данные: $error';
  }

  @override
  String get loadTestDataTitle => 'Загрузить тестовые данные?';

  @override
  String get loadTestDataMessage =>
      'Будет добавлено до 50 демо-контактов, 50 товаров только для продаж и 50 только для покупок, а также образцы продаж, покупок, платежей, склада, итогов закрытия, сотрудников, зарплат, посещаемости за последние 15 дней и алкогольных продуктов для калькулятора.';

  @override
  String get loadTestData => 'Загрузить тестовые данные';

  @override
  String get testDataLoaded => 'Тестовые данные загружены';

  @override
  String couldNotLoadTestData(String error) {
    return 'Не удалось загрузить тестовые данные: $error';
  }

  @override
  String get demoTestData => 'Демо тестовые данные';

  @override
  String get importTestDataSubtitle =>
      'Импортировать тестовые данные для всех функций';

  @override
  String get hideTestDataTitle =>
      'Скрыть тестовые данные для этой организации?';

  @override
  String get hideTestDataMessage =>
      'Если продолжить, раздел Тестовые данные будет скрыт везде в этой организации (включая настройку). Включить снова можно только переустановив приложение или очистив его данные.';

  @override
  String get hideTestDataWarning =>
      'Уже загруженные демо-данные останутся в базе данных, пока вы их не удалите в настройках.';

  @override
  String get okHideTestData => 'ОК, скрыть тестовые данные';

  @override
  String get testDataHiddenForOrg =>
      'Тестовые данные скрыты для этой организации';

  @override
  String get hideTestDataTooltip =>
      'Скрыть тестовые данные для этой организации';

  @override
  String get partyRolesTitle => 'Роли контрагентов';

  @override
  String get partyRolesMoreSubtitle => 'Клиент, поставщик, оба и другие';

  @override
  String get exploreCustomizeTitle => 'Настройте функции';

  @override
  String get exploreCustomizeSubtitle =>
      'Показать или скрыть ярлыки на главном экране. В списке перечислены только функции, к которым имеет доступ ваша организация.';

  @override
  String get exploreVisibleOnDashboard => 'Видно на приборной панели';

  @override
  String get exploreHiddenOnDashboard => 'Спрятано на приборной панели';

  @override
  String get partiesTitle => 'Контрагенты';

  @override
  String get partySearchByName => 'Поиск по имени…';

  @override
  String get partySortBy => 'Сортировать по:';

  @override
  String get partySortLatest => 'Последние';

  @override
  String get partySortAmountHighLow => 'Сумма: от высокой к низкой';

  @override
  String get partySortAmountLowHigh => 'Сумма: от низкой к высокой';

  @override
  String get partySortNameAZ => 'Имя: от А до Я';

  @override
  String get partySortNameZA => 'Имя: от Я до А';

  @override
  String get partyAddNew => 'Добавить контрагента';

  @override
  String get partyEdit => 'Изменить контрагента';

  @override
  String get partyUpdate => 'Обновить контрагента';

  @override
  String get partyNameLabel => 'Название контрагента*';

  @override
  String get partyNameHint => 'Введите название контрагента';

  @override
  String get partyNewNameLabel => 'Новое название контрагента*';

  @override
  String get partyNewNameHint => 'Введите новое название контрагента';

  @override
  String get partyRoleLabel => 'Роль контрагента *';

  @override
  String get partyTapToSelect => 'Нажмите, чтобы выбрать';

  @override
  String get partySelectRoleValidation => 'Пожалуйста, выберите роль';

  @override
  String get partyEnterNameValidation =>
      'Пожалуйста, введите название контрагента';

  @override
  String get partyBasicInfo => 'Основная информация';

  @override
  String get partyAdditionalInfo => 'Дополнительная информация';

  @override
  String get partyEmail => 'Эл. почта контрагента';

  @override
  String get partyEmailHint => 'Введите адрес электронной почты';

  @override
  String get partyPhone => 'Номер телефона';

  @override
  String get partyPhoneHint => 'Введите номер телефона';

  @override
  String get partyAddress => 'Адрес контрагента';

  @override
  String get partyAddressHint => 'Введите адрес';

  @override
  String get partyRoleCustomer => 'Клиент';

  @override
  String get partyRoleSupplier => 'Поставщик';

  @override
  String get partyRoleRoom => 'Комната';

  @override
  String get partyRoleCabin => 'Кабина';

  @override
  String get partyRoleEmployee => 'Сотрудник';

  @override
  String get partyRoleBoth => 'Оба';

  @override
  String get partyDefaultAccount => 'Счёт по умолчанию';

  @override
  String get partyLoyaltyProgram => 'Программа лояльности';

  @override
  String get partyLoyaltyPoints => 'Баллы лояльности';

  @override
  String get partySelectDefaultAccount => 'Выберите счёт по умолчанию';

  @override
  String get partySelectLoyaltyProgram => 'Выберите программу лояльности';

  @override
  String get partyCreateNewProgram => 'Создать новую программу';

  @override
  String get partySelectPartyRole => 'Выберите роль контрагента';

  @override
  String get partyAccountDebtors => 'Дебиторы';

  @override
  String get partyAccountCreditors => 'Кредиторы';

  @override
  String get partyBothRoleHint =>
      '«Оба» означает, что контрагент отображается только в разделах «Клиент» и «Поставщик», но не «Комната», «Кабина» или «Сотрудник».';

  @override
  String get partyValidNumber => 'Пожалуйста, введите действительный номер';

  @override
  String get partyValidAmount => 'Пожалуйста, введите действительную сумму';

  @override
  String get searchRoles => 'Поиск ролей';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count роли',
      many: '$count ролей',
      few: '$count роли',
      one: '1 роль',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'Ролей пока нет';

  @override
  String get noRolesYetHint =>
      'Добавьте Клиент, Поставщик, Оба или пользовательские роли для контактов.';

  @override
  String get addRole => 'Добавить роль';

  @override
  String get deleteRoleTitle => 'Удалить роль';

  @override
  String deleteRoleConfirm(String name) {
    return 'Удалить \"$name\"? Это нельзя отменить.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount контрагентами',
      many: '$partyCount контрагентами',
      few: '$partyCount контрагентами',
      one: '1 контрагентом',
    );
    return '\"$name\" используется $_temp0. Перенесите их в другую роль или удалите принудительно.';
  }

  @override
  String get transferParties => 'Перенести контрагентов';

  @override
  String get hardDeleteLoseParties =>
      'Принудительное удаление (потерять контрагентов)';

  @override
  String get hardDeleteRoleTitle => 'Принудительное удаление?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount контрагента',
      many: '$partyCount контрагентов',
      few: '$partyCount контрагентов',
      one: '1 контрагента',
    );
    return 'Это навсегда удалит \"$name\" и всех $_temp0. Данные контрагентов не подлежат восстановлению.\n\nКонтрагенты, связанные со счетами или платежами, могут не удалиться — используйте перенос.';
  }

  @override
  String get deleteRoleAndParties => 'Удалить роль и контрагентов';

  @override
  String get addAnotherRoleBeforeDelete =>
      'Добавьте другую роль перед удалением этой.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount контрагента',
      many: '$partyCount контрагентов',
      few: '$partyCount контрагентов',
      one: '1 контрагента',
    );
    return 'Переместить $_temp0 из \"$fromRole\" в:';
  }

  @override
  String get transferAndDeleteRole => 'Перенести и удалить роль';

  @override
  String get builtInRole => 'Встроенная';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count контрагента',
      many: '$count контрагентов',
      few: '$count контрагента',
      one: '1 контрагент',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'Контрагентов пока нет';

  @override
  String get newRole => 'Новая роль';

  @override
  String get editRole => 'Редактировать роль';

  @override
  String get defaultRolesCannotEdit =>
      'Роли по умолчанию нельзя переименовать или удалить.';

  @override
  String get roleNameLabel => 'Название роли *';

  @override
  String get roleNameHint => 'напр. Клиент';

  @override
  String get roleDescriptionLabel => 'Описание';

  @override
  String get roleDescriptionHint => 'Короткая заметка для команды';

  @override
  String get roleSortOrderLabel => 'Порядок сортировки';

  @override
  String get roleSortOrderHint => 'Меньшие значения отображаются первыми';

  @override
  String get roleCreated => 'Роль создана';

  @override
  String get roleUpdated => 'Роль обновлена';

  @override
  String get roleDeleted => 'Роль удалена';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count контрагента',
      many: '$count контрагентов',
      few: '$count контрагента',
      one: '1 контрагент',
    );
    return 'Роль удалена. $_temp0 перемещён(а) в $targetRole.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count контрагента',
      many: '$count контрагентов',
      few: '$count контрагента',
      one: '1 контрагент',
    );
    return 'Роль и $_temp0 удалены.';
  }

  @override
  String get privacyPolicyTitle => 'Политика конфиденциальности';

  @override
  String get termsAndConditions => 'Условия использования';

  @override
  String get logoutConfirmTitle => 'Выход';

  @override
  String get logoutConfirmMessage =>
      'Вы уверены, что хотите выйти из аккаунта?';

  @override
  String get faqTapToExpand => 'Нажмите на вопрос, чтобы раскрыть.';

  @override
  String get faqSectionGettingStarted => 'Начало работы';

  @override
  String get faqSectionLogin => 'Вход';

  @override
  String get faqSectionNavigation => 'Навигация';

  @override
  String get faqSectionInvoices => 'Счета';

  @override
  String get faqSectionPayments => 'Платежи';

  @override
  String get faqSectionItemsStock => 'Товары и склад';

  @override
  String get faqSectionProfileEmployees => 'Профиль и сотрудники';

  @override
  String get faqSectionDashboardReports => 'Панель и отчёты';

  @override
  String get faqSectionSyncTroubleshooting =>
      'Синхронизация и устранение неполадок';

  @override
  String get faqNeedInternetQuestion => 'Нужен ли интернет?';

  @override
  String get faqNeedInternetAnswer =>
      'После первоначальной локальной настройки можно записывать счета, товары и платежи без интернета. Данные хранятся на устройстве. Синхронизация с сервером опциональна.';

  @override
  String get faqFirstInstallQuestion => 'Что происходит при первой установке?';

  @override
  String get faqFirstInstallAnswer =>
      'Возможно, вы увидите краткое руководство, затем локальную настройку (организация, компания, email и пароль, валюта, финансовый год). После этого войдите с созданным email и паролем.';

  @override
  String get faqSignInCredentialsQuestion => 'Что использовать для входа?';

  @override
  String get faqSignInCredentialsAnswer =>
      'Ваш email и пароль из настройки. Приложение держит вас в системе, пока вы не выйдете через Ещё.';

  @override
  String get faqLoggedOutQuestion => 'Почему я был выведен из системы?';

  @override
  String get faqLoggedOutAnswer =>
      'Вы выбрали Выход, очистили данные приложения или истекла сессия. Войдите снова с теми же данными.';

  @override
  String get faqBottomTabsQuestion => 'Что делают нижние вкладки?';

  @override
  String get faqBottomTabsAnswer =>
      'Главная — панель и обзор.\nПродажи — счета продаж по дате.\nРасходы — счета покупок / расходов.\nЦентральная кнопка — Контрагенты (клиенты, поставщики).\nЕщё — профиль, отчёты, синхронизация, помощь, выход.';

  @override
  String get faqCreateInvoiceQuestion =>
      'Как создать счёт продажи или покупки?';

  @override
  String get faqCreateInvoiceAnswer =>
      'Откройте Продажи или Расходы, выберите дату в календаре, нажмите +, добавьте товары и суммы, при необходимости выберите контрагента, затем сохраните или отправьте.';

  @override
  String get faqInvoiceDetailsQuestion => 'Как просмотреть детали счёта?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'Нажмите на любой счёт в списке. В деталях транзакции отображаются позиции, итоги, скидки и платежи. Оттуда можно печатать, делиться, дублировать или платить.';

  @override
  String get faqZeroRateQuestion => 'Ставка или сумма отображается как ноль';

  @override
  String get faqZeroRateAnswer =>
      'Обычно это означает, что данные строки или платежа отсутствовали в старых сохранениях. Обновите приложение и при необходимости создайте или урегулируйте снова.';

  @override
  String get faqPartialPaymentQuestion => 'Как записать частичный платёж?';

  @override
  String get faqPartialPaymentAnswer =>
      'Откройте счёт → Детали транзакции → Произвести платёж. Введите сумму, метод и дату, затем Обработать расчёт.';

  @override
  String get faqMultiplePaymentQuestion => 'Как работает множественный платёж?';

  @override
  String get faqMultiplePaymentAnswer =>
      'Включите множественный платёж, нажмите редактировать и разделите итог на Наличные, Карту, QR и т.д. Каждый метод записывается отдельно.';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'Из разделённого платежа сохранён только один';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'Обновите до последней версии приложения. Старые сборки иногда сохраняли только первую строку. Урегулируйте снова, если баланс долга всё ещё неверен.';

  @override
  String get faqAddItemQuestion => 'Как добавить товар?';

  @override
  String get faqAddItemAnswer =>
      'Используйте Добавить товар из потока продаж или быстрое добавление. Введите название, цену, единицу, назначение и необязательное фото (JPEG/PNG/GIF/WebP, макс. 5 МБ), затем Создать товар.';

  @override
  String get faqCustomUnitQuestion => 'Как добавить пользовательскую единицу?';

  @override
  String get faqCustomUnitAnswer =>
      'В форме товара нажмите Единица → Создать новую единицу внизу списка, введите название (напр. Литр, Коробка) и Создать.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'Я изменил имя, но профиль показывает старое';

  @override
  String get faqProfileNameAnswer =>
      'Отредактируйте запись сотрудника (тот же email, что и для входа) и сохраните. Вкладка Ещё и панель должны обновиться.';

  @override
  String get faqRevenueDetailsQuestion => 'Что такое Детали дохода?';

  @override
  String get faqRevenueDetailsAnswer =>
      'Ежемесячный вид с графиком ежедневных тенденций, чистой прибылью, дебиторской задолженностью и разбивкой продаж против покупок по дням. Меняйте месяц через календарь или чип месяца.';

  @override
  String get faqOtherReportsQuestion => 'Где другие отчёты?';

  @override
  String get faqOtherReportsAnswer =>
      'Откройте Ещё и посмотрите в разделе Отчёты (Аналитика, Прибыли и убытки, Выписка и т.д.), если ваша роль имеет доступ.';

  @override
  String get faqWhenSyncQuestion => 'Когда нужно синхронизировать?';

  @override
  String get faqWhenSyncAnswer =>
      'Только когда администратор попросит и при наличии стабильного соединения. Синхронизация отправляет или получает данные между устройством и сервером.';

  @override
  String get faqFabPositionQuestion =>
      'Кнопка + слишком высоко в Продажах / Расходах';

  @override
  String get faqFabPositionAnswer =>
      'Она находится над нижней панелью навигации. Прокрутите список или обновите приложение, если кнопка перекрывает контент.';

  @override
  String get faqHowLogoutQuestion => 'Как выйти из системы?';

  @override
  String get faqHowLogoutAnswer => 'Ещё → Выход внизу списка настроек.';

  @override
  String get statisticsGoodMorning => 'Доброе утро';

  @override
  String get statisticsGoodAfternoon => 'Добрый день';

  @override
  String get statisticsGoodEvening => 'Добрый вечер';

  @override
  String get statisticsDefaultUser => 'Пользователь';

  @override
  String get statisticsCheckConnection =>
      'Пожалуйста, проверьте подключение и повторите попытку.';

  @override
  String get statisticsCouldNotLoadProfile => 'Не удалось загрузить профиль';

  @override
  String get statisticsCouldNotLoadData => 'Не удалось загрузить данные';

  @override
  String get statisticsPeriodDay => 'День';

  @override
  String get statisticsPeriodMonth => 'Месяц';

  @override
  String get statisticsPeriodYear => 'Год';

  @override
  String get statisticsSelectedPeriod => 'Выбранный период';

  @override
  String get statisticsSelectMonth => 'Выберите месяц';

  @override
  String get statisticsSelectMonthSubtitle =>
      'Выберите месяц для фильтрации данных';

  @override
  String get statisticsQuickOperations => 'Quick Operations';

  @override
  String get statisticsQuickOperationsSeeAll => 'Показать все';

  @override
  String get statisticsQuickOperationInvoice => 'Счёт';

  @override
  String get statisticsQuickOperationReports => 'Отчёты';

  @override
  String get statisticsAnnualRevenue => 'Годовой доход';

  @override
  String get statisticsCashflow => 'Денежный поток';

  @override
  String get statisticsCashflowLast7Days => 'Денежный поток (последние 7 дней)';

  @override
  String get statisticsCashflowLast12Months =>
      'Денежный поток (последние 12 месяцев)';

  @override
  String get statisticsDaily => 'Ежедневно';

  @override
  String get statisticsMonthly => 'Ежемесячно';

  @override
  String get statisticsOverall => 'Общий';

  @override
  String get statisticsLast7Days => 'Last 7 Days';

  @override
  String get statisticsLast12Months => 'Last 12 Months';

  @override
  String get statisticsAllYears => 'Все годы';

  @override
  String get statisticsNoDataAvailable => 'Нет доступных данных';

  @override
  String get statisticsMoneyIn => 'Деньги в';

  @override
  String get statisticsMoneyOut => 'Вывод денег';

  @override
  String get statisticsIncome => 'Доход';

  @override
  String get statisticsExpenses => 'Затраты';

  @override
  String get statisticsSalesSummary => 'Сводка продаж';

  @override
  String get statisticsPurchaseSummary => 'Сводная информация о покупке';

  @override
  String get statisticsTotalSales => 'Общий объем продаж';

  @override
  String get statisticsTotalIncome => 'Общий доход';

  @override
  String get statisticsTotalUnpaid => 'Всего неоплаченных';

  @override
  String get statisticsTotalPurchase => 'Общая сумма покупки';

  @override
  String get statisticsPaidPurchase => 'Платная покупка';

  @override
  String get statisticsUnpaidPurchase => 'Неоплаченная покупка';

  @override
  String get statisticsEmployeeDashboard => 'Панель управления сотрудника';

  @override
  String get statisticsDefaultEmployee => 'Сотрудник';

  @override
  String get statisticsDefaultDepartment => 'Отделение';

  @override
  String get statisticsDefaultPosition => 'Позиция';

  @override
  String get statisticsCurrentMonth => 'Текущий месяц';

  @override
  String get statisticsStatus => 'Статус';

  @override
  String get statisticsActive => 'Активный';

  @override
  String get statisticsWelcome => 'Добро пожаловать';

  @override
  String get statisticsEmployeeWelcomeMessage =>
      'Вы вошли в систему как сотрудник. Используйте меню навигации для доступа к доступным функциям.';

  @override
  String get statisticsRevenueDetails => 'Подробности о доходах';

  @override
  String get statisticsEmployeeDetails => 'Сведения о сотруднике';

  @override
  String get statisticsChangeMonth => 'Изменить месяц';

  @override
  String get statisticsFilterChartsSubtitle => 'Фильтрация диаграмм и разбивка';

  @override
  String get statisticsDailyTrend => 'Ежедневный тренд';

  @override
  String get statisticsDailyActivity => 'Ежедневная активность';

  @override
  String get statisticsNoDataForMonth => 'Нет данных за этот месяц';

  @override
  String get statisticsNetProfit => 'Чистая прибыль';

  @override
  String get statisticsMonthReceivables => 'Месячная дебиторская задолженность';

  @override
  String get statisticsMonthRevenue => 'Месячный доход';

  @override
  String get statisticsMonthExpenses => 'Месячные расходы';

  @override
  String get statisticsNoDailyEntries =>
      'В этом месяце ежедневных записей нет.';

  @override
  String get statisticsDailySalesBreakdown => 'Распределение продаж по дням';

  @override
  String get statisticsDailyBreakdown => 'Ежедневная разбивка';

  @override
  String get statisticsAdvance => 'Продвигать';

  @override
  String get statisticsExploreFeatures => 'Изучите возможности';

  @override
  String get statisticsShowOrHideFeatures => 'Показать или скрыть функции';

  @override
  String get statisticsAllFeaturesHidden => 'Все функции исследования скрыты';

  @override
  String get statisticsNoFeaturesForOrg =>
      'Для вашей организации нет доступных функций';

  @override
  String get statisticsTapTuneToShow =>
      'Коснитесь значка настройки выше, чтобы снова отобразить ярлыки.';

  @override
  String get statisticsMenuCheck => 'Сверка';

  @override
  String get statisticsMenuEmployee => 'Сотрудник';

  @override
  String get statisticsMenuOrder => 'Заказ';

  @override
  String get statisticsMenuInventory => 'Items';

  @override
  String get statisticsMenuCustomers => 'Клиенты';

  @override
  String get statisticsMenuCalculator => 'Liquor prices';

  @override
  String get statisticsMenuQuickExpenses => 'Быстрый\nРасходы';

  @override
  String get statisticsMenuQuickSales => 'Быстрый\nПродажи';

  @override
  String get statisticsMenuAddEmployee => 'Добавить\nСотрудник';

  @override
  String get statisticsMenuAddParty => 'Добавить\nконтрагента';

  @override
  String get statisticsMenuAddEmployeeSingle => 'Добавить сотрудника';

  @override
  String get statisticsMenuAddPartySingle => 'Добавить контрагента';

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
    return '$amount собрано';
  }

  @override
  String statisticsMetricPaid(String amount) {
    return '$amount оплачено';
  }

  @override
  String statisticsMoneyInAmount(String amount) {
    return 'Деньги на счете: $amount';
  }

  @override
  String statisticsMoneyOutAmount(String amount) {
    return 'Вывод денег: $amount';
  }

  @override
  String statisticsDayTooltip(String day, String amount) {
    return 'День $day\n$amount';
  }

  @override
  String statisticsProfitMargin(String percent) {
    return 'Маржа $percent%';
  }

  @override
  String get invoiceCommonActions => 'Действия';

  @override
  String get invoiceCommonSearchItems => 'Поиск предметов';

  @override
  String get invoiceCommonSearchItemsSubtitle => 'Поиск конкретных предметов';

  @override
  String get invoiceCommonAddNewInvoice => 'Добавить новый счет';

  @override
  String get invoiceCommonAddSalesInvoiceSubtitle =>
      'Создать новый счет продажи';

  @override
  String get invoiceCommonAddPurchaseInvoiceSubtitle =>
      'Создать новый счет на покупку';

  @override
  String get invoiceCommonSelectMonthYear => 'Выберите месяц/год';

  @override
  String get invoiceCommonSelectMonthYearSubtitle =>
      'Перейти к конкретному месяцу';

  @override
  String get invoiceCommonSelectMonthAndYear => 'Выберите месяц и год';

  @override
  String get invoiceCommonFilterByDate => 'Фильтровать по дате';

  @override
  String get invoiceCommonFilterByDateRange => 'Фильтровать по диапазону дат';

  @override
  String get invoiceCommonCloseSearch => 'Закрыть поиск';

  @override
  String get invoiceCommonSelectAll => 'Выбрать все';

  @override
  String get invoiceCommonToday => 'Сегодня';

  @override
  String get invoiceCommonTotalQuantity => 'Общее количество';

  @override
  String get invoiceCommonTotalAmount => 'Общая сумма';

  @override
  String get invoiceCommonTotal => 'Общий';

  @override
  String get invoiceCommonSearchForItems => 'Поиск предметов';

  @override
  String get invoiceCommonNoItemsFound => 'Элементы не найдены';

  @override
  String get invoiceCommonUnknownItem => 'Неизвестный предмет';

  @override
  String get invoiceCommonNotAvailable => 'Н/Д';

  @override
  String get invoiceSalesCouldNotLoad => 'Не удалось загрузить продажи.';

  @override
  String get invoiceSalesNoFound => 'Продажи не найдены';

  @override
  String get invoiceSalesSelectDate =>
      'Выберите дату, чтобы просмотреть продажи';

  @override
  String get invoiceSalesNoInvoicesFound => 'Счета-фактуры не найдены';

  @override
  String get invoiceSalesSelectDateLegacy =>
      'Выберите дату для просмотра счетов';

  @override
  String get invoicePurchaseCouldNotLoad => 'Не удалось загрузить расходы.';

  @override
  String get invoicePurchaseNoFound => 'Покупки не найдены';

  @override
  String get invoicePurchaseSelectDate => 'Выберите дату для просмотра покупок';

  @override
  String get invoiceWeekdaySun => 'Солнце';

  @override
  String get invoiceWeekdayMon => 'Пн.';

  @override
  String get invoiceWeekdayTue => 'Вт';

  @override
  String get invoiceWeekdayWed => 'Обвенчались';

  @override
  String get invoiceWeekdayThu => 'Чт';

  @override
  String get invoiceWeekdayFri => 'Пт';

  @override
  String get invoiceWeekdaySat => 'Суббота';

  @override
  String invoiceCommonSelectedCount(int count) {
    return '$count Выбрано';
  }

  @override
  String invoiceCommonQtyLabel(String qty) {
    return 'Кол-во: $qty';
  }

  @override
  String invoiceCommonInvoiceLabel(String number) {
    return 'Счет: $number';
  }

  @override
  String invoiceCommonCustomerLabel(String name) {
    return 'Клиент: $name';
  }

  @override
  String invoiceCommonSupplierLabel(String name) {
    return 'Поставщик: $name';
  }

  @override
  String invoiceCommonSearchingFor(String query) {
    return 'Ищем \"$query\"...';
  }

  @override
  String invoiceCommonSearchItemsHint(String scope) {
    return 'Поиск элементов в $scope...';
  }

  @override
  String invoiceCommonSalesSearchPrompt(String scope) {
    return 'Введите название товара, чтобы найти все продажи\nв $scope';
  }

  @override
  String invoiceCommonPurchaseSearchPrompt(String scope) {
    return 'Введите название товара, чтобы найти все покупки\nв $scope';
  }

  @override
  String invoiceCommonSalesNoMatch(String query, String scope) {
    return 'Нет продаж \"$query\"\nв $scope';
  }

  @override
  String invoiceCommonPurchaseNoMatch(String query, String scope) {
    return 'Нет покупок \"$query\"\nв $scope';
  }

  @override
  String invoiceCommonEmptyForDate(String date) {
    return 'для $date';
  }

  @override
  String invoiceFoundSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count продаж',
      one: '1 продажа',
    );
    return 'Найдено $_temp0';
  }

  @override
  String invoiceFoundPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count покупок',
      one: '1 покупка',
    );
    return 'Найдено $_temp0';
  }

  @override
  String invoiceDateSalesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count продаж',
      one: '1 продажа',
    );
    return '$_temp0';
  }

  @override
  String invoiceDatePurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count покупки',
      one: '1 покупка',
    );
    return '$_temp0';
  }

  @override
  String invoiceDateInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count счета',
      one: '1 счет',
    );
    return '$_temp0';
  }

  @override
  String invoiceDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count счета',
      one: '1 счет',
    );
    return 'Удалить $_temp0';
  }

  @override
  String invoiceDeleteMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count выбранные счета',
      one: '1 выбранный счет',
    );
    return 'Вы уверены, что хотите удалить $_temp0? Это действие невозможно отменить.';
  }

  @override
  String get contacts => 'Контакты';

  @override
  String get categories => 'Категории';

  @override
  String get manageStaff => 'Управление персоналом';

  @override
  String get payroll => 'Заработная плата';

  @override
  String get attendance => 'посещаемость';

  @override
  String get profitAndLoss => 'Прибыли и убытки';

  @override
  String get statementReport => 'Выписка';

  @override
  String get analytics => 'Аналитика';

  @override
  String get loggedOut => 'Вышел из системы';

  @override
  String organizationCodeDisplay(String code) {
    return 'Код: $code';
  }

  @override
  String get moreDataSynchronization => 'Синхронизация данных';

  @override
  String get moreSendDataToClient => 'Отправить данные клиенту';

  @override
  String get moreSendDataToClientSubtitle => 'Загрузить данные сервера клиенту';

  @override
  String get moreSendDataToClientWarning =>
      'Это действие заменит текущую клиентскую базу данных данными с сервера. Все недавние изменения клиента могут быть потеряны.';

  @override
  String get moreSendDataToClientConfirm =>
      'Вы уверены, что хотите отправить данные клиенту?';

  @override
  String get moreFetchDataFromClient => 'Получить данные от клиента';

  @override
  String get moreFetchDataFromClientSubtitle =>
      'Загрузить данные клиента на сервер';

  @override
  String get moreFetchDataFromClientWarning =>
      'Это действие заменит текущую базу данных сервера данными клиента. Все недавние изменения сервера могут быть потеряны.';

  @override
  String get moreFetchDataFromClientConfirm =>
      'Вы уверены, что хотите получить данные от клиента?';

  @override
  String get notifications => 'Уведомления';

  @override
  String get openingReminder => 'Напоминание об открытии';

  @override
  String get closingReminder => 'Закрытие напоминания';

  @override
  String get activityReminder => 'Sales & purchase reminder';

  @override
  String get openingTime => 'Время работы';

  @override
  String get closingTime => 'Время закрытия';

  @override
  String get activityReminderTime => 'Reminder time';

  @override
  String get notificationSettingsSaved => 'Настройки уведомлений сохранены.';

  @override
  String get notificationPermissionHint =>
      'Разрешите уведомления (и сигналы тревоги на Android), чтобы напоминания работали, когда приложение закрыто.';

  @override
  String dailyAtTime(String time) {
    return 'Ежедневно в $time';
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
  String get invoiceCommonYesterday => 'Вчера';

  @override
  String invoiceCommonTodayAt(String time) {
    return 'Сегодня $time';
  }

  @override
  String invoiceCommonDaysAgo(int count) {
    return '$count дней назад';
  }

  @override
  String invoiceReturnCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count возврат',
      one: '1 возврат',
    );
    return '$_temp0';
  }

  @override
  String get checkoutSelectParty => 'Выберите контрагента';

  @override
  String get partyPickerSubtitle => 'Для кого эта продажа?';

  @override
  String partyPickerSearchHint(String role) {
    return 'Поиск $role…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'Добавить $role';
  }

  @override
  String get partyPickerSettled => 'Оплачено';

  @override
  String get partyPickerSelectedLabel => 'ВЫБРАНО';

  @override
  String get checkoutCartSummary => 'Сводка корзины';

  @override
  String get checkoutNoItemsInCart => 'В корзине нет товаров';

  @override
  String get checkoutSearchHere => 'Искать здесь';

  @override
  String get checkoutCreateInvoice => 'Создать счет';

  @override
  String get checkoutEditInvoice => 'Редактировать счет';

  @override
  String get checkoutSaveInvoice => 'Сохранить счет';

  @override
  String get checkoutInvoiceSummary => 'Сводка счетов';

  @override
  String get checkoutEstimate => 'Оценивать';

  @override
  String get checkoutBasicInformation => 'Основная информация';

  @override
  String get checkoutAddItems => 'Добавить элементы';

  @override
  String get checkoutItemsSection => 'Предметы';

  @override
  String get checkoutPartyRequired => 'Контрагент *';

  @override
  String get checkoutPartyInformation => 'Информация о контрагенте';

  @override
  String get checkoutBillSummary => 'Краткое изложение законопроекта';

  @override
  String get checkoutBillSummaryHint =>
      'Нажмите, чтобы узнать более подробный расчет.';

  @override
  String get checkoutItemTotal => 'Товар Всего';

  @override
  String checkoutLoyaltyDiscount(String percent) {
    return 'Скидка лояльности ($percent%)';
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
    return '- Скидка ($percent%)';
  }

  @override
  String get checkoutTapToEdit => 'Нажмите, чтобы изменить';

  @override
  String get checkoutTotalAmount => 'Общая сумма';

  @override
  String get checkoutPaymentMode => 'Record payment';

  @override
  String get checkoutPaymentModeHint =>
      'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.';

  @override
  String get checkoutNetSalesAmount => 'Чистая сумма продаж';

  @override
  String get checkoutConfirmCheckout => 'Подтвердить оформление заказа';

  @override
  String get checkoutEditDiscount => 'Изменить скидку';

  @override
  String get checkoutPercentage => 'Процент';

  @override
  String get checkoutDiscard => 'Отказаться';

  @override
  String get checkoutPartialPayment => 'Частичная оплата';

  @override
  String get checkoutPartialPaymentBanner =>
      'Активировав частичную оплату, клиент сможет оплатить сумму, меньшую общей суммы счета.';

  @override
  String get checkoutPleaseEnterAmounts =>
      'Пожалуйста, введите соответствующие суммы:';

  @override
  String get checkoutPartialPaymentEqualHint =>
      'Поскольку ни один пользователь не назначен, общая сумма должна быть равна общей сумме счета.';

  @override
  String checkoutOverGrandTotalBy(String amount) {
    return 'Превышение общего итога: $amount';
  }

  @override
  String checkoutRemainingUnpaid(String amount) {
    return 'Остаток (невыплаченный из общей суммы): $amount';
  }

  @override
  String get checkoutConfirmPayment => 'Подтвердить платеж';

  @override
  String get checkoutUnpaidCredit => 'Неоплаченный / Кредит';

  @override
  String get checkoutAddAtLeastOneLine =>
      'Добавьте хотя бы одну позицию, чтобы просмотреть оценку';

  @override
  String get checkoutMultiplePayment => 'Множественный платеж';

  @override
  String get checkoutPaymentStatus => 'Статус платежа';

  @override
  String get checkoutPaymentMethods => 'Способы оплаты';

  @override
  String get checkoutPaymentMethod => 'Способ оплаты';

  @override
  String get checkoutTenderAmount => 'Сумма тендера';

  @override
  String get checkoutLoadingPaymentMethods => 'Загрузка способов оплаты…';

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
  String get stockSearchByDateHint => 'Поиск по дате или месяцу…';

  @override
  String get stockNoMatches => 'Нет совпадений';

  @override
  String get stockTryDifferentSearch => 'Попробуйте другой поисковый запрос';

  @override
  String get stockTryAnotherSearch => 'Попробуйте другой поиск';

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
    return 'Кол-во $qty';
  }

  @override
  String stockCardSummary(String records, String items, String locations) {
    return '$records записей · $items элементов · $locations местоположений';
  }

  @override
  String get stockFilterTitle => 'Filter stock reconciliation';

  @override
  String get stockBatchNumber => 'Номер партии';

  @override
  String get stockLocation => 'Расположение';

  @override
  String get stockOptionalHint => 'Необязательный';

  @override
  String get stockApplyFilters => 'Применить фильтры';

  @override
  String get stockClearFields => 'Очистить поля';

  @override
  String get stockDeleteAllTooltip => 'Удалить все акции на эту дату';

  @override
  String get stockNoItemsFound => 'Товары на складе не найдены';

  @override
  String get stockNoItemsSubtitle =>
      'Попробуйте другие фильтры или другую отчетную дату.';

  @override
  String get stockAdjustFilters => 'Настроить фильтры';

  @override
  String get stockSearchItemHint => 'Поиск товара, партии, местоположения…';

  @override
  String get stockEditQuantities => 'Редактировать количества';

  @override
  String get stockNoChangesDetected => 'Никаких изменений не обнаружено';

  @override
  String stockErrorPreparingChanges(String error) {
    return 'Ошибка при подготовке изменений: $error.';
  }

  @override
  String get stockUpdateSuccessful => 'Обновление успешно!';

  @override
  String get stockSummary => 'Краткое содержание';

  @override
  String get stockTotalRequested => 'Всего запрошено';

  @override
  String get stockSuccessfullyUpdated => 'Успешно обновлено';

  @override
  String get stockFailed => 'Неуспешный';

  @override
  String get stockUpdateFailed => 'Обновление не выполнено';

  @override
  String get stockClearAllQuantitiesTitle => 'Очистить все количества?';

  @override
  String get stockClearAllQuantitiesMessage =>
      'Это сбросит все количества на 0. Вы уверены?';

  @override
  String get stockClearAll => 'Очистить все';

  @override
  String get stockUpdatingQuantities => 'Обновление количества запасов...';

  @override
  String get stockEditQuantitiesTitle => 'Редактировать количество запасов';

  @override
  String stockReportingDate(String date) {
    return 'Отчетная дата: $date';
  }

  @override
  String stockTotalItemsHint(String count) {
    return 'Всего позиций: $count • При необходимости обновите количество.';
  }

  @override
  String get stockItemName => 'Название предмета';

  @override
  String stockBatchPrefix(String batch) {
    return 'Пакет: $batch';
  }

  @override
  String get stockDeleteConfirmTitle => 'Подтвердить удаление';

  @override
  String get stockDeleteConfirmIntro =>
      'Вы собираетесь окончательно удалить все товары на складе на следующую дату:';

  @override
  String get stockDeleteConfirmWarning =>
      'Это действие невозможно отменить. Все биржевые записи на эту дату будут удалены без возможности восстановления.';

  @override
  String get stockNoInternetRetry =>
      'Нет подключения к Интернету. Пожалуйста, проверьте подключение и повторите попытку.';

  @override
  String get itemsTitle => 'Предметы';

  @override
  String get itemAddSheetTitle => 'Добавить элемент';

  @override
  String get itemSingleAdd => 'Одиночное добавление';

  @override
  String get itemBulkAdd => 'Массовое добавление';

  @override
  String get itemBulkAddTitle => 'Массовое добавление элементов';

  @override
  String get itemEditTitle => 'Редактировать элемент';

  @override
  String get itemAddTitle => 'Добавить элемент';

  @override
  String get itemCreateButton => 'Создать элемент';

  @override
  String get itemUpdateButton => 'Обновить элемент';

  @override
  String get itemDeleteTitle => 'Удалить элемент';

  @override
  String itemDeleteConfirm(String name) {
    return 'Вы уверены, что хотите удалить «$name»?';
  }

  @override
  String get itemDeletedSuccess => 'Объект успешно удален';

  @override
  String get itemCreatedSuccess => 'Объект успешно создан';

  @override
  String get itemUpdatedSuccess => 'Элемент успешно обновлен';

  @override
  String get itemLoading => 'Загрузка элементов...';

  @override
  String get itemErrorTitle => 'Упс! Что-то пошло не так';

  @override
  String get itemTryAgain => 'Попробуйте еще раз';

  @override
  String get itemSearchHint => 'Поиск предметов';

  @override
  String get itemNoItemsFound => 'Элементы не найдены';

  @override
  String get itemTryAdjustSearch => 'Попробуйте изменить условия поиска';

  @override
  String get itemNoItemsAvailable => 'Нет доступных товаров';

  @override
  String get itemAddToGetStarted => 'Добавьте элементы, чтобы начать';

  @override
  String get itemNoMoreItems => 'Больше нет предметов';

  @override
  String get itemPurposeBoth => 'Оба';

  @override
  String get itemPurposePurchases => 'Покупки';

  @override
  String get itemTypeProduct => 'Продукт';

  @override
  String get itemTypeService => 'Услуга';

  @override
  String get itemTypeInventory => 'Инвентарь';

  @override
  String get itemPhotoTitle => 'Фото товара';

  @override
  String get itemPhotoHint =>
      'Нажмите здесь, чтобы выбрать или загрузить фотографии';

  @override
  String get itemPhotoFormats => 'JPEG, PNG, GIF или WebP · максимум 5 МБ';

  @override
  String get itemAddPhoto => 'Добавить фото';

  @override
  String get itemPhotoLibrary => 'Фототека';

  @override
  String get itemPhotoLibraryHint => 'Выбирайте из своих фотографий';

  @override
  String get itemTakePhoto => 'Сфотографироваться';

  @override
  String get itemUploadGallery => 'Загрузить из галереи';

  @override
  String get itemUploadGalleryHint => 'Просматривать файлы на этом устройстве';

  @override
  String get itemTypeLabel => 'Тип';

  @override
  String get itemTypeField => 'Тип элемента';

  @override
  String get itemNameLabel => 'Название предмета';

  @override
  String get itemNameHint => 'Введите название элемента';

  @override
  String get itemBarcodeLabel => 'Штрих-код / ​​QR-код';

  @override
  String get itemBarcodeField => 'Штрих-код/QR-код';

  @override
  String get itemBarcodeHint => 'Сканируйте из панели приложения или вставьте';

  @override
  String get itemSkuLabel => 'SKU (optional)';

  @override
  String get itemSkuField => 'SKU';

  @override
  String get itemSkuHint => 'Product code — optional';

  @override
  String get itemPickerSearchHint => 'Search items by name or SKU…';

  @override
  String get itemRateLabel => 'Ставка';

  @override
  String get itemUnitLabel => 'Единица';

  @override
  String get itemPurposeLabel => 'Цель';

  @override
  String get itemSelectUnit => 'Выберите единицу измерения';

  @override
  String get itemSelectPurpose => 'Выберите цель';

  @override
  String get itemSelectCategory => 'Выберите категорию';

  @override
  String get itemSelectType => 'Выберите тип';

  @override
  String get itemSelectItemType => 'Выберите тип элемента';

  @override
  String get itemSearchUnits => 'Поиск единиц…';

  @override
  String get itemSearchPurpose => 'Цель поиска…';

  @override
  String get itemSearchCategories => 'Категории поиска…';

  @override
  String get itemCreateCustomUnit => 'Создать собственный блок';

  @override
  String get itemUnitName => 'Название подразделения';

  @override
  String get itemUnitNameHint => 'например, литр, коробка, штука';

  @override
  String get itemValidationName => 'Пожалуйста, введите название товара';

  @override
  String get itemValidationRate => 'Пожалуйста, введите цену';

  @override
  String get itemValidationNumber => 'Пожалуйста, введите действительный номер';

  @override
  String get itemSelectUnitRequired => 'Пожалуйста, выберите единицу измерения';

  @override
  String get itemSelectPurposeRequired => 'Пожалуйста, выберите цель';

  @override
  String get itemSelectCategoryRequired => 'Выберите категорию';

  @override
  String get itemImageMissing => 'Файл изображения отсутствует';

  @override
  String get itemImageFormatError => 'Используйте JPEG, PNG, GIF или WebP.';

  @override
  String get itemImageSizeError => 'Изображение должно быть 5 МБ или меньше.';

  @override
  String get itemScanBarcode => 'Сканировать штрих-код';

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
    return 'Имя заполнено из каталога: $name';
  }

  @override
  String get itemBarcodePasteHint =>
      'Название продукта не найдено — в качестве имени вставлен код. Отредактируйте, если необходимо.';

  @override
  String get itemBulkRefillTooltip => 'Заполните предыдущий ввод';

  @override
  String get itemBulkAddRow => 'Добавить строку';

  @override
  String itemBulkRowLabel(String index) {
    return 'Товар $index';
  }

  @override
  String get itemBulkNameRequired => 'Требуется имя';

  @override
  String get itemBulkInvalidNumber => 'Неверный номер';

  @override
  String get itemBulkCreating => 'Создание…';

  @override
  String get itemBulkCreateItems => 'Создание предметов';

  @override
  String itemBulkCreatedCount(String count) {
    return 'Создано $count элементов';
  }

  @override
  String itemBulkCreateFailed(String error) {
    return 'Не удалось создать элементы: $error.';
  }

  @override
  String get itemBulkNoDraft => 'Сохраненный черновик не найден';

  @override
  String get itemBulkInvalidDraft =>
      'Формат сохраненного черновика недействителен.';

  @override
  String get itemBulkDraftRestored => 'Предыдущий черновик восстановлен.';

  @override
  String get itemBulkDraftRestoreFailed =>
      'Не удалось восстановить сохраненный черновик.';

  @override
  String get itemBulkAtLeastOne => 'Добавьте хотя бы один элемент';

  @override
  String get itemBulkCategoriesLoading =>
      'Категории загружаются, попробуйте еще раз.';

  @override
  String get itemBulkLoadingCategories => 'Загрузка категорий…';

  @override
  String get inventoryTitle => 'Аналитика запасов';

  @override
  String get inventorySubtitle =>
      'Отслеживание движения запасов в режиме реального времени';

  @override
  String get inventorySearchHint => 'Поиск предметов...';

  @override
  String get inventorySold => 'Продал';

  @override
  String get inventoryPurchased => 'Куплено';

  @override
  String get catNoCategories => 'Никаких категорий. Нажмите +, чтобы создать.';

  @override
  String get catLoadCategories => 'Категории загрузки';

  @override
  String get catCreated => 'Категория создана';

  @override
  String get catRenamed => 'Категория переименована';

  @override
  String get catDeleted => 'Категория удалена';

  @override
  String catDeletedBulk(int count) {
    return '$count categories deleted';
  }

  @override
  String get catNewTitle => 'Новая категория';

  @override
  String get catRenameTitle => 'Переименовать категорию';

  @override
  String get catNewName => 'Новое имя';

  @override
  String get catRename => 'Переименовать';

  @override
  String get catDeleteTitle => 'Удалить категорию';

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
    return 'Удалить \"$name\"?';
  }

  @override
  String get catDeleteLinkedHint =>
      'Предметы связаны. Вы можете принудительно удалить, чтобы разорвать связь.';

  @override
  String get catForceDelete => 'Принудительное удаление';

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
    return '$count элементов';
  }

  @override
  String get contactFavoritesOnly => 'Только избранное';

  @override
  String get contactShowAll => 'Показать все контакты';

  @override
  String get contactSearchHint =>
      'Поиск по имени, телефону, электронной почте…';

  @override
  String get contactNoConnection => 'Нет связи';

  @override
  String get contactCheckNetwork => 'Проверьте свою сеть и повторите попытку.';

  @override
  String get contactSomethingWrong => 'Что-то пошло не так';

  @override
  String get contactNoContacts => 'Нет контактов';

  @override
  String get contactNoFavorites =>
      'Нет фаворитов. Отключите звездный фильтр или добавьте избранное в контакте.';

  @override
  String get contactTrySearchOrAdd =>
      'Попробуйте другой поиск или нажмите +, чтобы добавить контакт.';

  @override
  String get contactEndOfList => 'Конец списка';

  @override
  String get contactNewTooltip => 'Новый контакт';

  @override
  String get contactLoading => 'Загрузка контактов…';

  @override
  String get contactUnknown => 'Неизвестный';

  @override
  String get contactCallTooltip => 'Вызов';

  @override
  String get contactEditTitle => 'Изменить контакт';

  @override
  String get contactNewTitle => 'Новый контакт';

  @override
  String get contactSelectTitle => 'Выберите контакт';

  @override
  String get contactDeleteTitle => 'Удалить контакт?';

  @override
  String get contactDeleteUndo => 'Это действие невозможно отменить.';

  @override
  String get contactNameRequired => 'Требуется имя';

  @override
  String get contactNameLabel => 'Имя *';

  @override
  String get contactNameHint => 'Контактное имя';

  @override
  String get contactPhoneHint => '+977-9841234567';

  @override
  String get contactEmailHint => 'электронная почта@example.com';

  @override
  String get contactCategoryHint => 'например бизнес, общий, VIP';

  @override
  String get contactCompanyHint => 'Название компании';

  @override
  String get contactFavorite => 'Любимый';

  @override
  String get contactCannotCall =>
      'Невозможно совершать звонки на этом устройстве';

  @override
  String get contactPermissionDenied =>
      'В разрешении на контакт было отказано. Вы можете включить его в настройках.';

  @override
  String get contactPermissionRequired =>
      'Для импорта с телефона требуется разрешение контакта.';

  @override
  String get contactImported => 'Контакт импортирован с телефона';

  @override
  String get contactCreated => 'Контакт создан';

  @override
  String get contactUpdated => 'Контакт обновлен';

  @override
  String get contactDeleted => 'Контакт удален';

  @override
  String get contactImportSearchHint =>
      'Поиск по имени, телефону, электронной почте, компании';

  @override
  String get contactImportNoResults => 'Контакты не найдены';

  @override
  String get checkoutMultiplePaymentHint =>
      'Включите эту опцию, если клиент платит через несколько режимов оплаты.';

  @override
  String get checkoutFillRemainingBalance => 'Пополнить остаток';

  @override
  String get checkoutEnterAtLeastOnePayment =>
      'Введите хотя бы одну сумму платежа';

  @override
  String get checkoutPaymentsExceedTotal =>
      'Общая сумма платежей не может превышать общую сумму';

  @override
  String checkoutSentAs(String api) {
    return 'Отправлено как: $api';
  }

  @override
  String get paymentCard => 'Карта';

  @override
  String get paymentQr => 'QR';

  @override
  String get paymentBank => 'Банк';

  @override
  String get paymentTransfer => 'Передача';

  @override
  String get paymentBankTransfer => 'Банковский перевод';

  @override
  String get paymentSettlement => 'Урегулирование';

  @override
  String get paymentCheque => 'Проверять';

  @override
  String get paymentDigital => 'Цифровой';

  @override
  String get paymentDigitalQr => 'Цифровой (QR)';

  @override
  String get closeSummaryTitle => 'Сводка закрытия';

  @override
  String get closeTabDashboard => 'Панель управления';

  @override
  String get closeTabCredits => 'Кредиты';

  @override
  String get closeWelcome => 'Добро пожаловать в заключительное резюме';

  @override
  String get closeSelectDateHint =>
      'Выберите дату и нажмите обновить для загрузки данных';

  @override
  String get closeLoadingDashboard =>
      'Загрузка данных информационной панели...';

  @override
  String get closeDataDeleted => 'Данные удалены';

  @override
  String closeErrorPrefix(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get closeExtraAmount => 'Дополнительная сумма';

  @override
  String get closeExtraAmountDesc =>
      'Дополнительные денежные средства или корректировки, зарегистрированные за этот заключительный день.';

  @override
  String get closeLostAmount => 'Потерянная сумма';

  @override
  String get closeLostAmountDesc =>
      'За этот период отмечена нехватка или отклонение денежных средств.';

  @override
  String get closeTapForDetails => 'Нажмите, чтобы узнать подробности';

  @override
  String get closeAmountLabel => 'Закрытие';

  @override
  String get closeAmountFormula => 'Формула закрывающей суммы';

  @override
  String get closeFormulaExpression =>
      'Продажи за наличные - Расходы за наличные = Сумма закрытия';

  @override
  String get closeCashSales => 'Продажа за наличные';

  @override
  String get closeCashExpenses => 'Денежные расходы';

  @override
  String get closeClosingAmount => 'Завершающая сумма';

  @override
  String get closeWhatThisMeans => 'Что это значит:';

  @override
  String get closeClosingMeaning =>
      'Это сумма наличных денег, которая должна находиться в вашем регистре/ящике в конце дня. Он представляет собой все полученные денежные средства за вычетом всех выплаченных денежных средств.';

  @override
  String get closeQuickStats => 'Быстрая статистика';

  @override
  String get closeTapCardHint =>
      'Нажмите на карточку, чтобы просмотреть ее краткое описание.';

  @override
  String get closeOpeningBalance => 'Начальный баланс';

  @override
  String get closeTotalSales => 'Общая выручка';

  @override
  String get closeQrAmount => 'QR-сумма';

  @override
  String get closeCashAmount => 'Сумма наличных';

  @override
  String get closeSalesDiscount => 'Скидка при продаже';

  @override
  String get closeCreditQr => 'Кредитный QR';

  @override
  String get closeCreditCash => 'Кредит наличными';

  @override
  String get closeCreditDiscount => 'Кредитная скидка';

  @override
  String get closePayCashGetQr => 'Оплатить наличными → Получить QR';

  @override
  String get closePayQrGetCash => 'Оплатить QR → Получить наличные';

  @override
  String get closePaymentMix => 'Комбинация платежей';

  @override
  String get closePaymentMixHint =>
      'Кассовый или цифровой · На панели отображается доля продаж';

  @override
  String get closeCashVsDigitalTooltip => 'Наличные и цифровая доля продаж';

  @override
  String closeSalesShareDesc(String label, String percent) {
    return '$label составил $percent% от общего объема продаж за этот день.';
  }

  @override
  String closeSalesLabel(String label) {
    return '$label продаж';
  }

  @override
  String get closeNoTransactions => 'Нет доступных транзакций';

  @override
  String get closeRecentTransactions => 'Недавние транзакции';

  @override
  String get closeViewAll => 'Посмотреть все';

  @override
  String get closeNoPurchases => 'Нет доступных покупок';

  @override
  String get closeRecentPurchases => 'Недавние покупки';

  @override
  String get closeNoSalesDate => 'Нет продаж на эту дату';

  @override
  String get closeNoSalesHint =>
      'Продажи будут показаны здесь после их регистрации.';

  @override
  String get closeRoomSales => 'Продажа номеров';

  @override
  String get closeEmployeeSales => 'Продажи сотрудников';

  @override
  String get closeOtherSales => 'other продаж';

  @override
  String closeSectionCount(String title, String count) {
    return '$title ($count)';
  }

  @override
  String closeDiscountShort(String amount) {
    return 'Диск: $amount';
  }

  @override
  String closePercentOff(String percent) {
    return 'Скидка $percent%';
  }

  @override
  String get closePending => 'В ожидании';

  @override
  String get closeNoCreditPayments => 'Никаких кредитных платежей';

  @override
  String get closeNoCreditHint => 'Платежи по кредиту появятся здесь';

  @override
  String get closeViewStatistics => 'Посмотреть статистику';

  @override
  String get closeExportData => 'Экспорт данных';

  @override
  String get closeExportComingSoon =>
      'Функция экспорта будет реализована здесь';

  @override
  String get closeHintOpeningBalance =>
      'Денежная позиция на начало выбранного дня.';

  @override
  String get closeHintTotalSales =>
      'Сумма всех продаж, зарегистрированных на эту дату.';

  @override
  String get closeHintQrAmount =>
      'Платежи, полученные с помощью QR или цифровыми методами.';

  @override
  String get closeHintCashAmount => 'Денежная часть продаж за день.';

  @override
  String get closeHintCashExpenses =>
      'Денежные средства, выплаченные на расходы в течение дня.';

  @override
  String get closeHintSalesDiscount => 'Скидки распространяются на распродажи.';

  @override
  String get closeHintCreditQr => 'QR-коллекции, связанные с кредитами.';

  @override
  String get closeHintCreditCash =>
      'Движение денежных средств, связанных с кредитом.';

  @override
  String get closeHintCreditDiscount =>
      'Скидки применяются при кредитных операциях.';

  @override
  String get closeHintPayCashGetQr =>
      'Обмен, при котором были оплачены наличные и получен QR-кредит.';

  @override
  String get closeHintPayQrGetCash =>
      'Обмен, где был оплачен QR и получены наличные.';

  @override
  String get closeOpeningAmount => 'Начальная сумма';

  @override
  String get closeCurrentAmount => 'Текущая сумма';

  @override
  String get closeSaveReport => 'Сохранить отчет';

  @override
  String get closeUpdateSummary => 'Сводка обновлений';

  @override
  String get closeExists => 'Существует';

  @override
  String get closeExistingDataInfo =>
      'Вы можете просмотреть или изменить существующие данные';

  @override
  String get closeEnterOpeningAmount => 'Пожалуйста, введите начальную сумму';

  @override
  String get closeEnterValidAmount =>
      'Пожалуйста, введите действительную сумму';

  @override
  String get closeAmountCannotBeNegative => 'Amount cannot be negative';

  @override
  String get googleDriveBackupSectionTitle =>
      'Резервное копирование и синхронизация';

  @override
  String get googleDriveBackupTitle => 'Резервная копия Google Drive';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Войдите, чтобы безопасно сохранить данные организации в Google Drive.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'Вход выполнен как $email';
  }

  @override
  String get googleDriveSignIn => 'Войти через Google';

  @override
  String get googleDriveSignOut => 'Выйти';

  @override
  String get googleDriveBackupNow => 'Создать копию сейчас';

  @override
  String get googleDriveSignInSuccess => 'Вход в Google Drive выполнен';

  @override
  String get googleDriveSignOutSuccess => 'Выход из Google Drive выполнен';

  @override
  String get googleDriveSignInCancelled => 'Вход через Google отменён';

  @override
  String get googleDriveBackupStarting => 'Подготовка резервной копии…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'Копия загружена ($tableCount таблиц, $recordCount записей)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'Для резервного копирования нужен полный перезапуск приложения. Закройте приложение, откройте снова и повторите.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'Резервное копирование не удалось: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'Последняя копия: $date';
  }

  @override
  String get backupSyncPageTitle => 'Резервное копирование и синхронизация';

  @override
  String get backupSyncGoogleAccount => 'Аккаунт Google';

  @override
  String get backupSyncSignedInAs => 'Вход выполнен как';

  @override
  String get backupSyncSignInHint =>
      'Войдите через Google, чтобы создать резервную копию данных организации.';

  @override
  String get backupSyncLastSyncTitle => 'Последняя синхронизация';

  @override
  String get backupSyncLastSyncDate => 'Дата и время';

  @override
  String get backupSyncNeverSynced => 'Резервная копия ещё не загружена.';

  @override
  String get backupSyncOrganization => 'Организация';

  @override
  String get backupSyncTables => 'Сохранённые таблицы';

  @override
  String get backupSyncRecords => 'Сохранённые записи';

  @override
  String get backupSyncStatus => 'Статус';

  @override
  String get backupSyncStatusSuccess => 'Завершено';

  @override
  String get backupSyncActiveOrganization => 'Текущая организация';

  @override
  String get backupSyncActiveOrganizationHint =>
      'Резервная копия загружает данные организации, которую вы используете сейчас.';

  @override
  String get backupSyncUnknownOrganization => 'Текущая организация';

  @override
  String get backupSyncInProgress => 'Синхронизация выполняется';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'Шаг: $step';
  }

  @override
  String get backupSyncStepExport => 'Экспорт локальных данных';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'Загрузка $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'Загрузка $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'Последняя ошибка: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'Выйти из Google Drive на этом устройстве?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Резервная копия в Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync =>
      'Вход выполнен · Копии ещё нет';

  @override
  String get backupSyncConnected => 'Подключено';

  @override
  String get backupSyncCompletedHint =>
      'Ваши данные надёжно сохранены в Google Drive.';

  @override
  String get backupSyncPhaseExport => 'Экспорт';

  @override
  String get backupSyncPhaseUpload => 'Загрузка';

  @override
  String get backupAutoSettingsTitle => 'Настройки Google Drive';

  @override
  String get backupAutoBackupTitle => 'Автоматическое резервное копирование';

  @override
  String get backupAutoBackupHint =>
      'Автоматическое резервное копирование при запуске приложения';

  @override
  String get backupWifiOnlyTitle => 'Копировать только через Wi‑Fi';

  @override
  String get backupWifiOnlyHint => 'Автокопирование ожидает Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => 'Использовать мобильные данные';

  @override
  String get backupAutoFrequencyTitle => 'Частота резервного копирования';

  @override
  String get backupAutoFrequencyOff => 'Выкл.';

  @override
  String get backupAutoFrequencyDaily => 'Ежедневно';

  @override
  String get backupAutoFrequencyWeekly => 'Еженедельно';

  @override
  String get backupAutoFrequencyMonthly => 'Ежемесячно';

  @override
  String get backupAutoSyncDirectionTitle => 'Автосинхронизация';

  @override
  String get backupAutoDirectionUpload => 'Загрузить в облако';

  @override
  String get backupAutoDirectionDownload => 'Скачать из облака';

  @override
  String get backupAutoDirectionBoth => 'Загрузка и скачивание';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'Последнее автокопирование: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'Последнее автовосстановление: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'Последняя автосинхронизация не удалась: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'Последняя автосинхронизация пропущена: $detail';
  }

  @override
  String get restoreAction => 'Восстановить';

  @override
  String get restoreFromGoogleDrive => 'Восстановить из Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'Войдите и выберите копию для восстановления организации на этом устройстве.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return 'Восстановить «$name»? Локальные данные этой организации будут заменены.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name восстановлено. Теперь можно войти.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'Восстановление не удалось: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'Резервные копии в Google Drive не найдены.';

  @override
  String get restoreFromGoogleDriveStarting => 'Запуск восстановления…';

  @override
  String get restoreStepDownload => 'Скачивание копии';

  @override
  String get restoreStepCreateDatabase => 'Создание базы данных';

  @override
  String get restoreStepImport => 'Импорт данных';

  @override
  String get restoreStepFinalize => 'Завершение восстановления';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'Последняя синхронизация: $date';
  }

  @override
  String get security => 'Безопасность';

  @override
  String get appLockTitle => 'Блокировка приложения';

  @override
  String get appLockSubtitle =>
      'Требовать PIN или биометрию при повторном открытии приложения';

  @override
  String get appPin => 'PIN приложения';

  @override
  String appPinSubtitle(int length) {
    return 'Быстрая разблокировка $length-значным PIN';
  }

  @override
  String get useBiometricUnlock => 'Использовать Face ID / биометрию';

  @override
  String get useBiometricUnlockSubtitle =>
      'Разблокировка отпечатком или Face ID после настройки PIN';

  @override
  String get changeAppPin => 'Изменить PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'Настроить PIN';

  @override
  String get confirmAppPin => 'Подтвердите PIN';

  @override
  String get enterAppPin => 'Введите PIN';

  @override
  String get enterPasscode => 'Введите код';

  @override
  String tapDigitsToUnlock(int length) {
    return 'Нажмите любые $length цифры для разблокировки.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'Выберите $length-значный код для этой организации';
  }

  @override
  String get confirmPasscodeHint => 'Введите код повторно для подтверждения';

  @override
  String createAppPinHint(int length) {
    return 'Выберите $length-значный PIN для этой организации';
  }

  @override
  String get confirmAppPinHint => 'Введите PIN повторно для подтверждения';

  @override
  String get appPinMismatch => 'PIN не совпадают. Попробуйте снова.';

  @override
  String get appPinIncorrect => 'Неверный PIN. Попробуйте снова.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'Неверный PIN. Осталось попыток: $remaining.';
  }

  @override
  String get appPinLockoutMessage =>
      'Слишком много неверных попыток. Войдите по email и паролю, чтобы сбросить PIN.';

  @override
  String get appPinSetSuccess => 'PIN сохранён для этой организации';

  @override
  String get appPinRemoved => 'PIN приложения удалён';

  @override
  String get appLockSettingsSaved => 'Настройки блокировки сохранены';

  @override
  String get biometricUnlockReason => 'Разблокировать BizTrack';

  @override
  String get biometricNotAvailable => 'Биометрия недоступна на этом устройстве';

  @override
  String get biometricRequiresPin =>
      'Настройте PIN приложения перед включением биометрии';

  @override
  String get disableAppPinTitle => 'Удалить PIN приложения?';

  @override
  String get disableAppPinMessage =>
      'Face ID / биометрическая разблокировка также будет отключена для этой организации.';

  @override
  String get verifyPinToRemoveTitle => 'Введите PIN';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'Подтвердите $length-значный PIN для снятия блокировки';
  }

  @override
  String get unlockApp => 'Разблокировать приложение';

  @override
  String get usePinInstead => 'Использовать PIN';

  @override
  String get useBiometricInstead => 'Использовать биометрию';

  @override
  String get signInWithFaceId => 'Войти через Face ID';

  @override
  String get signInWithFingerprint => 'Войти по отпечатку';

  @override
  String get signInWithBiometric => 'Войти по биометрии';

  @override
  String get signInWithPin => 'Войти по PIN';

  @override
  String get setUpQuickUnlock => 'Настроить быстрый вход по PIN';

  @override
  String get setUpFaceIdOrPin => 'Настроить Face ID или PIN';

  @override
  String get setUpFingerprintOrPin => 'Настроить отпечаток или PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'Используйте биометрию или PIN для этой организации';

  @override
  String quickUnlockAsUser(String email) {
    return 'Быстрый вход как $email';
  }

  @override
  String get orContinueWithPassword => 'или войти с паролем';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'Включить быстрый вход?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'Настройте Face ID, отпечаток или PIN для быстрого входа в следующий раз. Можно изменить позже в настройках.';

  @override
  String get notNow => 'Не сейчас';

  @override
  String get setUpNow => 'Настроить сейчас';

  @override
  String get enableFaceIdTitle => 'Включить Face ID?';

  @override
  String get enableFingerprintTitle => 'Включить отпечаток пальца?';

  @override
  String get enableBiometricTitle => 'Включить биометрию?';

  @override
  String get enableBiometricAfterPinMessage =>
      'Используйте биометрию устройства вместе с PIN для быстрого входа.';

  @override
  String get useFaceIdUnlock => 'Использовать Face ID';

  @override
  String get useFingerprintUnlock => 'Использовать отпечаток';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => 'Год';

  @override
  String get reportPeriodMonth => 'Месяц';

  @override
  String get reportPeriodRange => 'Диапазон';

  @override
  String get reportPeriodDay => 'День';

  @override
  String get reportPeriodFrom => 'С';

  @override
  String get reportPeriodTo => 'По';

  @override
  String get reportPeriod => 'Период';

  @override
  String get reportAllPurchases => 'Все закупки';

  @override
  String get reportBeforeTax => 'До налогов';

  @override
  String get reportRevenueRetained => 'Удержанная выручка';

  @override
  String get reportHideDetails => 'Скрыть детали';

  @override
  String get reportShowDetails => 'Показать детали';

  @override
  String get reportSalesRevenue => 'Выручка от продаж';

  @override
  String get reportDiscountsGiven => 'Предоставленные скидки';

  @override
  String get reportNetRevenue => 'Чистая выручка';

  @override
  String get reportOperatingExpenses => 'Операционные расходы';

  @override
  String get reportTotalExpenses => 'Общие расходы';

  @override
  String get reportGrossProfit => 'Валовая прибыль';

  @override
  String get reportGrossProfitChart => 'Валовая прибыль';

  @override
  String get reportOperatingPlDisclaimer =>
      'Налоги, амортизация и зарплатные обязательства ещё не учтены — операционная оценка P&L.';

  @override
  String get reportContraLabel => 'Корреспондирующий';

  @override
  String get reportNoDataForPeriod => 'Нет данных за выбранный период';

  @override
  String get reportRevenueVsExpenses => 'Выручка vs расходы';

  @override
  String get reportExpenseBreakdown => 'Разбивка расходов';

  @override
  String get reportExpenseFallback => 'Расход';

  @override
  String get reportGrossMarginPercent => 'Валовая маржа %';

  @override
  String get reportRoomVsFnB => 'Номера vs F&B';

  @override
  String get reportSegmentRoom => 'Номера';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'Ключевые показатели';

  @override
  String get reportIncomeStatement => 'Отчёт о прибылях и убытках';

  @override
  String get reportChartsSection => 'Графики';

  @override
  String get reportSegmentSummary => 'Сводка по сегментам';

  @override
  String get reportFailedToLoad => 'Не удалось загрузить отчёт';

  @override
  String get reportOverview => 'Обзор';

  @override
  String get reportOverviewCash => 'Наличные';

  @override
  String get reportOverviewBank => 'Банк';

  @override
  String get reportMonthlyOpeningBalance => 'Месячный начальный остаток';

  @override
  String get reportOpeningBalanceHint =>
      'Остаток наличных на начало каждого месяца';

  @override
  String get reportCashInOut => 'Поступление / расход наличных';

  @override
  String get reportCashIn => 'Поступление наличных';

  @override
  String get reportCashOut => 'Расход наличных';

  @override
  String get reportBankReceiptsPayments => 'Банковские поступления / платежи';

  @override
  String get reportReceipts => 'Поступления';

  @override
  String get reportPayments => 'Платежи';

  @override
  String get reportDailyCashVsQr => 'Ежедневная касса vs QR';

  @override
  String get reportSummariesSection => 'Сводки';

  @override
  String get reportCashSummary => 'Сводка по кассе';

  @override
  String get reportBankSummary => 'Сводка по банку';

  @override
  String get reportDailySummary => 'Ежедневная сводка';

  @override
  String get reportTabPurchase => 'Закупки';

  @override
  String get reportTabSales => 'Продажи';

  @override
  String get reportTabDashboard => 'Панель';

  @override
  String get reportSingleDayTrend => 'Один день — дневной тренд';

  @override
  String get reportFullYearTrend => 'Весь год — месячные графики трендов';

  @override
  String reportYearLabel(String year) {
    return 'Год $year';
  }

  @override
  String reportJanDec(String year) {
    return 'Янв – Дек $year';
  }

  @override
  String get reportTotalPurchases => 'Всего закупок';

  @override
  String get reportTotalSales => 'Общая выручка';

  @override
  String get reportTotalInvoices => 'Всего счетов';

  @override
  String get reportUnpaidBalance => 'Неоплаченный остаток';

  @override
  String get reportAvgPerInvoice => 'Среднее на счёт';

  @override
  String get reportPerTransaction => 'На транзакцию';

  @override
  String reportMonthlySpend(String symbol) {
    return 'Месячные расходы ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'Месячные продажи ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'Количество счетов по месяцам';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'Топ позиций по расходам ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'Расходы по категориям';

  @override
  String get reportOtherCategory => 'Прочее';

  @override
  String get reportSuppliers => 'Поставщики';

  @override
  String get reportTableSupplier => 'Поставщик';

  @override
  String get reportTableAmount => 'Сумма';

  @override
  String get reportTableBills => 'Счета';

  @override
  String get reportSalesTotal => 'Итого продаж';

  @override
  String get reportPurchaseTotal => 'Итого закупок';

  @override
  String get reportPositiveMargin => 'Положительная маржа';

  @override
  String get reportNegativeMargin => 'Отрицательная маржа';

  @override
  String get reportGrossMargin => 'Валовая маржа';

  @override
  String get reportOfTotalSales => 'От общей выручки';

  @override
  String get reportFailedToLoadAnalytics => 'Не удалось загрузить аналитику';

  @override
  String get reportMarginKpi => 'Маржа';

  @override
  String get reportExpensesKpi => 'Расходы';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'Нет результатов для «$query»';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'Контрагенты $role не найдены';
  }

  @override
  String get partyPickerLoadParties => 'Загрузить контрагентов';

  @override
  String get invoiceCashCustomer => 'Наличный клиент';

  @override
  String get invoiceQuickAddItemsTitle => 'Быстрое добавление';

  @override
  String get invoiceQuickLoadingMenu => 'Загрузка меню…';

  @override
  String get invoiceQuickInvoiceCreated => 'Счёт создан';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'Добавьте хотя бы одну позицию';

  @override
  String get invoiceQuickNoResults => 'Ничего не найдено!';

  @override
  String get invoiceQuickNoItemsInCategory => 'Нет позиций в этой категории';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'Добавить позицию';

  @override
  String get invoiceQuickLoadMore => 'Загрузить ещё';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'Прокрутите для загрузки ($count на страницу)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'Поставщик / Сотрудник';

  @override
  String get invoiceQuickEditItem => 'Изменить позицию';

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
  String get closeSelectDateRange => 'Выбрать диапазон дат';

  @override
  String get closeStartDate => 'Дата начала';

  @override
  String get closeEndDate => 'Дата окончания';

  @override
  String get closeSelectBothDates => 'Выберите даты начала и окончания';

  @override
  String get closeDeleteSummary => 'Удалить сводку';

  @override
  String get closeDeleteSummaryConfirm => 'Удалить эту сводку?';

  @override
  String get closeSelectDate => 'Выбрать дату';

  @override
  String get closeNoDataToExport => 'Нет данных для экспорта';

  @override
  String get closeNoDataToShare => 'Нет данных для отправки';

  @override
  String get closeNoDataToPrint => 'Нет данных для печати';

  @override
  String closePdfGenerateError(String error) {
    return 'Ошибка создания PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'Ошибка отправки PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'Ошибка печати PDF: $error';
  }

  @override
  String get closeExportPdf => 'Экспорт в PDF';

  @override
  String get closeSharePdf => 'Поделиться PDF';

  @override
  String get closePrint => 'Печать';

  @override
  String get closeExportOptions => 'Параметры экспорта';

  @override
  String get closeExportPdfSubtitle => 'Сохранить или просмотреть как PDF';

  @override
  String get closeSharePdfSubtitle => 'Отправить через приложения или e-mail';

  @override
  String get closePrintSubtitle => 'Печать отчёта';

  @override
  String get closeDailyCashSummaryTitle => 'Ежедневная сводка по кассе';

  @override
  String get closeDailyCashSummaryReport => 'Ежедневный отчёт по кассе';

  @override
  String closeGeneratedAt(String date) {
    return 'Создано: $date';
  }

  @override
  String get closeTotalRecords => 'Всего записей';

  @override
  String get closeSummaryOverview => 'Обзор сводки';

  @override
  String get closeAllRecords => 'Все записи';

  @override
  String closePeriodRange(String start, String end) {
    return 'Период: с $start по $end';
  }

  @override
  String get closeDetails => 'Подробности';

  @override
  String closePageN(int n) {
    return 'Страница $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'Показано $shown из $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'Загружено: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'Номер / Каюта / Сотрудник';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent% выручки';
  }

  @override
  String get reportParties => 'Контрагенты';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — дневные графики трендов';
  }

  @override
  String get invoiceQuickCart => 'Корзина';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'Корзина ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'Очистить поиск';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'Добавить сводку';

  @override
  String get closeSalesAmount => 'Сумма продаж';

  @override
  String get closeClosingBalance => 'Конечный баланс';

  @override
  String get closeLostMoney => 'Потерянные деньги';

  @override
  String get closeDiscount => 'Скидка';

  @override
  String get closeExpenses => 'Расходы';

  @override
  String get closeUnpaid => 'Не оплачено';

  @override
  String get closeTotalOpeningBalance => 'Общий начальный баланс';

  @override
  String get closeTotalSalesAmount => 'Общая сумма продаж';

  @override
  String get closeTotalCashAmount => 'Общая сумма наличных';

  @override
  String get closeTotalQrAmount => 'Общая сумма QR';

  @override
  String get closeTotalDiscount => 'Общая скидка';

  @override
  String get closeTotalExpenses => 'Общие расходы';

  @override
  String get closeTotalClosingBalance => 'Общий конечный баланс';

  @override
  String get closeTotalLostMoney => 'Общие потерянные деньги';

  @override
  String get closeTotalExtraAmount => 'Общая дополнительная сумма';

  @override
  String get closeShowingCurrentMonth => 'Данные текущего месяца';

  @override
  String get closeNoSummariesFound => 'Сводки не найдены';

  @override
  String get closeNoSummariesAvailable => 'Нет доступных сводок';

  @override
  String get closeTryAdjustingDateRange => 'Попробуйте изменить диапазон дат';

  @override
  String get closeCreateFirstSummary => 'Создайте первую сводку для начала';

  @override
  String get closeClearFilter => 'Сбросить фильтр';

  @override
  String get closeFiltered => 'Отфильтровано';

  @override
  String closeFilteredWithRange(String range) {
    return 'Отфильтровано: $range';
  }

  @override
  String get closeSummarySingular => 'Сводка';

  @override
  String get closeSummariesPlural => 'Сводки';

  @override
  String get closeSummaryUpdatedSuccess => 'Сводка успешно обновлена';

  @override
  String get closeSummaryDeletedSuccess => 'Сводка успешно удалена';

  @override
  String premiumUnlockTitle(String appName) {
    return 'Разблокировать $appName Premium';
  }

  @override
  String get premiumTagline =>
      'Полноценная офлайн-касса, счета, склад и отчёты — одна подписка для вашего бизнеса.';

  @override
  String get premiumFeatureUnlimitedInvoices => 'Неограниченные счета и чеки';

  @override
  String get premiumFeatureInventoryStock => 'Склад и учёт запасов';

  @override
  String get premiumFeatureReportsAnalytics => 'Отчёты о продажах и аналитика';

  @override
  String get premiumFeatureOfflineLocal =>
      'Работает офлайн — данные остаются на устройстве';

  @override
  String premiumContinueWith(String plan) {
    return 'Продолжить с $plan';
  }

  @override
  String get premiumRestorePurchases => 'Восстановить покупки';

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
      'Оплата списывается с Apple ID. Подписки продлеваются автоматически, если не отменить минимум за 24 часа до конца периода.';

  @override
  String get premiumPurchaseRestored => 'Покупка восстановлена.';

  @override
  String get premiumNoActiveSubscription => 'Активная подписка не найдена.';

  @override
  String get premiumPlanMonthly => 'Ежемесячно';

  @override
  String get premiumPlanMonthlySubtitle => 'Гибко — отмена в любой момент';

  @override
  String get premiumPlanYearly => 'Ежегодно';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'Лучшая цена — экономия $percent%';
  }

  @override
  String get premiumPlanLifetime => 'Навсегда';

  @override
  String get premiumPlanLifetimeSubtitle =>
      'Оплатите один раз — пользуйтесь всегда';

  @override
  String get premiumPlanPopular => 'Популярный';

  @override
  String get premiumOneTimePurchase => 'Разовая покупка';

  @override
  String get subscriptionSectionTitle => 'Подписка';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Перейти на Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'Ежемесячно $monthly · Ежегодно $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan активен до $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan активен';
  }

  @override
  String get premiumRequired => 'Требуется Premium';

  @override
  String get upgradeToPremiumContinue =>
      'Перейдите на Premium, чтобы продолжить.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'Бесплатный план позволяет до $limit $label. Перейдите на Premium для неограниченного доступа.';
  }

  @override
  String get freemiumPartyRoleRequired => 'Требуется роль контрагента.';

  @override
  String get freemiumLabelSalesInvoices => 'счета продажи';

  @override
  String get freemiumLabelPurchaseInvoices => 'счета покупки';

  @override
  String get freemiumLabelEmployees => 'сотрудники';

  @override
  String get freemiumLabelItems => 'товары';

  @override
  String get freemiumLabelCategories => 'категории';

  @override
  String get freemiumLabelPaymentMethods => 'способы оплаты';

  @override
  String get freemiumLabelCustomPartyRoles =>
      'пользовательские роли контрагентов';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'контрагенты для $role';
  }

  @override
  String get freemiumLabelOrganizations => 'организации';

  @override
  String get freemiumPremiumReports => 'Отчёты доступны с Premium.';

  @override
  String get freemiumPremiumBackupSync =>
      'Резервное копирование и синхронизация требуют Premium.';

  @override
  String get freemiumPremiumPayroll => 'Зарплата требует Premium.';

  @override
  String get freemiumPremiumAttendance => 'Посещаемость требует Premium.';

  @override
  String get freemiumPremiumStock => 'Управление складом требует Premium.';

  @override
  String get freemiumPremiumInvoiceExport =>
      'Скачивание и печать требуют Premium.';

  @override
  String get shiftReminderOpeningTitle => 'Напоминание об открытии';

  @override
  String get shiftReminderOpeningMessage => 'Вы открыли кассу на сегодня?';

  @override
  String get shiftReminderOpeningProceed => 'Да, открыть сейчас';

  @override
  String get shiftReminderClosingTitle => 'Напоминание о закрытии';

  @override
  String get shiftReminderClosingMessage => 'Вы закрыли кассу на сегодня?';

  @override
  String get shiftReminderClosingProceed => 'Да, закрыть сейчас';

  @override
  String get shiftReminderSkipToday => 'Пропустить сегодня';

  @override
  String get shiftReminderOpeningNotificationTitle => 'Напоминание об открытии';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'Вы открыли кассу на сегодня? Нажмите здесь, если ещё нужно открыть.';

  @override
  String get shiftReminderClosingNotificationTitle => 'Напоминание о закрытии';

  @override
  String get shiftReminderClosingNotificationBody =>
      'Вы закрыли кассу на сегодня? Нажмите здесь, если ещё нужно закрыть.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business платит клиенту QR; клиент даёт наличные.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business платит клиенту наличными; клиент платит QR.';
  }

  @override
  String get closePaymentExchange => 'Обмен платежами';

  @override
  String get closePayQrGetCashExchangeLabel =>
      'Оплатить QR → Получить наличные (обмен)';

  @override
  String get closePayCashGetQrExchangeLabel =>
      'Оплатить наличными → Получить QR (обмен)';

  @override
  String get closePayQrGetCashDetail => 'Оплатить QR, получить наличные';

  @override
  String get closePayCashGetQrDetail => 'Оплатить наличными, получить QR';

  @override
  String get faqSectionPremium => 'Premium и оплата';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Что входит в Premium?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium открывает неограниченные счета, полные отчёты (P&L, выписка, аналитика), резервное копирование и синхронизацию, зарплату, посещаемость, склад, экспорт/печать счетов и дополнительные организации. Бесплатный уровень позволяет использовать основные POS-функции в разумных пределах.';

  @override
  String get faqPremiumFreeTierQuestion => 'Что входит в бесплатный уровень?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'Можно создать до 10 счетов продажи и 10 покупки, 4 сотрудников, 30 товаров и другие лимиты при достижении. Открытие, закрытие, калькулятор и просмотр данных остаются бесплатными.';

  @override
  String get faqPremiumRestoreQuestion => 'Как восстановить покупку?';

  @override
  String get faqPremiumRestoreAnswer =>
      'Откройте Ещё → Перейти на Premium (или экран оплаты) и нажмите Восстановить покупки. Используйте тот же Apple ID, что при подписке.';

  @override
  String get faqPremiumCancelQuestion => 'Как отменить подписку?';

  @override
  String get faqPremiumCancelAnswer =>
      'Управляйте или отмените в Настройки iPhone → Apple ID → Подписки. Доступ сохраняется до конца оплаченного периода.';

  @override
  String get faqDarkModeQuestion => 'Как включить тёмную тему?';

  @override
  String get faqDarkModeAnswer =>
      'Откройте Ещё → Внешний вид и включите Тёмную тему. При системной теме приложение следует автоматически.';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'Что такое напоминания об открытии и закрытии?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName может напоминать об открытии или закрытии ежедневной кассы. Можно продолжить, пропустить сегодня или закрыть напоминание.';
  }

  @override
  String get faqPartyRolesQuestion => 'Что такое роли контрагентов?';

  @override
  String get faqPartyRolesAnswer =>
      'Роли контрагентов классифицируют контакты: клиенты, поставщики, номера, сотрудники. Настройте в Операции → Роли контрагентов и добавьте краткое описание для команды.';

  @override
  String faqRateAppQuestion(String appName) {
    return 'Как оценить $appName?';
  }

  @override
  String get faqRateAppAnswer =>
      'Откройте Ещё → Оцените нас, чтобы оставить отзыв в App Store. Ваш отзыв помогает улучшать офлайн-счета для вашего бизнеса.';
}
