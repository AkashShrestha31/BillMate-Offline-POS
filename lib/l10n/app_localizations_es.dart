// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get noInternetConnection => 'Sin conexión a Internet.';

  @override
  String get formatException => 'Excepción de formato';

  @override
  String get rememberMe => 'Recordarme';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get passwordHint => 'Ingrese la contraseña';

  @override
  String get forgetPassword => '¿Olvidó su información de acceso?';

  @override
  String get okay => 'Aceptar';

  @override
  String get success => 'Éxito';

  @override
  String get hotel => 'hotel';

  @override
  String get errorEncountered => 'Error encontrado';

  @override
  String get serverError => 'Error del servidor';

  @override
  String get requestFailed => 'Solicitud fallida';

  @override
  String get connectionTimedOut => 'Tiempo de conexión agotado';

  @override
  String get password => 'Contraseña';

  @override
  String get keepSignIn => 'Mantener sesión iniciada';

  @override
  String get enterPassword => 'Ingrese la contraseña';

  @override
  String get enterValidPassword => 'Ingrese una contraseña válida';

  @override
  String get skip => 'OMITIR';

  @override
  String get pleaseWait => 'Por favor espere ....';

  @override
  String get enterValidUserName => 'Ingrese un nombre de usuario válido.';

  @override
  String get userName => 'Nombre de usuario';

  @override
  String get or => 'O';

  @override
  String get retry => 'Reintentar';

  @override
  String get error => 'Error';

  @override
  String get supportMessage => 'Comuníquese con el administrador.';

  @override
  String get responseMessage404 => 'Error 404';

  @override
  String get appDisplayName => 'BizTrack';

  @override
  String appVersionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get close => 'Cerrar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteOrganizationTitle => '¿Eliminar organización?';

  @override
  String deleteOrganizationMessage(String name) {
    return 'Eliminar $name de este dispositivo. Todos los datos locales de esta organización serán eliminados.';
  }

  @override
  String get deleteOrganizationWarning => 'Esto no se puede deshacer.';

  @override
  String get organizationDeleted => 'Organización eliminada';

  @override
  String get confirm => 'Confirmar';

  @override
  String get done => 'Listo';

  @override
  String get next => 'Siguiente';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get walkthroughDashboardTitle => 'Todo su negocio de un vistazo';

  @override
  String get walkthroughDashboardDescription =>
      'Ventas de hoy, ingresos y saldos pendientes — todo en un panel claro al abrir la app.';

  @override
  String get walkthroughOfflineTitle => 'Funciona sin internet';

  @override
  String get walkthroughOfflineDescription =>
      'Cree facturas, registre gastos y gestione stock sin conexión. Todo se sincroniza automáticamente al volver en línea.';

  @override
  String get walkthroughBillingTitle => 'Facture y venda en segundos';

  @override
  String get walkthroughBillingDescription =>
      'Facturas de venta y compra, pedidos de mesa con tickets de cocina e inventario en vivo — todo desde una app.';

  @override
  String get walkthroughStaffTitle => 'Personal, nómina e informes';

  @override
  String get walkthroughStaffDescription =>
      'Gestione asistencia y nómina, luego exporte estados de P&G y recibos en PDF — sin herramientas extra.';

  @override
  String get walkthroughBackupTitle => 'Sus datos, siempre seguros';

  @override
  String get walkthroughBackupDescription =>
      'Seguridad de nivel bancario con copias en Google Drive con un toque, para que sus registros estén protegidos y fáciles de restaurar.';

  @override
  String get walkthroughReadyTitle => 'Listo cuando usted lo esté';

  @override
  String get walkthroughReadyDescription =>
      'Configure su organización en minutos y gestione su negocio de forma más inteligente hoy. Empecemos.';

  @override
  String get back => 'Atrás';

  @override
  String get submit => 'Enviar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get createAction => 'Crear';

  @override
  String get connectOrganizationTitle => 'Conectar su organización';

  @override
  String get connectOrganizationSubtitle =>
      'Seleccione una organización para iniciar sesión.';

  @override
  String get selectOrganization => 'Organizaciones';

  @override
  String get selectOrganizationHint => 'Toque una organización para continuar';

  @override
  String get noSavedOrganizationsYet =>
      'Aún no hay organizaciones. Cree una o use los datos de prueba a continuación.';

  @override
  String get orgConnectOnceInfo =>
      'Esto vincula la aplicación a su cuenta empresarial. Solo necesita configurarlo una vez por dispositivo.';

  @override
  String organizationCodeLabel(String code) {
    return 'Código: $code';
  }

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get warning => 'ADVERTENCIA';

  @override
  String get loading => 'Cargando…';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get required => 'Requerido';

  @override
  String get search => 'Buscar';

  @override
  String get add => 'Agregar';

  @override
  String get edit => 'Editar';

  @override
  String get remove => 'Eliminar';

  @override
  String get view => 'Ver';

  @override
  String get export => 'Exportar';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get partyExportPdfTooltip => 'Export PDF';

  @override
  String get import => 'Importar';

  @override
  String get refresh => 'Actualizar';

  @override
  String get select => 'Seleccionar';

  @override
  String get upload => 'Subir';

  @override
  String get download => 'Descargar';

  @override
  String get share => 'Compartir';

  @override
  String get filter => 'Filtrar';

  @override
  String get sort => 'Ordenar';

  @override
  String get apply => 'Aplicar';

  @override
  String get reset => 'Restablecer';

  @override
  String get clear => 'Borrar';

  @override
  String get all => 'Todo';

  @override
  String get none => 'Ninguno';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get grandTotal => 'Gran Total';

  @override
  String get amount => 'Monto';

  @override
  String get quantity => 'Cantidad';

  @override
  String get rate => 'Tasa';

  @override
  String get discount => 'Descuento';

  @override
  String get paid => 'Pagado';

  @override
  String get unpaid => 'Impagado';

  @override
  String get credit => 'Crédito';

  @override
  String get cash => 'Efectivo';

  @override
  String get date => 'Fecha';

  @override
  String get time => 'Hora';

  @override
  String get name => 'Nombre';

  @override
  String get email => 'Correo electrónico';

  @override
  String get phone => 'Teléfono';

  @override
  String get address => 'Dirección';

  @override
  String get notes => 'Notas';

  @override
  String get description => 'Descripción';

  @override
  String get status => 'Estado';

  @override
  String get type => 'Tipo';

  @override
  String get category => 'Categoría';

  @override
  String get party => 'Parte';

  @override
  String get item => 'Artículo';

  @override
  String get payment => 'Pago';

  @override
  String get settlement => 'Liquidación';

  @override
  String get opening => 'Apertura';

  @override
  String get closing => 'Cierre';

  @override
  String get stock => 'Stock reconciliation';

  @override
  String get expense => 'Gasto';

  @override
  String get revenue => 'Ingresos';

  @override
  String get profit => 'Beneficio';

  @override
  String get loss => 'Pérdida';

  @override
  String get sales => 'Ventas';

  @override
  String get purchase => 'Compra';

  @override
  String get monthJan => 'Ene';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Abr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Ago';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dic';

  @override
  String get more => 'Más';

  @override
  String get profile => 'Perfil';

  @override
  String get operations => 'Operaciones';

  @override
  String get operationManagement => 'Gestión de operaciones';

  @override
  String get operationManagementSubtitle =>
      'Items, stock reconciliation, contacts, categories, and closing';

  @override
  String get employeeManagement => 'Gestión de empleados';

  @override
  String get employeeManagementSubtitle => 'Personal, nómina y asistencia';

  @override
  String get report => 'Informe';

  @override
  String get reportSubtitle => 'Pérdidas y ganancias, estados y análisis';

  @override
  String get helpAndSupport => 'Ayuda y soporte';

  @override
  String get preferences => 'Preferencias';

  @override
  String get dataAndBackup => 'Datos y copia';

  @override
  String get privacyAndPolicies => 'Privacidad y políticas';

  @override
  String get faq => 'Preguntas frecuentes';

  @override
  String get contactSupport => 'Contactar soporte';

  @override
  String get rateUs => 'Califícanos';

  @override
  String get rateUsSubtitle =>
      '¿Disfrutando BizTrack? Deja una reseña en Google Play';

  @override
  String get rateUsUnavailable =>
      'No se pudo abrir la tienda. Inténtalo más tarde.';

  @override
  String get reportProblem => 'Informar de un problema';

  @override
  String get contactUs => 'Contáctenos';

  @override
  String get contactUsSubtitle =>
      'Soporte, comentarios o preguntas sobre la aplicación.';

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
  String get developerLabel => 'Desarrollador';

  @override
  String get emailCopiedToClipboard => 'Correo copiado al portapapeles';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get signOut => 'Salir';

  @override
  String get settings => 'Configuración';

  @override
  String get testData => 'Datos de prueba';

  @override
  String get loginWithTestData => 'Iniciar con datos de prueba';

  @override
  String get loginWithTestDataSubtitle =>
      'Cargar datos de hotel de demostración e iniciar sesión automáticamente';

  @override
  String testDataLoginFailed(String error) {
    return 'No se pudo cargar los datos de prueba: $error';
  }

  @override
  String get preparingTestData => 'Preparando datos de demostración…';

  @override
  String get regionAndCurrency => 'Región y moneda';

  @override
  String get reportingCurrency => 'Moneda de informes';

  @override
  String get selectCurrency => 'Seleccionar moneda';

  @override
  String currencySample(String code, String symbol, String sample) {
    return '$code · $symbol · muestra $sample';
  }

  @override
  String currencyUpdated(String code, String symbol) {
    return 'Moneda establecida en $code ($symbol)';
  }

  @override
  String currencyUpdateFailed(String error) {
    return 'No se pudo actualizar la moneda: $error';
  }

  @override
  String setupAppTitle(String appName) {
    return 'Configurar $appName';
  }

  @override
  String get setupSubtitle =>
      'Configure su organización y contabilidad — almacenado en este dispositivo para uso sin conexión.';

  @override
  String get setupOrganizationName => 'Nombre de la organización';

  @override
  String get setupCompanyName => 'Nombre de la empresa';

  @override
  String get setupBusinessType => 'Tipo de negocio';

  @override
  String get selectBusinessType => 'Select business type';

  @override
  String get businessTypeHotel => 'Hotel';

  @override
  String get businessTypeHotelSubtitle => 'Rooms, guests & front desk';

  @override
  String get businessTypeRestaurant => 'Restaurante';

  @override
  String get businessTypeRestaurantSubtitle =>
      'Dine-in, kitchen & table orders';

  @override
  String get businessTypeHotelRestaurant => 'Hotel y Restaurante';

  @override
  String get businessTypeHotelRestaurantSubtitle =>
      'Hotel rooms and restaurant together';

  @override
  String get businessTypeRetail => 'Venta al por menor / Tienda';

  @override
  String get businessTypeRetailSubtitle => 'Products, stock & checkout';

  @override
  String get businessTypeCafe => 'Café / Panadería';

  @override
  String get businessTypeCafeSubtitle => 'Coffee, pastries & light bites';

  @override
  String get businessTypeBar => 'Bar / Pub';

  @override
  String get businessTypeBarSubtitle => 'Drinks menu, tabs & bar sales';

  @override
  String get businessTypeOther => 'Otro';

  @override
  String get businessTypeOtherSubtitle => 'Custom setup for any business';

  @override
  String organizationBusinessTypeLabel(String type) {
    return 'Tipo: $type';
  }

  @override
  String get organizationSettings => 'Organización';

  @override
  String get editOrganizationInfo => 'Información de la organización';

  @override
  String get editOrganizationInfoSubtitle =>
      'Actualiza cómo aparece este negocio en la aplicación. El código de la organización no se puede cambiar.';

  @override
  String get organizationCode => 'Código de la organización';

  @override
  String get organizationCodeReadOnly =>
      'Este código se fija después de la configuración.';

  @override
  String get businessTypeReadOnly =>
      'Business type is set during setup and cannot be changed.';

  @override
  String get organizationInfoUpdated =>
      'Información de la organización guardada';

  @override
  String get organizationInfoLoadFailed =>
      'No se pudo cargar la información de la organización';

  @override
  String organizationInfoSaveFailed(String error) {
    return 'No se pudo guardar la información de la organización: $error';
  }

  @override
  String get organizationTabGeneral => 'General';

  @override
  String get organizationTabRegional => 'Regional y fiscal';

  @override
  String get organizationRegionalSubtitle =>
      'País, moneda de informes y fechas del ejercicio fiscal.';

  @override
  String get organizationTabAccounting => 'Contabilidad';

  @override
  String get organizationAccountingSubtitle =>
      'Configuración de facturas y visualización de importes.';

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
  String get displayPrecision => 'Precisión de visualización';

  @override
  String get displayPrecisionRange => 'Introduzca un número del 0 al 5';

  @override
  String get enableInvoiceReturns => 'Activar devoluciones de facturas';

  @override
  String get enableInvoiceReturnsSubtitle =>
      'Permitir crear devoluciones desde facturas pagadas.';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get setupFullName => 'Nombre completo';

  @override
  String get setupConfirmPassword => 'Confirmar contraseña';

  @override
  String get setupBankName => 'Nombre del banco';

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
  String get setupRegionStepTitle => 'Región y moneda';

  @override
  String get setupOrganizationStepTitle => 'Organización';

  @override
  String get setupOrganizationStepSubtitle =>
      'Cómo aparece su negocio en la aplicación';

  @override
  String get setupAdminStepTitle => 'Cuenta de administrador';

  @override
  String get setupAdminStepSubtitle =>
      'Usuario principal para esta instalación';

  @override
  String get setupAccountingStepTitle => 'Contabilidad';

  @override
  String get setupAccountingStepSubtitle =>
      'Banco, plan de cuentas y ejercicio fiscal';

  @override
  String get setupCompleteSetup => 'Completar configuración';

  @override
  String fieldRequired(String field) {
    return '$field es obligatorio';
  }

  @override
  String fieldMaxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get invalidEmailAddress =>
      'Ingrese una dirección de correo electrónico válida';

  @override
  String passwordMinLength(int min) {
    return 'La contraseña debe tener al menos $min caracteres';
  }

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get setupFixValidationErrors =>
      'Corrija los errores a continuación para continuar';

  @override
  String get setupCompleteSuccess => 'Configuración completada exitosamente';

  @override
  String get setupCompleteWithPdfSuccess =>
      'Configuración completa. Guarde el PDF en un lugar seguro.';

  @override
  String setupPdfFailed(String error) {
    return 'Configuración completada, pero no se pudo guardar el PDF: $error';
  }

  @override
  String get setupFailed =>
      'No se pudo completar la configuración. Inténtelo de nuevo.';

  @override
  String setupFailedWithDetails(String error) {
    return 'Configuración fallida: $error';
  }

  @override
  String get regionAndCurrencySubtitle =>
      'Configuración regional y moneda de reporte.';

  @override
  String get country => 'País';

  @override
  String get currency => 'Moneda';

  @override
  String get selectCountry => 'Seleccionar país';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get languageChangeLaterHint =>
      'Puede cambiarlo más tarde desde la configuración';

  @override
  String languageSelectionSubtitle(String appName) {
    return 'Elija cómo desea usar $appName. Puede cambiarlo más tarde en Configuración.';
  }

  @override
  String get searchLanguages => 'Buscar idiomas';

  @override
  String get languageSuggestedBadge => 'SUGERIDO';

  @override
  String continueInLanguage(String languageName) {
    return 'Continuar en $languageName';
  }

  @override
  String get noLanguageMatches => 'Sin coincidencias';

  @override
  String noLanguageMatchesForQuery(String query) {
    return 'Ningún idioma coincide con \"$query\"';
  }

  @override
  String get appearance => 'Apariencia';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get darkModeSubtitle => 'Usar fondo oscuro en toda la app';

  @override
  String get darkModeSystemSubtitle => 'Sigue el tema de su dispositivo';

  @override
  String languageUpdated(String name) {
    return 'Idioma establecido en $name';
  }

  @override
  String languageUpdateFailed(String error) {
    return 'No se pudo actualizar el idioma: $error';
  }

  @override
  String welcomeToApp(String appName) {
    return 'Bienvenido a $appName';
  }

  @override
  String forceUpdateMessage(String appName) {
    return 'Instale la versión más reciente de $appName para continuar.';
  }

  @override
  String generatedByApp(String appName) {
    return 'Generado por $appName';
  }

  @override
  String whatIsApp(String appName) {
    return '¿Qué es $appName?';
  }

  @override
  String appDescriptionFaq(String appName) {
    return '$appName le ayuda a gestionar facturas de ventas y compras, partes (clientes y proveedores), inventario, pagos, empleados y resúmenes diarios — desde su teléfono o tableta.';
  }

  @override
  String faqIntro(String appName) {
    return 'Respuestas a preguntas comunes sobre $appName.';
  }

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get photoLibrary => 'Biblioteca de fotos';

  @override
  String get addPhoto => 'Agregar foto';

  @override
  String couldNotPickImage(String error) {
    return 'No se pudo seleccionar la imagen: $error';
  }

  @override
  String get unpaidAmount => 'Monto no pagado';

  @override
  String get unpaidBalance => 'Saldo no pagado';

  @override
  String unpaidColonAmount(String amount) {
    return 'No pagado: $amount';
  }

  @override
  String get previousUnpaid => 'No pagado anterior';

  @override
  String get partyUnpaid => 'Parte no pagada';

  @override
  String get loadingUnpaid => 'Cargando no pagado…';

  @override
  String get totalUnpaid => 'Total no pagado';

  @override
  String get unpaidAmountNotYetCollected => 'Monto no pagado aún no cobrado.';

  @override
  String get partyUnpaidTabHint =>
      'Abra Empleados, seleccione una persona y toque Parte no pagada en su perfil. El servidor necesita un id de empleado para esta búsqueda.';

  @override
  String get partySettlementUsesUnpaidTotal =>
      'La liquidación de partes usa el total no pagado.';

  @override
  String get selectPartyWithUnpaidFirst =>
      'Ingrese primero un monto de liquidación (o seleccione una parte con saldo no pagado).';

  @override
  String get workspace => 'Espacio de trabajo';

  @override
  String get change => 'Cambiar';

  @override
  String get addMoreOrganization => 'Agregar más +';

  @override
  String get connectAnotherOrganization => 'Conectar otra organización';

  @override
  String get noSavedOrganizationsUseAddMore =>
      'Aún no hay organizaciones guardadas. Use Agregar más + para conectar una.';

  @override
  String get registerNewOrganizationTitleSignedIn =>
      '¿Registrar una nueva organización?';

  @override
  String get registerNewOrganizationTitle => '¿Registrar nueva organización?';

  @override
  String get registerNewOrganizationMessageSignedIn =>
      'Se cerrará su sesión y el asistente de configuración comenzará desde el principio.\n\nLas organizaciones guardadas permanecerán en la lista después de la configuración.';

  @override
  String get registerNewOrganizationMessageLogin =>
      'El asistente de configuración comenzará. Complete la configuración para crearlo; sus organizaciones guardadas permanecen en la lista.';

  @override
  String get startSetup => 'Iniciar configuración';

  @override
  String get enterOrganizationCode =>
      'Por favor ingrese su código de organización';

  @override
  String get organizationNotFoundCheckCode =>
      'Organización no encontrada. Verifique el código e intente de nuevo.';

  @override
  String get organizationNotFound => 'Organización no encontrada';

  @override
  String get couldNotVerifyOrganization =>
      'No se pudo verificar la organización';

  @override
  String noLocalDataCompleteSetup(String name) {
    return 'No hay datos locales para $name. Complete primero la configuración.';
  }

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get signInToContinue => 'Inicie sesión para continuar';

  @override
  String get enterEmail => 'Ingresar correo electrónico';

  @override
  String get pleaseEnterEmail => 'Por favor ingrese su correo electrónico';

  @override
  String get pleaseEnterValidEmail =>
      'Por favor ingrese un correo electrónico válido';

  @override
  String get enterEmailLocalPartOnly => 'Ingrese solo la parte antes de @';

  @override
  String get pleaseEnterPassword => 'Por favor ingrese su contraseña';

  @override
  String get logIn => 'INICIAR SESIÓN';

  @override
  String get searchCountry => 'Buscar país';

  @override
  String get searchCodeOrSymbol => 'Buscar código o símbolo';

  @override
  String get saveLoginDetailsTitle => '¿Guardar datos de inicio de sesión?';

  @override
  String get saveLoginDetailsMessage =>
      'Está a punto de completar la configuración.\n\n¿Descargar un PDF con código, nombre, correo y contraseña? Guárdelo en un lugar seguro.';

  @override
  String get downloadPdfAndContinue => 'Descargar PDF y continuar';

  @override
  String get continueWithoutPdf => 'Continuar sin PDF';

  @override
  String get legalDisplayNameHint => 'Nombre legal / de visualización';

  @override
  String get chartOfAccounts => 'Plan de cuentas';

  @override
  String get fiscalYearStart => 'Inicio del año fiscal';

  @override
  String get fiscalYearEnd => 'Fin del año fiscal';

  @override
  String get removeTestDataTitle => '¿Eliminar datos de prueba?';

  @override
  String get removeTestDataMessageDemoOrg =>
      'Se eliminarán todas las ventas, compras, contactos, partes, inventario, empleados y organizaciones de demostración.\n\nEstá en una organización de demostración — se cambiará automáticamente a su primera organización.';

  @override
  String get removeTestDataMessageNormal =>
      'Se eliminarán todos los datos de demostración y las 3 organizaciones adicionales. Su cuenta de administrador permanece intacta.';

  @override
  String get removeTestDataWarning =>
      'Esto no se puede deshacer excepto cargando los datos de prueba nuevamente.';

  @override
  String get removeTestData => 'Eliminar datos de prueba';

  @override
  String get keepTestData => 'Conservar datos de prueba';

  @override
  String get demoDataRemoved => 'Datos de demostración eliminados';

  @override
  String testDataRemovedSwitchedTo(String name) {
    return 'Datos de prueba eliminados. Cambiado a $name.';
  }

  @override
  String get testDataRemoved => 'Datos de prueba eliminados';

  @override
  String couldNotRemoveTestData(String error) {
    return 'No se pudieron eliminar los datos de prueba: $error';
  }

  @override
  String get loadTestDataTitle => '¿Cargar datos de prueba?';

  @override
  String get loadTestDataMessage =>
      'Esto agregará contactos, artículos, ventas, compras, pagos, empleados y asistencia de los últimos 15 días.';

  @override
  String get loadTestData => 'Cargar datos de prueba';

  @override
  String get testDataLoaded => 'Datos de prueba cargados';

  @override
  String couldNotLoadTestData(String error) {
    return 'No se pudieron cargar los datos de prueba: $error';
  }

  @override
  String get demoTestData => 'Datos de prueba de demostración';

  @override
  String get importTestDataSubtitle =>
      'Importar datos de prueba para todas las funciones';

  @override
  String get hideTestDataTitle =>
      '¿Ocultar datos de prueba para esta organización?';

  @override
  String get hideTestDataMessage =>
      'La sección de Datos de prueba se ocultará en toda esta organización.';

  @override
  String get hideTestDataWarning =>
      'Los datos de demostración ya cargados permanecerán en la base de datos hasta que los elimine.';

  @override
  String get okHideTestData => 'OK, ocultar datos de prueba';

  @override
  String get testDataHiddenForOrg =>
      'Datos de prueba ocultos para esta organización';

  @override
  String get hideTestDataTooltip =>
      'Ocultar datos de prueba para esta organización';

  @override
  String get partyRolesTitle => 'Roles de partes';

  @override
  String get partyRolesMoreSubtitle => 'Cliente, proveedor, ambos y más';

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
  String get partyRoleCustomer => 'Cliente';

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
  String get searchRoles => 'Buscar roles';

  @override
  String roleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count roles',
      one: '1 rol',
    );
    return '$_temp0';
  }

  @override
  String get noRolesYet => 'Aún no hay roles';

  @override
  String get noRolesYetHint =>
      'Agregue Cliente, Proveedor, Ambos o roles personalizados para contactos.';

  @override
  String get addRole => 'Agregar rol';

  @override
  String get deleteRoleTitle => 'Eliminar rol';

  @override
  String deleteRoleConfirm(String name) {
    return '¿Eliminar \"$name\"? Esto no se puede deshacer.';
  }

  @override
  String deleteRoleHasPartiesMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount partes',
      one: '1 parte',
    );
    return '\"$name\" es usado por $_temp0. Transfiera o elimine forzosamente.';
  }

  @override
  String get transferParties => 'Transferir partes';

  @override
  String get hardDeleteLoseParties => 'Eliminar forzosamente (perder partes)';

  @override
  String get hardDeleteRoleTitle => '¿Eliminación forzosa?';

  @override
  String hardDeleteRoleMessage(String name, int partyCount) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount partes',
      one: '1 parte',
    );
    return 'Esto eliminará permanentemente \"$name\" y $_temp0.\n\nLas partes vinculadas a facturas pueden no eliminarse — use Transferir.';
  }

  @override
  String get deleteRoleAndParties => 'Eliminar rol y partes';

  @override
  String get addAnotherRoleBeforeDelete =>
      'Agregue otro rol antes de eliminar este.';

  @override
  String transferPartiesMoveMessage(int partyCount, String fromRole) {
    String _temp0 = intl.Intl.pluralLogic(
      partyCount,
      locale: localeName,
      other: '$partyCount partes',
      one: '1 parte',
    );
    return 'Mover $_temp0 de \"$fromRole\" a:';
  }

  @override
  String get transferAndDeleteRole => 'Transferir y eliminar rol';

  @override
  String get builtInRole => 'Integrado';

  @override
  String rolePartyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partes',
      one: '1 parte',
    );
    return '$_temp0';
  }

  @override
  String get noPartiesYet => 'Aún no hay partes';

  @override
  String get newRole => 'Nuevo rol';

  @override
  String get editRole => 'Editar rol';

  @override
  String get defaultRolesCannotEdit =>
      'Los roles predeterminados no se pueden renombrar ni eliminar.';

  @override
  String get roleNameLabel => 'Nombre del rol *';

  @override
  String get roleNameHint => 'ej. Cliente';

  @override
  String get roleDescriptionLabel => 'Descripción';

  @override
  String get roleDescriptionHint => 'Nota corta para su equipo';

  @override
  String get roleSortOrderLabel => 'Orden de clasificación';

  @override
  String get roleSortOrderHint => 'El número menor aparece primero';

  @override
  String get roleCreated => 'Rol creado';

  @override
  String get roleUpdated => 'Rol actualizado';

  @override
  String get roleDeleted => 'Rol eliminado';

  @override
  String roleDeletedPartiesTransferred(int count, String targetRole) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partes',
      one: '1 parte',
    );
    return 'Rol eliminado. $_temp0 movida a $targetRole.';
  }

  @override
  String roleAndPartiesDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partes',
      one: '1 parte',
    );
    return 'Rol y $_temp0 eliminados.';
  }

  @override
  String get privacyPolicyTitle => 'Política de privacidad';

  @override
  String get termsAndConditions => 'Términos y condiciones';

  @override
  String get logoutConfirmTitle => 'Cerrar sesión';

  @override
  String get logoutConfirmMessage => '¿Está seguro de que desea cerrar sesión?';

  @override
  String get faqTapToExpand => 'Toque una pregunta para expandirla.';

  @override
  String get faqSectionGettingStarted => 'Comenzando';

  @override
  String get faqSectionLogin => 'Inicio de sesión';

  @override
  String get faqSectionNavigation => 'Navegación';

  @override
  String get faqSectionInvoices => 'Facturas';

  @override
  String get faqSectionPayments => 'Pagos';

  @override
  String get faqSectionItemsStock => 'Artículos e inventario';

  @override
  String get faqSectionProfileEmployees => 'Perfil y empleados';

  @override
  String get faqSectionDashboardReports => 'Panel e informes';

  @override
  String get faqSectionSyncTroubleshooting =>
      'Sincronización y solución de problemas';

  @override
  String get faqNeedInternetQuestion => '¿Necesito internet?';

  @override
  String get faqNeedInternetAnswer =>
      'Después de la configuración inicial puede registrar facturas y pagos sin internet. Los datos permanecen en su dispositivo.';

  @override
  String get faqFirstInstallQuestion => '¿Qué pasa en la primera instalación?';

  @override
  String get faqFirstInstallAnswer =>
      'Verá una introducción, luego configuración local (organización, empresa, correo, contraseña, moneda, año fiscal). Después inicie sesión.';

  @override
  String get faqSignInCredentialsQuestion => '¿Qué uso para iniciar sesión?';

  @override
  String get faqSignInCredentialsAnswer =>
      'Su correo electrónico y contraseña de la configuración.';

  @override
  String get faqLoggedOutQuestion => '¿Por qué se cerró mi sesión?';

  @override
  String get faqLoggedOutAnswer =>
      'Eligió cerrar sesión o la sesión expiró. Inicie sesión nuevamente.';

  @override
  String get faqBottomTabsQuestion => '¿Qué hacen las pestañas inferiores?';

  @override
  String get faqBottomTabsAnswer =>
      'Inicio — panel.\nVentas — facturas de ventas.\nGastos — facturas de compra.\nBotón central — Partes.\nMás — perfil, informes, cerrar sesión.';

  @override
  String get faqCreateInvoiceQuestion => '¿Cómo creo una factura?';

  @override
  String get faqCreateInvoiceAnswer =>
      'Abra Ventas o Gastos, seleccione fecha, toque +, agregue artículos y montos, luego guarde.';

  @override
  String get faqInvoiceDetailsQuestion =>
      '¿Cómo veo los detalles de la factura?';

  @override
  String get faqInvoiceDetailsAnswer => 'Toque cualquier factura en la lista.';

  @override
  String get faqZeroRateQuestion => 'La tasa muestra cero en los detalles';

  @override
  String get faqZeroRateAnswer =>
      'Datos faltantes en guardados anteriores. Actualice la aplicación.';

  @override
  String get faqPartialPaymentQuestion => '¿Cómo registro un pago parcial?';

  @override
  String get faqPartialPaymentAnswer => 'Factura → Detalles → Realizar pago.';

  @override
  String get faqMultiplePaymentQuestion => '¿Cómo funciona el pago múltiple?';

  @override
  String get faqMultiplePaymentAnswer =>
      'Active pago múltiple y divida entre Efectivo, Tarjeta, QR.';

  @override
  String get faqSplitPaymentSavedQuestion =>
      'Solo se guardó un pago de una división';

  @override
  String get faqSplitPaymentSavedAnswer =>
      'Actualice a la versión más reciente.';

  @override
  String get faqAddItemQuestion => '¿Cómo agrego un artículo?';

  @override
  String get faqAddItemAnswer =>
      'Use Agregar artículo. Ingrese nombre, precio, unidad, luego Crear artículo.';

  @override
  String get faqCustomUnitQuestion => '¿Cómo agrego una unidad personalizada?';

  @override
  String get faqCustomUnitAnswer => 'Artículo → Unidad → Crear nueva unidad.';

  @override
  String get faqStockQuantitiesQuestion => 'How do I enter stock quantities?';

  @override
  String get faqStockQuantitiesAnswer =>
      'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.';

  @override
  String get faqProfileNameQuestion =>
      'El perfil aún muestra el nombre anterior';

  @override
  String get faqProfileNameAnswer => 'Edite su registro de empleado y guarde.';

  @override
  String get faqRevenueDetailsQuestion => '¿Qué son los Detalles de ingresos?';

  @override
  String get faqRevenueDetailsAnswer =>
      'Vista mensual con gráfico diario, beneficio neto y desglose de ventas vs compras.';

  @override
  String get faqOtherReportsQuestion => '¿Dónde están otros informes?';

  @override
  String get faqOtherReportsAnswer => 'Más → Informes, si su rol tiene acceso.';

  @override
  String get faqWhenSyncQuestion => '¿Cuándo debo sincronizar?';

  @override
  String get faqWhenSyncAnswer =>
      'Solo cuando su administrador lo indique y tenga conexión estable.';

  @override
  String get faqFabPositionQuestion => 'El botón + parece demasiado alto';

  @override
  String get faqFabPositionAnswer =>
      'Se sitúa sobre la barra de navegación. Desplace la lista o actualice la app.';

  @override
  String get faqHowLogoutQuestion => '¿Cómo cierro sesión?';

  @override
  String get faqHowLogoutAnswer => 'Más → Cerrar sesión al final de la lista.';

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
  String get statisticsQuickOperationsSeeAll => 'Ver todo';

  @override
  String get statisticsQuickOperationInvoice => 'Factura';

  @override
  String get statisticsQuickOperationReports => 'Informes';

  @override
  String get statisticsAnnualRevenue => 'Annual Revenue';

  @override
  String get statisticsCashflow => 'Flujo de caja';

  @override
  String get statisticsCashflowLast7Days => 'Flujo de caja (últimos 7 días)';

  @override
  String get statisticsCashflowLast12Months =>
      'Flujo de caja (últimos 12 meses)';

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
  String get profitAndLoss => 'Pérdidas y ganancias';

  @override
  String get statementReport => 'Estado';

  @override
  String get analytics => 'Análisis';

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
  String get partyPickerSubtitle => '¿Para quién es esta venta?';

  @override
  String partyPickerSearchHint(String role) {
    return 'Buscar $role…';
  }

  @override
  String partyPickerAddNewRole(String role) {
    return 'Añadir $role';
  }

  @override
  String get partyPickerSettled => 'Liquidado';

  @override
  String get partyPickerSelectedLabel => 'SELECCIONADO';

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
  String get itemSelectCategoryRequired => 'Seleccione una categoría';

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
  String get closeSummaryTitle => 'Resumen de cierre';

  @override
  String get closeTabDashboard => 'Dashboard';

  @override
  String get closeTabCredits => 'Credits';

  @override
  String get closeWelcome => 'Welcome to Closing Summary';

  @override
  String get closeSelectDateHint =>
      'Seleccione una fecha y pulse actualizar para cargar los datos';

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
  String get closeTotalSales => 'Ventas totales';

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
  String get closePayCashGetQr => 'Pagar efectivo → Recibir QR';

  @override
  String get closePayQrGetCash => 'Pagar QR → Recibir efectivo';

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
  String get closeExportData => 'Exportar datos';

  @override
  String get closeExportComingSoon =>
      'La función de exportación se implementará aquí';

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
  String get googleDriveBackupSectionTitle => 'Copia y sincronización';

  @override
  String get googleDriveBackupTitle => 'Copia en Google Drive';

  @override
  String get googleDriveBackupSubtitleSignedOut =>
      'Inicie sesión para respaldar los datos de su organización en Google Drive.';

  @override
  String googleDriveBackupSubtitleSignedIn(String email) {
    return 'Sesión iniciada como $email';
  }

  @override
  String get googleDriveSignIn => 'Iniciar sesión con Google';

  @override
  String get googleDriveSignOut => 'Cerrar sesión';

  @override
  String get googleDriveBackupNow => 'Copiar ahora';

  @override
  String get googleDriveSignInSuccess => 'Sesión iniciada en Google Drive';

  @override
  String get googleDriveSignOutSuccess => 'Sesión cerrada en Google Drive';

  @override
  String get googleDriveSignInCancelled =>
      'Inicio de sesión con Google cancelado';

  @override
  String get googleDriveBackupStarting => 'Preparando copia…';

  @override
  String googleDriveBackupSuccess(int tableCount, int recordCount) {
    return 'Copia subida ($tableCount tablas, $recordCount registros)';
  }

  @override
  String get googleDriveBackupPluginError =>
      'La copia requiere reiniciar la app por completo. Cierre la app, ábrala de nuevo e inténtelo otra vez.';

  @override
  String googleDriveBackupFailed(String error) {
    return 'Copia fallida: $error';
  }

  @override
  String googleDriveLastBackup(String date) {
    return 'Última copia: $date';
  }

  @override
  String get backupSyncPageTitle => 'Copia y sincronización';

  @override
  String get backupSyncGoogleAccount => 'Cuenta de Google';

  @override
  String get backupSyncSignedInAs => 'Sesión iniciada como';

  @override
  String get backupSyncSignInHint =>
      'Inicie sesión con Google para respaldar los datos de su organización.';

  @override
  String get backupSyncLastSyncTitle => 'Última sincronización';

  @override
  String get backupSyncLastSyncDate => 'Fecha y hora';

  @override
  String get backupSyncNeverSynced => 'Aún no se ha subido ninguna copia.';

  @override
  String get backupSyncOrganization => 'Organización';

  @override
  String get backupSyncTables => 'Tablas respaldadas';

  @override
  String get backupSyncRecords => 'Registros respaldados';

  @override
  String get backupSyncStatus => 'Estado';

  @override
  String get backupSyncStatusSuccess => 'Completado';

  @override
  String get backupSyncActiveOrganization => 'Organización actual';

  @override
  String get backupSyncActiveOrganizationHint =>
      'La copia sube los datos de la organización que está usando ahora.';

  @override
  String get backupSyncUnknownOrganization => 'Organización actual';

  @override
  String get backupSyncInProgress => 'Sincronización en curso';

  @override
  String backupSyncProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String backupSyncCurrentStep(String step) {
    return 'Paso: $step';
  }

  @override
  String get backupSyncStepExport => 'Exportando datos locales';

  @override
  String backupSyncStepUploadTable(String table) {
    return 'Subiendo $table';
  }

  @override
  String backupSyncStepUploadFile(String file) {
    return 'Subiendo $file';
  }

  @override
  String backupSyncLastError(String error) {
    return 'Último error: $error';
  }

  @override
  String get backupSyncSignOutConfirm =>
      '¿Cerrar sesión de Google Drive en este dispositivo?';

  @override
  String get moreBackupSyncTileNeverSynced => 'Copiar en Google Drive';

  @override
  String get moreBackupSyncTileSignedInNoSync =>
      'Sesión iniciada · Sin copia aún';

  @override
  String get backupSyncConnected => 'Conectado';

  @override
  String get backupSyncCompletedHint =>
      'Sus datos están guardados de forma segura en Google Drive.';

  @override
  String get backupSyncPhaseExport => 'Exportar';

  @override
  String get backupSyncPhaseUpload => 'Subir';

  @override
  String get backupAutoSettingsTitle => 'Configuración de Google Drive';

  @override
  String get backupAutoBackupTitle => 'Copia automática';

  @override
  String get backupAutoBackupHint =>
      'Copia de seguridad automática al iniciar la app cuando corresponda';

  @override
  String get backupWifiOnlyTitle => 'Copiar solo con Wi‑Fi';

  @override
  String get backupWifiOnlyHint => 'La copia automática espera Wi‑Fi';

  @override
  String get backupWifiOnlyContinue => 'Usar datos móviles';

  @override
  String get backupAutoFrequencyTitle => 'Frecuencia de copia';

  @override
  String get backupAutoFrequencyOff => 'Desactivada';

  @override
  String get backupAutoFrequencyDaily => 'Diaria';

  @override
  String get backupAutoFrequencyWeekly => 'Semanal';

  @override
  String get backupAutoFrequencyMonthly => 'Mensual';

  @override
  String get backupAutoSyncDirectionTitle => 'Sincronización automática';

  @override
  String get backupAutoDirectionUpload => 'Subir a la nube';

  @override
  String get backupAutoDirectionDownload => 'Descargar de la nube';

  @override
  String get backupAutoDirectionBoth => 'Subir y descargar';

  @override
  String backupAutoLastUploaded(String detail) {
    return 'Última copia automática: $detail';
  }

  @override
  String backupAutoLastDownloaded(String detail) {
    return 'Última restauración automática: $detail';
  }

  @override
  String backupAutoLastFailed(String detail) {
    return 'Última sincronización automática fallida: $detail';
  }

  @override
  String backupAutoLastSkipped(String detail) {
    return 'Última sincronización automática omitida: $detail';
  }

  @override
  String get restoreAction => 'Restaurar';

  @override
  String get restoreFromGoogleDrive => 'Restaurar desde Google Drive';

  @override
  String get restoreFromGoogleDriveHint =>
      'Inicie sesión y elija una copia para restaurar su organización en este dispositivo.';

  @override
  String restoreFromGoogleDriveConfirm(String name) {
    return '¿Restaurar \"$name\"? Esto reemplazará los datos locales de esa organización.';
  }

  @override
  String restoreFromGoogleDriveSuccess(String name) {
    return '$name restaurado. Ya puede iniciar sesión.';
  }

  @override
  String restoreFromGoogleDriveFailed(String error) {
    return 'Restauración fallida: $error';
  }

  @override
  String get restoreFromGoogleDriveEmpty =>
      'No se encontraron copias en su Google Drive.';

  @override
  String get restoreFromGoogleDriveStarting => 'Iniciando restauración…';

  @override
  String get restoreStepDownload => 'Descargando copia';

  @override
  String get restoreStepCreateDatabase => 'Creando base de datos';

  @override
  String get restoreStepImport => 'Importando datos';

  @override
  String get restoreStepFinalize => 'Finalizando restauración';

  @override
  String moreBackupSyncTileLastSync(String date) {
    return 'Última sincronización: $date';
  }

  @override
  String get security => 'Seguridad';

  @override
  String get appLockTitle => 'Bloqueo de app';

  @override
  String get appLockSubtitle =>
      'Requerir PIN o biometría al volver a abrir la app';

  @override
  String get appPin => 'PIN de la app';

  @override
  String appPinSubtitle(int length) {
    return 'Desbloqueo rápido con un PIN de $length dígitos';
  }

  @override
  String get useBiometricUnlock => 'Usar Face ID / biometría';

  @override
  String get useBiometricUnlockSubtitle =>
      'Desbloquear con huella o Face ID después de configurar un PIN';

  @override
  String get changeAppPin => 'Cambiar PIN';

  @override
  String get verifyPinToChangeTitle => 'Enter current PIN';

  @override
  String verifyPinToChangeSubtitle(int length) {
    return 'Confirm your $length-digit PIN before setting a new one';
  }

  @override
  String get unlockWithBiometrics => 'Unlock with biometrics';

  @override
  String get setUpAppPin => 'Configurar PIN';

  @override
  String get confirmAppPin => 'Confirmar PIN';

  @override
  String get enterAppPin => 'Ingrese su PIN';

  @override
  String get enterPasscode => 'Ingrese el código';

  @override
  String tapDigitsToUnlock(int length) {
    return 'Toque $length dígitos cualesquiera para desbloquear.';
  }

  @override
  String createPasscodeHint(int length) {
    return 'Elija un código de $length dígitos para esta organización';
  }

  @override
  String get confirmPasscodeHint =>
      'Vuelva a ingresar su código para confirmar';

  @override
  String createAppPinHint(int length) {
    return 'Elija un PIN de $length dígitos para esta organización';
  }

  @override
  String get confirmAppPinHint => 'Vuelva a ingresar su PIN para confirmar';

  @override
  String get appPinMismatch => 'Los PIN no coinciden. Inténtelo de nuevo.';

  @override
  String get appPinIncorrect => 'PIN incorrecto. Inténtelo de nuevo.';

  @override
  String appPinIncorrectWithAttempts(int remaining) {
    return 'PIN incorrecto. Le quedan $remaining intentos.';
  }

  @override
  String get appPinLockoutMessage =>
      'Demasiados intentos incorrectos. Inicie sesión con su correo y contraseña para restablecer el PIN.';

  @override
  String get appPinSetSuccess => 'PIN guardado para esta organización';

  @override
  String get appPinRemoved => 'PIN de la app eliminado';

  @override
  String get appLockSettingsSaved => 'Configuración de bloqueo guardada';

  @override
  String get biometricUnlockReason => 'Desbloquear BizTrack';

  @override
  String get biometricNotAvailable =>
      'La biometría no está disponible en este dispositivo';

  @override
  String get biometricRequiresPin =>
      'Configure un PIN antes de activar la biometría';

  @override
  String get disableAppPinTitle => '¿Eliminar PIN de la app?';

  @override
  String get disableAppPinMessage =>
      'Face ID / desbloqueo biométrico también se desactivará para esta organización.';

  @override
  String get verifyPinToRemoveTitle => 'Ingrese su PIN';

  @override
  String verifyPinToRemoveSubtitle(int length) {
    return 'Confirme su PIN de $length dígitos para quitar el bloqueo';
  }

  @override
  String get unlockApp => 'Desbloquear app';

  @override
  String get usePinInstead => 'Usar PIN en su lugar';

  @override
  String get useBiometricInstead => 'Usar biometría';

  @override
  String get signInWithFaceId => 'Iniciar sesión con Face ID';

  @override
  String get signInWithFingerprint => 'Iniciar sesión con huella';

  @override
  String get signInWithBiometric => 'Iniciar sesión con biometría';

  @override
  String get signInWithPin => 'Iniciar sesión con PIN';

  @override
  String get setUpQuickUnlock => 'Configurar inicio rápido con PIN';

  @override
  String get setUpFaceIdOrPin => 'Configurar Face ID o PIN';

  @override
  String get setUpFingerprintOrPin => 'Configurar huella o PIN';

  @override
  String get setUpQuickUnlockSubtitle =>
      'Use biometría o PIN para esta organización';

  @override
  String quickUnlockAsUser(String email) {
    return 'Inicio rápido como $email';
  }

  @override
  String get orContinueWithPassword => 'o iniciar sesión con contraseña';

  @override
  String get setUpQuickUnlockAfterLoginTitle => '¿Activar inicio rápido?';

  @override
  String get setUpQuickUnlockAfterLoginMessage =>
      'Configure Face ID, huella o PIN para iniciar sesión más rápido la próxima vez. También puede cambiarlo después en Configuración.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get setUpNow => 'Configurar ahora';

  @override
  String get enableFaceIdTitle => '¿Activar Face ID?';

  @override
  String get enableFingerprintTitle => '¿Activar huella dactilar?';

  @override
  String get enableBiometricTitle => '¿Activar biometría?';

  @override
  String get enableBiometricAfterPinMessage =>
      'Use la biometría de su dispositivo junto con el PIN para iniciar sesión más rápido.';

  @override
  String get useFaceIdUnlock => 'Usar Face ID';

  @override
  String get useFingerprintUnlock => 'Usar huella dactilar';

  @override
  String get ok => 'OK';

  @override
  String get reportPeriodYear => 'Año';

  @override
  String get reportPeriodMonth => 'Mes';

  @override
  String get reportPeriodRange => 'Rango';

  @override
  String get reportPeriodDay => 'Día';

  @override
  String get reportPeriodFrom => 'Desde';

  @override
  String get reportPeriodTo => 'Hasta';

  @override
  String get reportPeriod => 'Período';

  @override
  String get reportAllPurchases => 'Todas las compras';

  @override
  String get reportBeforeTax => 'Antes de impuestos';

  @override
  String get reportRevenueRetained => 'Ingresos retenidos';

  @override
  String get reportHideDetails => 'Ocultar detalles';

  @override
  String get reportShowDetails => 'Mostrar detalles';

  @override
  String get reportSalesRevenue => 'Ingresos por ventas';

  @override
  String get reportDiscountsGiven => 'Descuentos otorgados';

  @override
  String get reportNetRevenue => 'Ingresos netos';

  @override
  String get reportOperatingExpenses => 'Gastos operativos';

  @override
  String get reportTotalExpenses => 'Gastos totales';

  @override
  String get reportGrossProfit => 'Beneficio bruto';

  @override
  String get reportGrossProfitChart => 'Beneficio bruto';

  @override
  String get reportOperatingPlDisclaimer =>
      'Impuestos, depreciación y nómina aún no contabilizados — aproximación operativa de P&G.';

  @override
  String get reportContraLabel => 'Contra';

  @override
  String get reportNoDataForPeriod =>
      'No hay datos para el período seleccionado';

  @override
  String get reportRevenueVsExpenses => 'Ingresos vs gastos';

  @override
  String get reportExpenseBreakdown => 'Desglose de gastos';

  @override
  String get reportExpenseFallback => 'Gasto';

  @override
  String get reportGrossMarginPercent => 'Margen bruto %';

  @override
  String get reportRoomVsFnB => 'Habitaciones vs F&B';

  @override
  String get reportSegmentRoom => 'Habitaciones';

  @override
  String get reportSegmentFnB => 'F&B';

  @override
  String get reportKeyMetrics => 'Métricas clave';

  @override
  String get reportIncomeStatement => 'Estado de resultados';

  @override
  String get reportChartsSection => 'Gráficos';

  @override
  String get reportSegmentSummary => 'Resumen por segmento';

  @override
  String get reportFailedToLoad => 'Error al cargar el informe';

  @override
  String get reportOverview => 'Resumen';

  @override
  String get reportOverviewCash => 'Efectivo';

  @override
  String get reportOverviewBank => 'Banco';

  @override
  String get reportMonthlyOpeningBalance => 'Saldo inicial mensual';

  @override
  String get reportOpeningBalanceHint =>
      'Posición de efectivo al inicio de cada mes';

  @override
  String get reportCashInOut => 'Entrada / salida de efectivo';

  @override
  String get reportCashIn => 'Entrada de efectivo';

  @override
  String get reportCashOut => 'Salida de efectivo';

  @override
  String get reportBankReceiptsPayments => 'Ingresos / pagos bancarios';

  @override
  String get reportReceipts => 'Ingresos';

  @override
  String get reportPayments => 'Pagos';

  @override
  String get reportDailyCashVsQr => 'Efectivo diario vs QR';

  @override
  String get reportSummariesSection => 'Resúmenes';

  @override
  String get reportCashSummary => 'Resumen de caja';

  @override
  String get reportBankSummary => 'Resumen bancario';

  @override
  String get reportDailySummary => 'Resumen diario';

  @override
  String get reportTabPurchase => 'Compras';

  @override
  String get reportTabSales => 'Ventas';

  @override
  String get reportTabDashboard => 'Panel';

  @override
  String get reportSingleDayTrend => 'Un solo día — tendencia diaria';

  @override
  String get reportFullYearTrend =>
      'Año completo — gráficos de tendencia mensual';

  @override
  String reportYearLabel(String year) {
    return 'Año $year';
  }

  @override
  String reportJanDec(String year) {
    return 'Ene – Dic $year';
  }

  @override
  String get reportTotalPurchases => 'Total de compras';

  @override
  String get reportTotalSales => 'Ventas totales';

  @override
  String get reportTotalInvoices => 'Total de facturas';

  @override
  String get reportUnpaidBalance => 'Saldo pendiente';

  @override
  String get reportAvgPerInvoice => 'Prom. por factura';

  @override
  String get reportPerTransaction => 'Por transacción';

  @override
  String reportMonthlySpend(String symbol) {
    return 'Gasto mensual ($symbol)';
  }

  @override
  String reportMonthlySalesChart(String symbol) {
    return 'Ventas mensuales ($symbol)';
  }

  @override
  String get reportInvoiceCountByMonth => 'Número de facturas por mes';

  @override
  String reportTopItemsBySpend(String symbol) {
    return 'Artículos principales por gasto ($symbol)';
  }

  @override
  String get reportSpendByCategory => 'Gasto por categoría';

  @override
  String get reportOtherCategory => 'Otros';

  @override
  String get reportSuppliers => 'Proveedores';

  @override
  String get reportTableSupplier => 'Proveedor';

  @override
  String get reportTableAmount => 'Importe';

  @override
  String get reportTableBills => 'Facturas';

  @override
  String get reportSalesTotal => 'Total de ventas';

  @override
  String get reportPurchaseTotal => 'Total de compras';

  @override
  String get reportPositiveMargin => 'Margen positivo';

  @override
  String get reportNegativeMargin => 'Margen negativo';

  @override
  String get reportGrossMargin => 'Margen bruto';

  @override
  String get reportOfTotalSales => 'Del total de ventas';

  @override
  String get reportFailedToLoadAnalytics => 'Error al cargar los análisis';

  @override
  String get reportMarginKpi => 'Margen';

  @override
  String get reportExpensesKpi => 'Gastos';

  @override
  String partyPickerNoResultsFor(String query) {
    return 'Sin resultados para \"$query\"';
  }

  @override
  String partyPickerNoPartiesForRole(String role) {
    return 'No se encontraron partes $role';
  }

  @override
  String get partyPickerLoadParties => 'Cargar partes';

  @override
  String get invoiceCashCustomer => 'Cliente en efectivo';

  @override
  String get invoiceQuickAddItemsTitle => 'Añadir artículos rápido';

  @override
  String get invoiceQuickLoadingMenu => 'Cargando menú…';

  @override
  String get invoiceQuickInvoiceCreated => 'Factura creada';

  @override
  String get invoiceQuickAddAtLeastOneItem => 'Añada al menos un artículo';

  @override
  String get invoiceQuickNoResults => '¡No se encontraron resultados!';

  @override
  String get invoiceQuickNoItemsInCategory =>
      'No hay artículos en esta categoría';

  @override
  String get invoiceQuickNoItemsInCategorySubtitle =>
      'Add your first item here to start billing from this category.';

  @override
  String get invoiceQuickNoResultsSubtitle =>
      'Check the spelling or try searching in a different category.';

  @override
  String get invoiceQuickAddItem => 'Añadir artículo';

  @override
  String get invoiceQuickLoadMore => 'Cargar más';

  @override
  String invoiceQuickScrollLoadMore(int count) {
    return 'Desplácese para cargar más ($count por página)';
  }

  @override
  String get invoiceQuickSupplierEmployee => 'Proveedor / Empleado';

  @override
  String get invoiceQuickEditItem => 'Editar artículo';

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
  String get closeSelectDateRange => 'Seleccionar rango de fechas';

  @override
  String get closeStartDate => 'Fecha de inicio';

  @override
  String get closeEndDate => 'Fecha de fin';

  @override
  String get closeSelectBothDates => 'Seleccione las fechas de inicio y fin';

  @override
  String get closeDeleteSummary => 'Eliminar resumen';

  @override
  String get closeDeleteSummaryConfirm =>
      '¿Seguro que desea eliminar este resumen?';

  @override
  String get closeSelectDate => 'Seleccionar fecha';

  @override
  String get closeNoDataToExport => 'No hay datos para exportar';

  @override
  String get closeNoDataToShare => 'No hay datos para compartir';

  @override
  String get closeNoDataToPrint => 'No hay datos para imprimir';

  @override
  String closePdfGenerateError(String error) {
    return 'Error al generar el PDF: $error';
  }

  @override
  String closePdfShareError(String error) {
    return 'Error al compartir el PDF: $error';
  }

  @override
  String closePdfPrintError(String error) {
    return 'Error al imprimir el PDF: $error';
  }

  @override
  String get closeExportPdf => 'Exportar como PDF';

  @override
  String get closeSharePdf => 'Compartir PDF';

  @override
  String get closePrint => 'Imprimir';

  @override
  String get closeExportOptions => 'Opciones de exportación';

  @override
  String get closeExportPdfSubtitle => 'Guardar o ver como documento PDF';

  @override
  String get closeSharePdfSubtitle => 'Compartir mediante apps o correo';

  @override
  String get closePrintSubtitle => 'Imprimir el informe';

  @override
  String get closeDailyCashSummaryTitle => 'Resumen de caja diario';

  @override
  String get closeDailyCashSummaryReport => 'Informe de resumen de caja diario';

  @override
  String closeGeneratedAt(String date) {
    return 'Generado: $date';
  }

  @override
  String get closeTotalRecords => 'Total de registros';

  @override
  String get closeSummaryOverview => 'Resumen general';

  @override
  String get closeAllRecords => 'Todos los registros';

  @override
  String closePeriodRange(String start, String end) {
    return 'Período: del $start al $end';
  }

  @override
  String get closeDetails => 'Detalles';

  @override
  String closePageN(int n) {
    return 'Página $n';
  }

  @override
  String invoiceQuickShowingItems(int shown, int total) {
    return 'Mostrando $shown de $total';
  }

  @override
  String invoiceQuickLoadedItems(int count) {
    return 'Cargados: $count';
  }

  @override
  String get invoiceQuickRoomCabinEmployee => 'Habitación / Cabina / Empleado';

  @override
  String reportPercentOfRevenue(String percent) {
    return '$percent % de ingresos';
  }

  @override
  String get reportParties => 'Partes';

  @override
  String reportMonthYearDailyTrend(String month, String year) {
    return '$month $year — gráficos de tendencia diaria';
  }

  @override
  String get invoiceQuickCart => 'Carrito';

  @override
  String invoiceQuickCartWithCount(int count) {
    return 'Carrito ($count)';
  }

  @override
  String get invoiceQuickClearSearch => 'Borrar búsqueda';

  @override
  String get organizationLogoHint => 'Tap to upload organization logo';

  @override
  String get employeeProfilePhotoHint => 'Tap to upload profile photo';

  @override
  String get closeAddSummary => 'Agregar resumen';

  @override
  String get closeSalesAmount => 'Monto de ventas';

  @override
  String get closeClosingBalance => 'Saldo de cierre';

  @override
  String get closeLostMoney => 'Dinero perdido';

  @override
  String get closeDiscount => 'Descuento';

  @override
  String get closeExpenses => 'Gastos';

  @override
  String get closeUnpaid => 'Sin pagar';

  @override
  String get closeTotalOpeningBalance => 'Saldo inicial total';

  @override
  String get closeTotalSalesAmount => 'Monto total de ventas';

  @override
  String get closeTotalCashAmount => 'Monto total en efectivo';

  @override
  String get closeTotalQrAmount => 'Monto total QR';

  @override
  String get closeTotalDiscount => 'Descuento total';

  @override
  String get closeTotalExpenses => 'Gastos totales';

  @override
  String get closeTotalClosingBalance => 'Saldo de cierre total';

  @override
  String get closeTotalLostMoney => 'Dinero perdido total';

  @override
  String get closeTotalExtraAmount => 'Monto extra total';

  @override
  String get closeShowingCurrentMonth => 'Mostrando datos del mes actual';

  @override
  String get closeNoSummariesFound => 'No se encontraron resúmenes';

  @override
  String get closeNoSummariesAvailable => 'No hay resúmenes disponibles';

  @override
  String get closeTryAdjustingDateRange => 'Intente ajustar el rango de fechas';

  @override
  String get closeCreateFirstSummary => 'Cree su primer resumen para comenzar';

  @override
  String get closeClearFilter => 'Borrar filtro';

  @override
  String get closeFiltered => 'Filtrado';

  @override
  String closeFilteredWithRange(String range) {
    return 'Filtrado: $range';
  }

  @override
  String get closeSummarySingular => 'Resumen';

  @override
  String get closeSummariesPlural => 'Resúmenes';

  @override
  String get closeSummaryUpdatedSuccess => 'Resumen actualizado correctamente';

  @override
  String get closeSummaryDeletedSuccess => 'Resumen eliminado correctamente';

  @override
  String premiumUnlockTitle(String appName) {
    return 'Desbloquear $appName Premium';
  }

  @override
  String get premiumTagline =>
      'TPV offline completo, facturación, inventario e informes — una suscripción para su negocio.';

  @override
  String get premiumFeatureUnlimitedInvoices => 'Facturas y recibos ilimitados';

  @override
  String get premiumFeatureInventoryStock => 'Inventario y control de stock';

  @override
  String get premiumFeatureReportsAnalytics => 'Informes de ventas y analítica';

  @override
  String get premiumFeatureOfflineLocal =>
      'Funciona sin conexión — sus datos permanecen locales';

  @override
  String premiumContinueWith(String plan) {
    return 'Continuar con $plan';
  }

  @override
  String get premiumRestorePurchases => 'Restaurar compras';

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
      'El pago se carga a su Apple ID. Las suscripciones se renuevan automáticamente salvo cancelación al menos 24 horas antes del fin del periodo.';

  @override
  String get premiumPurchaseRestored => 'Compra restaurada.';

  @override
  String get premiumNoActiveSubscription =>
      'No se encontró ninguna suscripción activa.';

  @override
  String get premiumPlanMonthly => 'Mensual';

  @override
  String get premiumPlanMonthlySubtitle => 'Flexible — cancele cuando quiera';

  @override
  String get premiumPlanYearly => 'Anual';

  @override
  String premiumPlanYearlySubtitle(int percent) {
    return 'Mejor valor — ahorre $percent%';
  }

  @override
  String get premiumPlanLifetime => 'De por vida';

  @override
  String get premiumPlanLifetimeSubtitle =>
      'Pague una vez, quédese para siempre';

  @override
  String get premiumPlanPopular => 'Popular';

  @override
  String get premiumOneTimePurchase => 'Compra única';

  @override
  String get subscriptionSectionTitle => 'Suscripción';

  @override
  String get subscriptionPremiumLabel => 'Premium';

  @override
  String get subscriptionUpgradeTitle => 'Actualizar a Premium';

  @override
  String subscriptionPremiumPricing(String monthly, String yearly) {
    return 'Mensual $monthly · Anual $yearly';
  }

  @override
  String subscriptionPremiumActiveUntil(String plan, String date) {
    return '$plan activo hasta $date';
  }

  @override
  String subscriptionPremiumActive(String plan) {
    return '$plan activo';
  }

  @override
  String get premiumRequired => 'Se requiere Premium';

  @override
  String get upgradeToPremiumContinue => 'Actualice a Premium para continuar.';

  @override
  String freemiumFreePlanLimit(int limit, String label) {
    return 'El plan gratuito permite hasta $limit $label. Actualice a Premium para acceso ilimitado.';
  }

  @override
  String get freemiumPartyRoleRequired => 'Se requiere el rol de parte.';

  @override
  String get freemiumLabelSalesInvoices => 'facturas de venta';

  @override
  String get freemiumLabelPurchaseInvoices => 'facturas de compra';

  @override
  String get freemiumLabelEmployees => 'empleados';

  @override
  String get freemiumLabelItems => 'artículos';

  @override
  String get freemiumLabelCategories => 'categorías';

  @override
  String get freemiumLabelPaymentMethods => 'métodos de pago';

  @override
  String get freemiumLabelCustomPartyRoles => 'roles de parte personalizados';

  @override
  String freemiumLabelPartiesForRole(String role) {
    return 'partes para $role';
  }

  @override
  String get freemiumLabelOrganizations => 'organizaciones';

  @override
  String get freemiumPremiumReports =>
      'Los informes están disponibles con Premium.';

  @override
  String get freemiumPremiumBackupSync =>
      'Copia de seguridad y sincronización requieren Premium.';

  @override
  String get freemiumPremiumPayroll => 'La nómina requiere Premium.';

  @override
  String get freemiumPremiumAttendance => 'La asistencia requiere Premium.';

  @override
  String get freemiumPremiumStock => 'La gestión de stock requiere Premium.';

  @override
  String get freemiumPremiumInvoiceExport =>
      'Descargar e imprimir requiere Premium.';

  @override
  String get shiftReminderOpeningTitle => 'Recordatorio de apertura';

  @override
  String get shiftReminderOpeningMessage => '¿Abrió la caja registradora hoy?';

  @override
  String get shiftReminderOpeningProceed => 'Sí, abrir ahora';

  @override
  String get shiftReminderClosingTitle => 'Recordatorio de cierre';

  @override
  String get shiftReminderClosingMessage => '¿Cerró la caja registradora hoy?';

  @override
  String get shiftReminderClosingProceed => 'Sí, cerrar ahora';

  @override
  String get shiftReminderSkipToday => 'Omitir por hoy';

  @override
  String get shiftReminderOpeningNotificationTitle =>
      'Recordatorio de apertura';

  @override
  String get shiftReminderOpeningNotificationBody =>
      '¿Abrió la caja registradora hoy? Toque aquí si aún necesita abrirla.';

  @override
  String get shiftReminderClosingNotificationTitle => 'Recordatorio de cierre';

  @override
  String get shiftReminderClosingNotificationBody =>
      '¿Cerró la caja registradora hoy? Toque aquí si aún necesita cerrarla.';

  @override
  String closeExchangePayQrGetCashHint(String business) {
    return '$business paga con QR al cliente; el cliente entrega efectivo.';
  }

  @override
  String closeExchangePayCashGetQrHint(String business) {
    return '$business paga efectivo al cliente; el cliente paga con QR.';
  }

  @override
  String get closePaymentExchange => 'Intercambio de pago';

  @override
  String get closePayQrGetCashExchangeLabel =>
      'Pagar QR → Recibir efectivo (intercambio)';

  @override
  String get closePayCashGetQrExchangeLabel =>
      'Pagar efectivo → Recibir QR (intercambio)';

  @override
  String get closePayQrGetCashDetail => 'Pagar QR, recibir efectivo';

  @override
  String get closePayCashGetQrDetail => 'Pagar efectivo, recibir QR';

  @override
  String get faqSectionPremium => 'Premium y facturación';

  @override
  String get faqPremiumWhatsIncludedQuestion => '¿Qué incluye Premium?';

  @override
  String get faqPremiumWhatsIncludedAnswer =>
      'Premium desbloquea facturas ilimitadas, informes completos (P&L, estado de cuenta, analítica), copia de seguridad y sincronización, nómina, asistencia, herramientas de stock, exportar/imprimir facturas y organizaciones adicionales. El nivel gratuito permite usar funciones POS básicas dentro de límites razonables.';

  @override
  String get faqPremiumFreeTierQuestion => '¿Qué incluye el nivel gratuito?';

  @override
  String get faqPremiumFreeTierAnswer =>
      'Puede crear hasta 10 facturas de venta y 10 de compra, 4 empleados, 30 artículos y otros límites que se muestran al alcanzarlos. Apertura, cierre, calculadora y consulta de datos siguen siendo gratis.';

  @override
  String get faqPremiumRestoreQuestion => '¿Cómo restauro mi compra?';

  @override
  String get faqPremiumRestoreAnswer =>
      'Abra Más → Actualizar a Premium (o la pantalla de pago) y toque Restaurar compras. Use el mismo Apple ID con el que se suscribió.';

  @override
  String get faqPremiumCancelQuestion => '¿Cómo cancelo mi suscripción?';

  @override
  String get faqPremiumCancelAnswer =>
      'Gestione o cancele en Ajustes del iPhone → Apple ID → Suscripciones. Conserva el acceso hasta el final del periodo pagado.';

  @override
  String get faqDarkModeQuestion => '¿Cómo activo el modo oscuro?';

  @override
  String get faqDarkModeAnswer =>
      'Abra Más → Apariencia y active Modo oscuro. Cuando su dispositivo usa el tema del sistema, la app lo sigue automáticamente.';

  @override
  String get faqOpeningClosingReminderQuestion =>
      '¿Qué son los recordatorios de apertura y cierre?';

  @override
  String faqOpeningClosingReminderAnswer(String appName) {
    return '$appName puede recordarle abrir o cerrar la caja diaria. Puede continuar, omitir por hoy o descartar el recordatorio.';
  }

  @override
  String get faqPartyRolesQuestion => '¿Qué son los roles de parte?';

  @override
  String get faqPartyRolesAnswer =>
      'Los roles de parte clasifican contactos como clientes, proveedores, habitaciones o empleados. Personalícelos en Operaciones → Roles de parte y añada una breve descripción para su equipo.';

  @override
  String faqRateAppQuestion(String appName) {
    return '¿Cómo califico $appName?';
  }

  @override
  String get faqRateAppAnswer =>
      'Abra Más → Califícanos para dejar una reseña en App Store. Sus comentarios nos ayudan a mejorar la facturación offline para su negocio.';
}
