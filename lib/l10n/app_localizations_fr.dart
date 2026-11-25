// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get noInternetConnection => 'Pas de connexion Internet.';

  @override
  String get formatException => 'Exception de format';

  @override
  String get rememberMe => 'Se souvenir de moi';

  @override
  String get signIn => 'Se connecter';

  @override
  String get passwordHint => 'Entrez le mot de passe';

  @override
  String get forgetPassword => 'Identifiants oubliés ?';

  @override
  String get okay => 'D\'accord';

  @override
  String get success => 'Succès';

  @override
  String get hotel => 'hôtel';

  @override
  String get errorEncountered => 'Erreur rencontrée';

  @override
  String get serverError => 'Erreur serveur';

  @override
  String get requestFailed => 'Requête échouée';

  @override
  String get connectionTimedOut => 'Délai de connexion dépassé';

  @override
  String get password => 'Mot de passe';

  @override
  String get keepSignIn => 'Rester connecté';

  @override
  String get enterPassword => 'Entrez le mot de passe';

  @override
  String get enterValidPassword => 'Entrez un mot de passe valide';

  @override
  String get skip => 'PASSER';

  @override
  String get pleaseWait => 'Veuillez patienter ....';

  @override
  String get enterValidUserName => 'Entrez un nom d\'utilisateur valide.';

  @override
  String get userName => 'Nom d\'utilisateur';

  @override
  String get or => 'Ou';

  @override
  String get retry => 'Réessayer';

  @override
  String get error => 'Erreur';

  @override
  String get supportMessage => 'Veuillez contacter l\'administrateur.';

  @override
  String get responseMessage404 => 'Erreur 404';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get close => 'Fermer';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteOrganizationTitle => 'Supprimer l\'organisation ?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'Supprimer $name de cet appareil. Toutes les données locales de cette organisation seront supprimées.';
  }

  @override
  String get deleteOrganizationWarning => 'Cette action est irréversible.';

  @override
  String get organizationDeleted => 'Organisation supprimée';

  @override
  String get confirm => 'Confirmer';

  @override
  String get done => 'Terminé';

  @override
  String get next => 'Suivant';

  @override
  String get getStarted => 'Commencer';

  @override
  String get walkthroughDashboardTitle =>
      'Toute votre activité en un coup d\'œil';

  @override
  String get walkthroughDashboardDescription =>
      'Ventes du jour, revenus et soldes impayés — tout sur un tableau de bord clair dès l\'ouverture de l\'app.';

  @override
  String get walkthroughOfflineTitle => 'Fonctionne sans internet';

  @override
  String get walkthroughOfflineDescription =>
      'Créez des factures, enregistrez des dépenses et gérez le stock hors ligne. Tout se synchronise automatiquement une fois en ligne.';

  @override
  String get walkthroughBillingTitle =>
      'Facturer et vendre en quelques secondes';

  @override
  String get walkthroughBillingDescription =>
      'Factures ventes et achats, commandes table avec tickets cuisine et inventaire en direct — le tout dans une app.';

  @override
  String get walkthroughStaffTitle => 'Personnel, paie et rapports';

  @override
  String get walkthroughStaffDescription =>
      'Gérez présence et paie, puis exportez comptes de résultat et bulletins en PDF — sans outils supplémentaires.';

  @override
  String get walkthroughBackupTitle => 'Vos données, toujours en sécurité';

  @override
  String get walkthroughBackupDescription =>
      'Sécurité de niveau bancaire avec sauvegardes Google Drive en un toucher — vos données protégées et faciles à restaurer.';

  @override
  String get walkthroughReadyTitle => 'Prêt quand vous l\'êtes';

  @override
  String get walkthroughReadyDescription =>
      'Configurez votre organisation en quelques minutes et gérez votre activité plus intelligemment dès aujourd\'hui. C\'est parti.';

  @override
  String get back => 'Retour';

  @override
  String get submit => 'Soumettre';

  @override
  String get continueAction => 'Continuer';

  @override
  String get createAction => 'Créer';

  @override
  String get connectOrganizationTitle => 'Connecter votre organisation';

  @override
  String get connectOrganizationSubtitle =>
      'Sélectionnez une organisation pour vous connecter.';

  @override
  String get selectOrganization => 'Organisations';

  @override
  String get selectOrganizationHint =>
      'Appuyez sur une organisation pour continuer';

  @override
  String get noSavedOrganizationsYet =>
      'Aucune organisation pour l\'instant. Créez-en une ou utilisez les données de test ci-dessous.';

  @override
  String get orgConnectOnceInfo =>
      'Cela lie l\'application à votre compte professionnel. Vous n\'avez besoin de le configurer qu\'une fois par appareil.';

  @override
  String organizationCodeLabel(String code) {
    return 'Code : $code';
  }

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get warning => 'AVERTISSEMENT';

  @override
  String get loading => 'Chargement…';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get required => 'Requis';

  @override
  String get search => 'Rechercher';

  @override
  String get add => 'Ajouter';

  @override
  String get edit => 'Modifier';

  @override
  String get remove => 'Supprimer';

  @override
  String get view => 'Afficher';

  @override
  String get export => 'Exporter';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'Importer';

  @override
  String get refresh => 'Actualiser';

  @override
  String get select => 'Sélectionner';

  @override
  String get upload => 'Téléverser';

  @override
  String get download => 'Télécharger';

  @override
  String get share => 'Partager';

  @override
  String get filter => 'Filtrer';

  @override
  String get sort => 'Trier';

  @override
  String get apply => 'Appliquer';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get clear => 'Effacer';

  @override
  String get all => 'Tout';

  @override
  String get none => 'Aucun';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Sous-total';

  @override
  String get grandTotal => 'Total général';

  @override
  String get amount => 'Montant';

  @override
  String get quantity => 'Quantité';

  @override
  String get rate => 'Taux';

  @override
  String get discount => 'Remise';

  @override
  String get paid => 'Payé';

  @override
  String get unpaid => 'Non payé';

  @override
  String get credit => 'Crédit';

  @override
  String get cash => 'Espèces';

  @override
  String get date => 'Date';

  @override
  String get time => 'Heure';

  @override
  String get name => 'Nom';

  @override
  String get email => 'E-mail';

  @override
  String get phone => 'Téléphone';

  @override
  String get address => 'Adresse';

  @override
  String get notes => 'Notes';

  @override
  String get description => 'Description';

  @override
  String get status => 'Statut';

  @override
  String get type => 'Type';

  @override
  String get category => 'Catégorie';

  @override
  String get party => 'Partie';

  @override
  String get item => 'Article';

  @override
  String get payment => 'Paiement';

  @override
  String get settlement => 'Règlement';

  @override
  String get opening => 'Ouverture';

  @override
  String get closing => 'Clôture';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'Dépense';

  @override
  String get revenue => 'Revenus';

  @override
  String get profit => 'Bénéfice';

  @override
  String get loss => 'Perte';

  @override
  String get sales => 'Ventes';

  @override
  String get purchase => 'Achat';

  @override
  String get monthJan => 'Janv';

  @override
  String get monthFeb => 'Fév';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Avr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Juin';

  @override
  String get monthJul => 'Juil';

  @override
  String get monthAug => 'Aoû';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Déc';

  @override
  String get more => 'Plus';

  @override
  String get profile => 'Profil';

  @override
  String get operations => 'Opérations';

  @override
  String get operationManagement => 'Gestion des opérations';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'Gestion des employés';

  @override
  String get employeeManagementSubtitle => 'Personnel, paie et présence';

  @override
  String get report => 'Rapport';

  @override
  String get reportSubtitle => 'Résultat, états et analyses';

  @override
  String get helpAndSupport => 'Aide et support';

  @override
  String get preferences => 'Préférences';

  @override
  String get dataAndBackup => 'Données et sauvegarde';

  @override
  String get privacyAndPolicies => 'Confidentialité et politiques';

  @override
  String get faq => 'FAQ';

  @override
  String get contactSupport => 'Contacter le support';

  @override
  String get rateUs => 'Notez-nous';

  @override
  String get rateUsSubtitle =>
      'Vous appréciez BizTrack ? Laissez un avis sur Google Play';

  @override
  String get rateUsUnavailable =>
      'Impossible d\'ouvrir le magasin. Réessayez plus tard.';

  @override
  String get reportProblem => 'Signaler un problème';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get contactUsSubtitle =>
      'Support, avis ou questions sur l\'application.';

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
  String get developerLabel => 'Développeur';

  @override
  String get emailCopiedToClipboard => 'E-mail copié dans le presse-papiers';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get settings => 'Paramètres';

  @override
  String get testData => 'Données de test';

  @override
  String get loginWithTestData => 'Connexion avec les données de test';

  @override
  String get loginWithTestDataSubtitle =>
      'Charger les données de démonstration de l\'hôtel et se connecter automatiquement';

  @override
  String testDataLoginFailed(String error) {
    return 'Impossible de charger les données de test : $error';
  }

  @override
  String get preparingTestData => 'Préparation des données de démonstration…';

  @override
  String get regionAndCurrency => 'Région et devise';

  @override
  String get reportingCurrency => 'Devise de reporting';

  @override
  String get selectCurrency => 'Sélectionner la devise';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · exemple $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'Devise définie sur $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'Impossible de mettre à jour la devise : $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'Configurer $appName';
  }

  @override
  String get setupSubtitle =>
      'Configurez votre organisation et votre comptabilité — stocké sur cet appareil pour une utilisation hors ligne.';

  @override
  String get setupOrganizationName => 'Nom de l\'organisation';

  @override
  String get setupCompanyName => 'Nom de l\'entreprise';

  @override
  String get setupBusinessType => 'Type d\'entreprise';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => 'Hôtel';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => 'Restaurant';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => 'Hôtel & Restaurant';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => 'Commerce de détail / Boutique';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'Café / Boulangerie';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'Bar / Pub';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'Autre';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'Type : $type';
  }

  @override
  String get organizationSettings => 'Organisation';

  @override
  String get editOrganizationInfo => 'Informations de l\'organisation';

  @override
  String get editOrganizationInfoSubtitle =>
      'Mettez à jour la façon dont cette entreprise apparaît dans l\'application. Le code de l\'organisation ne peut pas être modifié.';

  @override
  String get organizationCode => 'Code de l\'organisation';

  @override
  String get organizationCodeReadOnly =>
      'Ce code est fixé après la configuration.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated =>
      'Informations de l\'organisation enregistrées';

  @override
  String get organizationInfoLoadFailed =>
      'Impossible de charger les informations de l\'organisation';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'Impossible d\'enregistrer les informations de l\'organisation : $error';
  }

  @override
  String get organizationTabGeneral => 'Général';

  @override
  String get organizationTabRegional => 'Régional et fiscal';

  @override
  String get organizationRegionalSubtitle =>
      'Pays, devise de reporting et dates de l\'exercice fiscal.';

  @override
  String get organizationTabAccounting => 'Comptabilité';

  @override
  String get organizationAccountingSubtitle =>
      'Paramètres de facturation et d\'affichage des montants.';

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
  String get displayPrecision => 'Précision d\'affichage';

  @override
  String get displayPrecisionRange => 'Entrez un nombre de 0 à 5';

  @override
  String get enableInvoiceReturns => 'Activer les retours de facture';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'Autoriser la création de retours à partir de factures payées.';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get setupFullName => 'Nom complet';

  @override
  String get setupConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get setupBankName => 'Nom de la banque';

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
  String get setupRegionStepTitle => 'Région et devise';

  @override
  String get setupOrganizationStepTitle => 'Organisation';

  @override
  String get setupOrganizationStepSubtitle =>
      'Comment votre entreprise apparaît dans l\'application';

  @override
  String get setupAdminStepTitle => 'Compte administrateur';

  @override
  String get setupAdminStepSubtitle =>
      'Utilisateur principal pour cette installation';

  @override
  String get setupAccountingStepTitle => 'Comptabilité';

  @override
  String get setupAccountingStepSubtitle =>
      'Banque, plan comptable et exercice fiscal';

  @override
  String get setupCompleteSetup => 'Terminer la configuration';

  @override
  String fieldRequired(String field) {
    return '$field est requis';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress => 'Entrez une adresse e-mail valide';

  @override
  String passwordMinLength(int min) {
    return 'Le mot de passe doit contenir au moins $min caractères';
  }

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get setupFixValidationErrors =>
      'Veuillez corriger les erreurs ci-dessous pour continuer';

  @override
  String get setupCompleteSuccess => 'Configuration terminée avec succès';

  @override
  String get setupCompleteWithPdfSuccess =>
      'Configuration terminée. Enregistrez le PDF dans un endroit sécurisé.';

  @override
  String setupPdfFailed(String error) {
    return 'Configuration terminée, mais le PDF n\'a pas pu être enregistré : $error';
  }

  @override
  String get setupFailed =>
      'La configuration n\'a pas pu être complétée. Veuillez réessayer.';

  @override
  String setupFailedWithDetails(String error) {
    return 'Échec de la configuration : $error';
  }

  @override
  String get regionAndCurrencySubtitle =>
      'Paramètres régionaux et devise de reporting.';

  @override
  String get country => 'Pays';

  @override
  String get currency => 'Devise';

  @override
  String get selectCountry => 'Sélectionner le pays';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get languageChangeLaterHint =>
      'Vous pouvez le modifier ultérieurement depuis les paramètres';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'Choisissez comment utiliser $appName. Vous pourrez modifier cela plus tard dans les paramètres.';
  }

  @override
  String get searchLanguages => 'Rechercher des langues';

  @override
  String get languageSuggestedBadge => 'SUGGÉRÉ';

  @override
  String continueInLanguage(String languageName) {
    return 'Continuer en $languageName';
  }

  @override
  String get noLanguageMatches => 'Aucune correspondance';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'Aucune langue ne correspond à \"$query\"';
  }

  @override
  String get appearance => 'Apparence';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get darkModeSubtitle => 'Utiliser un fond sombre dans toute l\'app';

  @override
  String get darkModeSystemSubtitle => 'Suit le thème de votre appareil';

  @override
  String languageUpdated(String name) {
    return 'Langue définie sur $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'Impossible de mettre à jour la langue : $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'Bienvenue sur $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'Veuillez installer la dernière version de $appName pour continuer.';
  }

  @override
  String generatedByApp(String appName) {
    return 'Généré par $appName';
  }

  @override
  String whatIsApp(String appName) {
    return 'Qu\'est-ce que $appName ?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName vous aide à gérer les factures de ventes et d\'achats, les parties (clients et fournisseurs), le stock, les paiements, les employés et les résumés quotidiens — depuis votre téléphone ou tablette.';
  }

  @override
  String faqIntro(String appName) {
    return 'Réponses aux questions fréquentes sur $appName.';
  }

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get photoLibrary => 'Bibliothèque de photos';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String couldNotPickImage(String error) {
    return 'Impossible de sélectionner l\'image : $error';
  }

  @override
  String get unpaidAmount => 'Montant impayé';

  @override
  String get unpaidBalance => 'Solde impayé';

  @override
  String unpaidColonAmount(String amount) {
    return 'Non payé : $amount';
  }

  @override
  String get previousUnpaid => 'Impayé précédent';

  @override
  String get partyUnpaid => 'Partie impayée';

  @override
  String get loadingUnpaid => 'Chargement des impayés…';

  @override
  String get totalUnpaid => 'Total impayé';

  @override
  String get unpaidAmountNotYetCollected =>
      'Montant impayé pas encore encaissé.';

  @override
  String get partyUnpaidTabHint =>
      'Ouvrez Employés, sélectionnez une personne, puis appuyez sur Partie impayée sur son profil. Le serveur a besoin d\'un identifiant employé pour cette recherche.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'Le règlement de partie utilise le total impayé.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'Saisissez d\'abord un montant de règlement (ou sélectionnez une partie avec un impayé).';

  @override
  String get workspace => 'Espace de travail';

  @override
  String get change => 'Modifier';

  @override
  String get addMoreOrganization => 'Ajouter +';

  @override
  String get connectAnotherOrganization => 'Connecter une autre organisation';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'Aucune organisation enregistrée. Utilisez Ajouter + pour en connecter une.';

  @override
  String get registerNewOrganizationTitleSignedIn =>
      'Enregistrer une nouvelle organisation ?';

  @override
  String get registerNewOrganizationTitle =>
      'Enregistrer une nouvelle organisation ?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'Vous serez déconnecté et l\'assistant de configuration redémarrera depuis le début pour vous permettre d\'enregistrer une nouvelle entreprise sur cet appareil.\n\nLes organisations déjà enregistrées resteront dans la liste après la configuration.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'L\'assistant de configuration démarrera pour vous permettre d\'enregistrer une nouvelle entreprise sur cet appareil. Terminez la configuration pour la créer ; vos organisations enregistrées restent dans la liste.';

  @override
  String get startSetup => 'Démarrer la configuration';

  @override
  String get enterOrganizationCode =>
      'Veuillez saisir votre code d\'organisation';

  @override
  String get organizationNotFoundCheckCode =>
      'Organisation introuvable. Vérifiez le code et réessayez.';

  @override
  String get organizationNotFound => 'Organisation introuvable';

  @override
  String get couldNotVerifyOrganization =>
      'Impossible de vérifier l\'organisation';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'Aucune donnée locale pour $name. Terminez d\'abord la configuration de cette organisation.';
  }

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get signInToContinue => 'Connectez-vous pour continuer';

  @override
  String get enterEmail => 'Saisir l\'e-mail';

  @override
  String get pleaseEnterEmail => 'Veuillez saisir votre e-mail';

  @override
  String get pleaseEnterValidEmail => 'Veuillez saisir un e-mail valide';

  @override
  String get enterEmailLocalPartOnly =>
      'Saisissez uniquement la partie avant @';

  @override
  String get pleaseEnterPassword => 'Veuillez saisir votre mot de passe';

  @override
  String get logIn => 'CONNEXION';

  @override
  String get searchCountry => 'Rechercher un pays';

  @override
  String get searchCodeOrSymbol => 'Rechercher un code ou un symbole';

  @override
  String get saveLoginDetailsTitle => 'Enregistrer vos identifiants ?';

  @override
  String get saveLoginDetailsMessage =>
      'Vous êtes sur le point de terminer la configuration de cette organisation.\n\nSouhaitez-vous télécharger en toute sécurité un PDF avec votre code d\'organisation, le nom de l\'organisation, l\'e-mail de connexion et le mot de passe ? Conservez-le dans un endroit sûr — toute personne ayant ce fichier peut se connecter.';

  @override
  String get downloadPdfAndContinue => 'Télécharger le PDF et continuer';

  @override
  String get continueWithoutPdf => 'Continuer sans PDF';

  @override
  String get legalDisplayNameHint => 'Nom légal / d\'affichage';

  @override
  String get chartOfAccounts => 'Plan comptable';

  @override
  String get fiscalYearStart => 'Début de l\'exercice fiscal';

  @override
  String get fiscalYearEnd => 'Fin de l\'exercice fiscal';

  @override
  String get removeTestDataTitle => 'Supprimer les données de test ?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'Toutes les ventes de démonstration, les achats, les contacts, les parties, les articles d\'inventaire, le personnel, les produits de la calculatrice de boissons et les organisations de démonstration supplémentaires seront supprimés.\n\nVous êtes sur une organisation de démonstration — vous serez automatiquement redirigé vers votre première organisation.';

  @override
  String get removeTestDataMessageNormal =>
      'Toutes les ventes de démonstration, les achats, les contacts, les parties, les articles d\'inventaire, le personnel et les 3 organisations de démonstration supplémentaires seront supprimés. Votre compte administrateur et vos données de configuration réelles restent intacts.';

  @override
  String get removeTestDataWarning =>
      'Cette action est irréversible sauf en rechargeant les données de test.';

  @override
  String get removeTestData => 'Supprimer les données de test';

  @override
  String get keepTestData => 'Conserver les données de test';

  @override
  String get demoDataRemoved => 'Données de démonstration supprimées';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'Données de test supprimées. Basculé vers $name.';
  }

  @override
  String get testDataRemoved => 'Données de test supprimées';

  @override
  String couldNotRemoveTestData(String error) {
    return 'Impossible de supprimer les données de test : $error';
  }

  @override
  String get loadTestDataTitle => 'Charger les données de test ?';

  @override
  String get loadTestDataMessage =>
      'Cela ajoutera jusqu\'à 50 contacts de démonstration, 50 articles d\'inventaire ventes uniquement et 50 achats uniquement, ainsi que des ventes, achats, paiements, stocks, résumés de clôture, personnel, paie, présences pour les 15 derniers jours et des produits de boissons pour la calculatrice.';

  @override
  String get loadTestData => 'Charger les données de test';

  @override
  String get testDataLoaded => 'Données de test chargées';

  @override
  String couldNotLoadTestData(String error) {
    return 'Impossible de charger les données de test : $error';
  }

  @override
  String get demoTestData => 'Données de démonstration';

  @override
  String get importTestDataSubtitle =>
      'Importer des données de test pour toutes les fonctionnalités';

  @override
  String get hideTestDataTitle =>
      'Masquer les données de test pour cette organisation ?';

  @override
  String get hideTestDataMessage =>
      'Si vous continuez, la section Données de test sera masquée partout dans cette organisation (y compris la configuration). Vous pouvez la réactiver uniquement en réinstallant ou en effaçant les données de l\'application pour cette organisation.';

  @override
  String get hideTestDataWarning =>
      'Les données de démonstration déjà chargées resteront dans la base de données jusqu\'à ce que vous les supprimiez dans les paramètres.';

  @override
  String get okHideTestData => 'OK, masquer les données de test';

  @override
  String get testDataHiddenForOrg =>
      'Données de test masquées pour cette organisation';

  @override
  String get hideTestDataTooltip =>
      'Masquer les données de test pour cette organisation';

  @override
  String get partyRolesTitle => 'Rôles des parties';

  @override
  String get partyRolesMoreSubtitle => 'Client, fournisseur, les deux et plus';

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
  String get partyRoleCustomer => 'Client';

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
  String get searchRoles => 'Rechercher des rôles';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rôles',
      one: '1 rôle',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'Aucun rôle pour l\'instant';

  @override
  String get noRolesYetHint =>
      'Ajoutez Client, Fournisseur, Les deux ou des rôles personnalisés pour les contacts.';

  @override
  String get addRole => 'Ajouter un rôle';

  @override
  String get deleteRoleTitle => 'Supprimer le rôle';

  @override
  String deleteRoleConfirm(String name) {
    return 'Supprimer « $name » ? Cette action est irréversible.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount parties',
      one: '1 partie',
    );
    return '« $name » est utilisé par $_temp0. Transférez ces parties vers un autre rôle, ou supprimez-les définitivement.';
  }

  @override
  String get transferParties => 'Transférer les parties';

  @override
  String get hardDeleteLoseParties => 'Suppression forcée (perdre les parties)';

  @override
  String get hardDeleteRoleTitle => 'Suppression forcée ?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount parties',
      one: '1 partie',
    );
    return 'Cela supprimera définitivement « $name » et toutes les $_temp0 qui lui sont attribuées. Les données des parties ne peuvent pas être récupérées.\n\nLes parties liées aux factures ou aux paiements peuvent ne pas être supprimées — utilisez plutôt Transférer.';
  }

  @override
  String get deleteRoleAndParties => 'Supprimer le rôle et les parties';

  @override
  String get addAnotherRoleBeforeDelete =>
      'Ajoutez un autre rôle avant de supprimer celui-ci.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount parties',
      one: '1 partie',
    );
    return 'Déplacer $_temp0 de « $fromRole » vers :';
  }

  @override
  String get transferAndDeleteRole => 'Transférer et supprimer le rôle';

  @override
  String get builtInRole => 'Intégré';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 partie',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'Aucune partie pour l\'instant';

  @override
  String get newRole => 'Nouveau rôle';

  @override
  String get editRole => 'Modifier le rôle';

  @override
  String get defaultRolesCannotEdit =>
      'Les rôles par défaut ne peuvent pas être renommés ou supprimés.';

  @override
  String get roleNameLabel => 'Nom du rôle *';

  @override
  String get roleNameHint => 'ex. Client';

  @override
  String get roleDescriptionLabel => 'Description';

  @override
  String get roleDescriptionHint => 'Courte note pour votre équipe';

  @override
  String get roleSortOrderLabel => 'Ordre de tri';

  @override
  String get roleSortOrderHint =>
      'Les valeurs inférieures apparaissent en premier dans les listes';

  @override
  String get roleCreated => 'Rôle créé';

  @override
  String get roleUpdated => 'Rôle mis à jour';

  @override
  String get roleDeleted => 'Rôle supprimé';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 partie',
    );
    return 'Rôle supprimé. $_temp0 déplacée(s) vers $targetRole.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 partie',
    );
    return 'Rôle et $_temp0 supprimé(s).';
  }

  @override
  String get privacyPolicyTitle => 'Politique de confidentialité';

  @override
  String get termsAndConditions => 'Conditions générales';

  @override
  String get logoutConfirmTitle => 'Déconnexion';

  @override
  String get logoutConfirmMessage =>
      'Êtes-vous sûr de vouloir vous déconnecter de votre compte ?';

  @override
  String get faqTapToExpand => 'Appuyez sur une question pour la développer.';

  @override
  String get faqSectionGettingStarted => 'Démarrage';

  @override
  String get faqSectionLogin => 'Connexion';

  @override
  String get faqSectionNavigation => 'Navigation';

  @override
  String get faqSectionInvoices => 'Factures';

  @override
  String get faqSectionPayments => 'Paiements';

  @override
  String get faqSectionItemsStock => 'Articles et stock';

  @override
  String get faqSectionProfileEmployees => 'Profil et employés';

  @override
  String get faqSectionDashboardReports => 'Tableau de bord et rapports';

  @override
  String get faqSectionSyncTroubleshooting => 'Synchronisation et dépannage';

  @override
  String get faqNeedInternetQuestion => 'Ai-je besoin d\'internet ?';

  @override
  String get faqNeedInternetAnswer =>
      'Après la première configuration locale, vous pouvez enregistrer des factures, des articles et des paiements sans internet. Les données restent sur votre appareil. La synchronisation avec un serveur est facultative.';

  @override
  String get faqFirstInstallQuestion =>
      'Que se passe-t-il à la première installation ?';

  @override
  String get faqFirstInstallAnswer =>
      'Vous verrez peut-être une courte présentation, puis la configuration locale (organisation, entreprise, e-mail et mot de passe de connexion, devise, exercice fiscal). Ensuite, connectez-vous avec l\'e-mail et le mot de passe que vous avez créés.';

  @override
  String get faqSignInCredentialsQuestion =>
      'Que dois-je utiliser pour me connecter ?';

  @override
  String get faqSignInCredentialsAnswer =>
      'Votre adresse e-mail et mot de passe de la configuration. L\'application vous maintient connecté jusqu\'à ce que vous vous déconnectiez depuis Plus.';

  @override
  String get faqLoggedOutQuestion => 'Pourquoi ai-je été déconnecté ?';

  @override
  String get faqLoggedOutAnswer =>
      'Vous avez choisi Déconnexion, effacé les données de l\'application ou la session a expiré. Reconnectez-vous avec les mêmes identifiants.';

  @override
  String get faqBottomTabsQuestion => 'À quoi servent les onglets du bas ?';

  @override
  String get faqBottomTabsAnswer =>
      'Accueil — tableau de bord et aperçu.\nVentes — factures de vente par date.\nDépenses — factures d\'achat / dépenses.\nBouton central — Parties (clients, fournisseurs).\nPlus — profil, rapports, synchronisation, aide, déconnexion.';

  @override
  String get faqCreateInvoiceQuestion =>
      'Comment créer une facture de vente ou d\'achat ?';

  @override
  String get faqCreateInvoiceAnswer =>
      'Ouvrez Ventes ou Dépenses, sélectionnez une date sur le calendrier, appuyez sur le bouton +, ajoutez des articles et des montants, choisissez une partie si nécessaire, puis enregistrez ou soumettez.';

  @override
  String get faqInvoiceDetailsQuestion =>
      'Comment afficher les détails complets d\'une facture ?';

  @override
  String get faqInvoiceDetailsAnswer =>
      'Appuyez sur n\'importe quelle facture dans la liste. Les détails de la transaction affichent les lignes, totaux, remises et paiements. Vous pouvez imprimer, partager, dupliquer ou payer depuis là.';

  @override
  String get faqZeroRateQuestion =>
      'Le taux ou le montant affiche zéro dans les détails';

  @override
  String get faqZeroRateAnswer =>
      'Cela signifie généralement que les données de ligne ou de paiement étaient manquantes dans les anciens enregistrements. Mettez à jour l\'application et recréez ou réglez à nouveau si nécessaire.';

  @override
  String get faqPartialPaymentQuestion =>
      'Comment enregistrer un paiement partiel ?';

  @override
  String get faqPartialPaymentAnswer =>
      'Ouvrez la facture → Détails de la transaction → Effectuer un paiement. Saisissez le montant, le mode et la date, puis Traiter le règlement.';

  @override
  String get faqMultiplePaymentQuestion =>
      'Comment fonctionne le paiement multiple ?';

  @override
  String get faqMultiplePaymentAnswer =>
      'Activez le paiement multiple, appuyez sur modifier, et répartissez le total entre Espèces, Carte, QR, etc. Chaque mode est enregistré séparément.';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'Un seul paiement a été enregistré depuis un fractionnement';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'Mettez à jour vers la dernière version de l\'application. Les anciennes versions enregistraient parfois uniquement la première ligne. Réglez à nouveau si votre solde impayé est toujours incorrect.';

  @override
  String get faqAddItemQuestion => 'Comment ajouter un article ?';

  @override
  String get faqAddItemAnswer =>
      'Utilisez Ajouter un article depuis le flux de vente ou l\'ajout rapide. Saisissez le nom, le tarif, l\'unité, l\'objectif et une photo facultative (JPEG/PNG/GIF/WebP, max 5 Mo), puis Créer l\'article.';

  @override
  String get faqCustomUnitQuestion =>
      'Comment ajouter une unité personnalisée ?';

  @override
  String get faqCustomUnitAnswer =>
      'Dans le formulaire d\'article, appuyez sur Unité → Créer une nouvelle unité en bas de la liste, saisissez le nom (ex. Litre, Boîte), et Créer.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'J\'ai changé mon nom mais le profil affiche toujours l\'ancien nom';

  @override
  String get faqProfileNameAnswer =>
      'Modifiez votre fiche employé (même e-mail que la connexion) et enregistrez. L\'onglet Plus et le tableau de bord devraient se mettre à jour.';

  @override
  String get faqRevenueDetailsQuestion =>
      'Qu\'est-ce que les Détails des revenus ?';

  @override
  String get faqRevenueDetailsAnswer =>
      'Une vue mensuelle avec un graphique de tendance journalier, le bénéfice net, les créances impayées et une ventilation quotidienne ventes contre achats. Changez de mois avec le calendrier ou la puce de mois.';

  @override
  String get faqOtherReportsQuestion => 'Où sont les autres rapports ?';

  @override
  String get faqOtherReportsAnswer =>
      'Ouvrez Plus et cherchez sous Rapports (Analyses, Profits et pertes, Relevé, etc.) si votre rôle y a accès.';

  @override
  String get faqWhenSyncQuestion => 'Quand dois-je synchroniser ?';

  @override
  String get faqWhenSyncAnswer =>
      'Seulement quand votre administrateur vous le demande et quand vous avez une connexion stable. La synchronisation envoie ou reçoit des données entre l\'appareil et le serveur.';

  @override
  String get faqFabPositionQuestion =>
      'Le bouton + semble trop haut dans Ventes / Dépenses';

  @override
  String get faqFabPositionAnswer =>
      'Il se trouve au-dessus de la barre de navigation inférieure. Faites défiler la liste ou mettez à jour l\'application si le bouton chevauche le contenu.';

  @override
  String get faqHowLogoutQuestion => 'Comment me déconnecter ?';

  @override
  String get faqHowLogoutAnswer =>
      'Plus → Déconnexion en bas de la liste des paramètres.';

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
  String get statisticsQuickOperationsSeeAll => 'Tout voir';

  @override
  String get statisticsQuickOperationInvoice => 'Facture';

  @override
  String get statisticsQuickOperationReports => 'Rapports';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'Flux de trésorerie';

  @override
  String get statisticsCashflowLast7Days =>
      'Flux de trésorerie (7 derniers jours)';

  @override
  String get statisticsCashflowLast12Months =>
      'Flux de trésorerie (12 derniers mois)';

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
  String get profitAndLoss => 'Résultat';

  @override
  String get statementReport => 'État';

  @override
  String get analytics => 'Analyses';

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
  String get partyPickerSubtitle => 'Pour qui est cette vente ?';

  @override
  String partyPickerSearchHint(String role) {
    return 'Rechercher $role…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'Ajouter un $role';
  }

  @override
  String get partyPickerSettled => 'Réglé';

  @override
  String get partyPickerSelectedLabel => 'SÉLECTIONNÉ';

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
      'Veuillez sélectionner une catégorie';

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
  String get closeSummaryTitle => 'Résumé de clôture';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint =>
      'Sélectionnez une date et appuyez sur actualiser pour charger les données';

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
  String get closeTotalSales => 'Ventes totales';

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
  String get closePayCashGetQr => 'Payer espèces → Recevoir QR';

  @override
  String get closePayQrGetCash => 'Payer QR → Recevoir espèces';

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
  String get closeExportData => 'Exporter les données';

  @override
  String get closeExportComingSoon =>
      'La fonction d\'export sera implémentée ici';

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
  String get googleDriveBackupSectionTitle => 'Sauvegarde et synchro';

  @override
  String get googleDriveBackupTitle => 'Sauvegarde Google Drive';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Connectez-vous pour sauvegarder vos données d\'organisation sur Google Drive.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'Connecté en tant que $email';
  }

  @override
  String get googleDriveSignIn => 'Se connecter avec Google';

  @override
  String get googleDriveSignOut => 'Se déconnecter';

  @override
  String get googleDriveBackupNow => 'Sauvegarder maintenant';

  @override
  String get googleDriveSignInSuccess => 'Connecté à Google Drive';

  @override
  String get googleDriveSignOutSuccess => 'Déconnecté de Google Drive';

  @override
  String get googleDriveSignInCancelled => 'Connexion Google annulée';

  @override
  String get googleDriveBackupStarting => 'Préparation de la sauvegarde…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'Sauvegarde envoyée ($tableCount tables, $recordCount enregistrements)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'La sauvegarde nécessite un redémarrage complet de l\'app. Fermez l\'app, relancez-la et réessayez.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'Échec de la sauvegarde : $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'Dernière sauvegarde : $date';
  }

  @override
  String get backupSyncPageTitle => 'Sauvegarde et synchro';

  @override
  String get backupSyncGoogleAccount => 'Compte Google';

  @override
  String get backupSyncSignedInAs => 'Connecté en tant que';

  @override
  String get backupSyncSignInHint =>
      'Connectez-vous avec Google pour sauvegarder les données de votre organisation.';

  @override
  String get backupSyncLastSyncTitle => 'Dernière synchro';

  @override
  String get backupSyncLastSyncDate => 'Date et heure';

  @override
  String get backupSyncNeverSynced =>
      'Aucune sauvegarde n\'a encore été envoyée.';

  @override
  String get backupSyncOrganization => 'Organisation';

  @override
  String get backupSyncTables => 'Tables sauvegardées';

  @override
  String get backupSyncRecords => 'Enregistrements sauvegardés';

  @override
  String get backupSyncStatus => 'Statut';

  @override
  String get backupSyncStatusSuccess => 'Terminé';

  @override
  String get backupSyncActiveOrganization => 'Organisation actuelle';

  @override
  String get backupSyncActiveOrganizationHint =>
      'La sauvegarde envoie les données de l\'organisation que vous utilisez actuellement.';

  @override
  String get backupSyncUnknownOrganization => 'Organisation actuelle';

  @override
  String get backupSyncInProgress => 'Synchronisation en cours';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent %';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'Étape : $step';
  }

  @override
  String get backupSyncStepExport => 'Export des données locales';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'Envoi de $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'Envoi de $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'Dernière erreur : $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      'Se déconnecter de Google Drive sur cet appareil ?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Sauvegarder sur Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync =>
      'Connecté · Pas encore de sauvegarde';

  @override
  String get backupSyncConnected => 'Connecté';

  @override
  String get backupSyncCompletedHint =>
      'Vos données sont sauvegardées en toute sécurité sur Google Drive.';

  @override
  String get backupSyncPhaseExport => 'Export';

  @override
  String get backupSyncPhaseUpload => 'Envoi';

  @override
  String get backupAutoSettingsTitle => 'Paramètres Google Drive';

  @override
  String get backupAutoBackupTitle => 'Sauvegarde auto';

  @override
  String get backupAutoBackupHint =>
      'Sauvegarde automatique au démarrage de l\'app si nécessaire';

  @override
  String get backupWifiOnlyTitle => 'Sauvegarder uniquement en Wi‑Fi';

  @override
  String get backupWifiOnlyHint => 'La sauvegarde auto attend le Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => 'Utiliser les données mobiles';

  @override
  String get backupAutoFrequencyTitle => 'Fréquence de sauvegarde';

  @override
  String get backupAutoFrequencyOff => 'Désactivée';

  @override
  String get backupAutoFrequencyDaily => 'Quotidienne';

  @override
  String get backupAutoFrequencyWeekly => 'Hebdomadaire';

  @override
  String get backupAutoFrequencyMonthly => 'Mensuelle';

  @override
  String get backupAutoSyncDirectionTitle => 'Synchronisation auto';

  @override
  String get backupAutoDirectionUpload => 'Envoyer vers le cloud';

  @override
  String get backupAutoDirectionDownload => 'Télécharger depuis le cloud';

  @override
  String get backupAutoDirectionBoth => 'Envoi et téléchargement';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'Dernière sauvegarde auto : $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'Dernière restauration auto : $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'Dernière synchro auto échouée : $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'Dernière synchro auto ignorée : $detail';
  }

  @override
  String get restoreAction => 'Restaurer';

  @override
  String get restoreFromGoogleDrive => 'Restaurer depuis Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'Connectez-vous et choisissez une sauvegarde pour restaurer votre organisation sur cet appareil.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return 'Restaurer « $name » ? Cela remplacera les données locales de cette organisation.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name restauré. Vous pouvez vous connecter.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'Échec de la restauration : $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'Aucune sauvegarde trouvée dans votre Google Drive.';

  @override
  String get restoreFromGoogleDriveStarting => 'Démarrage de la restauration…';

  @override
  String get restoreStepDownload => 'Téléchargement de la sauvegarde';

  @override
  String get restoreStepCreateDatabase => 'Création de la base de données';

  @override
  String get restoreStepImport => 'Importation des données';

  @override
  String get restoreStepFinalize => 'Finalisation de la restauration';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'Dernière synchro : $date';
  }

  @override
  String get security => 'Sécurité';

  @override
  String get appLockTitle => 'Verrouillage de l\'app';

  @override
  String get appLockSubtitle =>
      'PIN ou biométrie requis à la réouverture de l\'app';

  @override
  String get appPin => 'PIN de l\'app';

  @override
  String appPinSubtitle(int length) {
    return 'Déverrouillage rapide avec un PIN à $length chiffres';
  }

  @override
  String get useBiometricUnlock => 'Utiliser Face ID / biométrie';

  @override
  String get useBiometricUnlockSubtitle =>
      'Déverrouiller avec empreinte ou Face ID après avoir configuré un PIN';

  @override
  String get changeAppPin => 'Changer le PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'Configurer le PIN';

  @override
  String get confirmAppPin => 'Confirmer le PIN';

  @override
  String get enterAppPin => 'Saisissez votre PIN';

  @override
  String get enterPasscode => 'Saisissez le code';

  @override
  String tapDigitsToUnlock(int length) {
    return 'Appuyez sur $length chiffres pour déverrouiller.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'Choisissez un code à $length chiffres pour cette organisation';
  }

  @override
  String get confirmPasscodeHint =>
      'Saisissez à nouveau votre code pour confirmer';

  @override
  String createAppPinHint(int length) {
    return 'Choisissez un PIN à $length chiffres pour cette organisation';
  }

  @override
  String get confirmAppPinHint =>
      'Saisissez à nouveau votre PIN pour confirmer';

  @override
  String get appPinMismatch => 'Les PIN ne correspondent pas. Réessayez.';

  @override
  String get appPinIncorrect => 'PIN incorrect. Réessayez.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN incorrect. Il vous reste $remaining essais.';
  }

  @override
  String get appPinLockoutMessage =>
      'Trop de tentatives incorrectes. Connectez-vous avec votre e-mail et mot de passe pour réinitialiser le PIN.';

  @override
  String get appPinSetSuccess => 'PIN enregistré pour cette organisation';

  @override
  String get appPinRemoved => 'PIN de l\'app supprimé';

  @override
  String get appLockSettingsSaved => 'Paramètres de verrouillage enregistrés';

  @override
  String get biometricUnlockReason => 'Déverrouiller BizTrack';

  @override
  String get biometricNotAvailable =>
      'La biométrie n\'est pas disponible sur cet appareil';

  @override
  String get biometricRequiresPin =>
      'Configurez un PIN avant d\'activer la biométrie';

  @override
  String get disableAppPinTitle => 'Supprimer le PIN de l\'app ?';

  @override
  String get disableAppPinMessage =>
      'Face ID / déverrouillage biométrique sera aussi désactivé pour cette organisation.';

  @override
  String get verifyPinToRemoveTitle => 'Saisissez votre PIN';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'Confirmez votre PIN à $length chiffres pour supprimer le verrouillage';
  }

  @override
  String get unlockApp => 'Déverrouiller l\'app';

  @override
  String get usePinInstead => 'Utiliser le PIN à la place';

  @override
  String get useBiometricInstead => 'Utiliser la biométrie';

  @override
  String get signInWithFaceId => 'Se connecter avec Face ID';

  @override
  String get signInWithFingerprint => 'Se connecter avec l\'empreinte';

  @override
  String get signInWithBiometric => 'Se connecter avec la biométrie';

  @override
  String get signInWithPin => 'Se connecter avec le PIN';

  @override
  String get setUpQuickUnlock => 'Configurer la connexion rapide par PIN';

  @override
  String get setUpFaceIdOrPin => 'Configurer Face ID ou PIN';

  @override
  String get setUpFingerprintOrPin => 'Configurer empreinte ou PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'Utilisez la biométrie ou un PIN pour cette organisation';

  @override
  String quickUnlockAsUser(String email) {
    return 'Connexion rapide en tant que $email';
  }

  @override
  String get orContinueWithPassword => 'ou se connecter avec le mot de passe';

  @override
  String get setUpQuickUnlockAfterLoginTitle => 'Activer la connexion rapide ?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'Configurez Face ID, empreinte ou PIN pour vous connecter plus vite la prochaine fois. Modifiable plus tard dans les paramètres.';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get setUpNow => 'Configurer maintenant';

  @override
  String get enableFaceIdTitle => 'Activer Face ID ?';

  @override
  String get enableFingerprintTitle => 'Activer l\'empreinte ?';

  @override
  String get enableBiometricTitle => 'Activer la biométrie ?';

  @override
  String get enableBiometricAfterPinMessage =>
      'Utilisez la biométrie de votre appareil avec votre PIN pour une connexion plus rapide.';

  @override
  String get useFaceIdUnlock => 'Utiliser Face ID';

  @override
  String get useFingerprintUnlock => 'Utiliser l\'empreinte';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => 'Année';

  @override
  String get reportPeriodMonth => 'Mois';

  @override
  String get reportPeriodRange => 'Plage';

  @override
  String get reportPeriodDay => 'Jour';

  @override
  String get reportPeriodFrom => 'De';

  @override
  String get reportPeriodTo => 'À';

  @override
  String get reportPeriod => 'Période';

  @override
  String get reportAllPurchases => 'Tous les achats';

  @override
  String get reportBeforeTax => 'Avant taxes';

  @override
  String get reportRevenueRetained => 'Revenu conservé';

  @override
  String get reportHideDetails => 'Masquer les détails';

  @override
  String get reportShowDetails => 'Afficher les détails';

  @override
  String get reportSalesRevenue => 'Revenus des ventes';

  @override
  String get reportDiscountsGiven => 'Remises accordées';

  @override
  String get reportNetRevenue => 'Revenu net';

  @override
  String get reportOperatingExpenses => 'Charges d\'exploitation';

  @override
  String get reportTotalExpenses => 'Dépenses totales';

  @override
  String get reportGrossProfit => 'Bénéfice brut';

  @override
  String get reportGrossProfitChart => 'Bénéfice brut';

  @override
  String get reportOperatingPlDisclaimer =>
      'Impôts, amortissements et charges de personnel non encore comptabilisés — approximation du résultat d\'exploitation.';

  @override
  String get reportContraLabel => 'Contrepartie';

  @override
  String get reportNoDataForPeriod =>
      'Aucune donnée pour la période sélectionnée';

  @override
  String get reportRevenueVsExpenses => 'Revenus vs dépenses';

  @override
  String get reportExpenseBreakdown => 'Répartition des dépenses';

  @override
  String get reportExpenseFallback => 'Dépense';

  @override
  String get reportGrossMarginPercent => 'Marge brute %';

  @override
  String get reportRoomVsFnB => 'Chambres vs restauration';

  @override
  String get reportSegmentRoom => 'Chambres';

  @override
  String get reportSegmentFnB => 'Restauration';

  @override
  String get reportKeyMetrics => 'Indicateurs clés';

  @override
  String get reportIncomeStatement => 'Compte de résultat';

  @override
  String get reportChartsSection => 'Graphiques';

  @override
  String get reportSegmentSummary => 'Synthèse par segment';

  @override
  String get reportFailedToLoad => 'Échec du chargement du rapport';

  @override
  String get reportOverview => 'Aperçu';

  @override
  String get reportOverviewCash => 'Caisse';

  @override
  String get reportOverviewBank => 'Banque';

  @override
  String get reportMonthlyOpeningBalance => 'Solde d\'ouverture mensuel';

  @override
  String get reportOpeningBalanceHint =>
      'Position de trésorerie en début de mois';

  @override
  String get reportCashInOut => 'Entrées / sorties de caisse';

  @override
  String get reportCashIn => 'Entrées de caisse';

  @override
  String get reportCashOut => 'Sorties de caisse';

  @override
  String get reportBankReceiptsPayments =>
      'Encaissements / paiements bancaires';

  @override
  String get reportReceipts => 'Encaissements';

  @override
  String get reportPayments => 'Paiements';

  @override
  String get reportDailyCashVsQr => 'Caisse quotidienne vs QR';

  @override
  String get reportSummariesSection => 'Synthèses';

  @override
  String get reportCashSummary => 'Synthèse de caisse';

  @override
  String get reportBankSummary => 'Synthèse bancaire';

  @override
  String get reportDailySummary => 'Synthèse quotidienne';

  @override
  String get reportTabPurchase => 'Achats';

  @override
  String get reportTabSales => 'Ventes';

  @override
  String get reportTabDashboard => 'Tableau de bord';

  @override
  String get reportSingleDayTrend => 'Jour unique — tendance quotidienne';

  @override
  String get reportFullYearTrend =>
      'Année complète — graphiques de tendance mensuelle';

  @override
  String reportYearLabel(String year) {
    return 'Année $year';
  }

  @override
  String reportJanDec(String year) {
    return 'Jan – Déc $year';
  }

  @override
  String get reportTotalPurchases => 'Total des achats';

  @override
  String get reportTotalSales => 'Ventes totales';

  @override
  String get reportTotalInvoices => 'Total des factures';

  @override
  String get reportUnpaidBalance => 'Solde impayé';

  @override
  String get reportAvgPerInvoice => 'Moy. par facture';

  @override
  String get reportPerTransaction => 'Par transaction';

  @override
  String reportMonthlySpend(String symbol) {
    return 'Dépenses mensuelles ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'Ventes mensuelles ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'Nombre de factures par mois';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'Articles les plus dépensés ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'Dépenses par catégorie';

  @override
  String get reportOtherCategory => 'Autre';

  @override
  String get reportSuppliers => 'Fournisseurs';

  @override
  String get reportTableSupplier => 'Fournisseur';

  @override
  String get reportTableAmount => 'Montant';

  @override
  String get reportTableBills => 'Factures';

  @override
  String get reportSalesTotal => 'Total des ventes';

  @override
  String get reportPurchaseTotal => 'Total des achats';

  @override
  String get reportPositiveMargin => 'Marge positive';

  @override
  String get reportNegativeMargin => 'Marge négative';

  @override
  String get reportGrossMargin => 'Marge brute';

  @override
  String get reportOfTotalSales => 'Des ventes totales';

  @override
  String get reportFailedToLoadAnalytics => 'Échec du chargement des analyses';

  @override
  String get reportMarginKpi => 'Marge';

  @override
  String get reportExpensesKpi => 'Dépenses';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'Aucun résultat pour « $query »';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'Aucune partie $role trouvée';
  }

  @override
  String get partyPickerLoadParties => 'Charger les parties';

  @override
  String get invoiceCashCustomer => 'Client comptant';

  @override
  String get invoiceQuickAddItemsTitle => 'Ajout rapide d\'articles';

  @override
  String get invoiceQuickLoadingMenu => 'Chargement du menu…';

  @override
  String get invoiceQuickInvoiceCreated => 'Facture créée';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'Ajoutez au moins un article';

  @override
  String get invoiceQuickNoResults => 'Aucun résultat !';

  @override
  String get invoiceQuickNoItemsInCategory =>
      'Aucun article dans cette catégorie';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'Ajouter un article';

  @override
  String get invoiceQuickLoadMore => 'Charger plus';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'Faites défiler pour en charger plus ($count par page)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'Fournisseur / Employé';

  @override
  String get invoiceQuickEditItem => 'Modifier l\'article';

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
  String get closeSelectDateRange => 'Sélectionner une plage de dates';

  @override
  String get closeStartDate => 'Date de début';

  @override
  String get closeEndDate => 'Date de fin';

  @override
  String get closeSelectBothDates =>
      'Veuillez sélectionner les dates de début et de fin';

  @override
  String get closeDeleteSummary => 'Supprimer le résumé';

  @override
  String get closeDeleteSummaryConfirm =>
      'Voulez-vous vraiment supprimer ce résumé ?';

  @override
  String get closeSelectDate => 'Sélectionner une date';

  @override
  String get closeNoDataToExport => 'Aucune donnée à exporter';

  @override
  String get closeNoDataToShare => 'Aucune donnée à partager';

  @override
  String get closeNoDataToPrint => 'Aucune donnée à imprimer';

  @override
  String closePdfGenerateError(String error) {
    return 'Erreur lors de la génération du PDF : $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'Erreur lors du partage du PDF : $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'Erreur lors de l\'impression du PDF : $error';
  }

  @override
  String get closeExportPdf => 'Exporter en PDF';

  @override
  String get closeSharePdf => 'Partager le PDF';

  @override
  String get closePrint => 'Imprimer';

  @override
  String get closeExportOptions => 'Options d\'export';

  @override
  String get closeExportPdfSubtitle =>
      'Enregistrer ou afficher en document PDF';

  @override
  String get closeSharePdfSubtitle =>
      'Partager via des applications ou par e-mail';

  @override
  String get closePrintSubtitle => 'Imprimer le rapport';

  @override
  String get closeDailyCashSummaryTitle => 'Synthèse de caisse quotidienne';

  @override
  String get closeDailyCashSummaryReport =>
      'Rapport de synthèse de caisse quotidien';

  @override
  String closeGeneratedAt(String date) {
    return 'Généré le : $date';
  }

  @override
  String get closeTotalRecords => 'Total des enregistrements';

  @override
  String get closeSummaryOverview => 'Aperçu du résumé';

  @override
  String get closeAllRecords => 'Tous les enregistrements';

  @override
  String closePeriodRange(String start, String end) {
    return 'Période : du $start au $end';
  }

  @override
  String get closeDetails => 'Détails';

  @override
  String closePageN(int n) {
    return 'Page $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'Affichage de $shown sur $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'Chargé : $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'Chambre / Cabine / Employé';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent % du revenu';
  }

  @override
  String get reportParties => 'Parties';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — graphiques de tendance quotidienne';
  }

  @override
  String get invoiceQuickCart => 'Panier';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'Panier ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'Effacer la recherche';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'Ajouter un résumé';

  @override
  String get closeSalesAmount => 'Montant des ventes';

  @override
  String get closeClosingBalance => 'Solde de clôture';

  @override
  String get closeLostMoney => 'Argent perdu';

  @override
  String get closeDiscount => 'Remise';

  @override
  String get closeExpenses => 'Dépenses';

  @override
  String get closeUnpaid => 'Impayé';

  @override
  String get closeTotalOpeningBalance => 'Solde d\'ouverture total';

  @override
  String get closeTotalSalesAmount => 'Montant total des ventes';

  @override
  String get closeTotalCashAmount => 'Montant total en espèces';

  @override
  String get closeTotalQrAmount => 'Montant total QR';

  @override
  String get closeTotalDiscount => 'Remise totale';

  @override
  String get closeTotalExpenses => 'Dépenses totales';

  @override
  String get closeTotalClosingBalance => 'Solde de clôture total';

  @override
  String get closeTotalLostMoney => 'Argent perdu total';

  @override
  String get closeTotalExtraAmount => 'Montant supplémentaire total';

  @override
  String get closeShowingCurrentMonth => 'Données du mois en cours';

  @override
  String get closeNoSummariesFound => 'Aucun résumé trouvé';

  @override
  String get closeNoSummariesAvailable => 'Aucun résumé disponible';

  @override
  String get closeTryAdjustingDateRange =>
      'Essayez d\'ajuster la plage de dates';

  @override
  String get closeCreateFirstSummary =>
      'Créez votre premier résumé pour commencer';

  @override
  String get closeClearFilter => 'Effacer le filtre';

  @override
  String get closeFiltered => 'Filtré';

  @override
  String closeFilteredWithRange(String range) {
    return 'Filtré : $range';
  }

  @override
  String get closeSummarySingular => 'Résumé';

  @override
  String get closeSummariesPlural => 'Résumés';

  @override
  String get closeSummaryUpdatedSuccess => 'Résumé mis à jour avec succès';

  @override
  String get closeSummaryDeletedSuccess => 'Résumé supprimé avec succès';

  @override
  String premiumUnlockTitle(String appName) {
    return 'Débloquer $appName Premium';
  }

  @override
  String get premiumTagline =>
      'Caisse offline complète, facturation, inventaire et rapports — un abonnement pour votre entreprise.';

  @override
  String get premiumFeatureUnlimitedInvoices => 'Factures et reçus illimités';

  @override
  String get premiumFeatureInventoryStock => 'Inventaire et suivi des stocks';

  @override
  String get premiumFeatureReportsAnalytics => 'Rapports de ventes et analyses';

  @override
  String get premiumFeatureOfflineLocal =>
      'Fonctionne hors ligne — vos données restent locales';

  @override
  String premiumContinueWith(String plan) {
    return 'Continuer avec $plan';
  }

  @override
  String get premiumRestorePurchases => 'Restaurer les achats';

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
      'Le paiement est débité de votre Apple ID. Les abonnements se renouvellent automatiquement sauf annulation au moins 24 h avant la fin de la période.';

  @override
  String get premiumPurchaseRestored => 'Achat restauré.';

  @override
  String get premiumNoActiveSubscription => 'Aucun abonnement actif trouvé.';

  @override
  String get premiumPlanMonthly => 'Mensuel';

  @override
  String get premiumPlanMonthlySubtitle => 'Flexible — résiliez à tout moment';

  @override
  String get premiumPlanYearly => 'Annuel';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'Meilleur rapport qualité-prix — économisez $percent %';
  }

  @override
  String get premiumPlanLifetime => 'À vie';

  @override
  String get premiumPlanLifetimeSubtitle =>
      'Payez une fois, gardez pour toujours';

  @override
  String get premiumPlanPopular => 'Populaire';

  @override
  String get premiumOneTimePurchase => 'Achat unique';

  @override
  String get subscriptionSectionTitle => 'Abonnement';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Passer à Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'Mensuel $monthly · Annuel $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan actif jusqu\'au $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan actif';
  }

  @override
  String get premiumRequired => 'Premium requis';

  @override
  String get upgradeToPremiumContinue => 'Passez à Premium pour continuer.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'Le plan gratuit autorise jusqu\'à $limit $label. Passez à Premium pour un accès illimité.';
  }

  @override
  String get freemiumPartyRoleRequired => 'Le rôle de partie est requis.';

  @override
  String get freemiumLabelSalesInvoices => 'factures de vente';

  @override
  String get freemiumLabelPurchaseInvoices => 'factures d\'achat';

  @override
  String get freemiumLabelEmployees => 'employés';

  @override
  String get freemiumLabelItems => 'articles';

  @override
  String get freemiumLabelCategories => 'catégories';

  @override
  String get freemiumLabelPaymentMethods => 'modes de paiement';

  @override
  String get freemiumLabelCustomPartyRoles => 'rôles de partie personnalisés';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'parties pour $role';
  }

  @override
  String get freemiumLabelOrganizations => 'organisations';

  @override
  String get freemiumPremiumReports =>
      'Les rapports sont disponibles avec Premium.';

  @override
  String get freemiumPremiumBackupSync =>
      'Sauvegarde et sync nécessitent Premium.';

  @override
  String get freemiumPremiumPayroll => 'La paie nécessite Premium.';

  @override
  String get freemiumPremiumAttendance => 'La présence nécessite Premium.';

  @override
  String get freemiumPremiumStock => 'La gestion des stocks nécessite Premium.';

  @override
  String get freemiumPremiumInvoiceExport =>
      'Téléchargement et impression nécessitent Premium.';

  @override
  String get shiftReminderOpeningTitle => 'Rappel d\'ouverture';

  @override
  String get shiftReminderOpeningMessage =>
      'Avez-vous ouvert la caisse pour aujourd\'hui ?';

  @override
  String get shiftReminderOpeningProceed => 'Oui, ouvrir maintenant';

  @override
  String get shiftReminderClosingTitle => 'Rappel de clôture';

  @override
  String get shiftReminderClosingMessage =>
      'Avez-vous fermé la caisse pour aujourd\'hui ?';

  @override
  String get shiftReminderClosingProceed => 'Oui, fermer maintenant';

  @override
  String get shiftReminderSkipToday => 'Ignorer pour aujourd\'hui';

  @override
  String get shiftReminderOpeningNotificationTitle => 'Rappel d\'ouverture';

  @override
  String get shiftReminderOpeningNotificationBody =>
      'Avez-vous ouvert la caisse pour aujourd\'hui ? Appuyez ici si vous devez encore l\'ouvrir.';

  @override
  String get shiftReminderClosingNotificationTitle => 'Rappel de clôture';

  @override
  String get shiftReminderClosingNotificationBody =>
      'Avez-vous fermé la caisse pour aujourd\'hui ? Appuyez ici si vous devez encore la fermer.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business paie en QR au client ; le client fournit des espèces.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business paie en espèces au client ; le client paie en QR.';
  }

  @override
  String get closePaymentExchange => 'Échange de paiement';

  @override
  String get closePayQrGetCashExchangeLabel =>
      'Payer QR → Recevoir espèces (échange)';

  @override
  String get closePayCashGetQrExchangeLabel =>
      'Payer espèces → Recevoir QR (échange)';

  @override
  String get closePayQrGetCashDetail => 'Payer QR, recevoir espèces';

  @override
  String get closePayCashGetQrDetail => 'Payer espèces, recevoir QR';

  @override
  String get faqSectionPremium => 'Premium et facturation';

  @override
  String get faqPremiumWhatsIncludedQuestion => 'Que comprend Premium ?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium débloque des factures illimitées, des rapports complets (P&L, relevé, analyses), sauvegarde et sync, paie, présence, outils stock, export/impression de factures et organisations supplémentaires. Le niveau gratuit permet d\'utiliser les fonctions POS essentielles dans des limites raisonnables.';

  @override
  String get faqPremiumFreeTierQuestion => 'Que comprend le niveau gratuit ?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'Vous pouvez créer jusqu\'à 10 factures de vente et 10 d\'achat, 4 employés, 30 articles et d\'autres limites affichées à l\'atteinte. Ouverture, clôture, calculatrice et consultation des données restent gratuits.';

  @override
  String get faqPremiumRestoreQuestion => 'Comment restaurer mon achat ?';

  @override
  String get faqPremiumRestoreAnswer =>
      'Ouvrez Plus → Passer à Premium (ou l\'écran de paiement) et appuyez sur Restaurer les achats. Utilisez le même Apple ID que pour l\'abonnement.';

  @override
  String get faqPremiumCancelQuestion => 'Comment annuler mon abonnement ?';

  @override
  String get faqPremiumCancelAnswer =>
      'Gérez ou annulez dans Réglages iPhone → Apple ID → Abonnements. Vous conservez l\'accès jusqu\'à la fin de la période payée.';

  @override
  String get faqDarkModeQuestion => 'Comment activer le mode sombre ?';

  @override
  String get faqDarkModeAnswer =>
      'Ouvrez Plus → Apparence et activez Mode sombre. Quand l\'appareil utilise le thème système, l\'app suit automatiquement.';

  @override
  String get faqOpeningClosingReminderQuestion =>
      'Que sont les rappels d\'ouverture et de clôture ?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName peut vous rappeler d\'ouvrir ou fermer la caisse quotidienne. Vous pouvez continuer, ignorer pour aujourd\'hui ou fermer le rappel.';
  }

  @override
  String get faqPartyRolesQuestion => 'Que sont les rôles de partie ?';

  @override
  String get faqPartyRolesAnswer =>
      'Les rôles de partie classent les contacts comme clients, fournisseurs, chambres ou employés. Personnalisez-les dans Opérations → Rôles de partie et ajoutez une courte description pour votre équipe.';

  @override
  String faqRateAppQuestion(String appName) {
    return 'Comment noter $appName ?';
  }

  @override
  String get faqRateAppAnswer =>
      'Ouvrez Plus → Notez-nous pour laisser un avis sur l\'App Store. Vos retours nous aident à améliorer la facturation offline pour votre entreprise.';
}
