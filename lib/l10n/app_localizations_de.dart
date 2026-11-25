// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get noInternetConnection => 'Keine Internetverbindung.';

  @override
  String get formatException => 'Formatfehler';

  @override
  String get rememberMe => 'Angemeldet bleiben';

  @override
  String get signIn => 'Anmelden';

  @override
  String get passwordHint => 'Passwort eingeben';

  @override
  String get forgetPassword => 'Anmeldedaten vergessen?';

  @override
  String get okay => 'OK';

  @override
  String get success => 'Erfolgreich';

  @override
  String get hotel => 'Hotel';

  @override
  String get errorEncountered => 'Fehler aufgetreten';

  @override
  String get serverError => 'Serverfehler';

  @override
  String get requestFailed => 'Anfrage fehlgeschlagen';

  @override
  String get connectionTimedOut => 'Verbindung abgelaufen';

  @override
  String get password => 'Passwort';

  @override
  String get keepSignIn => 'Angemeldet bleiben';

  @override
  String get enterPassword => 'Passwort eingeben';

  @override
  String get enterValidPassword => 'Gültiges Passwort eingeben';

  @override
  String get skip => 'ÜBERSPRINGEN';

  @override
  String get pleaseWait => 'Bitte warten ....';

  @override
  String get enterValidUserName => 'Gültigen Benutzernamen eingeben.';

  @override
  String get userName => 'Benutzername';

  @override
  String get or => 'Oder';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get error => 'Fehler';

  @override
  String get supportMessage => 'Bitte Administrator kontaktieren.';

  @override
  String get responseMessage404 => '404-Fehler';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get close => 'Schließen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteOrganizationTitle => 'Organisation löschen?';

  @override
  String deleteOrganizationMessage(String name) {
    return '$name von diesem Gerät entfernen. Alle lokalen Daten dieser Organisation werden gelöscht.';
  }

  @override
  String get deleteOrganizationWarning =>
      'Dies kann nicht rückgängig gemacht werden.';

  @override
  String get organizationDeleted => 'Organisation entfernt';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get done => 'Fertig';

  @override
  String get next => 'Weiter';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get walkthroughDashboardTitle =>
      'Ihr gesamtes Geschäft auf einen Blick';

  @override
  String get walkthroughDashboardDescription =>
      'Heutige Verkäufe, Umsatz und offene Salden — alles auf einem übersichtlichen Dashboard, sobald Sie die App öffnen.';

  @override
  String get walkthroughOfflineTitle => 'Funktioniert auch ohne Internet';

  @override
  String get walkthroughOfflineDescription =>
      'Rechnungen erstellen, Ausgaben erfassen und Bestand verwalten — vollständig offline. Alles synchronisiert sich automatisch, sobald Sie wieder online sind.';

  @override
  String get walkthroughBillingTitle => 'In Sekunden abrechnen und verkaufen';

  @override
  String get walkthroughBillingDescription =>
      'Verkaufs- und Einkaufsrechnungen, Tischbestellungen mit Küchentickets und Live-Inventar — alles in einer App.';

  @override
  String get walkthroughStaffTitle => 'Personal, Gehalt & Berichte';

  @override
  String get walkthroughStaffDescription =>
      'Anwesenheit und Gehaltsabrechnung verwalten, GuV-Auszüge und Lohnabrechnungen als PDF exportieren — ohne zusätzliche Tools.';

  @override
  String get walkthroughBackupTitle => 'Ihre Daten, immer sicher';

  @override
  String get walkthroughBackupDescription =>
      'Sicherheit auf Bankniveau mit Google-Drive-Sicherungen per Tipp — Ihre Daten sind geschützt und leicht wiederherstellbar.';

  @override
  String get walkthroughReadyTitle => 'Bereit, wenn Sie es sind';

  @override
  String get walkthroughReadyDescription =>
      'Richten Sie Ihre Organisation in Minuten ein und führen Sie Ihr Geschäft ab heute smarter. Legen wir los.';

  @override
  String get back => 'Zurück';

  @override
  String get submit => 'Absenden';

  @override
  String get continueAction => 'Weiter';

  @override
  String get createAction => 'Erstellen';

  @override
  String get connectOrganizationTitle => 'Organisation verbinden';

  @override
  String get connectOrganizationSubtitle =>
      'Wählen Sie eine Organisation zum Anmelden.';

  @override
  String get selectOrganization => 'Organisationen';

  @override
  String get selectOrganizationHint =>
      'Tippen Sie auf eine Organisation, um fortzufahren';

  @override
  String get noSavedOrganizationsYet =>
      'Noch keine Organisationen. Erstellen Sie eine oder verwenden Sie unten Testdaten.';

  @override
  String get orgConnectOnceInfo =>
      'Dies verknüpft die App mit Ihrem Geschäftskonto. Sie müssen es nur einmal pro Gerät einrichten.';

  @override
  String organizationCodeLabel(String code) {
    return 'Code: $code';
  }

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get warning => 'WARNUNG';

  @override
  String get loading => 'Wird geladen…';

  @override
  String get comingSoon => 'Demnächst';

  @override
  String get required => 'Erforderlich';

  @override
  String get search => 'Suchen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get remove => 'Entfernen';

  @override
  String get view => 'Anzeigen';

  @override
  String get export => 'Exportieren';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'Importieren';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get select => 'Auswählen';

  @override
  String get upload => 'Hochladen';

  @override
  String get download => 'Herunterladen';

  @override
  String get share => 'Teilen';

  @override
  String get filter => 'Filtern';

  @override
  String get sort => 'Sortieren';

  @override
  String get apply => 'Anwenden';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get clear => 'Leeren';

  @override
  String get all => 'Alle';

  @override
  String get none => 'Keine';

  @override
  String get total => 'Gesamt';

  @override
  String get subtotal => 'Zwischensumme';

  @override
  String get grandTotal => 'Gesamtsumme';

  @override
  String get amount => 'Betrag';

  @override
  String get quantity => 'Menge';

  @override
  String get rate => 'Preis';

  @override
  String get discount => 'Rabatt';

  @override
  String get paid => 'Bezahlt';

  @override
  String get unpaid => 'Unbezahlt';

  @override
  String get credit => 'Kredit';

  @override
  String get cash => 'Bargeld';

  @override
  String get date => 'Datum';

  @override
  String get time => 'Uhrzeit';

  @override
  String get name => 'Name';

  @override
  String get email => 'E-Mail';

  @override
  String get phone => 'Telefon';

  @override
  String get address => 'Adresse';

  @override
  String get notes => 'Notizen';

  @override
  String get description => 'Beschreibung';

  @override
  String get status => 'Status';

  @override
  String get type => 'Typ';

  @override
  String get category => 'Kategorie';

  @override
  String get party => 'Partei';

  @override
  String get item => 'Artikel';

  @override
  String get payment => 'Zahlung';

  @override
  String get settlement => 'Abrechnung';

  @override
  String get opening => 'Eröffnung';

  @override
  String get closing => 'Abschluss';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'Ausgabe';

  @override
  String get revenue => 'Umsatz';

  @override
  String get profit => 'Gewinn';

  @override
  String get loss => 'Verlust';

  @override
  String get sales => 'Verkauf';

  @override
  String get purchase => 'Einkauf';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mär';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dez';

  @override
  String get more => 'Mehr';

  @override
  String get profile => 'Profil';

  @override
  String get operations => 'Betrieb';

  @override
  String get operationManagement => 'Betriebsverwaltung';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'Mitarbeiterverwaltung';

  @override
  String get employeeManagementSubtitle =>
      'Personal, Gehaltsabrechnung und Anwesenheit';

  @override
  String get report => 'Bericht';

  @override
  String get reportSubtitle => 'Gewinn & Verlust, Berichte und Analysen';

  @override
  String get helpAndSupport => 'Hilfe & Support';

  @override
  String get preferences => 'Einstellungen';

  @override
  String get dataAndBackup => 'Daten & Sicherung';

  @override
  String get privacyAndPolicies => 'Datenschutz & Richtlinien';

  @override
  String get faq => 'FAQ';

  @override
  String get contactSupport => 'Support kontaktieren';

  @override
  String get rateUs => 'Bewerte uns';

  @override
  String get rateUsSubtitle =>
      'Gefällt dir BizTrack? Hinterlasse eine Bewertung bei Google Play';

  @override
  String get rateUsUnavailable =>
      'Store konnte nicht geöffnet werden. Versuche es später erneut.';

  @override
  String get reportProblem => 'Problem melden';

  @override
  String get contactUs => 'Kontakt';

  @override
  String get contactUsSubtitle => 'Support, Feedback oder Fragen zur App.';

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
  String get developerLabel => 'Entwickler';

  @override
  String get emailCopiedToClipboard => 'E-Mail in die Zwischenablage kopiert';

  @override
  String get logout => 'Abmelden';

  @override
  String get signOut => 'Abmelden';

  @override
  String get settings => 'Einstellungen';

  @override
  String get testData => 'Testdaten';

  @override
  String get loginWithTestData => 'Mit Testdaten anmelden';

  @override
  String get loginWithTestDataSubtitle =>
      'Demo-Hoteldaten laden und automatisch anmelden';

  @override
  String testDataLoginFailed(String error) {
    return 'Testdaten konnten nicht geladen werden: $error';
  }

  @override
  String get preparingTestData => 'Demo-Daten werden vorbereitet…';

  @override
  String get regionAndCurrency => 'Region & Währung';

  @override
  String get reportingCurrency => 'Berichtswährung';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · Beispiel $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'Währung auf $code ($symbol) gesetzt';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'Währung konnte nicht aktualisiert werden: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return '$appName einrichten';
  }

  @override
  String get setupSubtitle =>
      'Konfigurieren Sie Ihre Organisation und Buchhaltung — auf diesem Gerät für die Offline-Nutzung gespeichert.';

  @override
  String get setupOrganizationName => 'Organisationsname';

  @override
  String get setupCompanyName => 'Firmenname';

  @override
  String get setupBusinessType => 'Unternehmenstyp';

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
  String get businessTypeRetail => 'Einzelhandel / Geschäft';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'Café / Bäckerei';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'Bar / Pub';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'Sonstiges';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'Typ: $type';
  }

  @override
  String get organizationSettings => 'Organisation';

  @override
  String get editOrganizationInfo => 'Organisationsinfo';

  @override
  String get editOrganizationInfoSubtitle =>
      'Aktualisiere, wie dieses Unternehmen in der App angezeigt wird. Der Organisationscode kann nicht geändert werden.';

  @override
  String get organizationCode => 'Organisationscode';

  @override
  String get organizationCodeReadOnly =>
      'Dieser Code ist nach der Einrichtung festgelegt.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated => 'Organisationsinfo gespeichert';

  @override
  String get organizationInfoLoadFailed =>
      'Organisationsinfo konnte nicht geladen werden';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'Organisationsinfo konnte nicht gespeichert werden: $error';
  }

  @override
  String get organizationTabGeneral => 'Allgemein';

  @override
  String get organizationTabRegional => 'Regional & Geschäftsjahr';

  @override
  String get organizationRegionalSubtitle =>
      'Land, Berichtswährung und Geschäftsjahresdaten.';

  @override
  String get organizationTabAccounting => 'Buchhaltung';

  @override
  String get organizationAccountingSubtitle =>
      'Einstellungen für Rechnungen und Betragsanzeige.';

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
  String get displayPrecision => 'Anzeigegenauigkeit';

  @override
  String get displayPrecisionRange => 'Geben Sie eine Zahl von 0 bis 5 ein';

  @override
  String get enableInvoiceReturns => 'Rechnungsretouren aktivieren';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'Retouren aus bezahlten Rechnungen zulassen.';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get setupFullName => 'Vollständiger Name';

  @override
  String get setupConfirmPassword => 'Passwort bestätigen';

  @override
  String get setupBankName => 'Bankname';

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
  String get setupRegionStepTitle => 'Region & Währung';

  @override
  String get setupOrganizationStepTitle => 'Organisation';

  @override
  String get setupOrganizationStepSubtitle =>
      'Wie Ihr Unternehmen in der App erscheint';

  @override
  String get setupAdminStepTitle => 'Administratorkonto';

  @override
  String get setupAdminStepSubtitle =>
      'Primärer Benutzer für diese Installation';

  @override
  String get setupAccountingStepTitle => 'Buchhaltung';

  @override
  String get setupAccountingStepSubtitle =>
      'Bank, Kontenplan und Geschäftsjahr';

  @override
  String get setupCompleteSetup => 'Einrichtung abschließen';

  @override
  String fieldRequired(String field) {
    return '$field ist erforderlich';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'Geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String passwordMinLength(int min) {
    return 'Das Passwort muss mindestens $min Zeichen lang sein';
  }

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get setupFixValidationErrors =>
      'Bitte beheben Sie die folgenden Fehler, um fortzufahren';

  @override
  String get setupCompleteSuccess => 'Einrichtung erfolgreich abgeschlossen';

  @override
  String get setupCompleteWithPdfSuccess =>
      'Einrichtung abgeschlossen. Speichern Sie die PDF an einem sicheren Ort.';

  @override
  String setupPdfFailed(String error) {
    return 'Einrichtung abgeschlossen, aber die PDF konnte nicht gespeichert werden: $error';
  }

  @override
  String get setupFailed =>
      'Die Einrichtung konnte nicht abgeschlossen werden. Bitte versuchen Sie es erneut.';

  @override
  String setupFailedWithDetails(String error) {
    return 'Einrichtung fehlgeschlagen: $error';
  }

  @override
  String get regionAndCurrencySubtitle => 'Gebietsschema und Berichtswährung.';

  @override
  String get country => 'Land';

  @override
  String get currency => 'Währung';

  @override
  String get selectCountry => 'Land auswählen';

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get languageChangeLaterHint =>
      'Sie können es später in den Einstellungen ändern';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'Wählen Sie, wie Sie $appName nutzen möchten. Sie können dies später in den Einstellungen ändern.';
  }

  @override
  String get searchLanguages => 'Sprachen suchen';

  @override
  String get languageSuggestedBadge => 'EMPFOHLEN';

  @override
  String continueInLanguage(String languageName) {
    return 'Weiter auf $languageName';
  }

  @override
  String get noLanguageMatches => 'Keine Treffer';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'Keine Sprache entspricht \"$query\"';
  }

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get darkModeSubtitle =>
      'Dunklen Hintergrund in der gesamten App verwenden';

  @override
  String get darkModeSystemSubtitle => 'Folgt dem Design Ihres Geräts';

  @override
  String languageUpdated(String name) {
    return 'Sprache auf $name gesetzt';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'Sprache konnte nicht aktualisiert werden: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'Willkommen bei $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'Bitte installieren Sie die neueste Version von $appName, um fortzufahren.';
  }

  @override
  String generatedByApp(String appName) {
    return 'Erstellt von $appName';
  }

  @override
  String whatIsApp(String appName) {
    return 'Was ist $appName?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName hilft Ihnen, Verkaufs- und Einkaufsrechnungen, Parteien (Kunden und Lieferanten), Lager, Zahlungen, Mitarbeiter und tägliche Zusammenfassungen zu verwalten — von Ihrem Telefon oder Tablet.';
  }

  @override
  String faqIntro(String appName) {
    return 'Antworten auf häufige Fragen zu $appName.';
  }

  @override
  String get chooseFromGallery => 'Aus Galerie auswählen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get photoLibrary => 'Fotobibliothek';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String couldNotPickImage(String error) {
    return 'Bild konnte nicht ausgewählt werden: $error';
  }

  @override
  String get unpaidAmount => 'Unbezahlter Betrag';

  @override
  String get unpaidBalance => 'Unbezahlter Saldo';

  @override
  String unpaidColonAmount(String amount) {
    return 'Unbezahlt: $amount';
  }

  @override
  String get previousUnpaid => 'Zuvor unbezahlt';

  @override
  String get partyUnpaid => 'Geschäftspartner unbezahlt';

  @override
  String get loadingUnpaid => 'Unbezahlt wird geladen…';

  @override
  String get totalUnpaid => 'Gesamt unbezahlt';

  @override
  String get unpaidAmountNotYetCollected =>
      'Unbezahlter Betrag noch nicht eingezogen.';

  @override
  String get partyUnpaidTabHint =>
      'Öffnen Sie Mitarbeiter, wählen Sie eine Person und tippen Sie in ihrem Profil auf Geschäftspartner unbezahlt. Der Server benötigt eine Mitarbeiter-ID für diese Suche.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'Parteiausgleich verwendet den unbezahlten Gesamtbetrag.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'Geben Sie zuerst einen Ausgleichsbetrag ein (oder wählen Sie einen Geschäftspartner mit offenem Betrag).';

  @override
  String get workspace => 'Arbeitsbereich';

  @override
  String get change => 'Ändern';

  @override
  String get addMoreOrganization => 'Mehr hinzufügen +';

  @override
  String get connectAnotherOrganization => 'Weitere Organisation verbinden';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'Noch keine gespeicherten Organisationen. Verwenden Sie Mehr hinzufügen +.';

  @override
  String get registerNewOrganizationTitleSignedIn =>
      'Neue Organisation registrieren?';

  @override
  String get registerNewOrganizationTitle => 'Neue Organisation registrieren?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'Sie werden abgemeldet und der Einrichtungsassistent startet von vorne.\n\nBereits gespeicherte Organisationen bleiben nach der Einrichtung in der Liste.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'Der Einrichtungsassistent startet. Schließen Sie die Einrichtung ab; Ihre gespeicherten Organisationen bleiben in der Liste.';

  @override
  String get startSetup => 'Einrichtung starten';

  @override
  String get enterOrganizationCode =>
      'Bitte geben Sie Ihren Organisationscode ein';

  @override
  String get organizationNotFoundCheckCode =>
      'Organisation nicht gefunden. Überprüfen Sie den Code und versuchen Sie es erneut.';

  @override
  String get organizationNotFound => 'Organisation nicht gefunden';

  @override
  String get couldNotVerifyOrganization =>
      'Organisation konnte nicht verifiziert werden';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'Keine lokalen Daten für $name. Schließen Sie zunächst die Einrichtung für diese Organisation ab.';
  }

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get signInToContinue => 'Melden Sie sich an, um fortzufahren';

  @override
  String get enterEmail => 'E-Mail eingeben';

  @override
  String get pleaseEnterEmail => 'Bitte geben Sie Ihre E-Mail-Adresse ein';

  @override
  String get pleaseEnterValidEmail =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get enterEmailLocalPartOnly => 'Geben Sie nur den Teil vor @ ein';

  @override
  String get pleaseEnterPassword => 'Bitte geben Sie Ihr Passwort ein';

  @override
  String get logIn => 'ANMELDEN';

  @override
  String get searchCountry => 'Land suchen';

  @override
  String get searchCodeOrSymbol => 'Code oder Symbol suchen';

  @override
  String get saveLoginDetailsTitle => 'Anmeldedaten speichern?';

  @override
  String get saveLoginDetailsMessage =>
      'Sie sind dabei, die Einrichtung abzuschließen.\n\nMöchten Sie ein PDF mit Organisationscode, Name, E-Mail und Passwort sicher herunterladen? Bewahren Sie es sicher auf.';

  @override
  String get downloadPdfAndContinue => 'PDF herunterladen und fortfahren';

  @override
  String get continueWithoutPdf => 'Ohne PDF fortfahren';

  @override
  String get legalDisplayNameHint => 'Rechtlicher / Anzeigename';

  @override
  String get chartOfAccounts => 'Kontenplan';

  @override
  String get fiscalYearStart => 'Beginn des Geschäftsjahres';

  @override
  String get fiscalYearEnd => 'Ende des Geschäftsjahres';

  @override
  String get removeTestDataTitle => 'Testdaten entfernen?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'Alle Demo-Verkäufe, -Käufe, -Kontakte, -Parteien, -Lagerartikel, -Mitarbeiter und Demo-Organisationen werden entfernt.\n\nSie befinden sich in einer Demo-Organisation — danach werden Sie automatisch zurückgewechselt.';

  @override
  String get removeTestDataMessageNormal =>
      'Alle Demo-Daten und die 3 zusätzlichen Demo-Organisationen werden entfernt. Ihr Administratorkonto bleibt erhalten.';

  @override
  String get removeTestDataWarning =>
      'Dies kann nicht rückgängig gemacht werden, außer durch erneutes Laden der Testdaten.';

  @override
  String get removeTestData => 'Testdaten entfernen';

  @override
  String get keepTestData => 'Testdaten behalten';

  @override
  String get demoDataRemoved => 'Demo-Daten entfernt';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'Testdaten entfernt. Gewechselt zu $name.';
  }

  @override
  String get testDataRemoved => 'Testdaten entfernt';

  @override
  String couldNotRemoveTestData(String error) {
    return 'Testdaten konnten nicht entfernt werden: $error';
  }

  @override
  String get loadTestDataTitle => 'Testdaten laden?';

  @override
  String get loadTestDataMessage =>
      'Dies fügt Demo-Kontakte, Lagerartikel, Verkäufe, Käufe, Zahlungen, Lager, Mitarbeiter und Anwesenheit für die letzten 15 Tage hinzu.';

  @override
  String get loadTestData => 'Testdaten laden';

  @override
  String get testDataLoaded => 'Testdaten geladen';

  @override
  String couldNotLoadTestData(String error) {
    return 'Testdaten konnten nicht geladen werden: $error';
  }

  @override
  String get demoTestData => 'Demo-Testdaten';

  @override
  String get importTestDataSubtitle =>
      'Testdaten für alle Funktionen importieren';

  @override
  String get hideTestDataTitle =>
      'Testdaten für diese Organisation ausblenden?';

  @override
  String get hideTestDataMessage =>
      'Der Abschnitt Testdaten wird überall in dieser Organisation ausgeblendet.';

  @override
  String get hideTestDataWarning =>
      'Bereits geladene Demo-Daten bleiben in der Datenbank, bis Sie sie aus den Einstellungen entfernen.';

  @override
  String get okHideTestData => 'OK, Testdaten ausblenden';

  @override
  String get testDataHiddenForOrg =>
      'Testdaten für diese Organisation ausgeblendet';

  @override
  String get hideTestDataTooltip =>
      'Testdaten für diese Organisation ausblenden';

  @override
  String get partyRolesTitle => 'Parteirollen';

  @override
  String get partyRolesMoreSubtitle => 'Kunde, Lieferant, beides & mehr';

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
  String get partyRoleCustomer => 'Kunde';

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
  String get searchRoles => 'Rollen suchen';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Rollen',
      one: '1 Rolle',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'Noch keine Rollen';

  @override
  String get noRolesYetHint =>
      'Fügen Sie Kunde, Lieferant, Beides oder benutzerdefinierte Rollen für Kontakte hinzu.';

  @override
  String get addRole => 'Rolle hinzufügen';

  @override
  String get deleteRoleTitle => 'Rolle löschen';

  @override
  String deleteRoleConfirm(String name) {
    return '\"$name\" löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount Parteien',
      one: '1 Partei',
    );
    return '\"$name\" wird von $_temp0 verwendet. Übertragen oder erzwungen löschen.';
  }

  @override
  String get transferParties => 'Parteien übertragen';

  @override
  String get hardDeleteLoseParties => 'Erzwungen löschen (Parteien verlieren)';

  @override
  String get hardDeleteRoleTitle => 'Erzwungen löschen?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount Parteien',
      one: '1 Partei',
    );
    return 'Dadurch wird \"$name\" und alle zugewiesenen $_temp0 dauerhaft gelöscht.\n\nParteien mit Rechnungen können nicht gelöscht werden — verwenden Sie Übertragen.';
  }

  @override
  String get deleteRoleAndParties => 'Rolle und Parteien löschen';

  @override
  String get addAnotherRoleBeforeDelete =>
      'Fügen Sie eine weitere Rolle hinzu, bevor Sie diese löschen.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount Parteien',
      one: '1 Partei',
    );
    return '$_temp0 von \"$fromRole\" verschieben nach:';
  }

  @override
  String get transferAndDeleteRole => 'Übertragen und Rolle löschen';

  @override
  String get builtInRole => 'Integriert';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Parteien',
      one: '1 Partei',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'Noch keine Parteien';

  @override
  String get newRole => 'Neue Rolle';

  @override
  String get editRole => 'Rolle bearbeiten';

  @override
  String get defaultRolesCannotEdit =>
      'Standardrollen können nicht umbenannt oder gelöscht werden.';

  @override
  String get roleNameLabel => 'Rollenname *';

  @override
  String get roleNameHint => 'z. B. Kunde';

  @override
  String get roleDescriptionLabel => 'Beschreibung';

  @override
  String get roleDescriptionHint => 'Kurze Notiz für Ihr Team';

  @override
  String get roleSortOrderLabel => 'Sortierreihenfolge';

  @override
  String get roleSortOrderHint => 'Niedrigere Zahl erscheint zuerst';

  @override
  String get roleCreated => 'Rolle erstellt';

  @override
  String get roleUpdated => 'Rolle aktualisiert';

  @override
  String get roleDeleted => 'Rolle gelöscht';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Parteien',
      one: '1 Partei',
    );
    return 'Rolle gelöscht. $_temp0 zu $targetRole verschoben.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Parteien',
      one: '1 Partei',
    );
    return 'Rolle und $_temp0 gelöscht.';
  }

  @override
  String get privacyPolicyTitle => 'Datenschutzrichtlinie';

  @override
  String get termsAndConditions => 'Nutzungsbedingungen';

  @override
  String get logoutConfirmTitle => 'Abmelden';

  @override
  String get logoutConfirmMessage =>
      'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String get faqTapToExpand =>
      'Tippen Sie auf eine Frage, um sie zu erweitern.';

  @override
  String get faqSectionGettingStarted => 'Erste Schritte';

  @override
  String get faqSectionLogin => 'Anmeldung';

  @override
  String get faqSectionNavigation => 'Navigation';

  @override
  String get faqSectionInvoices => 'Rechnungen';

  @override
  String get faqSectionPayments => 'Zahlungen';

  @override
  String get faqSectionItemsStock => 'Artikel & Lager';

  @override
  String get faqSectionProfileEmployees => 'Profil & Mitarbeiter';

  @override
  String get faqSectionDashboardReports => 'Dashboard & Berichte';

  @override
  String get faqSectionSyncTroubleshooting =>
      'Synchronisierung & Fehlerbehebung';

  @override
  String get faqNeedInternetQuestion => 'Benötige ich Internet?';

  @override
  String get faqNeedInternetAnswer =>
      'Nach der Einrichtung können Sie Rechnungen, Artikel und Zahlungen ohne Internet aufzeichnen. Daten bleiben auf Ihrem Gerät.';

  @override
  String get faqFirstInstallQuestion =>
      'Was passiert bei der ersten Installation?';

  @override
  String get faqFirstInstallAnswer =>
      'Sie sehen eine Einführung, dann lokale Einrichtung (Organisation, Unternehmen, E-Mail, Passwort, Währung, Geschäftsjahr). Danach anmelden.';

  @override
  String get faqSignInCredentialsQuestion => 'Was verwende ich zum Anmelden?';

  @override
  String get faqSignInCredentialsAnswer =>
      'Ihre E-Mail und Ihr Passwort aus der Einrichtung.';

  @override
  String get faqLoggedOutQuestion => 'Warum wurde ich abgemeldet?';

  @override
  String get faqLoggedOutAnswer =>
      'Sie haben sich abgemeldet oder die Sitzung ist abgelaufen. Erneut anmelden.';

  @override
  String get faqBottomTabsQuestion => 'Was machen die unteren Tabs?';

  @override
  String get faqBottomTabsAnswer =>
      'Home — Dashboard.\nVerkauf — Verkaufsrechnungen.\nAusgaben — Einkaufsrechnungen.\nMittlerer Button — Parteien.\nMehr — Profil, Berichte, Abmelden.';

  @override
  String get faqCreateInvoiceQuestion => 'Wie erstelle ich eine Rechnung?';

  @override
  String get faqCreateInvoiceAnswer =>
      'Verkauf oder Ausgaben öffnen, Datum wählen, + tippen, Artikel und Beträge hinzufügen, dann speichern.';

  @override
  String get faqInvoiceDetailsQuestion => 'Wie zeige ich Rechnungsdetails an?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'Tippen Sie auf eine Rechnung in der Liste.';

  @override
  String get faqZeroRateQuestion => 'Preis oder Betrag zeigt null';

  @override
  String get faqZeroRateAnswer =>
      'Fehlende Daten in älteren Speicherungen. App aktualisieren und neu erstellen.';

  @override
  String get faqPartialPaymentQuestion => 'Wie erfasse ich eine Teilzahlung?';

  @override
  String get faqPartialPaymentAnswer =>
      'Rechnung → Transaktionsdetails → Zahlung vornehmen.';

  @override
  String get faqMultiplePaymentQuestion => 'Wie funktioniert Mehrfachzahlung?';

  @override
  String get faqMultiplePaymentAnswer =>
      'Mehrfachzahlung einschalten und Betrag auf Bar, Karte, QR aufteilen.';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'Nur eine Zahlung aus Aufteilung gespeichert';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'Aktualisieren Sie auf die neueste App-Version.';

  @override
  String get faqAddItemQuestion => 'Wie füge ich einen Artikel hinzu?';

  @override
  String get faqAddItemAnswer =>
      'Artikel hinzufügen aus dem Verkaufsablauf. Name, Preis, Einheit eingeben.';

  @override
  String get faqCustomUnitQuestion =>
      'Wie füge ich eine benutzerdefinierte Einheit hinzu?';

  @override
  String get faqCustomUnitAnswer =>
      'Artikel → Einheit → Neue Einheit erstellen.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion => 'Profil zeigt noch alten Namen';

  @override
  String get faqProfileNameAnswer =>
      'Mitarbeiterdatensatz bearbeiten und speichern.';

  @override
  String get faqRevenueDetailsQuestion => 'Was sind Umsatzdetails?';

  @override
  String get faqRevenueDetailsAnswer =>
      'Monatsansicht mit Trenddiagramm, Nettogewinn und täglicher Verkaufs-/Kaufaufschlüsselung.';

  @override
  String get faqOtherReportsQuestion => 'Wo sind andere Berichte?';

  @override
  String get faqOtherReportsAnswer =>
      'Mehr → Berichte, wenn Ihre Rolle Zugang hat.';

  @override
  String get faqWhenSyncQuestion => 'Wann sollte ich synchronisieren?';

  @override
  String get faqWhenSyncAnswer =>
      'Nur wenn Ihr Administrator es verlangt und Sie eine stabile Verbindung haben.';

  @override
  String get faqFabPositionQuestion => 'Der + Button sieht zu hoch aus';

  @override
  String get faqFabPositionAnswer =>
      'Er sitzt über der Navigationsleiste. Liste scrollen oder App aktualisieren.';

  @override
  String get faqHowLogoutQuestion => 'Wie melde ich mich ab?';

  @override
  String get faqHowLogoutAnswer =>
      'Mehr → Abmelden am Ende der Einstellungsliste.';

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
  String get statisticsQuickOperationsSeeAll => 'Alle anzeigen';

  @override
  String get statisticsQuickOperationInvoice => 'Rechnung';

  @override
  String get statisticsQuickOperationReports => 'Berichte';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'Cashflow';

  @override
  String get statisticsCashflowLast7Days => 'Cashflow (letzte 7 Tage)';

  @override
  String get statisticsCashflowLast12Months => 'Cashflow (letzte 12 Monate)';

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
  String get profitAndLoss => 'Gewinn & Verlust';

  @override
  String get statementReport => 'Bericht';

  @override
  String get analytics => 'Analysen';

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
  String get partyPickerSubtitle => 'Für wen ist dieser Verkauf?';

  @override
  String partyPickerSearchHint(String role) {
    return '$role suchen…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'Neuen $role hinzufügen';
  }

  @override
  String get partyPickerSettled => 'Abgerechnet';

  @override
  String get partyPickerSelectedLabel => 'AUSGEWÄHLT';

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
  String get itemSelectCategoryRequired => 'Bitte wählen Sie eine Kategorie';

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
  String get closeSummaryTitle => 'Tagesabschluss';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint =>
      'Datum auswählen und Aktualisieren tippen, um Daten zu laden';

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
  String get closeTotalSales => 'Umsatz gesamt';

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
  String get closePayCashGetQr => 'Bargeld zahlen → QR erhalten';

  @override
  String get closePayQrGetCash => 'QR zahlen → Bargeld erhalten';

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
  String get closeExportData => 'Daten exportieren';

  @override
  String get closeExportComingSoon => 'Exportfunktion wird hier implementiert';

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
  String get googleDriveBackupSectionTitle => 'Sicherung & Sync';

  @override
  String get googleDriveBackupTitle => 'Google Drive-Sicherung';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Melden Sie sich an, um Ihre Organisationsdaten sicher in Google Drive zu sichern.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'Angemeldet als $email';
  }

  @override
  String get googleDriveSignIn => 'Mit Google anmelden';

  @override
  String get googleDriveSignOut => 'Abmelden';

  @override
  String get googleDriveBackupNow => 'Jetzt sichern';

  @override
  String get googleDriveSignInSuccess => 'Bei Google Drive angemeldet';

  @override
  String get googleDriveSignOutSuccess => 'Von Google Drive abgemeldet';

  @override
  String get googleDriveSignInCancelled => 'Google-Anmeldung abgebrochen';

  @override
  String get googleDriveBackupStarting => 'Sicherung wird vorbereitet…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'Sicherung hochgeladen ($tableCount Tabellen, $recordCount Datensätze)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'Sicherung erfordert einen vollständigen App-Neustart. App beenden, neu starten und erneut versuchen.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'Sicherung fehlgeschlagen: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'Letzte Sicherung: $date';
  }

  @override
  String get backupSyncPageTitle => 'Sicherung & Sync';

  @override
  String get backupSyncGoogleAccount => 'Google-Konto';

  @override
  String get backupSyncSignedInAs => 'Angemeldet als';

  @override
  String get backupSyncSignInHint =>
      'Melden Sie sich mit Google an, um Ihre Organisationsdaten zu sichern.';

  @override
  String get backupSyncLastSyncTitle => 'Letzte Synchronisation';

  @override
  String get backupSyncLastSyncDate => 'Datum und Uhrzeit';

  @override
  String get backupSyncNeverSynced =>
      'Es wurde noch keine Sicherung hochgeladen.';

  @override
  String get backupSyncOrganization => 'Organisation';

  @override
  String get backupSyncTables => 'Gesicherte Tabellen';

  @override
  String get backupSyncRecords => 'Gesicherte Datensätze';

  @override
  String get backupSyncStatus => 'Status';

  @override
  String get backupSyncStatusSuccess => 'Abgeschlossen';

  @override
  String get backupSyncActiveOrganization => 'Aktuelle Organisation';

  @override
  String get backupSyncActiveOrganizationHint =>
      'Die Sicherung lädt Daten für die Organisation hoch, die Sie gerade verwenden.';

  @override
  String get backupSyncUnknownOrganization => 'Aktuelle Organisation';

  @override
  String get backupSyncInProgress => 'Synchronisation läuft';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent %';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'Schritt: $step';
  }

  @override
  String get backupSyncStepExport => 'Lokale Daten werden exportiert';

  @override
  String backupSyncStepUploadTable(String table) {
    return '$table wird hochgeladen';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return '$file wird hochgeladen';
  }

  @override
  String backupSyncLastError(String error) {
    return 'Letzter Fehler: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'Von Google Drive auf diesem Gerät abmelden?';

  @override
  String get moreBackupSyncTileNeverSynced => 'In Google Drive sichern';

  @override
  String get moreBackupSyncTileSignedInNoSync =>
      'Angemeldet · Noch keine Sicherung';

  @override
  String get backupSyncConnected => 'Verbunden';

  @override
  String get backupSyncCompletedHint =>
      'Ihre Daten sind sicher in Google Drive gesichert.';

  @override
  String get backupSyncPhaseExport => 'Export';

  @override
  String get backupSyncPhaseUpload => 'Upload';

  @override
  String get backupAutoSettingsTitle => 'Google Drive-Einstellungen';

  @override
  String get backupAutoBackupTitle => 'Automatische Sicherung';

  @override
  String get backupAutoBackupHint =>
      'Beim App-Start automatisch sichern, wenn fällig';

  @override
  String get backupWifiOnlyTitle => 'Nur über WLAN sichern';

  @override
  String get backupWifiOnlyHint => 'Automatische Sicherung wartet auf WLAN';

  @override
  String get backupWifiOnlyContinue => 'Mobile Daten verwenden';

  @override
  String get backupAutoFrequencyTitle => 'Sicherungshäufigkeit';

  @override
  String get backupAutoFrequencyOff => 'Aus';

  @override
  String get backupAutoFrequencyDaily => 'Täglich';

  @override
  String get backupAutoFrequencyWeekly => 'Wöchentlich';

  @override
  String get backupAutoFrequencyMonthly => 'Monatlich';

  @override
  String get backupAutoSyncDirectionTitle => 'Automatische Synchronisation';

  @override
  String get backupAutoDirectionUpload => 'In die Cloud hochladen';

  @override
  String get backupAutoDirectionDownload => 'Aus der Cloud herunterladen';

  @override
  String get backupAutoDirectionBoth => 'Hoch- und Herunterladen';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'Letzte automatische Sicherung: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'Letzte automatische Wiederherstellung: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'Letzte automatische Synchronisation fehlgeschlagen: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'Letzte automatische Synchronisation übersprungen: $detail';
  }

  @override
  String get restoreAction => 'Wiederherstellen';

  @override
  String get restoreFromGoogleDrive => 'Aus Google Drive wiederherstellen';

  @override
  String get restoreFromGoogleDriveHint =>
      'Melden Sie sich an und wählen Sie eine Sicherung, um Ihre Organisation auf diesem Gerät wiederherzustellen.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '\"$name\" wiederherstellen? Dies ersetzt die lokalen Daten für diese Organisation.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name wiederhergestellt. Sie können sich jetzt anmelden.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'Wiederherstellung fehlgeschlagen: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'Keine Sicherungen in Ihrem Google Drive gefunden.';

  @override
  String get restoreFromGoogleDriveStarting =>
      'Wiederherstellung wird gestartet…';

  @override
  String get restoreStepDownload => 'Sicherung wird heruntergeladen';

  @override
  String get restoreStepCreateDatabase => 'Datenbank wird erstellt';

  @override
  String get restoreStepImport => 'Daten werden importiert';

  @override
  String get restoreStepFinalize => 'Wiederherstellung wird abgeschlossen';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'Letzte Synchronisation: $date';
  }

  @override
  String get security => 'Sicherheit';

  @override
  String get appLockTitle => 'App-Sperre';

  @override
  String get appLockSubtitle =>
      'PIN oder Biometrie beim erneuten Öffnen der App erforderlich';

  @override
  String get appPin => 'App-PIN';

  @override
  String appPinSubtitle(int length) {
    return 'Schnellentsperrung mit einer $length-stelligen PIN';
  }

  @override
  String get useBiometricUnlock => 'Face ID / Biometrie verwenden';

  @override
  String get useBiometricUnlockSubtitle =>
      'Mit Fingerabdruck oder Face ID entsperren, nachdem eine PIN eingerichtet wurde';

  @override
  String get changeAppPin => 'PIN ändern';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'PIN einrichten';

  @override
  String get confirmAppPin => 'PIN bestätigen';

  @override
  String get enterAppPin => 'PIN eingeben';

  @override
  String get enterPasscode => 'Passcode eingeben';

  @override
  String tapDigitsToUnlock(int length) {
    return 'Tippen Sie auf beliebige $length Ziffern zum Entsperren.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'Wählen Sie einen $length-stelligen Passcode für diese Organisation';
  }

  @override
  String get confirmPasscodeHint => 'Passcode zur Bestätigung erneut eingeben';

  @override
  String createAppPinHint(int length) {
    return 'Wählen Sie eine $length-stellige PIN für diese Organisation';
  }

  @override
  String get confirmAppPinHint => 'PIN zur Bestätigung erneut eingeben';

  @override
  String get appPinMismatch =>
      'PINs stimmen nicht überein. Bitte erneut versuchen.';

  @override
  String get appPinIncorrect => 'Falsche PIN. Bitte erneut versuchen.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'Falsche PIN. Sie haben noch $remaining Versuche.';
  }

  @override
  String get appPinLockoutMessage =>
      'Zu viele falsche PIN-Versuche. Melden Sie sich mit E-Mail und Passwort an, um Ihre PIN zurückzusetzen.';

  @override
  String get appPinSetSuccess => 'PIN für diese Organisation gespeichert';

  @override
  String get appPinRemoved => 'App-PIN entfernt';

  @override
  String get appLockSettingsSaved => 'App-Sperreinstellungen gespeichert';

  @override
  String get biometricUnlockReason => 'BizTrack entsperren';

  @override
  String get biometricNotAvailable =>
      'Biometrie ist auf diesem Gerät nicht verfügbar';

  @override
  String get biometricRequiresPin =>
      'Richten Sie eine App-PIN ein, bevor Sie Biometrie aktivieren';

  @override
  String get disableAppPinTitle => 'App-PIN entfernen?';

  @override
  String get disableAppPinMessage =>
      'Face ID / biometrische Entsperrung wird für diese Organisation ebenfalls deaktiviert.';

  @override
  String get verifyPinToRemoveTitle => 'PIN eingeben';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'Bestätigen Sie Ihre $length-stellige PIN, um die App-Sperre zu entfernen';
  }

  @override
  String get unlockApp => 'App entsperren';

  @override
  String get usePinInstead => 'Stattdessen PIN verwenden';

  @override
  String get useBiometricInstead => 'Biometrie verwenden';

  @override
  String get signInWithFaceId => 'Mit Face ID anmelden';

  @override
  String get signInWithFingerprint => 'Mit Fingerabdruck anmelden';

  @override
  String get signInWithBiometric => 'Mit Biometrie anmelden';

  @override
  String get signInWithPin => 'Mit PIN anmelden';

  @override
  String get setUpQuickUnlock => 'PIN-Schnellanmeldung einrichten';

  @override
  String get setUpFaceIdOrPin => 'Face ID oder PIN einrichten';

  @override
  String get setUpFingerprintOrPin => 'Fingerabdruck oder PIN einrichten';

  @override
  String get setUpQuickUnlockSubtitle =>
      'Biometrie oder PIN für diese Organisation verwenden';

  @override
  String quickUnlockAsUser(String email) {
    return 'Schnellanmeldung als $email';
  }

  @override
  String get orContinueWithPassword => 'oder mit Passwort anmelden';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'Schnellanmeldung aktivieren?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'Richten Sie Face ID, Fingerabdruck oder eine PIN ein, um sich beim nächsten Mal schneller anzumelden. Sie können dies später in den Einstellungen ändern.';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String get setUpNow => 'Jetzt einrichten';

  @override
  String get enableFaceIdTitle => 'Face ID aktivieren?';

  @override
  String get enableFingerprintTitle => 'Fingerabdruck aktivieren?';

  @override
  String get enableBiometricTitle => 'Biometrie aktivieren?';

  @override
  String get enableBiometricAfterPinMessage =>
      'Nutzen Sie die Biometrie Ihres Geräts zusammen mit Ihrer PIN für eine schnellere Anmeldung.';

  @override
  String get useFaceIdUnlock => 'Face ID verwenden';

  @override
  String get useFingerprintUnlock => 'Fingerabdruck verwenden';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => 'Jahr';

  @override
  String get reportPeriodMonth => 'Monat';

  @override
  String get reportPeriodRange => 'Bereich';

  @override
  String get reportPeriodDay => 'Tag';

  @override
  String get reportPeriodFrom => 'Von';

  @override
  String get reportPeriodTo => 'Bis';

  @override
  String get reportPeriod => 'Zeitraum';

  @override
  String get reportAllPurchases => 'Alle Einkäufe';

  @override
  String get reportBeforeTax => 'Vor Steuern';

  @override
  String get reportRevenueRetained => 'Verbleibender Umsatz';

  @override
  String get reportHideDetails => 'Details ausblenden';

  @override
  String get reportShowDetails => 'Details anzeigen';

  @override
  String get reportSalesRevenue => 'Umsatzerlöse';

  @override
  String get reportDiscountsGiven => 'Gewährte Rabatte';

  @override
  String get reportNetRevenue => 'Nettoumsatz';

  @override
  String get reportOperatingExpenses => 'Betriebsausgaben';

  @override
  String get reportTotalExpenses => 'Ausgaben gesamt';

  @override
  String get reportGrossProfit => 'Bruttogewinn';

  @override
  String get reportGrossProfitChart => 'Bruttogewinn';

  @override
  String get reportOperatingPlDisclaimer =>
      'Steuern, Abschreibungen und Lohnverbindlichkeiten noch nicht berücksichtigt — betriebliche GuV-Näherung.';

  @override
  String get reportContraLabel => 'Contra';

  @override
  String get reportNoDataForPeriod => 'Keine Daten für den gewählten Zeitraum';

  @override
  String get reportRevenueVsExpenses => 'Umsatz vs. Ausgaben';

  @override
  String get reportExpenseBreakdown => 'Ausgabenaufschlüsselung';

  @override
  String get reportExpenseFallback => 'Ausgabe';

  @override
  String get reportGrossMarginPercent => 'Bruttomarge %';

  @override
  String get reportRoomVsFnB => 'Zimmer vs. Gastronomie';

  @override
  String get reportSegmentRoom => 'Zimmer';

  @override
  String get reportSegmentFnB => 'Gastronomie';

  @override
  String get reportKeyMetrics => 'Kennzahlen';

  @override
  String get reportIncomeStatement => 'Gewinn- und Verlustrechnung';

  @override
  String get reportChartsSection => 'Diagramme';

  @override
  String get reportSegmentSummary => 'Segmentübersicht';

  @override
  String get reportFailedToLoad => 'Bericht konnte nicht geladen werden';

  @override
  String get reportOverview => 'Übersicht';

  @override
  String get reportOverviewCash => 'Bar';

  @override
  String get reportOverviewBank => 'Bank';

  @override
  String get reportMonthlyOpeningBalance => 'Monatlicher Anfangssaldo';

  @override
  String get reportOpeningBalanceHint => 'Kassenbestand zu Monatsbeginn';

  @override
  String get reportCashInOut => 'Bareingang / -ausgang';

  @override
  String get reportCashIn => 'Bareingang';

  @override
  String get reportCashOut => 'Barausgang';

  @override
  String get reportBankReceiptsPayments => 'Bankeingänge / -ausgänge';

  @override
  String get reportReceipts => 'Eingänge';

  @override
  String get reportPayments => 'Zahlungen';

  @override
  String get reportDailyCashVsQr => 'Täglich Bar vs. QR';

  @override
  String get reportSummariesSection => 'Zusammenfassungen';

  @override
  String get reportCashSummary => 'Kassenübersicht';

  @override
  String get reportBankSummary => 'Bankübersicht';

  @override
  String get reportDailySummary => 'Tagesübersicht';

  @override
  String get reportTabPurchase => 'Einkauf';

  @override
  String get reportTabSales => 'Verkauf';

  @override
  String get reportTabDashboard => 'Dashboard';

  @override
  String get reportSingleDayTrend => 'Einzelner Tag — Tagestrend';

  @override
  String get reportFullYearTrend => 'Ganzes Jahr — monatliche Trenddiagramme';

  @override
  String reportYearLabel(String year) {
    return 'Jahr $year';
  }

  @override
  String reportJanDec(String year) {
    return 'Jan – Dez $year';
  }

  @override
  String get reportTotalPurchases => 'Einkäufe gesamt';

  @override
  String get reportTotalSales => 'Umsatz gesamt';

  @override
  String get reportTotalInvoices => 'Rechnungen gesamt';

  @override
  String get reportUnpaidBalance => 'Offener Saldo';

  @override
  String get reportAvgPerInvoice => 'Durchschn. pro Rechnung';

  @override
  String get reportPerTransaction => 'Pro Transaktion';

  @override
  String reportMonthlySpend(String symbol) {
    return 'Monatsausgaben ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'Monatsumsatz ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'Rechnungsanzahl nach Monat';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'Top-Artikel nach Ausgaben ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'Ausgaben nach Kategorie';

  @override
  String get reportOtherCategory => 'Sonstige';

  @override
  String get reportSuppliers => 'Lieferanten';

  @override
  String get reportTableSupplier => 'Lieferant';

  @override
  String get reportTableAmount => 'Betrag';

  @override
  String get reportTableBills => 'Rechnungen';

  @override
  String get reportSalesTotal => 'Verkauf gesamt';

  @override
  String get reportPurchaseTotal => 'Einkauf gesamt';

  @override
  String get reportPositiveMargin => 'Positive Marge';

  @override
  String get reportNegativeMargin => 'Negative Marge';

  @override
  String get reportGrossMargin => 'Bruttomarge';

  @override
  String get reportOfTotalSales => 'Vom Gesamtumsatz';

  @override
  String get reportFailedToLoadAnalytics =>
      'Analysen konnten nicht geladen werden';

  @override
  String get reportMarginKpi => 'Marge';

  @override
  String get reportExpensesKpi => 'Ausgaben';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'Keine Ergebnisse für \"$query\"';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'Keine $role-Parteien gefunden';
  }

  @override
  String get partyPickerLoadParties => 'Parteien laden';

  @override
  String get invoiceCashCustomer => 'Barzahlung';

  @override
  String get invoiceQuickAddItemsTitle => 'Artikel schnell hinzufügen';

  @override
  String get invoiceQuickLoadingMenu => 'Menü wird geladen…';

  @override
  String get invoiceQuickInvoiceCreated => 'Rechnung erstellt';

  @override
  String get invoiceQuickAddAtLeastOneItem =>
      'Mindestens einen Artikel hinzufügen';

  @override
  String get invoiceQuickNoResults => 'Keine Ergebnisse!';

  @override
  String get invoiceQuickNoItemsInCategory =>
      'Keine Artikel in dieser Kategorie';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'Artikel hinzufügen';

  @override
  String get invoiceQuickLoadMore => 'Mehr laden';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'Scrollen für mehr ($count pro Seite)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'Lieferant / Mitarbeiter';

  @override
  String get invoiceQuickEditItem => 'Artikel bearbeiten';

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
  String get closeSelectDateRange => 'Datumsbereich auswählen';

  @override
  String get closeStartDate => 'Startdatum';

  @override
  String get closeEndDate => 'Enddatum';

  @override
  String get closeSelectBothDates => 'Bitte Start- und Enddatum auswählen';

  @override
  String get closeDeleteSummary => 'Zusammenfassung löschen';

  @override
  String get closeDeleteSummaryConfirm =>
      'Möchten Sie diese Zusammenfassung wirklich löschen?';

  @override
  String get closeSelectDate => 'Datum auswählen';

  @override
  String get closeNoDataToExport => 'Keine Daten zum Exportieren';

  @override
  String get closeNoDataToShare => 'Keine Daten zum Teilen';

  @override
  String get closeNoDataToPrint => 'Keine Daten zum Drucken';

  @override
  String closePdfGenerateError(String error) {
    return 'Fehler beim Erstellen der PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'Fehler beim Teilen der PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'Fehler beim Drucken der PDF: $error';
  }

  @override
  String get closeExportPdf => 'Als PDF exportieren';

  @override
  String get closeSharePdf => 'PDF teilen';

  @override
  String get closePrint => 'Drucken';

  @override
  String get closeExportOptions => 'Exportoptionen';

  @override
  String get closeExportPdfSubtitle =>
      'Als PDF-Dokument speichern oder anzeigen';

  @override
  String get closeSharePdfSubtitle => 'Über Apps oder E-Mail teilen';

  @override
  String get closePrintSubtitle => 'Bericht drucken';

  @override
  String get closeDailyCashSummaryTitle => 'Tägliche Kassenübersicht';

  @override
  String get closeDailyCashSummaryReport => 'Täglicher Kassenbericht';

  @override
  String closeGeneratedAt(String date) {
    return 'Erstellt: $date';
  }

  @override
  String get closeTotalRecords => 'Einträge gesamt';

  @override
  String get closeSummaryOverview => 'Zusammenfassung';

  @override
  String get closeAllRecords => 'Alle Einträge';

  @override
  String closePeriodRange(String start, String end) {
    return 'Zeitraum: $start bis $end';
  }

  @override
  String get closeDetails => 'Details';

  @override
  String closePageN(int n) {
    return 'Seite $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return '$shown von $total angezeigt';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'Geladen: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'Zimmer / Kabine / Mitarbeiter';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent % des Umsatzes';
  }

  @override
  String get reportParties => 'Parteien';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — tägliche Trenddiagramme';
  }

  @override
  String get invoiceQuickCart => 'Warenkorb';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'Warenkorb ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'Suche löschen';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'Zusammenfassung hinzufügen';

  @override
  String get closeSalesAmount => 'Verkaufsbetrag';

  @override
  String get closeClosingBalance => 'Schlussbilanz';

  @override
  String get closeLostMoney => 'Verlorenes Geld';

  @override
  String get closeDiscount => 'Rabatt';

  @override
  String get closeExpenses => 'Ausgaben';

  @override
  String get closeUnpaid => 'Unbezahlt';

  @override
  String get closeTotalOpeningBalance => 'Gesamter Anfangssaldo';

  @override
  String get closeTotalSalesAmount => 'Gesamter Verkaufsbetrag';

  @override
  String get closeTotalCashAmount => 'Gesamter Bargeldbetrag';

  @override
  String get closeTotalQrAmount => 'Gesamter QR-Betrag';

  @override
  String get closeTotalDiscount => 'Gesamtrabatt';

  @override
  String get closeTotalExpenses => 'Gesamtausgaben';

  @override
  String get closeTotalClosingBalance => 'Gesamter Schlusssaldo';

  @override
  String get closeTotalLostMoney => 'Gesamtes verlorenes Geld';

  @override
  String get closeTotalExtraAmount => 'Gesamter Zusatzbetrag';

  @override
  String get closeShowingCurrentMonth => 'Daten des aktuellen Monats';

  @override
  String get closeNoSummariesFound => 'Keine Zusammenfassungen gefunden';

  @override
  String get closeNoSummariesAvailable => 'Keine Zusammenfassungen verfügbar';

  @override
  String get closeTryAdjustingDateRange =>
      'Versuchen Sie, den Datumsbereich anzupassen';

  @override
  String get closeCreateFirstSummary =>
      'Erstellen Sie Ihre erste Zusammenfassung';

  @override
  String get closeClearFilter => 'Filter löschen';

  @override
  String get closeFiltered => 'Gefiltert';

  @override
  String closeFilteredWithRange(String range) {
    return 'Gefiltert: $range';
  }

  @override
  String get closeSummarySingular => 'Zusammenfassung';

  @override
  String get closeSummariesPlural => 'Zusammenfassungen';

  @override
  String get closeSummaryUpdatedSuccess =>
      'Zusammenfassung erfolgreich aktualisiert';

  @override
  String get closeSummaryDeletedSuccess =>
      'Zusammenfassung erfolgreich gelöscht';

  @override
  String premiumUnlockTitle(String appName) {
    return '$appName Premium freischalten';
  }

  @override
  String get premiumTagline =>
      'Vollständiges Offline-POS, Rechnungen, Inventar und Berichte — ein Abo für Ihr Unternehmen.';

  @override
  String get premiumFeatureUnlimitedInvoices =>
      'Unbegrenzte Rechnungen & Belege';

  @override
  String get premiumFeatureInventoryStock => 'Inventar- & Bestandsverfolgung';

  @override
  String get premiumFeatureReportsAnalytics => 'Verkaufsberichte & Analysen';

  @override
  String get premiumFeatureOfflineLocal =>
      'Funktioniert offline — Ihre Daten bleiben lokal';

  @override
  String premiumContinueWith(String plan) {
    return 'Weiter mit $plan';
  }

  @override
  String get premiumRestorePurchases => 'Käufe wiederherstellen';

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
      'Die Zahlung wird Ihrer Apple-ID belastet. Abos verlängern sich automatisch, sofern sie nicht mindestens 24 Stunden vor Periodenende gekündigt werden.';

  @override
  String get premiumPurchaseRestored => 'Kauf wiederhergestellt.';

  @override
  String get premiumNoActiveSubscription => 'Kein aktives Abonnement gefunden.';

  @override
  String get premiumPlanMonthly => 'Monatlich';

  @override
  String get premiumPlanMonthlySubtitle => 'Flexibel — jederzeit kündbar';

  @override
  String get premiumPlanYearly => 'Jährlich';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'Bestes Preis-Leistungs-Verhältnis — $percent % sparen';
  }

  @override
  String get premiumPlanLifetime => 'Lebenslang';

  @override
  String get premiumPlanLifetimeSubtitle => 'Einmal zahlen, für immer behalten';

  @override
  String get premiumPlanPopular => 'Beliebt';

  @override
  String get premiumOneTimePurchase => 'Einmalkauf';

  @override
  String get subscriptionSectionTitle => 'Abonnement';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Auf Premium upgraden';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'Monatlich $monthly · Jährlich $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan aktiv bis $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan aktiv';
  }

  @override
  String get premiumRequired => 'Premium erforderlich';

  @override
  String get upgradeToPremiumContinue =>
      'Upgraden Sie auf Premium, um fortzufahren.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'Der kostenlose Plan erlaubt bis zu $limit $label. Upgraden Sie auf Premium für unbegrenzten Zugriff.';
  }

  @override
  String get freemiumPartyRoleRequired => 'Parteirolle ist erforderlich.';

  @override
  String get freemiumLabelSalesInvoices => 'Verkaufsrechnungen';

  @override
  String get freemiumLabelPurchaseInvoices => 'Einkaufsrechnungen';

  @override
  String get freemiumLabelEmployees => 'Mitarbeiter';

  @override
  String get freemiumLabelItems => 'Artikel';

  @override
  String get freemiumLabelCategories => 'Kategorien';

  @override
  String get freemiumLabelPaymentMethods => 'Zahlungsmethoden';

  @override
  String get freemiumLabelCustomPartyRoles => 'benutzerdefinierte Parteirollen';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'Parteien für $role';
  }

  @override
  String get freemiumLabelOrganizations => 'Organisationen';

  @override
  String get freemiumPremiumReports => 'Berichte sind mit Premium verfügbar.';

  @override
  String get freemiumPremiumBackupSync => 'Backup & Sync erfordert Premium.';

  @override
  String get freemiumPremiumPayroll => 'Lohnabrechnung erfordert Premium.';

  @override
  String get freemiumPremiumAttendance => 'Anwesenheit erfordert Premium.';

  @override
  String get freemiumPremiumStock => 'Bestandsverwaltung erfordert Premium.';

  @override
  String get freemiumPremiumInvoiceExport =>
      'Download und Druck erfordert Premium.';

  @override
  String get shiftReminderOpeningTitle => 'Eröffnungserinnerung';

  @override
  String get shiftReminderOpeningMessage =>
      'Haben Sie die Kasse für heute geöffnet?';

  @override
  String get shiftReminderOpeningProceed => 'Ja, jetzt öffnen';

  @override
  String get shiftReminderClosingTitle => 'Schließerinnerung';

  @override
  String get shiftReminderClosingMessage =>
      'Haben Sie die Kasse für heute geschlossen?';

  @override
  String get shiftReminderClosingProceed => 'Ja, jetzt schließen';

  @override
  String get shiftReminderSkipToday => 'Heute überspringen';

  @override
  String get shiftReminderOpeningNotificationTitle => 'Eröffnungserinnerung';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'Haben Sie die Kasse für heute geöffnet? Tippen Sie hier, wenn Sie noch öffnen müssen.';

  @override
  String get shiftReminderClosingNotificationTitle => 'Schließerinnerung';

  @override
  String get shiftReminderClosingNotificationBody =>
      'Haben Sie die Kasse für heute geschlossen? Tippen Sie hier, wenn Sie noch schließen müssen.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business zahlt per QR an den Kunden; der Kunde gibt Bargeld.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business zahlt Bargeld an den Kunden; der Kunde zahlt per QR.';
  }

  @override
  String get closePaymentExchange => 'Zahlungsaustausch';

  @override
  String get closePayQrGetCashExchangeLabel => 'QR zahlen → Bargeldaustausch';

  @override
  String get closePayCashGetQrExchangeLabel => 'Bargeld zahlen → QR-Austausch';

  @override
  String get closePayQrGetCashDetail => 'QR zahlen, Bargeld erhalten';

  @override
  String get closePayCashGetQrDetail => 'Bargeld zahlen, QR erhalten';

  @override
  String get faqSectionPremium => 'Premium & Abrechnung';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Was ist in Premium enthalten?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium schaltet unbegrenzte Rechnungen, vollständige Berichte (GuV, Kontoauszug, Analysen), Backup & Sync, Lohnabrechnung, Anwesenheit, Bestandstools, Rechnungsexport/-druck und zusätzliche Organisationen frei. Die kostenlose Stufe lässt Sie Kern-POS-Funktionen innerhalb fairer Limits nutzen.';

  @override
  String get faqPremiumFreeTierQuestion =>
      'Was ist in der kostenlosen Stufe enthalten?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'Sie können bis zu 10 Verkaufs- und 10 Einkaufsrechnungen, 4 Mitarbeiter, 30 Artikel und weitere Limits erstellen, die beim Erreichen angezeigt werden. Öffnen, Schließen, Rechner und Daten durchsuchen bleiben kostenlos.';

  @override
  String get faqPremiumRestoreQuestion =>
      'Wie stelle ich meinen Kauf wieder her?';

  @override
  String get faqPremiumRestoreAnswer =>
      'Öffnen Sie Mehr → Auf Premium upgraden (oder die Paywall) und tippen Sie auf Käufe wiederherstellen. Verwenden Sie dieselbe Apple-ID wie beim Abonnement.';

  @override
  String get faqPremiumCancelQuestion => 'Wie kündige ich mein Abonnement?';

  @override
  String get faqPremiumCancelAnswer =>
      'Verwalten oder kündigen unter iPhone-Einstellungen → Apple-ID → Abonnements. Der Zugriff bleibt bis zum Ende des bezahlten Zeitraums.';

  @override
  String get faqDarkModeQuestion => 'Wie schalte ich den Dunkelmodus ein?';

  @override
  String get faqDarkModeAnswer =>
      'Öffnen Sie Mehr → Erscheinungsbild und aktivieren Sie Dunkelmodus. Wenn Ihr Gerät das Systemdesign nutzt, folgt die App automatisch.';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'Was sind Eröffnungs- und Schließerinnerungen?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName kann Sie daran erinnern, die tägliche Kasse zu öffnen oder zu schließen. Sie können fortfahren, heute überspringen oder die Erinnerung schließen.';
  }

  @override
  String get faqPartyRolesQuestion => 'Was sind Parteirollen?';

  @override
  String get faqPartyRolesAnswer =>
      'Parteirollen klassifizieren Kontakte wie Kunden, Lieferanten, Zimmer oder Mitarbeiter. Passen Sie Rollen unter Betrieb → Parteirollen an und fügen Sie eine kurze Beschreibung für Ihr Team hinzu.';

  @override
  String faqRateAppQuestion(String appName) {
    return 'Wie bewerte ich $appName?';
  }

  @override
  String get faqRateAppAnswer =>
      'Öffnen Sie Mehr → Bewerten Sie uns, um eine App-Store-Bewertung zu hinterlassen. Ihr Feedback hilft uns, die Offline-Abrechnung für Ihr Unternehmen zu verbessern.';
}
