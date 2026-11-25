import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('ne'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sw'),
    Locale('th'),
    Locale('tr'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get noInternetConnection;

  /// No description provided for @formatException.
  ///
  /// In en, this message translates to:
  /// **'Format exception'**
  String get formatException;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot login info?'**
  String get forgetPassword;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @hotel.
  ///
  /// In en, this message translates to:
  /// **'hotel'**
  String get hotel;

  /// No description provided for @errorEncountered.
  ///
  /// In en, this message translates to:
  /// **'Error encountered'**
  String get errorEncountered;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get requestFailed;

  /// No description provided for @connectionTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out'**
  String get connectionTimedOut;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @keepSignIn.
  ///
  /// In en, this message translates to:
  /// **'Keep sign in'**
  String get keepSignIn;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @enterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter valid password'**
  String get enterValidPassword;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please Wait ....'**
  String get pleaseWait;

  /// No description provided for @enterValidUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter valid user name.'**
  String get enterValidUserName;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @supportMessage.
  ///
  /// In en, this message translates to:
  /// **'Please contact admin.'**
  String get supportMessage;

  /// No description provided for @responseMessage404.
  ///
  /// In en, this message translates to:
  /// **'404 error'**
  String get responseMessage404;

  /// No description provided for @appDisplayName.
  ///
  /// In en, this message translates to:
  /// **'BizTrack'**
  String get appDisplayName;

  /// No description provided for @appVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersionLabel(String version);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteOrganizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete organization?'**
  String get deleteOrganizationTitle;

  /// No description provided for @deleteOrganizationMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from this device. All local data for this organization will be deleted.'**
  String deleteOrganizationMessage(String name);

  /// No description provided for @deleteOrganizationWarning.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get deleteOrganizationWarning;

  /// No description provided for @organizationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Organization removed'**
  String get organizationDeleted;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @walkthroughDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Your whole business, at a glance'**
  String get walkthroughDashboardTitle;

  /// No description provided for @walkthroughDashboardDescription.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sales, revenue and outstanding balances — all on one clean dashboard the moment you open the app.'**
  String get walkthroughDashboardDescription;

  /// No description provided for @walkthroughOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Works even without internet'**
  String get walkthroughOfflineTitle;

  /// No description provided for @walkthroughOfflineDescription.
  ///
  /// In en, this message translates to:
  /// **'Create invoices, log expenses and manage stock fully offline. Everything syncs automatically once you\'re back online.'**
  String get walkthroughOfflineDescription;

  /// No description provided for @walkthroughBillingTitle.
  ///
  /// In en, this message translates to:
  /// **'Bill and sell in seconds'**
  String get walkthroughBillingTitle;

  /// No description provided for @walkthroughBillingDescription.
  ///
  /// In en, this message translates to:
  /// **'Sales and purchase invoices, table orders with kitchen tickets, and live inventory — all from one app.'**
  String get walkthroughBillingDescription;

  /// No description provided for @walkthroughStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Staff, payroll & reports'**
  String get walkthroughStaffTitle;

  /// No description provided for @walkthroughStaffDescription.
  ///
  /// In en, this message translates to:
  /// **'Run attendance and payroll, then export P&L statements and payslips as PDF — no extra tools needed.'**
  String get walkthroughStaffDescription;

  /// No description provided for @walkthroughBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Your data, always safe'**
  String get walkthroughBackupTitle;

  /// No description provided for @walkthroughBackupDescription.
  ///
  /// In en, this message translates to:
  /// **'Bank-grade security with one-tap Google Drive backups, so your records are protected and easy to restore.'**
  String get walkthroughBackupDescription;

  /// No description provided for @walkthroughReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready when you are'**
  String get walkthroughReadyTitle;

  /// No description provided for @walkthroughReadyDescription.
  ///
  /// In en, this message translates to:
  /// **'Set up your organization in minutes and start running your business smarter today. Let\'s get you started.'**
  String get walkthroughReadyDescription;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @createAction.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createAction;

  /// No description provided for @connectOrganizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect your Organization'**
  String get connectOrganizationTitle;

  /// No description provided for @connectOrganizationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select an organization to sign in.'**
  String get connectOrganizationSubtitle;

  /// No description provided for @selectOrganization.
  ///
  /// In en, this message translates to:
  /// **'Organizations'**
  String get selectOrganization;

  /// No description provided for @selectOrganizationHint.
  ///
  /// In en, this message translates to:
  /// **'Tap an organization to continue'**
  String get selectOrganizationHint;

  /// No description provided for @noSavedOrganizationsYet.
  ///
  /// In en, this message translates to:
  /// **'No organizations yet. Create one or use test data below.'**
  String get noSavedOrganizationsYet;

  /// No description provided for @orgConnectOnceInfo.
  ///
  /// In en, this message translates to:
  /// **'This links the app to your business account. You only need to set it once per device.'**
  String get orgConnectOnceInfo;

  /// No description provided for @organizationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Code: {code}'**
  String organizationCodeLabel(String code);

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'WARNING'**
  String get warning;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportAsPdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get exportAsPdf;

  /// No description provided for @sharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdf;

  /// No description provided for @partyExportPdfTooltip.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get partyExportPdfTooltip;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @grandTotal.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get grandTotal;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @party.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get party;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @settlement.
  ///
  /// In en, this message translates to:
  /// **'Settlement'**
  String get settlement;

  /// No description provided for @opening.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get opening;

  /// No description provided for @closing.
  ///
  /// In en, this message translates to:
  /// **'Closing'**
  String get closing;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock reconciliation'**
  String get stock;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @loss.
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get loss;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @operations.
  ///
  /// In en, this message translates to:
  /// **'Operations'**
  String get operations;

  /// No description provided for @operationManagement.
  ///
  /// In en, this message translates to:
  /// **'Operation management'**
  String get operationManagement;

  /// No description provided for @operationManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Items, stock reconciliation, contacts, categories, and closing'**
  String get operationManagementSubtitle;

  /// No description provided for @employeeManagement.
  ///
  /// In en, this message translates to:
  /// **'Employee management'**
  String get employeeManagement;

  /// No description provided for @employeeManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Staff, payroll, and attendance'**
  String get employeeManagementSubtitle;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @reportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Profit & loss, statements, and analytics'**
  String get reportSubtitle;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @dataAndBackup.
  ///
  /// In en, this message translates to:
  /// **'Data & Backup'**
  String get dataAndBackup;

  /// No description provided for @privacyAndPolicies.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Policies'**
  String get privacyAndPolicies;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate us'**
  String get rateUs;

  /// No description provided for @rateUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoying BizTrack? Leave a review on Google Play'**
  String get rateUsSubtitle;

  /// No description provided for @rateUsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not open the store. Try again later.'**
  String get rateUsUnavailable;

  /// No description provided for @reportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get reportProblem;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @contactUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue below. You can attach photos or videos, then send directly to our support email.'**
  String get contactUsSubtitle;

  /// No description provided for @contactUsMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Your message'**
  String get contactUsMessageLabel;

  /// No description provided for @contactUsMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue, question, or feedback…'**
  String get contactUsMessageHint;

  /// No description provided for @contactUsMessageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please describe your issue'**
  String get contactUsMessageRequired;

  /// No description provided for @contactUsAttachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments (optional)'**
  String get contactUsAttachments;

  /// No description provided for @contactUsAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photos'**
  String get contactUsAddPhoto;

  /// No description provided for @contactUsAddPhotoLimit.
  ///
  /// In en, this message translates to:
  /// **'You can attach up to {count} photos'**
  String contactUsAddPhotoLimit(int count);

  /// No description provided for @contactUsVideoLimit.
  ///
  /// In en, this message translates to:
  /// **'Only 1 video is allowed'**
  String get contactUsVideoLimit;

  /// No description provided for @contactUsAddVideo.
  ///
  /// In en, this message translates to:
  /// **'Add video'**
  String get contactUsAddVideo;

  /// No description provided for @contactUsSendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get contactUsSendEmail;

  /// No description provided for @contactUsNoEmailApp.
  ///
  /// In en, this message translates to:
  /// **'No email app found on this device. Support email copied to clipboard.'**
  String get contactUsNoEmailApp;

  /// No description provided for @contactUsEmailFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open email: {error}'**
  String contactUsEmailFailed(String error);

  /// No description provided for @contactUsAttachmentTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Attachment is too large (max {maxMb} MB)'**
  String contactUsAttachmentTooLarge(int maxMb);

  /// No description provided for @couldNotPickVideo.
  ///
  /// In en, this message translates to:
  /// **'Could not pick video: {error}'**
  String couldNotPickVideo(String error);

  /// No description provided for @developerLabel.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developerLabel;

  /// No description provided for @emailCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Email copied to clipboard'**
  String get emailCopiedToClipboard;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @testData.
  ///
  /// In en, this message translates to:
  /// **'Test Data'**
  String get testData;

  /// No description provided for @loginWithTestData.
  ///
  /// In en, this message translates to:
  /// **'Login with test data'**
  String get loginWithTestData;

  /// No description provided for @loginWithTestDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Load demo hotel data and sign in automatically'**
  String get loginWithTestDataSubtitle;

  /// No description provided for @testDataLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load test data: {error}'**
  String testDataLoginFailed(String error);

  /// No description provided for @preparingTestData.
  ///
  /// In en, this message translates to:
  /// **'Preparing demo data…'**
  String get preparingTestData;

  /// No description provided for @regionAndCurrency.
  ///
  /// In en, this message translates to:
  /// **'Region & currency'**
  String get regionAndCurrency;

  /// No description provided for @reportingCurrency.
  ///
  /// In en, this message translates to:
  /// **'Reporting currency'**
  String get reportingCurrency;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select currency'**
  String get selectCurrency;

  /// No description provided for @currencySample.
  ///
  /// In en, this message translates to:
  /// **'{code} · {symbol} · sample {sample}'**
  String currencySample(String code, String symbol, String sample);

  /// No description provided for @currencyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Currency set to {code} ({symbol})'**
  String currencyUpdated(String code, String symbol);

  /// No description provided for @currencyUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update currency: {error}'**
  String currencyUpdateFailed(String error);

  /// No description provided for @setupAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup {appName}'**
  String setupAppTitle(String appName);

  /// No description provided for @setupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure your organization and accounting — stored on this device for offline use.'**
  String get setupSubtitle;

  /// No description provided for @setupOrganizationName.
  ///
  /// In en, this message translates to:
  /// **'Organization name'**
  String get setupOrganizationName;

  /// No description provided for @setupCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get setupCompanyName;

  /// No description provided for @setupBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Business type'**
  String get setupBusinessType;

  /// No description provided for @selectBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Select business type'**
  String get selectBusinessType;

  /// No description provided for @businessTypeHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get businessTypeHotel;

  /// No description provided for @businessTypeHotelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rooms, guests & front desk'**
  String get businessTypeHotelSubtitle;

  /// No description provided for @businessTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get businessTypeRestaurant;

  /// No description provided for @businessTypeRestaurantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dine-in, kitchen & table orders'**
  String get businessTypeRestaurantSubtitle;

  /// No description provided for @businessTypeHotelRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Hotel & Restaurant'**
  String get businessTypeHotelRestaurant;

  /// No description provided for @businessTypeHotelRestaurantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hotel rooms and restaurant together'**
  String get businessTypeHotelRestaurantSubtitle;

  /// No description provided for @businessTypeRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail / Shop'**
  String get businessTypeRetail;

  /// No description provided for @businessTypeRetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Products, stock & checkout'**
  String get businessTypeRetailSubtitle;

  /// No description provided for @businessTypeCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe / Bakery'**
  String get businessTypeCafe;

  /// No description provided for @businessTypeCafeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Coffee, pastries & light bites'**
  String get businessTypeCafeSubtitle;

  /// No description provided for @businessTypeBar.
  ///
  /// In en, this message translates to:
  /// **'Bar / Pub'**
  String get businessTypeBar;

  /// No description provided for @businessTypeBarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Drinks menu, tabs & bar sales'**
  String get businessTypeBarSubtitle;

  /// No description provided for @businessTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get businessTypeOther;

  /// No description provided for @businessTypeOtherSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Custom setup for any business'**
  String get businessTypeOtherSubtitle;

  /// No description provided for @organizationBusinessTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String organizationBusinessTypeLabel(String type);

  /// No description provided for @organizationSettings.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organizationSettings;

  /// No description provided for @editOrganizationInfo.
  ///
  /// In en, this message translates to:
  /// **'Organization info'**
  String get editOrganizationInfo;

  /// No description provided for @editOrganizationInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update how this business appears in the app. The organization code cannot be changed.'**
  String get editOrganizationInfoSubtitle;

  /// No description provided for @organizationCode.
  ///
  /// In en, this message translates to:
  /// **'Organization code'**
  String get organizationCode;

  /// No description provided for @organizationCodeReadOnly.
  ///
  /// In en, this message translates to:
  /// **'This code is fixed after setup.'**
  String get organizationCodeReadOnly;

  /// No description provided for @businessTypeReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Business type is set during setup and cannot be changed.'**
  String get businessTypeReadOnly;

  /// No description provided for @organizationInfoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Organization info saved'**
  String get organizationInfoUpdated;

  /// No description provided for @organizationInfoLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load organization info'**
  String get organizationInfoLoadFailed;

  /// No description provided for @organizationInfoSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save organization info: {error}'**
  String organizationInfoSaveFailed(String error);

  /// No description provided for @organizationTabGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get organizationTabGeneral;

  /// No description provided for @organizationTabRegional.
  ///
  /// In en, this message translates to:
  /// **'Regional & fiscal'**
  String get organizationTabRegional;

  /// No description provided for @organizationRegionalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Country, reporting currency, and fiscal year dates.'**
  String get organizationRegionalSubtitle;

  /// No description provided for @organizationTabAccounting.
  ///
  /// In en, this message translates to:
  /// **'Accounting'**
  String get organizationTabAccounting;

  /// No description provided for @organizationAccountingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice and amount display settings.'**
  String get organizationAccountingSubtitle;

  /// No description provided for @defaultTaxRate.
  ///
  /// In en, this message translates to:
  /// **'Default tax rate'**
  String get defaultTaxRate;

  /// No description provided for @taxIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax ID label'**
  String get taxIdLabel;

  /// No description provided for @taxIdNumberOptional.
  ///
  /// In en, this message translates to:
  /// **'{label} number (optional)'**
  String taxIdNumberOptional(String label);

  /// No description provided for @taxIdNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. {example}'**
  String taxIdNumberHint(String example);

  /// No description provided for @taxMode.
  ///
  /// In en, this message translates to:
  /// **'Tax calculation'**
  String get taxMode;

  /// No description provided for @taxModeExclusive.
  ///
  /// In en, this message translates to:
  /// **'Exclusive'**
  String get taxModeExclusive;

  /// No description provided for @taxModeInclusive.
  ///
  /// In en, this message translates to:
  /// **'Inclusive'**
  String get taxModeInclusive;

  /// No description provided for @taxRateRange.
  ///
  /// In en, this message translates to:
  /// **'Enter a rate between 0 and 100'**
  String get taxRateRange;

  /// No description provided for @applyTaxOnInvoice.
  ///
  /// In en, this message translates to:
  /// **'Apply tax'**
  String get applyTaxOnInvoice;

  /// No description provided for @applyTaxOnInvoiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add {rate} tax to this invoice'**
  String applyTaxOnInvoiceSubtitle(String rate);

  /// No description provided for @taxAmountLine.
  ///
  /// In en, this message translates to:
  /// **'Tax ({rate})'**
  String taxAmountLine(String rate);

  /// No description provided for @taxIdLabelPickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Business tax ID labels by country'**
  String get taxIdLabelPickerSubtitle;

  /// No description provided for @searchCountryOrLabel.
  ///
  /// In en, this message translates to:
  /// **'Search country or label'**
  String get searchCountryOrLabel;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get noSearchResults;

  /// No description provided for @displayPrecision.
  ///
  /// In en, this message translates to:
  /// **'Display precision'**
  String get displayPrecision;

  /// No description provided for @displayPrecisionRange.
  ///
  /// In en, this message translates to:
  /// **'Enter a number from 0 to 5'**
  String get displayPrecisionRange;

  /// No description provided for @enableInvoiceReturns.
  ///
  /// In en, this message translates to:
  /// **'Enable invoice returns'**
  String get enableInvoiceReturns;

  /// No description provided for @enableInvoiceReturnsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow creating returns from paid invoices.'**
  String get enableInvoiceReturnsSubtitle;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @setupFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get setupFullName;

  /// No description provided for @setupConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get setupConfirmPassword;

  /// No description provided for @setupBankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get setupBankName;

  /// No description provided for @banksSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Banks'**
  String get banksSettingsTitle;

  /// No description provided for @banksSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add banks and view bank reports'**
  String get banksSettingsSubtitle;

  /// No description provided for @banksSettingsSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected: {name}'**
  String banksSettingsSelected(String name);

  /// No description provided for @banksAddTitle.
  ///
  /// In en, this message translates to:
  /// **'New bank'**
  String get banksAddTitle;

  /// No description provided for @banksEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit bank'**
  String get banksEditTitle;

  /// No description provided for @banksAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get banksAccountNumber;

  /// No description provided for @banksAccountHolder.
  ///
  /// In en, this message translates to:
  /// **'Account holder'**
  String get banksAccountHolder;

  /// No description provided for @banksOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get banksOptional;

  /// No description provided for @banksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No banks yet. Add the bank you use for payments.'**
  String get banksEmpty;

  /// No description provided for @banksSaved.
  ///
  /// In en, this message translates to:
  /// **'Bank saved'**
  String get banksSaved;

  /// No description provided for @banksDeleted.
  ///
  /// In en, this message translates to:
  /// **'Bank deleted'**
  String get banksDeleted;

  /// No description provided for @banksSelected.
  ///
  /// In en, this message translates to:
  /// **'{name} is now the selected bank'**
  String banksSelected(String name);

  /// No description provided for @banksSelectedBadge.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get banksSelectedBadge;

  /// No description provided for @banksUseSelected.
  ///
  /// In en, this message translates to:
  /// **'Use as selected bank'**
  String get banksUseSelected;

  /// No description provided for @banksViewReport.
  ///
  /// In en, this message translates to:
  /// **'View report'**
  String get banksViewReport;

  /// No description provided for @banksReportIn.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get banksReportIn;

  /// No description provided for @banksReportOut.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get banksReportOut;

  /// No description provided for @banksReportNet.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get banksReportNet;

  /// No description provided for @banksReportActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get banksReportActivity;

  /// No description provided for @banksReportEmpty.
  ///
  /// In en, this message translates to:
  /// **'No payments for this bank yet'**
  String get banksReportEmpty;

  /// No description provided for @banksAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one bank'**
  String get banksAtLeastOne;

  /// No description provided for @banksLinkedAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank account'**
  String get banksLinkedAccount;

  /// No description provided for @banksPickBank.
  ///
  /// In en, this message translates to:
  /// **'Select bank'**
  String get banksPickBank;

  /// No description provided for @banksNoBanksYet.
  ///
  /// In en, this message translates to:
  /// **'Add a bank in Settings first'**
  String get banksNoBanksYet;

  /// No description provided for @setupRegionStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Region & currency'**
  String get setupRegionStepTitle;

  /// No description provided for @setupOrganizationStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get setupOrganizationStepTitle;

  /// No description provided for @setupOrganizationStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How your business appears in the app'**
  String get setupOrganizationStepSubtitle;

  /// No description provided for @setupAdminStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin account'**
  String get setupAdminStepTitle;

  /// No description provided for @setupAdminStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Primary user for this installation'**
  String get setupAdminStepSubtitle;

  /// No description provided for @setupAccountingStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounting'**
  String get setupAccountingStepTitle;

  /// No description provided for @setupAccountingStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bank, chart of accounts, and fiscal year'**
  String get setupAccountingStepSubtitle;

  /// No description provided for @setupCompleteSetup.
  ///
  /// In en, this message translates to:
  /// **'Complete setup'**
  String get setupCompleteSetup;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'{field} is required'**
  String fieldRequired(String field);

  /// No description provided for @fieldMaxLength.
  ///
  /// In en, this message translates to:
  /// **'{field} must be at most {max} characters'**
  String fieldMaxLength(String field, int max);

  /// No description provided for @invalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmailAddress;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {min} characters'**
  String passwordMinLength(int min);

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @setupFixValidationErrors.
  ///
  /// In en, this message translates to:
  /// **'Please fix the errors below to continue'**
  String get setupFixValidationErrors;

  /// No description provided for @setupCompleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Setup completed successfully'**
  String get setupCompleteSuccess;

  /// No description provided for @setupCompleteWithPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'Setup complete. Login credentials PDF saved to Downloads.'**
  String get setupCompleteWithPdfSuccess;

  /// No description provided for @setupPdfFailed.
  ///
  /// In en, this message translates to:
  /// **'Setup finished, but the PDF could not be saved: {error}'**
  String setupPdfFailed(String error);

  /// No description provided for @setupFailed.
  ///
  /// In en, this message translates to:
  /// **'Setup could not be completed. Please try again.'**
  String get setupFailed;

  /// No description provided for @setupFailedWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Setup failed: {error}'**
  String setupFailedWithDetails(String error);

  /// No description provided for @regionAndCurrencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Locale and reporting currency.'**
  String get regionAndCurrencySubtitle;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get selectCountry;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @languageChangeLaterHint.
  ///
  /// In en, this message translates to:
  /// **'You can change it later from settings'**
  String get languageChangeLaterHint;

  /// No description provided for @languageSelectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you\'d like to use {appName}. You can change this later in Settings.'**
  String languageSelectionSubtitle(String appName);

  /// No description provided for @searchLanguages.
  ///
  /// In en, this message translates to:
  /// **'Search languages'**
  String get searchLanguages;

  /// No description provided for @languageSuggestedBadge.
  ///
  /// In en, this message translates to:
  /// **'SUGGESTED'**
  String get languageSuggestedBadge;

  /// No description provided for @continueInLanguage.
  ///
  /// In en, this message translates to:
  /// **'Continue in {languageName}'**
  String continueInLanguage(String languageName);

  /// No description provided for @noLanguageMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get noLanguageMatches;

  /// No description provided for @noLanguageMatchesForQuery.
  ///
  /// In en, this message translates to:
  /// **'No language matches \"{query}\"'**
  String noLanguageMatchesForQuery(String query);

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a dark background across the app'**
  String get darkModeSubtitle;

  /// No description provided for @darkModeSystemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Follows your device theme'**
  String get darkModeSystemSubtitle;

  /// No description provided for @languageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Language set to {name}'**
  String languageUpdated(String name);

  /// No description provided for @languageUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update language: {error}'**
  String languageUpdateFailed(String error);

  /// No description provided for @welcomeToApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {appName}'**
  String welcomeToApp(String appName);

  /// No description provided for @forceUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'Please install the latest version of {appName} to continue.'**
  String forceUpdateMessage(String appName);

  /// No description provided for @generatedByApp.
  ///
  /// In en, this message translates to:
  /// **'Generated by {appName}'**
  String generatedByApp(String appName);

  /// No description provided for @whatIsApp.
  ///
  /// In en, this message translates to:
  /// **'What is {appName}?'**
  String whatIsApp(String appName);

  /// No description provided for @appDescriptionFaq.
  ///
  /// In en, this message translates to:
  /// **'{appName} helps you manage sales and purchase invoices, parties (customers and suppliers), stock, payments, employees, and daily summaries — from your phone or tablet.'**
  String appDescriptionFaq(String appName);

  /// No description provided for @faqIntro.
  ///
  /// In en, this message translates to:
  /// **'Answers to common questions about {appName}.'**
  String faqIntro(String appName);

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @photoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Photo library'**
  String get photoLibrary;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get addPhoto;

  /// No description provided for @couldNotPickImage.
  ///
  /// In en, this message translates to:
  /// **'Could not pick image: {error}'**
  String couldNotPickImage(String error);

  /// No description provided for @unpaidAmount.
  ///
  /// In en, this message translates to:
  /// **'Unpaid amount'**
  String get unpaidAmount;

  /// No description provided for @unpaidBalance.
  ///
  /// In en, this message translates to:
  /// **'Unpaid balance'**
  String get unpaidBalance;

  /// No description provided for @unpaidColonAmount.
  ///
  /// In en, this message translates to:
  /// **'Unpaid: {amount}'**
  String unpaidColonAmount(String amount);

  /// No description provided for @previousUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Previous unpaid'**
  String get previousUnpaid;

  /// No description provided for @partyUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Party unpaid'**
  String get partyUnpaid;

  /// No description provided for @loadingUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Loading unpaid…'**
  String get loadingUnpaid;

  /// No description provided for @totalUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Total unpaid'**
  String get totalUnpaid;

  /// No description provided for @unpaidAmountNotYetCollected.
  ///
  /// In en, this message translates to:
  /// **'Unpaid amount not yet collected.'**
  String get unpaidAmountNotYetCollected;

  /// No description provided for @partyUnpaidTabHint.
  ///
  /// In en, this message translates to:
  /// **'Open Employees, select a person, then tap Party unpaid on their profile. The server needs an employee id for this search.'**
  String get partyUnpaidTabHint;

  /// No description provided for @partySettlementUsesUnpaidTotal.
  ///
  /// In en, this message translates to:
  /// **'Party settlement uses the unpaid total.'**
  String get partySettlementUsesUnpaidTotal;

  /// No description provided for @selectPartyWithUnpaidFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter a settlement amount first (or select a party with unpaid).'**
  String get selectPartyWithUnpaidFirst;

  /// No description provided for @workspace.
  ///
  /// In en, this message translates to:
  /// **'Workspace'**
  String get workspace;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @addMoreOrganization.
  ///
  /// In en, this message translates to:
  /// **'Add more +'**
  String get addMoreOrganization;

  /// No description provided for @connectAnotherOrganization.
  ///
  /// In en, this message translates to:
  /// **'Connect another organization'**
  String get connectAnotherOrganization;

  /// No description provided for @noSavedOrganizationsUseAddMore.
  ///
  /// In en, this message translates to:
  /// **'No saved organizations yet. Use Add more + to connect one.'**
  String get noSavedOrganizationsUseAddMore;

  /// No description provided for @registerNewOrganizationTitleSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Register a new organization?'**
  String get registerNewOrganizationTitleSignedIn;

  /// No description provided for @registerNewOrganizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Register new organization?'**
  String get registerNewOrganizationTitle;

  /// No description provided for @registerNewOrganizationMessageSignedIn.
  ///
  /// In en, this message translates to:
  /// **'You will be signed out and the setup wizard will start from the beginning so you can register a new business on this device.\n\nOrganizations you already saved stay in the list after setup.'**
  String get registerNewOrganizationMessageSignedIn;

  /// No description provided for @registerNewOrganizationMessageLogin.
  ///
  /// In en, this message translates to:
  /// **'The setup wizard will start so you can register a new business on this device. Finish setup to create it; your saved organizations stay in the list.'**
  String get registerNewOrganizationMessageLogin;

  /// No description provided for @startSetup.
  ///
  /// In en, this message translates to:
  /// **'Start setup'**
  String get startSetup;

  /// No description provided for @enterOrganizationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter your organization code'**
  String get enterOrganizationCode;

  /// No description provided for @organizationNotFoundCheckCode.
  ///
  /// In en, this message translates to:
  /// **'Organization not found. Check the code and try again.'**
  String get organizationNotFoundCheckCode;

  /// No description provided for @organizationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Organization not found'**
  String get organizationNotFound;

  /// No description provided for @couldNotVerifyOrganization.
  ///
  /// In en, this message translates to:
  /// **'Could not verify organization'**
  String get couldNotVerifyOrganization;

  /// No description provided for @noLocalDataCompleteSetup.
  ///
  /// In en, this message translates to:
  /// **'No local data for {name}. Complete setup for this organization first.'**
  String noLocalDataCompleteSetup(String name);

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enterEmail;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @enterEmailLocalPartOnly.
  ///
  /// In en, this message translates to:
  /// **'Enter only the part before @'**
  String get enterEmailLocalPartOnly;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get logIn;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// No description provided for @searchCodeOrSymbol.
  ///
  /// In en, this message translates to:
  /// **'Search code or symbol'**
  String get searchCodeOrSymbol;

  /// No description provided for @saveLoginDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Save your login details?'**
  String get saveLoginDetailsTitle;

  /// No description provided for @saveLoginDetailsMessage.
  ///
  /// In en, this message translates to:
  /// **'You are about to complete setup for this organization.\n\nWould you like to safely download a PDF with your organization code, organization name, login email, and password? Store it in a secure place — anyone with this file can sign in.'**
  String get saveLoginDetailsMessage;

  /// No description provided for @downloadPdfAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Download PDF & continue'**
  String get downloadPdfAndContinue;

  /// No description provided for @continueWithoutPdf.
  ///
  /// In en, this message translates to:
  /// **'Continue without PDF'**
  String get continueWithoutPdf;

  /// No description provided for @legalDisplayNameHint.
  ///
  /// In en, this message translates to:
  /// **'Legal / display name'**
  String get legalDisplayNameHint;

  /// No description provided for @chartOfAccounts.
  ///
  /// In en, this message translates to:
  /// **'Chart of accounts'**
  String get chartOfAccounts;

  /// No description provided for @fiscalYearStart.
  ///
  /// In en, this message translates to:
  /// **'Fiscal year start'**
  String get fiscalYearStart;

  /// No description provided for @fiscalYearEnd.
  ///
  /// In en, this message translates to:
  /// **'Fiscal year end'**
  String get fiscalYearEnd;

  /// No description provided for @removeTestDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove test data?'**
  String get removeTestDataTitle;

  /// No description provided for @removeTestDataMessageDemoOrg.
  ///
  /// In en, this message translates to:
  /// **'All demo sales, purchases, contacts, parties, inventory items, staff, and liquor calculator products will be removed.\n\nYou are on a demo organization — after this you will be switched back to your first organization automatically.'**
  String get removeTestDataMessageDemoOrg;

  /// No description provided for @removeTestDataMessageNormal.
  ///
  /// In en, this message translates to:
  /// **'All demo sales, purchases, contacts, parties, inventory items, and staff will be removed. Your admin account and real setup data stay intact.'**
  String get removeTestDataMessageNormal;

  /// No description provided for @removeTestDataWarning.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone except by loading test data again.'**
  String get removeTestDataWarning;

  /// No description provided for @removeTestData.
  ///
  /// In en, this message translates to:
  /// **'Remove test data'**
  String get removeTestData;

  /// No description provided for @keepTestData.
  ///
  /// In en, this message translates to:
  /// **'Keep test data'**
  String get keepTestData;

  /// No description provided for @demoDataRemoved.
  ///
  /// In en, this message translates to:
  /// **'Demo data removed'**
  String get demoDataRemoved;

  /// No description provided for @testDataRemovedSwitchedTo.
  ///
  /// In en, this message translates to:
  /// **'Test data removed. Switched to {name}.'**
  String testDataRemovedSwitchedTo(String name);

  /// No description provided for @testDataRemoved.
  ///
  /// In en, this message translates to:
  /// **'Test data removed'**
  String get testDataRemoved;

  /// No description provided for @couldNotRemoveTestData.
  ///
  /// In en, this message translates to:
  /// **'Could not remove test data: {error}'**
  String couldNotRemoveTestData(String error);

  /// No description provided for @loadTestDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Load test data?'**
  String get loadTestDataTitle;

  /// No description provided for @loadTestDataMessage.
  ///
  /// In en, this message translates to:
  /// **'This will add up to 50 demo contacts, 50 sales-only and 50 purchase-only inventory items, plus sample sales, purchases, payments, stock, closing summaries, staff, payroll, attendance for the last 15 days, and sample liquor products for the calculator.'**
  String get loadTestDataMessage;

  /// No description provided for @loadTestData.
  ///
  /// In en, this message translates to:
  /// **'Load test data'**
  String get loadTestData;

  /// No description provided for @testDataLoaded.
  ///
  /// In en, this message translates to:
  /// **'Test data loaded'**
  String get testDataLoaded;

  /// No description provided for @couldNotLoadTestData.
  ///
  /// In en, this message translates to:
  /// **'Could not load test data: {error}'**
  String couldNotLoadTestData(String error);

  /// No description provided for @demoTestData.
  ///
  /// In en, this message translates to:
  /// **'Demo test data'**
  String get demoTestData;

  /// No description provided for @importTestDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import test data for all features'**
  String get importTestDataSubtitle;

  /// No description provided for @hideTestDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Hide test data for this organization?'**
  String get hideTestDataTitle;

  /// No description provided for @hideTestDataMessage.
  ///
  /// In en, this message translates to:
  /// **'If you continue, the Test Data section will be hidden everywhere in this organization (including setup). You can turn it back on only by reinstalling or clearing app data for this org.'**
  String get hideTestDataMessage;

  /// No description provided for @hideTestDataWarning.
  ///
  /// In en, this message translates to:
  /// **'Demo data already loaded will stay in the database until you remove it from settings.'**
  String get hideTestDataWarning;

  /// No description provided for @okHideTestData.
  ///
  /// In en, this message translates to:
  /// **'OK, hide test data'**
  String get okHideTestData;

  /// No description provided for @testDataHiddenForOrg.
  ///
  /// In en, this message translates to:
  /// **'Test Data hidden for this organization'**
  String get testDataHiddenForOrg;

  /// No description provided for @hideTestDataTooltip.
  ///
  /// In en, this message translates to:
  /// **'Hide test data for this organization'**
  String get hideTestDataTooltip;

  /// No description provided for @partyRolesTitle.
  ///
  /// In en, this message translates to:
  /// **'Party roles'**
  String get partyRolesTitle;

  /// No description provided for @partyRolesMoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customer, supplier, both & more'**
  String get partyRolesMoreSubtitle;

  /// No description provided for @exploreCustomizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Customize features'**
  String get exploreCustomizeTitle;

  /// No description provided for @exploreCustomizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show or hide shortcuts on your home screen. Only features your organization can access are listed.'**
  String get exploreCustomizeSubtitle;

  /// No description provided for @exploreVisibleOnDashboard.
  ///
  /// In en, this message translates to:
  /// **'Visible on dashboard'**
  String get exploreVisibleOnDashboard;

  /// No description provided for @exploreHiddenOnDashboard.
  ///
  /// In en, this message translates to:
  /// **'Hidden on dashboard'**
  String get exploreHiddenOnDashboard;

  /// No description provided for @partiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get partiesTitle;

  /// No description provided for @partySearchByName.
  ///
  /// In en, this message translates to:
  /// **'Search by name…'**
  String get partySearchByName;

  /// No description provided for @partySortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By:'**
  String get partySortBy;

  /// No description provided for @partySortLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get partySortLatest;

  /// No description provided for @partySortAmountHighLow.
  ///
  /// In en, this message translates to:
  /// **'Amount: High to Low'**
  String get partySortAmountHighLow;

  /// No description provided for @partySortAmountLowHigh.
  ///
  /// In en, this message translates to:
  /// **'Amount: Low to High'**
  String get partySortAmountLowHigh;

  /// No description provided for @partySortNameAZ.
  ///
  /// In en, this message translates to:
  /// **'Name: A to Z'**
  String get partySortNameAZ;

  /// No description provided for @partySortNameZA.
  ///
  /// In en, this message translates to:
  /// **'Name: Z to A'**
  String get partySortNameZA;

  /// No description provided for @partyAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add New Party'**
  String get partyAddNew;

  /// No description provided for @partyEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Party'**
  String get partyEdit;

  /// No description provided for @partyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Party'**
  String get partyUpdate;

  /// No description provided for @partyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Party Name*'**
  String get partyNameLabel;

  /// No description provided for @partyNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter party name'**
  String get partyNameHint;

  /// No description provided for @partyNewNameLabel.
  ///
  /// In en, this message translates to:
  /// **'New Party Name*'**
  String get partyNewNameLabel;

  /// No description provided for @partyNewNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new party name'**
  String get partyNewNameHint;

  /// No description provided for @partyRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Party Role *'**
  String get partyRoleLabel;

  /// No description provided for @partyTapToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap to select'**
  String get partyTapToSelect;

  /// No description provided for @partySelectRoleValidation.
  ///
  /// In en, this message translates to:
  /// **'Please select role'**
  String get partySelectRoleValidation;

  /// No description provided for @partyEnterNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter party name'**
  String get partyEnterNameValidation;

  /// No description provided for @partyBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get partyBasicInfo;

  /// No description provided for @partyAdditionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional Info'**
  String get partyAdditionalInfo;

  /// No description provided for @partyEmail.
  ///
  /// In en, this message translates to:
  /// **'Party Email'**
  String get partyEmail;

  /// No description provided for @partyEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get partyEmailHint;

  /// No description provided for @partyPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get partyPhone;

  /// No description provided for @partyPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get partyPhoneHint;

  /// No description provided for @partyAddress.
  ///
  /// In en, this message translates to:
  /// **'Party Address'**
  String get partyAddress;

  /// No description provided for @partyAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get partyAddressHint;

  /// No description provided for @partyRoleCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get partyRoleCustomer;

  /// No description provided for @partyRoleSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get partyRoleSupplier;

  /// No description provided for @partyRoleRoom.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get partyRoleRoom;

  /// No description provided for @partyRoleCabin.
  ///
  /// In en, this message translates to:
  /// **'Cabin'**
  String get partyRoleCabin;

  /// No description provided for @partyRoleEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get partyRoleEmployee;

  /// No description provided for @partyRoleBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get partyRoleBoth;

  /// No description provided for @partyDefaultAccount.
  ///
  /// In en, this message translates to:
  /// **'Default Account'**
  String get partyDefaultAccount;

  /// No description provided for @partyLoyaltyProgram.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Program'**
  String get partyLoyaltyProgram;

  /// No description provided for @partyLoyaltyPoints.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Points'**
  String get partyLoyaltyPoints;

  /// No description provided for @partySelectDefaultAccount.
  ///
  /// In en, this message translates to:
  /// **'Select Default Account'**
  String get partySelectDefaultAccount;

  /// No description provided for @partySelectLoyaltyProgram.
  ///
  /// In en, this message translates to:
  /// **'Select Loyalty Program'**
  String get partySelectLoyaltyProgram;

  /// No description provided for @partyCreateNewProgram.
  ///
  /// In en, this message translates to:
  /// **'Create new program'**
  String get partyCreateNewProgram;

  /// No description provided for @partySelectPartyRole.
  ///
  /// In en, this message translates to:
  /// **'Select Party Role'**
  String get partySelectPartyRole;

  /// No description provided for @partyAccountDebtors.
  ///
  /// In en, this message translates to:
  /// **'Debtors'**
  String get partyAccountDebtors;

  /// No description provided for @partyAccountCreditors.
  ///
  /// In en, this message translates to:
  /// **'Creditors'**
  String get partyAccountCreditors;

  /// No description provided for @partyBothRoleHint.
  ///
  /// In en, this message translates to:
  /// **'Both means this party appears under Customer and Supplier only — not Room, Cabin, or Employee.'**
  String get partyBothRoleHint;

  /// No description provided for @partyValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid number'**
  String get partyValidNumber;

  /// No description provided for @partyValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid amount'**
  String get partyValidAmount;

  /// No description provided for @searchRoles.
  ///
  /// In en, this message translates to:
  /// **'Search roles'**
  String get searchRoles;

  /// No description provided for @roleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 role} other{{count} roles}}'**
  String roleCount(int count);

  /// No description provided for @noRolesYet.
  ///
  /// In en, this message translates to:
  /// **'No roles yet'**
  String get noRolesYet;

  /// No description provided for @noRolesYetHint.
  ///
  /// In en, this message translates to:
  /// **'Add Customer, Supplier, Both, or custom roles for contacts.'**
  String get noRolesYetHint;

  /// No description provided for @addRole.
  ///
  /// In en, this message translates to:
  /// **'Add role'**
  String get addRole;

  /// No description provided for @deleteRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete role'**
  String get deleteRoleTitle;

  /// No description provided for @deleteRoleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? This cannot be undone.'**
  String deleteRoleConfirm(String name);

  /// No description provided for @deleteRoleHasPartiesMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" is used by {partyCount, plural, =1{1 party} other{{partyCount} parties}}. Transfer those parties to another role, or hard delete and lose them.'**
  String deleteRoleHasPartiesMessage(String name, int partyCount);

  /// No description provided for @transferParties.
  ///
  /// In en, this message translates to:
  /// **'Transfer parties'**
  String get transferParties;

  /// No description provided for @hardDeleteLoseParties.
  ///
  /// In en, this message translates to:
  /// **'Hard delete (lose parties)'**
  String get hardDeleteLoseParties;

  /// No description provided for @hardDeleteRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Hard delete?'**
  String get hardDeleteRoleTitle;

  /// No description provided for @hardDeleteRoleMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete \"{name}\" and all {partyCount, plural, =1{1 party} other{{partyCount} parties}} assigned to it. Party data cannot be recovered.\n\nParties linked to invoices or payments may not delete — use Transfer instead.'**
  String hardDeleteRoleMessage(String name, int partyCount);

  /// No description provided for @deleteRoleAndParties.
  ///
  /// In en, this message translates to:
  /// **'Delete role and parties'**
  String get deleteRoleAndParties;

  /// No description provided for @addAnotherRoleBeforeDelete.
  ///
  /// In en, this message translates to:
  /// **'Add another role before deleting this one.'**
  String get addAnotherRoleBeforeDelete;

  /// No description provided for @transferPartiesMoveMessage.
  ///
  /// In en, this message translates to:
  /// **'Move {partyCount, plural, =1{1 party} other{{partyCount} parties}} from \"{fromRole}\" to:'**
  String transferPartiesMoveMessage(int partyCount, String fromRole);

  /// No description provided for @transferAndDeleteRole.
  ///
  /// In en, this message translates to:
  /// **'Transfer and delete role'**
  String get transferAndDeleteRole;

  /// No description provided for @builtInRole.
  ///
  /// In en, this message translates to:
  /// **'Built-in'**
  String get builtInRole;

  /// No description provided for @rolePartyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 party} other{{count} parties}}'**
  String rolePartyCount(int count);

  /// No description provided for @noPartiesYet.
  ///
  /// In en, this message translates to:
  /// **'No parties yet'**
  String get noPartiesYet;

  /// No description provided for @newRole.
  ///
  /// In en, this message translates to:
  /// **'New role'**
  String get newRole;

  /// No description provided for @editRole.
  ///
  /// In en, this message translates to:
  /// **'Edit role'**
  String get editRole;

  /// No description provided for @defaultRolesCannotEdit.
  ///
  /// In en, this message translates to:
  /// **'Default roles cannot be renamed or deleted.'**
  String get defaultRolesCannotEdit;

  /// No description provided for @roleNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Role name *'**
  String get roleNameLabel;

  /// No description provided for @roleNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Customer'**
  String get roleNameHint;

  /// No description provided for @roleDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get roleDescriptionLabel;

  /// No description provided for @roleDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Short note for your team'**
  String get roleDescriptionHint;

  /// No description provided for @roleSortOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort order'**
  String get roleSortOrderLabel;

  /// No description provided for @roleSortOrderHint.
  ///
  /// In en, this message translates to:
  /// **'Lower shows first in lists'**
  String get roleSortOrderHint;

  /// No description provided for @roleCreated.
  ///
  /// In en, this message translates to:
  /// **'Role created'**
  String get roleCreated;

  /// No description provided for @roleUpdated.
  ///
  /// In en, this message translates to:
  /// **'Role updated'**
  String get roleUpdated;

  /// No description provided for @roleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Role deleted'**
  String get roleDeleted;

  /// No description provided for @roleDeletedPartiesTransferred.
  ///
  /// In en, this message translates to:
  /// **'Role deleted. {count, plural, =1{1 party} other{{count} parties}} moved to {targetRole}.'**
  String roleDeletedPartiesTransferred(int count, String targetRole);

  /// No description provided for @roleAndPartiesDeleted.
  ///
  /// In en, this message translates to:
  /// **'Role and {count, plural, =1{1 party} other{{count} parties}} deleted.'**
  String roleAndPartiesDeleted(int count);

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from your account?'**
  String get logoutConfirmMessage;

  /// No description provided for @faqTapToExpand.
  ///
  /// In en, this message translates to:
  /// **'Tap a question to expand.'**
  String get faqTapToExpand;

  /// No description provided for @faqSectionGettingStarted.
  ///
  /// In en, this message translates to:
  /// **'Getting started'**
  String get faqSectionGettingStarted;

  /// No description provided for @faqSectionLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get faqSectionLogin;

  /// No description provided for @faqSectionNavigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get faqSectionNavigation;

  /// No description provided for @faqSectionInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get faqSectionInvoices;

  /// No description provided for @faqSectionPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get faqSectionPayments;

  /// No description provided for @faqSectionItemsStock.
  ///
  /// In en, this message translates to:
  /// **'Items & stock'**
  String get faqSectionItemsStock;

  /// No description provided for @faqSectionProfileEmployees.
  ///
  /// In en, this message translates to:
  /// **'Profile & employees'**
  String get faqSectionProfileEmployees;

  /// No description provided for @faqSectionDashboardReports.
  ///
  /// In en, this message translates to:
  /// **'Dashboard & reports'**
  String get faqSectionDashboardReports;

  /// No description provided for @faqSectionSyncTroubleshooting.
  ///
  /// In en, this message translates to:
  /// **'Sync & troubleshooting'**
  String get faqSectionSyncTroubleshooting;

  /// No description provided for @faqNeedInternetQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do I need internet?'**
  String get faqNeedInternetQuestion;

  /// No description provided for @faqNeedInternetAnswer.
  ///
  /// In en, this message translates to:
  /// **'After first-time local setup, you can record invoices, items, and payments without internet. Data stays on your device. Sync with a server is optional and available from the More tab when configured.'**
  String get faqNeedInternetAnswer;

  /// No description provided for @faqFirstInstallQuestion.
  ///
  /// In en, this message translates to:
  /// **'What happens on first install?'**
  String get faqFirstInstallQuestion;

  /// No description provided for @faqFirstInstallAnswer.
  ///
  /// In en, this message translates to:
  /// **'You may see a short walkthrough, then Local setup (organization, company, your login email and password, currency, fiscal year). After that, sign in with the email and password you created.'**
  String get faqFirstInstallAnswer;

  /// No description provided for @faqSignInCredentialsQuestion.
  ///
  /// In en, this message translates to:
  /// **'What do I use to sign in?'**
  String get faqSignInCredentialsQuestion;

  /// No description provided for @faqSignInCredentialsAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your email address and password from setup. The app keeps you signed in until you log out from More.'**
  String get faqSignInCredentialsAnswer;

  /// No description provided for @faqLoggedOutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Why was I logged out?'**
  String get faqLoggedOutQuestion;

  /// No description provided for @faqLoggedOutAnswer.
  ///
  /// In en, this message translates to:
  /// **'You chose Logout, cleared app data, or the session expired. Sign in again with the same credentials.'**
  String get faqLoggedOutAnswer;

  /// No description provided for @faqBottomTabsQuestion.
  ///
  /// In en, this message translates to:
  /// **'What do the bottom tabs do?'**
  String get faqBottomTabsQuestion;

  /// No description provided for @faqBottomTabsAnswer.
  ///
  /// In en, this message translates to:
  /// **'Home — dashboard and overview.\nSales — sales invoices by date.\nExpenses — purchase / expense invoices.\nCenter button — Parties (customers, suppliers).\nMore — profile, reports, sync, help, logout.'**
  String get faqBottomTabsAnswer;

  /// No description provided for @faqCreateInvoiceQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I create a sales or purchase invoice?'**
  String get faqCreateInvoiceQuestion;

  /// No description provided for @faqCreateInvoiceAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open Sales or Expenses, select a date on the calendar, tap the + button, add items and amounts, choose a party if needed, then save or submit.'**
  String get faqCreateInvoiceAnswer;

  /// No description provided for @faqInvoiceDetailsQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I view full invoice details?'**
  String get faqInvoiceDetailsQuestion;

  /// No description provided for @faqInvoiceDetailsAnswer.
  ///
  /// In en, this message translates to:
  /// **'Tap any invoice in the list. Transaction details shows line items, totals, discounts, and payments. You can print, share, duplicate, or pay from there.'**
  String get faqInvoiceDetailsAnswer;

  /// No description provided for @faqZeroRateQuestion.
  ///
  /// In en, this message translates to:
  /// **'Rate or amount shows zero in details'**
  String get faqZeroRateQuestion;

  /// No description provided for @faqZeroRateAnswer.
  ///
  /// In en, this message translates to:
  /// **'This usually means line or payment data was missing in older saves. Update the app and create or settle again if needed. New entries should show correct rate and amount.'**
  String get faqZeroRateAnswer;

  /// No description provided for @faqPartialPaymentQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I record a partial payment?'**
  String get faqPartialPaymentQuestion;

  /// No description provided for @faqPartialPaymentAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open the invoice → Transaction details → Make Payment. Enter the amount, method, and date, then Process Settlement.'**
  String get faqPartialPaymentAnswer;

  /// No description provided for @faqMultiplePaymentQuestion.
  ///
  /// In en, this message translates to:
  /// **'How does Multiple Payment work?'**
  String get faqMultiplePaymentQuestion;

  /// No description provided for @faqMultiplePaymentAnswer.
  ///
  /// In en, this message translates to:
  /// **'Turn Multiple Payment ON, tap edit, and split the total across Cash, Card, QR, etc. The split total should match what the customer paid. Each method is recorded separately.'**
  String get faqMultiplePaymentAnswer;

  /// No description provided for @faqSplitPaymentSavedQuestion.
  ///
  /// In en, this message translates to:
  /// **'Only one payment was saved from a split'**
  String get faqSplitPaymentSavedQuestion;

  /// No description provided for @faqSplitPaymentSavedAnswer.
  ///
  /// In en, this message translates to:
  /// **'Update to the latest app version. Older local builds sometimes saved only the first split line. Settle again if your unpaid balance is still wrong.'**
  String get faqSplitPaymentSavedAnswer;

  /// No description provided for @faqAddItemQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I add an item?'**
  String get faqAddItemQuestion;

  /// No description provided for @faqAddItemAnswer.
  ///
  /// In en, this message translates to:
  /// **'Use Add item from sales flow or quick add. Enter name, rate, unit, purpose, and optional photo (JPEG/PNG/GIF/WebP, max 5 MB), then Create item.'**
  String get faqAddItemAnswer;

  /// No description provided for @faqCustomUnitQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I add a custom unit?'**
  String get faqCustomUnitQuestion;

  /// No description provided for @faqCustomUnitAnswer.
  ///
  /// In en, this message translates to:
  /// **'On the item form, tap Unit → Create new unit at the bottom of the list, enter the name (e.g. Litre, Box), and Create.'**
  String get faqCustomUnitAnswer;

  /// No description provided for @faqStockQuantitiesQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I enter stock quantities?'**
  String get faqStockQuantitiesQuestion;

  /// No description provided for @faqStockQuantitiesAnswer.
  ///
  /// In en, this message translates to:
  /// **'Live qty is In stock on each item. Set stock on an item to enter opening stock or a stock adjustment. Opening stock / stock reconciliation (upload or enter a count) also sets In stock when live tracking is on. Liquor prices is a pour-price list, not stock.'**
  String get faqStockQuantitiesAnswer;

  /// No description provided for @faqProfileNameQuestion.
  ///
  /// In en, this message translates to:
  /// **'I changed my name but profile still shows the old name'**
  String get faqProfileNameQuestion;

  /// No description provided for @faqProfileNameAnswer.
  ///
  /// In en, this message translates to:
  /// **'Edit your employee record (same email as login) and save. The More tab and dashboard should update. Log out and back in only if it still looks wrong.'**
  String get faqProfileNameAnswer;

  /// No description provided for @faqRevenueDetailsQuestion.
  ///
  /// In en, this message translates to:
  /// **'What is Revenue Details?'**
  String get faqRevenueDetailsQuestion;

  /// No description provided for @faqRevenueDetailsAnswer.
  ///
  /// In en, this message translates to:
  /// **'A monthly view with a daily trend chart, net profit, unpaid receivables, and a day-by-day sales vs purchase breakdown. Change month with the calendar or month chip.'**
  String get faqRevenueDetailsAnswer;

  /// No description provided for @faqOtherReportsQuestion.
  ///
  /// In en, this message translates to:
  /// **'Where are other reports?'**
  String get faqOtherReportsQuestion;

  /// No description provided for @faqOtherReportsAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open More and look under Reports (Analytics, Profit & Loss, Statement, etc.) if your role has access.'**
  String get faqOtherReportsAnswer;

  /// No description provided for @faqWhenSyncQuestion.
  ///
  /// In en, this message translates to:
  /// **'When should I sync?'**
  String get faqWhenSyncQuestion;

  /// No description provided for @faqWhenSyncAnswer.
  ///
  /// In en, this message translates to:
  /// **'Only when your administrator asks you to, and when you have a stable connection. Sync sends or receives data between the device and the server.'**
  String get faqWhenSyncAnswer;

  /// No description provided for @faqFabPositionQuestion.
  ///
  /// In en, this message translates to:
  /// **'The + button looks too high on Sales / Expenses'**
  String get faqFabPositionQuestion;

  /// No description provided for @faqFabPositionAnswer.
  ///
  /// In en, this message translates to:
  /// **'It sits above the bottom navigation bar. Scroll the list or update the app if the button overlaps content on your device.'**
  String get faqFabPositionAnswer;

  /// No description provided for @faqHowLogoutQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I log out?'**
  String get faqHowLogoutQuestion;

  /// No description provided for @faqHowLogoutAnswer.
  ///
  /// In en, this message translates to:
  /// **'More → Logout at the bottom of the settings list.'**
  String get faqHowLogoutAnswer;

  /// No description provided for @statisticsGoodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get statisticsGoodMorning;

  /// No description provided for @statisticsGoodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get statisticsGoodAfternoon;

  /// No description provided for @statisticsGoodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get statisticsGoodEvening;

  /// No description provided for @statisticsDefaultUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get statisticsDefaultUser;

  /// No description provided for @statisticsCheckConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again.'**
  String get statisticsCheckConnection;

  /// No description provided for @statisticsCouldNotLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile'**
  String get statisticsCouldNotLoadProfile;

  /// No description provided for @statisticsCouldNotLoadData.
  ///
  /// In en, this message translates to:
  /// **'Could not load data'**
  String get statisticsCouldNotLoadData;

  /// No description provided for @statisticsPeriodDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get statisticsPeriodDay;

  /// No description provided for @statisticsPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get statisticsPeriodMonth;

  /// No description provided for @statisticsPeriodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get statisticsPeriodYear;

  /// No description provided for @statisticsSelectedPeriod.
  ///
  /// In en, this message translates to:
  /// **'Selected Period'**
  String get statisticsSelectedPeriod;

  /// No description provided for @statisticsSelectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get statisticsSelectMonth;

  /// No description provided for @statisticsSelectMonthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a month to filter data'**
  String get statisticsSelectMonthSubtitle;

  /// No description provided for @statisticsQuickOperations.
  ///
  /// In en, this message translates to:
  /// **'Quick operations'**
  String get statisticsQuickOperations;

  /// No description provided for @statisticsQuickOperationsSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get statisticsQuickOperationsSeeAll;

  /// No description provided for @statisticsQuickOperationInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get statisticsQuickOperationInvoice;

  /// No description provided for @statisticsQuickOperationReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get statisticsQuickOperationReports;

  /// No description provided for @statisticsAnnualRevenue.
  ///
  /// In en, this message translates to:
  /// **'Annual Revenue'**
  String get statisticsAnnualRevenue;

  /// No description provided for @statisticsCashflow.
  ///
  /// In en, this message translates to:
  /// **'Cashflow'**
  String get statisticsCashflow;

  /// No description provided for @statisticsCashflowLast7Days.
  ///
  /// In en, this message translates to:
  /// **'Cashflow (Last 7 Days)'**
  String get statisticsCashflowLast7Days;

  /// No description provided for @statisticsCashflowLast12Months.
  ///
  /// In en, this message translates to:
  /// **'Cashflow (Last 12 Months)'**
  String get statisticsCashflowLast12Months;

  /// No description provided for @statisticsDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get statisticsDaily;

  /// No description provided for @statisticsMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get statisticsMonthly;

  /// No description provided for @statisticsOverall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get statisticsOverall;

  /// No description provided for @statisticsLast7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get statisticsLast7Days;

  /// No description provided for @statisticsLast12Months.
  ///
  /// In en, this message translates to:
  /// **'Last 12 months'**
  String get statisticsLast12Months;

  /// No description provided for @statisticsAllYears.
  ///
  /// In en, this message translates to:
  /// **'All Years'**
  String get statisticsAllYears;

  /// No description provided for @statisticsNoDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get statisticsNoDataAvailable;

  /// No description provided for @statisticsMoneyIn.
  ///
  /// In en, this message translates to:
  /// **'Money In'**
  String get statisticsMoneyIn;

  /// No description provided for @statisticsMoneyOut.
  ///
  /// In en, this message translates to:
  /// **'Money Out'**
  String get statisticsMoneyOut;

  /// No description provided for @statisticsIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get statisticsIncome;

  /// No description provided for @statisticsExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get statisticsExpenses;

  /// No description provided for @statisticsSalesSummary.
  ///
  /// In en, this message translates to:
  /// **'Sales Summary'**
  String get statisticsSalesSummary;

  /// No description provided for @statisticsPurchaseSummary.
  ///
  /// In en, this message translates to:
  /// **'Purchase Summary'**
  String get statisticsPurchaseSummary;

  /// No description provided for @statisticsTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get statisticsTotalSales;

  /// No description provided for @statisticsTotalIncome.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get statisticsTotalIncome;

  /// No description provided for @statisticsTotalUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Total Unpaid'**
  String get statisticsTotalUnpaid;

  /// No description provided for @statisticsTotalPurchase.
  ///
  /// In en, this message translates to:
  /// **'Total Purchase'**
  String get statisticsTotalPurchase;

  /// No description provided for @statisticsPaidPurchase.
  ///
  /// In en, this message translates to:
  /// **'Paid Purchase'**
  String get statisticsPaidPurchase;

  /// No description provided for @statisticsUnpaidPurchase.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Purchase'**
  String get statisticsUnpaidPurchase;

  /// No description provided for @statisticsEmployeeDashboard.
  ///
  /// In en, this message translates to:
  /// **'Employee Dashboard'**
  String get statisticsEmployeeDashboard;

  /// No description provided for @statisticsDefaultEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get statisticsDefaultEmployee;

  /// No description provided for @statisticsDefaultDepartment.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get statisticsDefaultDepartment;

  /// No description provided for @statisticsDefaultPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get statisticsDefaultPosition;

  /// No description provided for @statisticsCurrentMonth.
  ///
  /// In en, this message translates to:
  /// **'Current Month'**
  String get statisticsCurrentMonth;

  /// No description provided for @statisticsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statisticsStatus;

  /// No description provided for @statisticsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statisticsActive;

  /// No description provided for @statisticsWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get statisticsWelcome;

  /// No description provided for @statisticsEmployeeWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'You are logged in as an employee. Use the navigation menu to access available features.'**
  String get statisticsEmployeeWelcomeMessage;

  /// No description provided for @statisticsRevenueDetails.
  ///
  /// In en, this message translates to:
  /// **'Revenue Details'**
  String get statisticsRevenueDetails;

  /// No description provided for @statisticsEmployeeDetails.
  ///
  /// In en, this message translates to:
  /// **'Employee Details'**
  String get statisticsEmployeeDetails;

  /// No description provided for @statisticsChangeMonth.
  ///
  /// In en, this message translates to:
  /// **'Change month'**
  String get statisticsChangeMonth;

  /// No description provided for @statisticsFilterChartsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Filter charts and breakdown'**
  String get statisticsFilterChartsSubtitle;

  /// No description provided for @statisticsDailyTrend.
  ///
  /// In en, this message translates to:
  /// **'Daily trend'**
  String get statisticsDailyTrend;

  /// No description provided for @statisticsDailyActivity.
  ///
  /// In en, this message translates to:
  /// **'Daily activity'**
  String get statisticsDailyActivity;

  /// No description provided for @statisticsNoDataForMonth.
  ///
  /// In en, this message translates to:
  /// **'No data for this month'**
  String get statisticsNoDataForMonth;

  /// No description provided for @statisticsNetProfit.
  ///
  /// In en, this message translates to:
  /// **'Net profit'**
  String get statisticsNetProfit;

  /// No description provided for @statisticsMonthReceivables.
  ///
  /// In en, this message translates to:
  /// **'Month receivables'**
  String get statisticsMonthReceivables;

  /// No description provided for @statisticsMonthRevenue.
  ///
  /// In en, this message translates to:
  /// **'Month Revenue'**
  String get statisticsMonthRevenue;

  /// No description provided for @statisticsMonthExpenses.
  ///
  /// In en, this message translates to:
  /// **'Month Expenses'**
  String get statisticsMonthExpenses;

  /// No description provided for @statisticsNoDailyEntries.
  ///
  /// In en, this message translates to:
  /// **'No daily entries for this month'**
  String get statisticsNoDailyEntries;

  /// No description provided for @statisticsDailySalesBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Daily sales breakdown'**
  String get statisticsDailySalesBreakdown;

  /// No description provided for @statisticsDailyBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Daily breakdown'**
  String get statisticsDailyBreakdown;

  /// No description provided for @statisticsAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advance'**
  String get statisticsAdvance;

  /// No description provided for @statisticsExploreFeatures.
  ///
  /// In en, this message translates to:
  /// **'Explore Features'**
  String get statisticsExploreFeatures;

  /// No description provided for @statisticsShowOrHideFeatures.
  ///
  /// In en, this message translates to:
  /// **'Show or hide features'**
  String get statisticsShowOrHideFeatures;

  /// No description provided for @statisticsAllFeaturesHidden.
  ///
  /// In en, this message translates to:
  /// **'All explore features are hidden'**
  String get statisticsAllFeaturesHidden;

  /// No description provided for @statisticsNoFeaturesForOrg.
  ///
  /// In en, this message translates to:
  /// **'No features available for your organization'**
  String get statisticsNoFeaturesForOrg;

  /// No description provided for @statisticsTapTuneToShow.
  ///
  /// In en, this message translates to:
  /// **'Tap the tune icon above to show shortcuts again.'**
  String get statisticsTapTuneToShow;

  /// No description provided for @statisticsMenuCheck.
  ///
  /// In en, this message translates to:
  /// **'Reconciliation'**
  String get statisticsMenuCheck;

  /// No description provided for @statisticsMenuEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get statisticsMenuEmployee;

  /// No description provided for @statisticsMenuOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get statisticsMenuOrder;

  /// No description provided for @statisticsMenuInventory.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get statisticsMenuInventory;

  /// No description provided for @statisticsMenuCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get statisticsMenuCustomers;

  /// No description provided for @statisticsMenuCalculator.
  ///
  /// In en, this message translates to:
  /// **'Liquor prices'**
  String get statisticsMenuCalculator;

  /// No description provided for @statisticsMenuQuickExpenses.
  ///
  /// In en, this message translates to:
  /// **'Quick\nExpenses'**
  String get statisticsMenuQuickExpenses;

  /// No description provided for @statisticsMenuQuickSales.
  ///
  /// In en, this message translates to:
  /// **'Quick\nSales'**
  String get statisticsMenuQuickSales;

  /// No description provided for @statisticsMenuAddEmployee.
  ///
  /// In en, this message translates to:
  /// **'Add\nEmployee'**
  String get statisticsMenuAddEmployee;

  /// No description provided for @statisticsMenuAddParty.
  ///
  /// In en, this message translates to:
  /// **'Add\nParty'**
  String get statisticsMenuAddParty;

  /// No description provided for @statisticsMenuAddEmployeeSingle.
  ///
  /// In en, this message translates to:
  /// **'Add Employee'**
  String get statisticsMenuAddEmployeeSingle;

  /// No description provided for @statisticsMenuAddPartySingle.
  ///
  /// In en, this message translates to:
  /// **'Add Party'**
  String get statisticsMenuAddPartySingle;

  /// No description provided for @statisticsGreeting.
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {name}'**
  String statisticsGreeting(String greeting, String name);

  /// No description provided for @statisticsEmployeeGreeting.
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {name}!'**
  String statisticsEmployeeGreeting(String greeting, String name);

  /// No description provided for @statisticsDepartmentPosition.
  ///
  /// In en, this message translates to:
  /// **'{department} • {position}'**
  String statisticsDepartmentPosition(String department, String position);

  /// No description provided for @statisticsMetricCollected.
  ///
  /// In en, this message translates to:
  /// **'{amount} collected'**
  String statisticsMetricCollected(String amount);

  /// No description provided for @statisticsMetricPaid.
  ///
  /// In en, this message translates to:
  /// **'{amount} paid'**
  String statisticsMetricPaid(String amount);

  /// No description provided for @statisticsMoneyInAmount.
  ///
  /// In en, this message translates to:
  /// **'Money In: {amount}'**
  String statisticsMoneyInAmount(String amount);

  /// No description provided for @statisticsMoneyOutAmount.
  ///
  /// In en, this message translates to:
  /// **'Money Out: {amount}'**
  String statisticsMoneyOutAmount(String amount);

  /// No description provided for @statisticsDayTooltip.
  ///
  /// In en, this message translates to:
  /// **'Day {day}\n{amount}'**
  String statisticsDayTooltip(String day, String amount);

  /// No description provided for @statisticsProfitMargin.
  ///
  /// In en, this message translates to:
  /// **'{percent}% margin'**
  String statisticsProfitMargin(String percent);

  /// No description provided for @invoiceCommonActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get invoiceCommonActions;

  /// No description provided for @invoiceCommonSearchItems.
  ///
  /// In en, this message translates to:
  /// **'Search Items'**
  String get invoiceCommonSearchItems;

  /// No description provided for @invoiceCommonSearchItemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search for specific items'**
  String get invoiceCommonSearchItemsSubtitle;

  /// No description provided for @invoiceCommonAddNewInvoice.
  ///
  /// In en, this message translates to:
  /// **'Add New Invoice'**
  String get invoiceCommonAddNewInvoice;

  /// No description provided for @invoiceCommonAddSalesInvoiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new sales invoice'**
  String get invoiceCommonAddSalesInvoiceSubtitle;

  /// No description provided for @invoiceCommonAddPurchaseInvoiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new purchase invoice'**
  String get invoiceCommonAddPurchaseInvoiceSubtitle;

  /// No description provided for @invoiceCommonSelectMonthYear.
  ///
  /// In en, this message translates to:
  /// **'Select Month/Year'**
  String get invoiceCommonSelectMonthYear;

  /// No description provided for @invoiceCommonSelectMonthYearSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Jump to a specific month'**
  String get invoiceCommonSelectMonthYearSubtitle;

  /// No description provided for @invoiceCommonSelectMonthAndYear.
  ///
  /// In en, this message translates to:
  /// **'Select Month & Year'**
  String get invoiceCommonSelectMonthAndYear;

  /// No description provided for @invoiceCommonFilterByDate.
  ///
  /// In en, this message translates to:
  /// **'Filter by date'**
  String get invoiceCommonFilterByDate;

  /// No description provided for @invoiceCommonFilterByDateRange.
  ///
  /// In en, this message translates to:
  /// **'Filter by date range'**
  String get invoiceCommonFilterByDateRange;

  /// No description provided for @invoiceCommonCloseSearch.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get invoiceCommonCloseSearch;

  /// No description provided for @invoiceCommonSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get invoiceCommonSelectAll;

  /// No description provided for @invoiceCommonToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get invoiceCommonToday;

  /// No description provided for @invoiceCommonTotalQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Quantity'**
  String get invoiceCommonTotalQuantity;

  /// No description provided for @invoiceCommonTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get invoiceCommonTotalAmount;

  /// No description provided for @invoiceCommonTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get invoiceCommonTotal;

  /// No description provided for @invoiceCommonSearchForItems.
  ///
  /// In en, this message translates to:
  /// **'Search for items'**
  String get invoiceCommonSearchForItems;

  /// No description provided for @invoiceCommonNoItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get invoiceCommonNoItemsFound;

  /// No description provided for @invoiceCommonUnknownItem.
  ///
  /// In en, this message translates to:
  /// **'Unknown Item'**
  String get invoiceCommonUnknownItem;

  /// No description provided for @invoiceCommonNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get invoiceCommonNotAvailable;

  /// No description provided for @invoiceSalesCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load sales'**
  String get invoiceSalesCouldNotLoad;

  /// No description provided for @invoiceSalesNoFound.
  ///
  /// In en, this message translates to:
  /// **'No Sales found'**
  String get invoiceSalesNoFound;

  /// No description provided for @invoiceSalesSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date to view Sales'**
  String get invoiceSalesSelectDate;

  /// No description provided for @invoiceSalesNoInvoicesFound.
  ///
  /// In en, this message translates to:
  /// **'No invoices found'**
  String get invoiceSalesNoInvoicesFound;

  /// No description provided for @invoiceSalesSelectDateLegacy.
  ///
  /// In en, this message translates to:
  /// **'Select a date to view invoices'**
  String get invoiceSalesSelectDateLegacy;

  /// No description provided for @invoicePurchaseCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load expenses'**
  String get invoicePurchaseCouldNotLoad;

  /// No description provided for @invoicePurchaseNoFound.
  ///
  /// In en, this message translates to:
  /// **'No purchases found'**
  String get invoicePurchaseNoFound;

  /// No description provided for @invoicePurchaseSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date to view purchases'**
  String get invoicePurchaseSelectDate;

  /// No description provided for @invoiceWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get invoiceWeekdaySun;

  /// No description provided for @invoiceWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get invoiceWeekdayMon;

  /// No description provided for @invoiceWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get invoiceWeekdayTue;

  /// No description provided for @invoiceWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get invoiceWeekdayWed;

  /// No description provided for @invoiceWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get invoiceWeekdayThu;

  /// No description provided for @invoiceWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get invoiceWeekdayFri;

  /// No description provided for @invoiceWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get invoiceWeekdaySat;

  /// No description provided for @invoiceCommonSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Selected'**
  String invoiceCommonSelectedCount(int count);

  /// No description provided for @invoiceCommonQtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Qty: {qty}'**
  String invoiceCommonQtyLabel(String qty);

  /// No description provided for @invoiceCommonInvoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice: {number}'**
  String invoiceCommonInvoiceLabel(String number);

  /// No description provided for @invoiceCommonCustomerLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer: {name}'**
  String invoiceCommonCustomerLabel(String name);

  /// No description provided for @invoiceCommonSupplierLabel.
  ///
  /// In en, this message translates to:
  /// **'Supplier: {name}'**
  String invoiceCommonSupplierLabel(String name);

  /// No description provided for @invoiceCommonSearchingFor.
  ///
  /// In en, this message translates to:
  /// **'Searching for \"{query}\"...'**
  String invoiceCommonSearchingFor(String query);

  /// No description provided for @invoiceCommonSearchItemsHint.
  ///
  /// In en, this message translates to:
  /// **'Search items in {scope}...'**
  String invoiceCommonSearchItemsHint(String scope);

  /// No description provided for @invoiceCommonSalesSearchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Type an item name to find all sales\nin {scope}'**
  String invoiceCommonSalesSearchPrompt(String scope);

  /// No description provided for @invoiceCommonPurchaseSearchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Type an item name to find all purchases\nin {scope}'**
  String invoiceCommonPurchaseSearchPrompt(String scope);

  /// No description provided for @invoiceCommonSalesNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No sales of \"{query}\"\nin {scope}'**
  String invoiceCommonSalesNoMatch(String query, String scope);

  /// No description provided for @invoiceCommonPurchaseNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No purchases of \"{query}\"\nin {scope}'**
  String invoiceCommonPurchaseNoMatch(String query, String scope);

  /// No description provided for @invoiceCommonEmptyForDate.
  ///
  /// In en, this message translates to:
  /// **'for {date}'**
  String invoiceCommonEmptyForDate(String date);

  /// No description provided for @invoiceFoundSalesCount.
  ///
  /// In en, this message translates to:
  /// **'Found {count, plural, =1{1 sale} other{{count} sales}}'**
  String invoiceFoundSalesCount(int count);

  /// No description provided for @invoiceFoundPurchaseCount.
  ///
  /// In en, this message translates to:
  /// **'Found {count, plural, =1{1 purchase} other{{count} purchases}}'**
  String invoiceFoundPurchaseCount(int count);

  /// No description provided for @invoiceDateSalesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 sale} other{{count} sales}}'**
  String invoiceDateSalesCount(int count);

  /// No description provided for @invoiceDatePurchaseCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 purchase} other{{count} purchases}}'**
  String invoiceDatePurchaseCount(int count);

  /// No description provided for @invoiceDateInvoiceCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 invoice} other{{count} invoices}}'**
  String invoiceDateInvoiceCount(int count);

  /// No description provided for @invoiceDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {count, plural, =1{1 invoice} other{{count} invoices}}'**
  String invoiceDeleteTitle(int count);

  /// No description provided for @invoiceDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count, plural, =1{1 selected invoice} other{{count} selected invoices}}? This action cannot be undone.'**
  String invoiceDeleteMessage(int count);

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @manageStaff.
  ///
  /// In en, this message translates to:
  /// **'Manage staff'**
  String get manageStaff;

  /// No description provided for @payroll.
  ///
  /// In en, this message translates to:
  /// **'Payroll'**
  String get payroll;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @profitAndLoss.
  ///
  /// In en, this message translates to:
  /// **'Profit & Loss'**
  String get profitAndLoss;

  /// No description provided for @statementReport.
  ///
  /// In en, this message translates to:
  /// **'Statement'**
  String get statementReport;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @loggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out'**
  String get loggedOut;

  /// No description provided for @organizationCodeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Code: {code}'**
  String organizationCodeDisplay(String code);

  /// No description provided for @moreDataSynchronization.
  ///
  /// In en, this message translates to:
  /// **'Data Synchronization'**
  String get moreDataSynchronization;

  /// No description provided for @moreSendDataToClient.
  ///
  /// In en, this message translates to:
  /// **'Send Data to Client'**
  String get moreSendDataToClient;

  /// No description provided for @moreSendDataToClientSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload server data to client'**
  String get moreSendDataToClientSubtitle;

  /// No description provided for @moreSendDataToClientWarning.
  ///
  /// In en, this message translates to:
  /// **'This action will replace the current client database with data from the server. All recent client changes may be lost.'**
  String get moreSendDataToClientWarning;

  /// No description provided for @moreSendDataToClientConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to send data to the client?'**
  String get moreSendDataToClientConfirm;

  /// No description provided for @moreFetchDataFromClient.
  ///
  /// In en, this message translates to:
  /// **'Fetch Data from Client'**
  String get moreFetchDataFromClient;

  /// No description provided for @moreFetchDataFromClientSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Download client data to server'**
  String get moreFetchDataFromClientSubtitle;

  /// No description provided for @moreFetchDataFromClientWarning.
  ///
  /// In en, this message translates to:
  /// **'This action will replace the current server database with data from the client. All recent server changes may be lost.'**
  String get moreFetchDataFromClientWarning;

  /// No description provided for @moreFetchDataFromClientConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to fetch data from the client?'**
  String get moreFetchDataFromClientConfirm;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @openingReminder.
  ///
  /// In en, this message translates to:
  /// **'Opening reminder'**
  String get openingReminder;

  /// No description provided for @closingReminder.
  ///
  /// In en, this message translates to:
  /// **'Closing reminder'**
  String get closingReminder;

  /// No description provided for @activityReminder.
  ///
  /// In en, this message translates to:
  /// **'Sales & purchase reminder'**
  String get activityReminder;

  /// No description provided for @openingTime.
  ///
  /// In en, this message translates to:
  /// **'Opening time'**
  String get openingTime;

  /// No description provided for @closingTime.
  ///
  /// In en, this message translates to:
  /// **'Closing time'**
  String get closingTime;

  /// No description provided for @activityReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get activityReminderTime;

  /// No description provided for @notificationSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Notification settings saved'**
  String get notificationSettingsSaved;

  /// No description provided for @notificationPermissionHint.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications (and alarms on Android) so reminders work when the app is closed'**
  String get notificationPermissionHint;

  /// No description provided for @dailyAtTime.
  ///
  /// In en, this message translates to:
  /// **'Daily at {time}'**
  String dailyAtTime(String time);

  /// No description provided for @invoiceActivityReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'No sales or purchases today'**
  String get invoiceActivityReminderTitle;

  /// No description provided for @invoiceActivityReminderMessage.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added a sales or purchase record yet today. Add one to keep your books up to date.'**
  String get invoiceActivityReminderMessage;

  /// No description provided for @invoiceActivityReminderProceed.
  ///
  /// In en, this message translates to:
  /// **'Add record'**
  String get invoiceActivityReminderProceed;

  /// No description provided for @invoiceActivityReminderAddSales.
  ///
  /// In en, this message translates to:
  /// **'Add sales'**
  String get invoiceActivityReminderAddSales;

  /// No description provided for @invoiceActivityReminderAddPurchase.
  ///
  /// In en, this message translates to:
  /// **'Add purchase'**
  String get invoiceActivityReminderAddPurchase;

  /// No description provided for @invoiceActivityReminderNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Add today\'s record'**
  String get invoiceActivityReminderNotificationTitle;

  /// No description provided for @invoiceActivityReminderNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'No sales or purchase yet today. Tap to add a record.'**
  String get invoiceActivityReminderNotificationBody;

  /// No description provided for @invoiceCommonYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get invoiceCommonYesterday;

  /// No description provided for @invoiceCommonTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Today, {time}'**
  String invoiceCommonTodayAt(String time);

  /// No description provided for @invoiceCommonDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String invoiceCommonDaysAgo(int count);

  /// No description provided for @invoiceReturnCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 return} other{{count} returns}}'**
  String invoiceReturnCount(int count);

  /// No description provided for @checkoutSelectParty.
  ///
  /// In en, this message translates to:
  /// **'Select Party'**
  String get checkoutSelectParty;

  /// No description provided for @partyPickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who is this sale for?'**
  String get partyPickerSubtitle;

  /// No description provided for @partyPickerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search {role}...'**
  String partyPickerSearchHint(String role);

  /// No description provided for @partyPickerAddNewRole.
  ///
  /// In en, this message translates to:
  /// **'Add new {role}'**
  String partyPickerAddNewRole(String role);

  /// No description provided for @partyPickerSettled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get partyPickerSettled;

  /// No description provided for @partyPickerSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'SELECTED'**
  String get partyPickerSelectedLabel;

  /// No description provided for @checkoutCartSummary.
  ///
  /// In en, this message translates to:
  /// **'Cart summary'**
  String get checkoutCartSummary;

  /// No description provided for @checkoutNoItemsInCart.
  ///
  /// In en, this message translates to:
  /// **'No items in cart'**
  String get checkoutNoItemsInCart;

  /// No description provided for @checkoutSearchHere.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get checkoutSearchHere;

  /// No description provided for @checkoutCreateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get checkoutCreateInvoice;

  /// No description provided for @checkoutEditInvoice.
  ///
  /// In en, this message translates to:
  /// **'Edit Invoice'**
  String get checkoutEditInvoice;

  /// No description provided for @checkoutSaveInvoice.
  ///
  /// In en, this message translates to:
  /// **'Save Invoice'**
  String get checkoutSaveInvoice;

  /// No description provided for @checkoutInvoiceSummary.
  ///
  /// In en, this message translates to:
  /// **'Invoice Summary'**
  String get checkoutInvoiceSummary;

  /// No description provided for @checkoutEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimate'**
  String get checkoutEstimate;

  /// No description provided for @checkoutBasicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get checkoutBasicInformation;

  /// No description provided for @checkoutAddItems.
  ///
  /// In en, this message translates to:
  /// **'Add Items'**
  String get checkoutAddItems;

  /// No description provided for @checkoutItemsSection.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get checkoutItemsSection;

  /// No description provided for @checkoutPartyRequired.
  ///
  /// In en, this message translates to:
  /// **'Party *'**
  String get checkoutPartyRequired;

  /// No description provided for @checkoutPartyInformation.
  ///
  /// In en, this message translates to:
  /// **'Party Information'**
  String get checkoutPartyInformation;

  /// No description provided for @checkoutBillSummary.
  ///
  /// In en, this message translates to:
  /// **'Bill Summary'**
  String get checkoutBillSummary;

  /// No description provided for @checkoutBillSummaryHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to know more detailed calculation.'**
  String get checkoutBillSummaryHint;

  /// No description provided for @checkoutItemTotal.
  ///
  /// In en, this message translates to:
  /// **'Item Total'**
  String get checkoutItemTotal;

  /// No description provided for @checkoutLoyaltyDiscount.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Discount ({percent}%)'**
  String checkoutLoyaltyDiscount(String percent);

  /// No description provided for @checkoutLoyaltyDiscountLabel.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Discount'**
  String get checkoutLoyaltyDiscountLabel;

  /// No description provided for @checkoutDiscountLabel.
  ///
  /// In en, this message translates to:
  /// **'- Discount'**
  String get checkoutDiscountLabel;

  /// No description provided for @checkoutTaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get checkoutTaxLabel;

  /// No description provided for @checkoutEditTax.
  ///
  /// In en, this message translates to:
  /// **'Edit tax'**
  String get checkoutEditTax;

  /// No description provided for @checkoutTaxType.
  ///
  /// In en, this message translates to:
  /// **'Tax type'**
  String get checkoutTaxType;

  /// No description provided for @checkoutTaxCorporate.
  ///
  /// In en, this message translates to:
  /// **'Corporate'**
  String get checkoutTaxCorporate;

  /// No description provided for @checkoutTaxPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get checkoutTaxPersonal;

  /// No description provided for @checkoutTaxApplyHint.
  ///
  /// In en, this message translates to:
  /// **'Add tax to this invoice total'**
  String get checkoutTaxApplyHint;

  /// No description provided for @checkoutTaxTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Rates for {type} from your country reference — you can override below.'**
  String checkoutTaxTypeHint(String type);

  /// No description provided for @checkoutTaxPresetsForCountry.
  ///
  /// In en, this message translates to:
  /// **'Suggested rates for {country}'**
  String checkoutTaxPresetsForCountry(String country);

  /// No description provided for @checkoutTaxNoTax.
  ///
  /// In en, this message translates to:
  /// **'No tax'**
  String get checkoutTaxNoTax;

  /// No description provided for @checkoutSummaryPercent.
  ///
  /// In en, this message translates to:
  /// **'({percent}%)'**
  String checkoutSummaryPercent(String percent);

  /// No description provided for @checkoutDiscountLine.
  ///
  /// In en, this message translates to:
  /// **'- Discount ({percent}%)'**
  String checkoutDiscountLine(String percent);

  /// No description provided for @checkoutTapToEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap to Edit'**
  String get checkoutTapToEdit;

  /// No description provided for @checkoutTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get checkoutTotalAmount;

  /// No description provided for @checkoutPaymentMode.
  ///
  /// In en, this message translates to:
  /// **'Record payment'**
  String get checkoutPaymentMode;

  /// No description provided for @checkoutPaymentModeHint.
  ///
  /// In en, this message translates to:
  /// **'Turn on to take payment now. Leave off to submit the bill unpaid and collect later.'**
  String get checkoutPaymentModeHint;

  /// No description provided for @checkoutNetSalesAmount.
  ///
  /// In en, this message translates to:
  /// **'Net Sales Amount'**
  String get checkoutNetSalesAmount;

  /// No description provided for @checkoutConfirmCheckout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Checkout'**
  String get checkoutConfirmCheckout;

  /// No description provided for @checkoutEditDiscount.
  ///
  /// In en, this message translates to:
  /// **'Edit Discount'**
  String get checkoutEditDiscount;

  /// No description provided for @checkoutPercentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get checkoutPercentage;

  /// No description provided for @checkoutDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get checkoutDiscard;

  /// No description provided for @checkoutPartialPayment.
  ///
  /// In en, this message translates to:
  /// **'Partial Payment'**
  String get checkoutPartialPayment;

  /// No description provided for @checkoutPartialPaymentBanner.
  ///
  /// In en, this message translates to:
  /// **'By activating Partial Payment the customer will be able to pay the amount less than the Total Billed Amount.'**
  String get checkoutPartialPaymentBanner;

  /// No description provided for @checkoutPleaseEnterAmounts.
  ///
  /// In en, this message translates to:
  /// **'Please enter respective amounts:'**
  String get checkoutPleaseEnterAmounts;

  /// No description provided for @checkoutPartialPaymentEqualHint.
  ///
  /// In en, this message translates to:
  /// **'Since no user is assigned, the total amount should be equal to the total billed amount.'**
  String get checkoutPartialPaymentEqualHint;

  /// No description provided for @checkoutOverGrandTotalBy.
  ///
  /// In en, this message translates to:
  /// **'Over Grand Total by: {amount}'**
  String checkoutOverGrandTotalBy(String amount);

  /// No description provided for @checkoutRemainingUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Remaining (unpaid from Grand Total): {amount}'**
  String checkoutRemainingUnpaid(String amount);

  /// No description provided for @checkoutConfirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get checkoutConfirmPayment;

  /// No description provided for @checkoutUnpaidCredit.
  ///
  /// In en, this message translates to:
  /// **'Unpaid / Credit'**
  String get checkoutUnpaidCredit;

  /// No description provided for @checkoutAddAtLeastOneLine.
  ///
  /// In en, this message translates to:
  /// **'Add at least one line item to view estimate'**
  String get checkoutAddAtLeastOneLine;

  /// No description provided for @checkoutMultiplePayment.
  ///
  /// In en, this message translates to:
  /// **'Multiple Payment'**
  String get checkoutMultiplePayment;

  /// No description provided for @checkoutPaymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment status'**
  String get checkoutPaymentStatus;

  /// No description provided for @checkoutPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get checkoutPaymentMethods;

  /// No description provided for @checkoutPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get checkoutPaymentMethod;

  /// No description provided for @checkoutTenderAmount.
  ///
  /// In en, this message translates to:
  /// **'Tender amount'**
  String get checkoutTenderAmount;

  /// No description provided for @checkoutLoadingPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Loading payment methods…'**
  String get checkoutLoadingPaymentMethods;

  /// No description provided for @stocksTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock reconciliation'**
  String get stocksTitle;

  /// No description provided for @stockUploadTooltip.
  ///
  /// In en, this message translates to:
  /// **'Opening stock'**
  String get stockUploadTooltip;

  /// No description provided for @stockNoDataYet.
  ///
  /// In en, this message translates to:
  /// **'No opening stock yet'**
  String get stockNoDataYet;

  /// No description provided for @stockNoDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a physical count. With live tracking on, that count becomes In stock.'**
  String get stockNoDataSubtitle;

  /// No description provided for @stockUploadAction.
  ///
  /// In en, this message translates to:
  /// **'Opening stock'**
  String get stockUploadAction;

  /// No description provided for @stockSearchByDateHint.
  ///
  /// In en, this message translates to:
  /// **'Search by date or month…'**
  String get stockSearchByDateHint;

  /// No description provided for @stockNoMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get stockNoMatches;

  /// No description provided for @stockTryDifferentSearch.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term'**
  String get stockTryDifferentSearch;

  /// No description provided for @stockTryAnotherSearch.
  ///
  /// In en, this message translates to:
  /// **'Try another search'**
  String get stockTryAnotherSearch;

  /// No description provided for @liveStockTracking.
  ///
  /// In en, this message translates to:
  /// **'Live stock tracking'**
  String get liveStockTracking;

  /// No description provided for @liveStockTrackingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Purchases add In stock, sales take it.'**
  String get liveStockTrackingSubtitle;

  /// No description provided for @itemsListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Item list and live In stock'**
  String get itemsListSubtitle;

  /// No description provided for @stockCountsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Opening stock and counts'**
  String get stockCountsSubtitle;

  /// No description provided for @liquorPricesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pour prices only — not item stock'**
  String get liquorPricesSubtitle;

  /// No description provided for @stockCountsPageHint.
  ///
  /// In en, this message translates to:
  /// **'Physical count for stock reconciliation. With live tracking on, In stock is set to the counted qty.'**
  String get stockCountsPageHint;

  /// No description provided for @stockUploadPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Opening stock'**
  String get stockUploadPageTitle;

  /// No description provided for @stockEnterQuantitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter opening stock'**
  String get stockEnterQuantitiesTitle;

  /// No description provided for @stockUploadSubmit.
  ///
  /// In en, this message translates to:
  /// **'Save opening stock'**
  String get stockUploadSubmit;

  /// No description provided for @stockEnterQuantitiesOption.
  ///
  /// In en, this message translates to:
  /// **'Enter opening stock'**
  String get stockEnterQuantitiesOption;

  /// No description provided for @stockEnterQuantitiesOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Physical count. With live tracking on, this sets In stock.'**
  String get stockEnterQuantitiesOptionSubtitle;

  /// No description provided for @liveStockTrackingSaved.
  ///
  /// In en, this message translates to:
  /// **'Live stock tracking updated'**
  String get liveStockTrackingSaved;

  /// No description provided for @liveStockOnHand.
  ///
  /// In en, this message translates to:
  /// **'In stock: {qty}'**
  String liveStockOnHand(String qty);

  /// No description provided for @liveStockOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'{item} is out of stock'**
  String liveStockOutOfStock(String item);

  /// No description provided for @liveStockInsufficient.
  ///
  /// In en, this message translates to:
  /// **'{item} has only {qty} in stock'**
  String liveStockInsufficient(String item, String qty);

  /// No description provided for @liveStockSetOnHand.
  ///
  /// In en, this message translates to:
  /// **'Set stock'**
  String get liveStockSetOnHand;

  /// No description provided for @liveStockOnHandLabel.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get liveStockOnHandLabel;

  /// No description provided for @liveStockOnHandHint.
  ///
  /// In en, this message translates to:
  /// **'Opening stock or stock adjustment — physical count, no purchase needed'**
  String get liveStockOnHandHint;

  /// No description provided for @liveStockOnHandSaved.
  ///
  /// In en, this message translates to:
  /// **'Stock updated'**
  String get liveStockOnHandSaved;

  /// No description provided for @liveStockSaveOnHand.
  ///
  /// In en, this message translates to:
  /// **'Save stock'**
  String get liveStockSaveOnHand;

  /// No description provided for @stockQtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Qty {qty}'**
  String stockQtyLabel(String qty);

  /// No description provided for @stockCardSummary.
  ///
  /// In en, this message translates to:
  /// **'{records} records · {items} items · {locations} locations'**
  String stockCardSummary(String records, String items, String locations);

  /// No description provided for @stockFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter stock reconciliation'**
  String get stockFilterTitle;

  /// No description provided for @stockBatchNumber.
  ///
  /// In en, this message translates to:
  /// **'Batch number'**
  String get stockBatchNumber;

  /// No description provided for @stockLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get stockLocation;

  /// No description provided for @stockOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get stockOptionalHint;

  /// No description provided for @stockApplyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get stockApplyFilters;

  /// No description provided for @stockClearFields.
  ///
  /// In en, this message translates to:
  /// **'Clear fields'**
  String get stockClearFields;

  /// No description provided for @stockDeleteAllTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete all stock for this date'**
  String get stockDeleteAllTooltip;

  /// No description provided for @stockNoItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No stock items found'**
  String get stockNoItemsFound;

  /// No description provided for @stockNoItemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try different filters or another reporting date.'**
  String get stockNoItemsSubtitle;

  /// No description provided for @stockAdjustFilters.
  ///
  /// In en, this message translates to:
  /// **'Adjust filters'**
  String get stockAdjustFilters;

  /// No description provided for @stockSearchItemHint.
  ///
  /// In en, this message translates to:
  /// **'Search item, batch, location…'**
  String get stockSearchItemHint;

  /// No description provided for @stockEditQuantities.
  ///
  /// In en, this message translates to:
  /// **'Edit quantities'**
  String get stockEditQuantities;

  /// No description provided for @stockNoChangesDetected.
  ///
  /// In en, this message translates to:
  /// **'No changes detected'**
  String get stockNoChangesDetected;

  /// No description provided for @stockErrorPreparingChanges.
  ///
  /// In en, this message translates to:
  /// **'Error preparing changes: {error}'**
  String stockErrorPreparingChanges(String error);

  /// No description provided for @stockUpdateSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Update Successful!'**
  String get stockUpdateSuccessful;

  /// No description provided for @stockSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get stockSummary;

  /// No description provided for @stockTotalRequested.
  ///
  /// In en, this message translates to:
  /// **'Total Requested'**
  String get stockTotalRequested;

  /// No description provided for @stockSuccessfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Successfully Updated'**
  String get stockSuccessfullyUpdated;

  /// No description provided for @stockFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get stockFailed;

  /// No description provided for @stockUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update Failed'**
  String get stockUpdateFailed;

  /// No description provided for @stockClearAllQuantitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All Quantities?'**
  String get stockClearAllQuantitiesTitle;

  /// No description provided for @stockClearAllQuantitiesMessage.
  ///
  /// In en, this message translates to:
  /// **'This will reset all quantities to 0. Are you sure?'**
  String get stockClearAllQuantitiesMessage;

  /// No description provided for @stockClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get stockClearAll;

  /// No description provided for @stockUpdatingQuantities.
  ///
  /// In en, this message translates to:
  /// **'Updating stock quantities...'**
  String get stockUpdatingQuantities;

  /// No description provided for @stockEditQuantitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Stock Quantities'**
  String get stockEditQuantitiesTitle;

  /// No description provided for @stockReportingDate.
  ///
  /// In en, this message translates to:
  /// **'Reporting Date: {date}'**
  String stockReportingDate(String date);

  /// No description provided for @stockTotalItemsHint.
  ///
  /// In en, this message translates to:
  /// **'Total items: {count} • Update quantities as needed'**
  String stockTotalItemsHint(String count);

  /// No description provided for @stockItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get stockItemName;

  /// No description provided for @stockBatchPrefix.
  ///
  /// In en, this message translates to:
  /// **'Batch: {batch}'**
  String stockBatchPrefix(String batch);

  /// No description provided for @stockDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get stockDeleteConfirmTitle;

  /// No description provided for @stockDeleteConfirmIntro.
  ///
  /// In en, this message translates to:
  /// **'You are about to permanently delete all stock items for the following date:'**
  String get stockDeleteConfirmIntro;

  /// No description provided for @stockDeleteConfirmWarning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All stock records for this date will be permanently deleted.'**
  String get stockDeleteConfirmWarning;

  /// No description provided for @stockNoInternetRetry.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your connection and try again.'**
  String get stockNoInternetRetry;

  /// No description provided for @itemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get itemsTitle;

  /// No description provided for @itemAddSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get itemAddSheetTitle;

  /// No description provided for @itemSingleAdd.
  ///
  /// In en, this message translates to:
  /// **'Single add'**
  String get itemSingleAdd;

  /// No description provided for @itemBulkAdd.
  ///
  /// In en, this message translates to:
  /// **'Bulk add'**
  String get itemBulkAdd;

  /// No description provided for @itemBulkAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk add items'**
  String get itemBulkAddTitle;

  /// No description provided for @itemEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get itemEditTitle;

  /// No description provided for @itemAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get itemAddTitle;

  /// No description provided for @itemCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Item'**
  String get itemCreateButton;

  /// No description provided for @itemUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update Item'**
  String get itemUpdateButton;

  /// No description provided for @itemDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Item'**
  String get itemDeleteTitle;

  /// No description provided for @itemDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String itemDeleteConfirm(String name);

  /// No description provided for @itemDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item deleted successfully'**
  String get itemDeletedSuccess;

  /// No description provided for @itemCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item created successfully'**
  String get itemCreatedSuccess;

  /// No description provided for @itemUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item updated successfully'**
  String get itemUpdatedSuccess;

  /// No description provided for @itemLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading items...'**
  String get itemLoading;

  /// No description provided for @itemErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get itemErrorTitle;

  /// No description provided for @itemTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get itemTryAgain;

  /// No description provided for @itemSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or SKU'**
  String get itemSearchHint;

  /// No description provided for @itemNoItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get itemNoItemsFound;

  /// No description provided for @itemTryAdjustSearch.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search terms'**
  String get itemTryAdjustSearch;

  /// No description provided for @itemNoItemsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No items available'**
  String get itemNoItemsAvailable;

  /// No description provided for @itemAddToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add items to get started'**
  String get itemAddToGetStarted;

  /// No description provided for @itemNoMoreItems.
  ///
  /// In en, this message translates to:
  /// **'No more items'**
  String get itemNoMoreItems;

  /// No description provided for @itemPurposeBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get itemPurposeBoth;

  /// No description provided for @itemPurposePurchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get itemPurposePurchases;

  /// No description provided for @itemTypeProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get itemTypeProduct;

  /// No description provided for @itemTypeService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get itemTypeService;

  /// No description provided for @itemTypeInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get itemTypeInventory;

  /// No description provided for @itemPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Item photo'**
  String get itemPhotoTitle;

  /// No description provided for @itemPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Click here to select or upload photos'**
  String get itemPhotoHint;

  /// No description provided for @itemPhotoFormats.
  ///
  /// In en, this message translates to:
  /// **'JPEG, PNG, GIF, or WebP · max 5MB'**
  String get itemPhotoFormats;

  /// No description provided for @itemAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get itemAddPhoto;

  /// No description provided for @itemPhotoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Photo library'**
  String get itemPhotoLibrary;

  /// No description provided for @itemPhotoLibraryHint.
  ///
  /// In en, this message translates to:
  /// **'Choose from your photos'**
  String get itemPhotoLibraryHint;

  /// No description provided for @itemTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get itemTakePhoto;

  /// No description provided for @itemUploadGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from gallery'**
  String get itemUploadGallery;

  /// No description provided for @itemUploadGalleryHint.
  ///
  /// In en, this message translates to:
  /// **'Browse files on this device'**
  String get itemUploadGalleryHint;

  /// No description provided for @itemTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get itemTypeLabel;

  /// No description provided for @itemTypeField.
  ///
  /// In en, this message translates to:
  /// **'Item type'**
  String get itemTypeField;

  /// No description provided for @itemNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemNameLabel;

  /// No description provided for @itemNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter item name'**
  String get itemNameHint;

  /// No description provided for @itemBarcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Barcode / QR Code'**
  String get itemBarcodeLabel;

  /// No description provided for @itemBarcodeField.
  ///
  /// In en, this message translates to:
  /// **'Barcode / QR code'**
  String get itemBarcodeField;

  /// No description provided for @itemBarcodeHint.
  ///
  /// In en, this message translates to:
  /// **'Scan from app bar or paste'**
  String get itemBarcodeHint;

  /// No description provided for @itemSkuLabel.
  ///
  /// In en, this message translates to:
  /// **'SKU (optional)'**
  String get itemSkuLabel;

  /// No description provided for @itemSkuField.
  ///
  /// In en, this message translates to:
  /// **'SKU'**
  String get itemSkuField;

  /// No description provided for @itemSkuHint.
  ///
  /// In en, this message translates to:
  /// **'Product code — optional'**
  String get itemSkuHint;

  /// No description provided for @itemPickerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search items by name or SKU…'**
  String get itemPickerSearchHint;

  /// No description provided for @itemRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get itemRateLabel;

  /// No description provided for @itemUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get itemUnitLabel;

  /// No description provided for @itemPurposeLabel.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get itemPurposeLabel;

  /// No description provided for @itemSelectUnit.
  ///
  /// In en, this message translates to:
  /// **'Select unit'**
  String get itemSelectUnit;

  /// No description provided for @itemSelectPurpose.
  ///
  /// In en, this message translates to:
  /// **'Select purpose'**
  String get itemSelectPurpose;

  /// No description provided for @itemSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get itemSelectCategory;

  /// No description provided for @itemSelectType.
  ///
  /// In en, this message translates to:
  /// **'Select type'**
  String get itemSelectType;

  /// No description provided for @itemSelectItemType.
  ///
  /// In en, this message translates to:
  /// **'Select item type'**
  String get itemSelectItemType;

  /// No description provided for @itemSearchUnits.
  ///
  /// In en, this message translates to:
  /// **'Search units…'**
  String get itemSearchUnits;

  /// No description provided for @itemSearchPurpose.
  ///
  /// In en, this message translates to:
  /// **'Search purpose…'**
  String get itemSearchPurpose;

  /// No description provided for @itemSearchCategories.
  ///
  /// In en, this message translates to:
  /// **'Search categories…'**
  String get itemSearchCategories;

  /// No description provided for @itemCreateCustomUnit.
  ///
  /// In en, this message translates to:
  /// **'Create custom unit'**
  String get itemCreateCustomUnit;

  /// No description provided for @itemUnitName.
  ///
  /// In en, this message translates to:
  /// **'Unit name'**
  String get itemUnitName;

  /// No description provided for @itemUnitNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Litre, Box, Piece'**
  String get itemUnitNameHint;

  /// No description provided for @itemValidationName.
  ///
  /// In en, this message translates to:
  /// **'Please enter item name'**
  String get itemValidationName;

  /// No description provided for @itemValidationRate.
  ///
  /// In en, this message translates to:
  /// **'Please enter rate'**
  String get itemValidationRate;

  /// No description provided for @itemValidationNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid number'**
  String get itemValidationNumber;

  /// No description provided for @itemSelectUnitRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a unit'**
  String get itemSelectUnitRequired;

  /// No description provided for @itemSelectPurposeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a purpose'**
  String get itemSelectPurposeRequired;

  /// No description provided for @itemSelectCategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get itemSelectCategoryRequired;

  /// No description provided for @itemImageMissing.
  ///
  /// In en, this message translates to:
  /// **'Image file is missing'**
  String get itemImageMissing;

  /// No description provided for @itemImageFormatError.
  ///
  /// In en, this message translates to:
  /// **'Use JPEG, PNG, GIF, or WebP'**
  String get itemImageFormatError;

  /// No description provided for @itemImageSizeError.
  ///
  /// In en, this message translates to:
  /// **'Image must be 5MB or smaller'**
  String get itemImageSizeError;

  /// No description provided for @itemScanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
  String get itemScanBarcode;

  /// No description provided for @posScanAlignHint.
  ///
  /// In en, this message translates to:
  /// **'Align barcode or QR within the frame'**
  String get posScanAlignHint;

  /// No description provided for @posScanKeepScanning.
  ///
  /// In en, this message translates to:
  /// **'Keep scanning to add more items'**
  String get posScanKeepScanning;

  /// No description provided for @posScanItemAdded.
  ///
  /// In en, this message translates to:
  /// **'Added {name} × {qty}'**
  String posScanItemAdded(String name, String qty);

  /// No description provided for @posScanItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'No item found for this code'**
  String get posScanItemNotFound;

  /// No description provided for @posScanCameraDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan barcodes'**
  String get posScanCameraDenied;

  /// No description provided for @posScanTorch.
  ///
  /// In en, this message translates to:
  /// **'Flashlight'**
  String get posScanTorch;

  /// No description provided for @posScanDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get posScanDone;

  /// No description provided for @btPrinterTitle.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth printer'**
  String get btPrinterTitle;

  /// No description provided for @btPrinterSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt printer'**
  String get btPrinterSettingsTitle;

  /// No description provided for @btPrinterPrintTitle.
  ///
  /// In en, this message translates to:
  /// **'Print receipt'**
  String get btPrinterPrintTitle;

  /// No description provided for @btPrinterBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth thermal printer'**
  String get btPrinterBluetooth;

  /// No description provided for @btPrinterPrintOn.
  ///
  /// In en, this message translates to:
  /// **'Print on {name}'**
  String btPrinterPrintOn(String name);

  /// No description provided for @btPrinterChooseAnother.
  ///
  /// In en, this message translates to:
  /// **'Choose another Bluetooth printer'**
  String get btPrinterChooseAnother;

  /// No description provided for @btPrinterSystem.
  ///
  /// In en, this message translates to:
  /// **'System printer / Save as PDF'**
  String get btPrinterSystem;

  /// No description provided for @btPrinterAirPrint.
  ///
  /// In en, this message translates to:
  /// **'AirPrint / Save as PDF'**
  String get btPrinterAirPrint;

  /// No description provided for @btPrinterPaper58.
  ///
  /// In en, this message translates to:
  /// **'58 mm'**
  String get btPrinterPaper58;

  /// No description provided for @btPrinterPaper80.
  ///
  /// In en, this message translates to:
  /// **'80 mm'**
  String get btPrinterPaper80;

  /// No description provided for @btPrinterPairHint.
  ///
  /// In en, this message translates to:
  /// **'Pair the printer in Bluetooth settings first, then select it here. Keep the printer on and in range.'**
  String get btPrinterPairHint;

  /// No description provided for @btPrinterUse.
  ///
  /// In en, this message translates to:
  /// **'Use printer'**
  String get btPrinterUse;

  /// No description provided for @btPrinterTest.
  ///
  /// In en, this message translates to:
  /// **'Test print'**
  String get btPrinterTest;

  /// No description provided for @btPrinterForget.
  ///
  /// In en, this message translates to:
  /// **'Forget printer'**
  String get btPrinterForget;

  /// No description provided for @btPrinterSelectOne.
  ///
  /// In en, this message translates to:
  /// **'Select a printer'**
  String get btPrinterSelectOne;

  /// No description provided for @btPrinterNonePaired.
  ///
  /// In en, this message translates to:
  /// **'No paired Bluetooth devices. Pair your receipt printer in system settings, then try again.'**
  String get btPrinterNonePaired;

  /// No description provided for @btPrinterBluetoothOff.
  ///
  /// In en, this message translates to:
  /// **'Turn on Bluetooth and try again.'**
  String get btPrinterBluetoothOff;

  /// No description provided for @btPrinterPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth permission is required to print receipts.'**
  String get btPrinterPermissionDenied;

  /// No description provided for @btPrinterConnectFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not connect to the printer. Make sure it is on and in range.'**
  String get btPrinterConnectFailed;

  /// No description provided for @btPrinterPrintFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not print to the Bluetooth printer.'**
  String get btPrinterPrintFailed;

  /// No description provided for @btPrinterPrintSent.
  ///
  /// In en, this message translates to:
  /// **'Receipt sent to the printer'**
  String get btPrinterPrintSent;

  /// No description provided for @btPrinterTestSent.
  ///
  /// In en, this message translates to:
  /// **'Test page sent to the printer'**
  String get btPrinterTestSent;

  /// No description provided for @btPrinterSystemFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open system printer options'**
  String get btPrinterSystemFailed;

  /// No description provided for @btPrinterOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get btPrinterOpenSettings;

  /// No description provided for @btPrinterNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not set — tap to choose a printer'**
  String get btPrinterNotConfigured;

  /// No description provided for @btPrinterIosHint.
  ///
  /// In en, this message translates to:
  /// **'Turn the printer on, grant Bluetooth permission, then select it.'**
  String get btPrinterIosHint;

  /// No description provided for @itemNameFromCatalog.
  ///
  /// In en, this message translates to:
  /// **'Name filled from catalog: {name}'**
  String itemNameFromCatalog(String name);

  /// No description provided for @itemBarcodePasteHint.
  ///
  /// In en, this message translates to:
  /// **'No product name found — code pasted as name. Edit if needed.'**
  String get itemBarcodePasteHint;

  /// No description provided for @itemBulkRefillTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refill previous input'**
  String get itemBulkRefillTooltip;

  /// No description provided for @itemBulkAddRow.
  ///
  /// In en, this message translates to:
  /// **'Add row'**
  String get itemBulkAddRow;

  /// No description provided for @itemBulkRowLabel.
  ///
  /// In en, this message translates to:
  /// **'Item {index}'**
  String itemBulkRowLabel(String index);

  /// No description provided for @itemBulkNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name required'**
  String get itemBulkNameRequired;

  /// No description provided for @itemBulkInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get itemBulkInvalidNumber;

  /// No description provided for @itemBulkCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating…'**
  String get itemBulkCreating;

  /// No description provided for @itemBulkCreateItems.
  ///
  /// In en, this message translates to:
  /// **'Create items'**
  String get itemBulkCreateItems;

  /// No description provided for @itemBulkCreatedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s) created'**
  String itemBulkCreatedCount(String count);

  /// No description provided for @itemBulkCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create items: {error}'**
  String itemBulkCreateFailed(String error);

  /// No description provided for @itemBulkNoDraft.
  ///
  /// In en, this message translates to:
  /// **'No saved draft found'**
  String get itemBulkNoDraft;

  /// No description provided for @itemBulkInvalidDraft.
  ///
  /// In en, this message translates to:
  /// **'Saved draft format is invalid'**
  String get itemBulkInvalidDraft;

  /// No description provided for @itemBulkDraftRestored.
  ///
  /// In en, this message translates to:
  /// **'Previous draft restored'**
  String get itemBulkDraftRestored;

  /// No description provided for @itemBulkDraftRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not restore saved draft'**
  String get itemBulkDraftRestoreFailed;

  /// No description provided for @itemBulkAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Add at least one item'**
  String get itemBulkAtLeastOne;

  /// No description provided for @itemBulkCategoriesLoading.
  ///
  /// In en, this message translates to:
  /// **'Categories are loading, please try again'**
  String get itemBulkCategoriesLoading;

  /// No description provided for @itemBulkLoadingCategories.
  ///
  /// In en, this message translates to:
  /// **'Loading categories…'**
  String get itemBulkLoadingCategories;

  /// No description provided for @inventoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Inventory Analytics'**
  String get inventoryTitle;

  /// No description provided for @inventorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time stock movement tracking'**
  String get inventorySubtitle;

  /// No description provided for @inventorySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search items...'**
  String get inventorySearchHint;

  /// No description provided for @inventorySold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get inventorySold;

  /// No description provided for @inventoryPurchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get inventoryPurchased;

  /// No description provided for @catNoCategories.
  ///
  /// In en, this message translates to:
  /// **'No categories. Tap + to create.'**
  String get catNoCategories;

  /// No description provided for @catLoadCategories.
  ///
  /// In en, this message translates to:
  /// **'Load categories'**
  String get catLoadCategories;

  /// No description provided for @catCreated.
  ///
  /// In en, this message translates to:
  /// **'Category created'**
  String get catCreated;

  /// No description provided for @catRenamed.
  ///
  /// In en, this message translates to:
  /// **'Category renamed'**
  String get catRenamed;

  /// No description provided for @catDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted'**
  String get catDeleted;

  /// No description provided for @catDeletedBulk.
  ///
  /// In en, this message translates to:
  /// **'{count} categories deleted'**
  String catDeletedBulk(int count);

  /// No description provided for @catNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get catNewTitle;

  /// No description provided for @catRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename category'**
  String get catRenameTitle;

  /// No description provided for @catNewName.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get catNewName;

  /// No description provided for @catRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get catRename;

  /// No description provided for @catDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get catDeleteTitle;

  /// No description provided for @catDeleteBulkTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete categories'**
  String get catDeleteBulkTitle;

  /// No description provided for @catDeleteBulkConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete {count, plural, =1{1 selected category} other{{count} selected categories}}?'**
  String catDeleteBulkConfirm(num count);

  /// No description provided for @catDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String catDeleteConfirm(String name);

  /// No description provided for @catDeleteLinkedHint.
  ///
  /// In en, this message translates to:
  /// **'Items are linked. Move them to another category before deleting.'**
  String get catDeleteLinkedHint;

  /// No description provided for @catForceDelete.
  ///
  /// In en, this message translates to:
  /// **'Force delete'**
  String get catForceDelete;

  /// No description provided for @catDeleteHasItemsMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" has {count, plural, =1{1 item} other{{count} items}}. Move them to another category before deleting.'**
  String catDeleteHasItemsMessage(String name, int count);

  /// No description provided for @catTransferItems.
  ///
  /// In en, this message translates to:
  /// **'Transfer items'**
  String get catTransferItems;

  /// No description provided for @catTransferItemsMoveMessage.
  ///
  /// In en, this message translates to:
  /// **'Move {count, plural, =1{1 item} other{{count} items}} to:'**
  String catTransferItemsMoveMessage(int count);

  /// No description provided for @catTransferAndDelete.
  ///
  /// In en, this message translates to:
  /// **'Transfer and delete'**
  String get catTransferAndDelete;

  /// No description provided for @catAddAnotherBeforeDelete.
  ///
  /// In en, this message translates to:
  /// **'Add another category before deleting this one.'**
  String get catAddAnotherBeforeDelete;

  /// No description provided for @catDeletedItemsTransferred.
  ///
  /// In en, this message translates to:
  /// **'Category deleted. {count, plural, =1{1 item} other{{count} items}} moved to {target}.'**
  String catDeletedItemsTransferred(int count, String target);

  /// No description provided for @catItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String catItemsCount(String count);

  /// No description provided for @contactFavoritesOnly.
  ///
  /// In en, this message translates to:
  /// **'Favorites only'**
  String get contactFavoritesOnly;

  /// No description provided for @contactShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all contacts'**
  String get contactShowAll;

  /// No description provided for @contactSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search name, phone, email…'**
  String get contactSearchHint;

  /// No description provided for @contactNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get contactNoConnection;

  /// No description provided for @contactCheckNetwork.
  ///
  /// In en, this message translates to:
  /// **'Check your network and try again.'**
  String get contactCheckNetwork;

  /// No description provided for @contactSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get contactSomethingWrong;

  /// No description provided for @contactNoContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get contactNoContacts;

  /// No description provided for @contactNoFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites match. Turn off the star filter or add favorites in a contact.'**
  String get contactNoFavorites;

  /// No description provided for @contactTrySearchOrAdd.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or tap + to add a contact.'**
  String get contactTrySearchOrAdd;

  /// No description provided for @contactEndOfList.
  ///
  /// In en, this message translates to:
  /// **'End of list'**
  String get contactEndOfList;

  /// No description provided for @contactNewTooltip.
  ///
  /// In en, this message translates to:
  /// **'New contact'**
  String get contactNewTooltip;

  /// No description provided for @contactLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading contacts…'**
  String get contactLoading;

  /// No description provided for @contactUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get contactUnknown;

  /// No description provided for @contactCallTooltip.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get contactCallTooltip;

  /// No description provided for @contactEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit contact'**
  String get contactEditTitle;

  /// No description provided for @contactNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New contact'**
  String get contactNewTitle;

  /// No description provided for @contactSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select contact'**
  String get contactSelectTitle;

  /// No description provided for @contactDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete contact?'**
  String get contactDeleteTitle;

  /// No description provided for @contactDeleteUndo.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get contactDeleteUndo;

  /// No description provided for @contactNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get contactNameRequired;

  /// No description provided for @contactNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get contactNameLabel;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'Contact name'**
  String get contactNameHint;

  /// No description provided for @contactPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+977-9841234567'**
  String get contactPhoneHint;

  /// No description provided for @contactEmailHint.
  ///
  /// In en, this message translates to:
  /// **'email@example.com'**
  String get contactEmailHint;

  /// No description provided for @contactCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. business, general, vip'**
  String get contactCategoryHint;

  /// No description provided for @contactCompanyHint.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get contactCompanyHint;

  /// No description provided for @contactFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get contactFavorite;

  /// No description provided for @contactCannotCall.
  ///
  /// In en, this message translates to:
  /// **'Cannot make calls on this device'**
  String get contactCannotCall;

  /// No description provided for @contactPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Contact permission was denied. You can enable it in Settings.'**
  String get contactPermissionDenied;

  /// No description provided for @contactPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Contact permission is required to import from phone'**
  String get contactPermissionRequired;

  /// No description provided for @contactImported.
  ///
  /// In en, this message translates to:
  /// **'Contact imported from phone'**
  String get contactImported;

  /// No description provided for @contactCreated.
  ///
  /// In en, this message translates to:
  /// **'Contact created'**
  String get contactCreated;

  /// No description provided for @contactUpdated.
  ///
  /// In en, this message translates to:
  /// **'Contact updated'**
  String get contactUpdated;

  /// No description provided for @contactDeleted.
  ///
  /// In en, this message translates to:
  /// **'Contact deleted'**
  String get contactDeleted;

  /// No description provided for @contactImportSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, phone, email, company'**
  String get contactImportSearchHint;

  /// No description provided for @contactImportNoResults.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get contactImportNoResults;

  /// No description provided for @checkoutMultiplePaymentHint.
  ///
  /// In en, this message translates to:
  /// **'Turn this ON, if customer pays via multiple payment mode.'**
  String get checkoutMultiplePaymentHint;

  /// No description provided for @checkoutFillRemainingBalance.
  ///
  /// In en, this message translates to:
  /// **'Fill remaining balance'**
  String get checkoutFillRemainingBalance;

  /// No description provided for @checkoutEnterAtLeastOnePayment.
  ///
  /// In en, this message translates to:
  /// **'Enter at least one payment amount'**
  String get checkoutEnterAtLeastOnePayment;

  /// No description provided for @checkoutPaymentsExceedTotal.
  ///
  /// In en, this message translates to:
  /// **'Total payments cannot exceed the grand total'**
  String get checkoutPaymentsExceedTotal;

  /// No description provided for @checkoutSentAs.
  ///
  /// In en, this message translates to:
  /// **'Sent as: {api}'**
  String checkoutSentAs(String api);

  /// No description provided for @paymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get paymentCard;

  /// No description provided for @paymentQr.
  ///
  /// In en, this message translates to:
  /// **'QR'**
  String get paymentQr;

  /// No description provided for @paymentBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get paymentBank;

  /// No description provided for @paymentTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get paymentTransfer;

  /// No description provided for @paymentBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get paymentBankTransfer;

  /// No description provided for @paymentSettlement.
  ///
  /// In en, this message translates to:
  /// **'Settlement'**
  String get paymentSettlement;

  /// No description provided for @paymentCheque.
  ///
  /// In en, this message translates to:
  /// **'Cheque'**
  String get paymentCheque;

  /// No description provided for @paymentDigital.
  ///
  /// In en, this message translates to:
  /// **'Digital'**
  String get paymentDigital;

  /// No description provided for @paymentDigitalQr.
  ///
  /// In en, this message translates to:
  /// **'Digital (QR)'**
  String get paymentDigitalQr;

  /// No description provided for @closeSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Closing Summary'**
  String get closeSummaryTitle;

  /// No description provided for @closeTabDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get closeTabDashboard;

  /// No description provided for @closeTabCredits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get closeTabCredits;

  /// No description provided for @closeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Closing Summary'**
  String get closeWelcome;

  /// No description provided for @closeSelectDateHint.
  ///
  /// In en, this message translates to:
  /// **'Select a date and tap refresh to load data'**
  String get closeSelectDateHint;

  /// No description provided for @closeLoadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Loading dashboard data...'**
  String get closeLoadingDashboard;

  /// No description provided for @closeDataDeleted.
  ///
  /// In en, this message translates to:
  /// **'Data deleted'**
  String get closeDataDeleted;

  /// No description provided for @closeErrorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String closeErrorPrefix(String message);

  /// No description provided for @closeExtraAmount.
  ///
  /// In en, this message translates to:
  /// **'Extra amount'**
  String get closeExtraAmount;

  /// No description provided for @closeExtraAmountDesc.
  ///
  /// In en, this message translates to:
  /// **'Additional cash or adjustments recorded for this closing day.'**
  String get closeExtraAmountDesc;

  /// No description provided for @closeLostAmount.
  ///
  /// In en, this message translates to:
  /// **'Lost amount'**
  String get closeLostAmount;

  /// No description provided for @closeLostAmountDesc.
  ///
  /// In en, this message translates to:
  /// **'Cash shortage or variance flagged for this period.'**
  String get closeLostAmountDesc;

  /// No description provided for @closeTapForDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap for details'**
  String get closeTapForDetails;

  /// No description provided for @closeAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Closing'**
  String get closeAmountLabel;

  /// No description provided for @closeAmountFormula.
  ///
  /// In en, this message translates to:
  /// **'Closing Amount Formula'**
  String get closeAmountFormula;

  /// No description provided for @closeFormulaExpression.
  ///
  /// In en, this message translates to:
  /// **'Cash Sales - Cash Expenses = Closing Amount'**
  String get closeFormulaExpression;

  /// No description provided for @closeCashSales.
  ///
  /// In en, this message translates to:
  /// **'Cash Sales'**
  String get closeCashSales;

  /// No description provided for @closeCashExpenses.
  ///
  /// In en, this message translates to:
  /// **'Cash Expenses'**
  String get closeCashExpenses;

  /// No description provided for @closeClosingAmount.
  ///
  /// In en, this message translates to:
  /// **'Closing Amount'**
  String get closeClosingAmount;

  /// No description provided for @closeWhatThisMeans.
  ///
  /// In en, this message translates to:
  /// **'What this means:'**
  String get closeWhatThisMeans;

  /// No description provided for @closeClosingMeaning.
  ///
  /// In en, this message translates to:
  /// **'This is the amount of cash that should be in your register/drawer at the end of the day. It represents all cash received minus all cash paid out.'**
  String get closeClosingMeaning;

  /// No description provided for @closeQuickStats.
  ///
  /// In en, this message translates to:
  /// **'Quick Stats'**
  String get closeQuickStats;

  /// No description provided for @closeTapCardHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a card for a short description'**
  String get closeTapCardHint;

  /// No description provided for @closeOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Opening Balance'**
  String get closeOpeningBalance;

  /// No description provided for @closeTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get closeTotalSales;

  /// No description provided for @closeQrAmount.
  ///
  /// In en, this message translates to:
  /// **'QR Amount'**
  String get closeQrAmount;

  /// No description provided for @closeCashAmount.
  ///
  /// In en, this message translates to:
  /// **'Cash Amount'**
  String get closeCashAmount;

  /// No description provided for @closeSalesDiscount.
  ///
  /// In en, this message translates to:
  /// **'Sales Discount'**
  String get closeSalesDiscount;

  /// No description provided for @closeCreditQr.
  ///
  /// In en, this message translates to:
  /// **'Credit QR'**
  String get closeCreditQr;

  /// No description provided for @closeCreditCash.
  ///
  /// In en, this message translates to:
  /// **'Credit Cash'**
  String get closeCreditCash;

  /// No description provided for @closeCreditDiscount.
  ///
  /// In en, this message translates to:
  /// **'Credit Discount'**
  String get closeCreditDiscount;

  /// No description provided for @closePayCashGetQr.
  ///
  /// In en, this message translates to:
  /// **'Pay Cash → Get QR'**
  String get closePayCashGetQr;

  /// No description provided for @closePayQrGetCash.
  ///
  /// In en, this message translates to:
  /// **'Pay Qr → Get Cash'**
  String get closePayQrGetCash;

  /// No description provided for @closePaymentMix.
  ///
  /// In en, this message translates to:
  /// **'Payment mix'**
  String get closePaymentMix;

  /// No description provided for @closePaymentMixHint.
  ///
  /// In en, this message translates to:
  /// **'Tap cash or digital · bar shows share of sales'**
  String get closePaymentMixHint;

  /// No description provided for @closeCashVsDigitalTooltip.
  ///
  /// In en, this message translates to:
  /// **'Cash vs digital share of sales'**
  String get closeCashVsDigitalTooltip;

  /// No description provided for @closeSalesShareDesc.
  ///
  /// In en, this message translates to:
  /// **'{label} made up {percent}% of total sales for this day.'**
  String closeSalesShareDesc(String label, String percent);

  /// No description provided for @closeSalesLabel.
  ///
  /// In en, this message translates to:
  /// **'{label} sales'**
  String closeSalesLabel(String label);

  /// No description provided for @closeNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions available'**
  String get closeNoTransactions;

  /// No description provided for @closeRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get closeRecentTransactions;

  /// No description provided for @closeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get closeViewAll;

  /// No description provided for @closeNoPurchases.
  ///
  /// In en, this message translates to:
  /// **'No purchases available'**
  String get closeNoPurchases;

  /// No description provided for @closeRecentPurchases.
  ///
  /// In en, this message translates to:
  /// **'Recent Purchases'**
  String get closeRecentPurchases;

  /// No description provided for @closeNoSalesDate.
  ///
  /// In en, this message translates to:
  /// **'No sales for this date'**
  String get closeNoSalesDate;

  /// No description provided for @closeNoSalesHint.
  ///
  /// In en, this message translates to:
  /// **'Sales will show here after they are recorded.'**
  String get closeNoSalesHint;

  /// No description provided for @closeRoomSales.
  ///
  /// In en, this message translates to:
  /// **'Room sales'**
  String get closeRoomSales;

  /// No description provided for @closeEmployeeSales.
  ///
  /// In en, this message translates to:
  /// **'Employee sales'**
  String get closeEmployeeSales;

  /// No description provided for @closeOtherSales.
  ///
  /// In en, this message translates to:
  /// **'Other sales'**
  String get closeOtherSales;

  /// No description provided for @closeSectionCount.
  ///
  /// In en, this message translates to:
  /// **'{title} ({count})'**
  String closeSectionCount(String title, String count);

  /// No description provided for @closeDiscountShort.
  ///
  /// In en, this message translates to:
  /// **'Disc: {amount}'**
  String closeDiscountShort(String amount);

  /// No description provided for @closePercentOff.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String closePercentOff(String percent);

  /// No description provided for @closePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get closePending;

  /// No description provided for @closeNoCreditPayments.
  ///
  /// In en, this message translates to:
  /// **'No Credit Payments'**
  String get closeNoCreditPayments;

  /// No description provided for @closeNoCreditHint.
  ///
  /// In en, this message translates to:
  /// **'Credit payments will appear here'**
  String get closeNoCreditHint;

  /// No description provided for @closeViewStatistics.
  ///
  /// In en, this message translates to:
  /// **'View Statistics'**
  String get closeViewStatistics;

  /// No description provided for @closeExportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get closeExportData;

  /// No description provided for @closeExportComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Export feature will be implemented here'**
  String get closeExportComingSoon;

  /// No description provided for @closeHintOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Cash position at the start of the selected day.'**
  String get closeHintOpeningBalance;

  /// No description provided for @closeHintTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Sum of all sales recorded for this date.'**
  String get closeHintTotalSales;

  /// No description provided for @closeHintQrAmount.
  ///
  /// In en, this message translates to:
  /// **'Payments received via QR or digital methods.'**
  String get closeHintQrAmount;

  /// No description provided for @closeHintCashAmount.
  ///
  /// In en, this message translates to:
  /// **'Cash portion of sales for the day.'**
  String get closeHintCashAmount;

  /// No description provided for @closeHintCashExpenses.
  ///
  /// In en, this message translates to:
  /// **'Cash paid out for expenses during the day.'**
  String get closeHintCashExpenses;

  /// No description provided for @closeHintSalesDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discounts applied to sales.'**
  String get closeHintSalesDiscount;

  /// No description provided for @closeHintCreditQr.
  ///
  /// In en, this message translates to:
  /// **'Credit-related QR collections.'**
  String get closeHintCreditQr;

  /// No description provided for @closeHintCreditCash.
  ///
  /// In en, this message translates to:
  /// **'Credit-related cash movements.'**
  String get closeHintCreditCash;

  /// No description provided for @closeHintCreditDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discounts applied on credit transactions.'**
  String get closeHintCreditDiscount;

  /// No description provided for @closeHintPayCashGetQr.
  ///
  /// In en, this message translates to:
  /// **'Exchange where cash was paid and QR credit received.'**
  String get closeHintPayCashGetQr;

  /// No description provided for @closeHintPayQrGetCash.
  ///
  /// In en, this message translates to:
  /// **'Exchange where QR was paid and cash was received.'**
  String get closeHintPayQrGetCash;

  /// No description provided for @closeOpeningAmount.
  ///
  /// In en, this message translates to:
  /// **'Opening Amount'**
  String get closeOpeningAmount;

  /// No description provided for @closeCurrentAmount.
  ///
  /// In en, this message translates to:
  /// **'Current Amount'**
  String get closeCurrentAmount;

  /// No description provided for @closeSaveReport.
  ///
  /// In en, this message translates to:
  /// **'Save Report'**
  String get closeSaveReport;

  /// No description provided for @closeUpdateSummary.
  ///
  /// In en, this message translates to:
  /// **'Update Summary'**
  String get closeUpdateSummary;

  /// No description provided for @closeExists.
  ///
  /// In en, this message translates to:
  /// **'Exists'**
  String get closeExists;

  /// No description provided for @closeExistingDataInfo.
  ///
  /// In en, this message translates to:
  /// **'You can view or modify existing data'**
  String get closeExistingDataInfo;

  /// No description provided for @closeEnterOpeningAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an opening amount'**
  String get closeEnterOpeningAmount;

  /// No description provided for @closeEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get closeEnterValidAmount;

  /// No description provided for @closeAmountCannotBeNegative.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot be negative'**
  String get closeAmountCannotBeNegative;

  /// No description provided for @googleDriveBackupSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Sync'**
  String get googleDriveBackupSectionTitle;

  /// No description provided for @googleDriveBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Drive Backup'**
  String get googleDriveBackupTitle;

  /// No description provided for @googleDriveBackupSubtitleSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Sign in to back up your organization data safely in Google Drive.'**
  String get googleDriveBackupSubtitleSignedOut;

  /// No description provided for @googleDriveBackupSubtitleSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String googleDriveBackupSubtitleSignedIn(String email);

  /// No description provided for @googleDriveSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get googleDriveSignIn;

  /// No description provided for @googleDriveSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get googleDriveSignOut;

  /// No description provided for @googleDriveBackupNow.
  ///
  /// In en, this message translates to:
  /// **'Backup now'**
  String get googleDriveBackupNow;

  /// No description provided for @googleDriveSignInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in to Google Drive'**
  String get googleDriveSignInSuccess;

  /// No description provided for @googleDriveSignOutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed out of Google Drive'**
  String get googleDriveSignOutSuccess;

  /// No description provided for @googleDriveSignInCancelled.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in was cancelled'**
  String get googleDriveSignInCancelled;

  /// No description provided for @googleDriveBackupStarting.
  ///
  /// In en, this message translates to:
  /// **'Preparing backup…'**
  String get googleDriveBackupStarting;

  /// No description provided for @googleDriveBackupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup uploaded ({tableCount} tables, {recordCount} records)'**
  String googleDriveBackupSuccess(int tableCount, int recordCount);

  /// No description provided for @googleDriveBackupPluginError.
  ///
  /// In en, this message translates to:
  /// **'Backup needs a full app restart. Stop the app, run it again, then retry.'**
  String get googleDriveBackupPluginError;

  /// No description provided for @googleDriveBackupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String googleDriveBackupFailed(String error);

  /// No description provided for @googleDriveLastBackup.
  ///
  /// In en, this message translates to:
  /// **'Last backup: {date}'**
  String googleDriveLastBackup(String date);

  /// No description provided for @backupSyncPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Sync'**
  String get backupSyncPageTitle;

  /// No description provided for @backupSyncGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'Google account'**
  String get backupSyncGoogleAccount;

  /// No description provided for @backupSyncSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as'**
  String get backupSyncSignedInAs;

  /// No description provided for @backupSyncSignInHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google to back up your organization data.'**
  String get backupSyncSignInHint;

  /// No description provided for @backupSyncLastSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Last sync'**
  String get backupSyncLastSyncTitle;

  /// No description provided for @backupSyncLastSyncDate.
  ///
  /// In en, this message translates to:
  /// **'Date & time'**
  String get backupSyncLastSyncDate;

  /// No description provided for @backupSyncNeverSynced.
  ///
  /// In en, this message translates to:
  /// **'No backup has been uploaded yet.'**
  String get backupSyncNeverSynced;

  /// No description provided for @backupSyncOrganization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get backupSyncOrganization;

  /// No description provided for @backupSyncTables.
  ///
  /// In en, this message translates to:
  /// **'Tables backed up'**
  String get backupSyncTables;

  /// No description provided for @backupSyncRecords.
  ///
  /// In en, this message translates to:
  /// **'Records backed up'**
  String get backupSyncRecords;

  /// No description provided for @backupSyncStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get backupSyncStatus;

  /// No description provided for @backupSyncStatusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get backupSyncStatusSuccess;

  /// No description provided for @backupSyncActiveOrganization.
  ///
  /// In en, this message translates to:
  /// **'Current organization'**
  String get backupSyncActiveOrganization;

  /// No description provided for @backupSyncActiveOrganizationHint.
  ///
  /// In en, this message translates to:
  /// **'Backup uploads data for the organization you are using now.'**
  String get backupSyncActiveOrganizationHint;

  /// No description provided for @backupSyncUnknownOrganization.
  ///
  /// In en, this message translates to:
  /// **'Current organization'**
  String get backupSyncUnknownOrganization;

  /// No description provided for @backupSyncInProgress.
  ///
  /// In en, this message translates to:
  /// **'Sync in progress'**
  String get backupSyncInProgress;

  /// No description provided for @backupSyncProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String backupSyncProgressPercent(int percent);

  /// No description provided for @backupSyncCurrentStep.
  ///
  /// In en, this message translates to:
  /// **'Step: {step}'**
  String backupSyncCurrentStep(String step);

  /// No description provided for @backupSyncStepExport.
  ///
  /// In en, this message translates to:
  /// **'Exporting local data'**
  String get backupSyncStepExport;

  /// No description provided for @backupSyncStepUploadTable.
  ///
  /// In en, this message translates to:
  /// **'Uploading {table}'**
  String backupSyncStepUploadTable(String table);

  /// No description provided for @backupSyncStepUploadFile.
  ///
  /// In en, this message translates to:
  /// **'Uploading {file}'**
  String backupSyncStepUploadFile(String file);

  /// No description provided for @backupSyncLastError.
  ///
  /// In en, this message translates to:
  /// **'Last error: {error}'**
  String backupSyncLastError(String error);

  /// No description provided for @backupSyncSignOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign out of Google Drive on this device?'**
  String get backupSyncSignOutConfirm;

  /// No description provided for @moreBackupSyncTileNeverSynced.
  ///
  /// In en, this message translates to:
  /// **'Back up to Google Drive'**
  String get moreBackupSyncTileNeverSynced;

  /// No description provided for @moreBackupSyncTileSignedInNoSync.
  ///
  /// In en, this message translates to:
  /// **'Signed in · No backup yet'**
  String get moreBackupSyncTileSignedInNoSync;

  /// No description provided for @backupSyncConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get backupSyncConnected;

  /// No description provided for @backupSyncCompletedHint.
  ///
  /// In en, this message translates to:
  /// **'Your data is safely backed up to Google Drive.'**
  String get backupSyncCompletedHint;

  /// No description provided for @backupSyncPhaseExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get backupSyncPhaseExport;

  /// No description provided for @backupSyncPhaseUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get backupSyncPhaseUpload;

  /// No description provided for @backupAutoSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'GOOGLE DRIVE SETTINGS'**
  String get backupAutoSettingsTitle;

  /// No description provided for @backupAutoBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto backup'**
  String get backupAutoBackupTitle;

  /// No description provided for @backupAutoBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Back up automatically on app start when due'**
  String get backupAutoBackupHint;

  /// No description provided for @backupWifiOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Back up over Wi‑Fi only'**
  String get backupWifiOnlyTitle;

  /// No description provided for @backupWifiOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'Auto backup waits for Wi‑Fi'**
  String get backupWifiOnlyHint;

  /// No description provided for @backupWifiOnlyContinue.
  ///
  /// In en, this message translates to:
  /// **'Use mobile data'**
  String get backupWifiOnlyContinue;

  /// No description provided for @backupAutoFrequencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup frequency'**
  String get backupAutoFrequencyTitle;

  /// No description provided for @backupAutoFrequencyOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get backupAutoFrequencyOff;

  /// No description provided for @backupAutoFrequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get backupAutoFrequencyDaily;

  /// No description provided for @backupAutoFrequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get backupAutoFrequencyWeekly;

  /// No description provided for @backupAutoFrequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get backupAutoFrequencyMonthly;

  /// No description provided for @backupAutoSyncDirectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto sync'**
  String get backupAutoSyncDirectionTitle;

  /// No description provided for @backupAutoDirectionUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload to cloud'**
  String get backupAutoDirectionUpload;

  /// No description provided for @backupAutoDirectionDownload.
  ///
  /// In en, this message translates to:
  /// **'Download from cloud'**
  String get backupAutoDirectionDownload;

  /// No description provided for @backupAutoDirectionBoth.
  ///
  /// In en, this message translates to:
  /// **'Upload & download'**
  String get backupAutoDirectionBoth;

  /// No description provided for @backupAutoLastUploaded.
  ///
  /// In en, this message translates to:
  /// **'Last auto backup: {detail}'**
  String backupAutoLastUploaded(String detail);

  /// No description provided for @backupAutoLastDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Last auto restore: {detail}'**
  String backupAutoLastDownloaded(String detail);

  /// No description provided for @backupAutoLastFailed.
  ///
  /// In en, this message translates to:
  /// **'Last auto sync failed: {detail}'**
  String backupAutoLastFailed(String detail);

  /// No description provided for @backupAutoLastSkipped.
  ///
  /// In en, this message translates to:
  /// **'Last auto sync skipped: {detail}'**
  String backupAutoLastSkipped(String detail);

  /// No description provided for @restoreAction.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreAction;

  /// No description provided for @restoreFromGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Restore from Google Drive'**
  String get restoreFromGoogleDrive;

  /// No description provided for @restoreFromGoogleDriveHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in and pick a backup to restore your organization on this device.'**
  String get restoreFromGoogleDriveHint;

  /// No description provided for @restoreFromGoogleDriveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Restore \"{name}\"? This replaces local data for that organization.'**
  String restoreFromGoogleDriveConfirm(String name);

  /// No description provided for @restoreFromGoogleDriveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restored {name}. You can sign in now.'**
  String restoreFromGoogleDriveSuccess(String name);

  /// No description provided for @restoreFromGoogleDriveFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String restoreFromGoogleDriveFailed(String error);

  /// No description provided for @restoreFromGoogleDriveEmpty.
  ///
  /// In en, this message translates to:
  /// **'No backups found in your Google Drive.'**
  String get restoreFromGoogleDriveEmpty;

  /// No description provided for @restoreFromGoogleDriveStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting restore…'**
  String get restoreFromGoogleDriveStarting;

  /// No description provided for @restoreStepDownload.
  ///
  /// In en, this message translates to:
  /// **'Downloading backup'**
  String get restoreStepDownload;

  /// No description provided for @restoreStepCreateDatabase.
  ///
  /// In en, this message translates to:
  /// **'Creating database'**
  String get restoreStepCreateDatabase;

  /// No description provided for @restoreStepImport.
  ///
  /// In en, this message translates to:
  /// **'Importing data'**
  String get restoreStepImport;

  /// No description provided for @restoreStepFinalize.
  ///
  /// In en, this message translates to:
  /// **'Finishing restore'**
  String get restoreStepFinalize;

  /// No description provided for @moreBackupSyncTileLastSync.
  ///
  /// In en, this message translates to:
  /// **'Last sync: {date}'**
  String moreBackupSyncTileLastSync(String date);

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @appLockTitle.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get appLockTitle;

  /// No description provided for @appLockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require PIN or biometrics when reopening the app'**
  String get appLockSubtitle;

  /// No description provided for @appPin.
  ///
  /// In en, this message translates to:
  /// **'App PIN'**
  String get appPin;

  /// No description provided for @appPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick unlock with a {length}-digit PIN'**
  String appPinSubtitle(int length);

  /// No description provided for @useBiometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics'**
  String get useBiometricUnlock;

  /// No description provided for @useBiometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint or face recognition after setting a PIN'**
  String get useBiometricUnlockSubtitle;

  /// No description provided for @changeAppPin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changeAppPin;

  /// No description provided for @verifyPinToChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter current PIN'**
  String get verifyPinToChangeTitle;

  /// No description provided for @verifyPinToChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your {length}-digit PIN before setting a new one'**
  String verifyPinToChangeSubtitle(int length);

  /// No description provided for @unlockWithBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Unlock with biometrics'**
  String get unlockWithBiometrics;

  /// No description provided for @setUpAppPin.
  ///
  /// In en, this message translates to:
  /// **'Set up PIN'**
  String get setUpAppPin;

  /// No description provided for @confirmAppPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmAppPin;

  /// No description provided for @enterAppPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get enterAppPin;

  /// No description provided for @enterPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter Passcode'**
  String get enterPasscode;

  /// No description provided for @tapDigitsToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Tap any {length} digits to unlock.'**
  String tapDigitsToUnlock(int length);

  /// No description provided for @createPasscodeHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a {length}-digit passcode for this organization'**
  String createPasscodeHint(int length);

  /// No description provided for @confirmPasscodeHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your passcode to confirm'**
  String get confirmPasscodeHint;

  /// No description provided for @createAppPinHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a {length}-digit PIN for this organization'**
  String createAppPinHint(int length);

  /// No description provided for @confirmAppPinHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your PIN to confirm'**
  String get confirmAppPinHint;

  /// No description provided for @appPinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match. Try again.'**
  String get appPinMismatch;

  /// No description provided for @appPinIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. Try again.'**
  String get appPinIncorrect;

  /// No description provided for @appPinIncorrectWithAttempts.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. You have {remaining} tries left.'**
  String appPinIncorrectWithAttempts(int remaining);

  /// No description provided for @appPinLockoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Too many incorrect PIN attempts. Sign in with your email and password to reset your PIN.'**
  String get appPinLockoutMessage;

  /// No description provided for @appPinSetSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN saved for this organization'**
  String get appPinSetSuccess;

  /// No description provided for @appPinRemoved.
  ///
  /// In en, this message translates to:
  /// **'App PIN removed'**
  String get appPinRemoved;

  /// No description provided for @appLockSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'App lock settings saved'**
  String get appLockSettingsSaved;

  /// No description provided for @biometricUnlockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock BizTrack'**
  String get biometricUnlockReason;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics are not available on this device'**
  String get biometricNotAvailable;

  /// No description provided for @biometricRequiresPin.
  ///
  /// In en, this message translates to:
  /// **'Set up an app PIN before enabling biometrics'**
  String get biometricRequiresPin;

  /// No description provided for @disableAppPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove app PIN?'**
  String get disableAppPinTitle;

  /// No description provided for @disableAppPinMessage.
  ///
  /// In en, this message translates to:
  /// **'Face ID / biometric unlock will also be turned off for this organization.'**
  String get disableAppPinMessage;

  /// No description provided for @verifyPinToRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get verifyPinToRemoveTitle;

  /// No description provided for @verifyPinToRemoveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your {length}-digit PIN to remove app lock'**
  String verifyPinToRemoveSubtitle(int length);

  /// No description provided for @unlockApp.
  ///
  /// In en, this message translates to:
  /// **'Unlock app'**
  String get unlockApp;

  /// No description provided for @usePinInstead.
  ///
  /// In en, this message translates to:
  /// **'Use PIN instead'**
  String get usePinInstead;

  /// No description provided for @useBiometricInstead.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics'**
  String get useBiometricInstead;

  /// No description provided for @signInWithFaceId.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Face ID'**
  String get signInWithFaceId;

  /// No description provided for @signInWithFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Sign in with fingerprint'**
  String get signInWithFingerprint;

  /// No description provided for @signInWithBiometric.
  ///
  /// In en, this message translates to:
  /// **'Sign in with biometrics'**
  String get signInWithBiometric;

  /// No description provided for @signInWithPin.
  ///
  /// In en, this message translates to:
  /// **'Sign in with PIN'**
  String get signInWithPin;

  /// No description provided for @setUpQuickUnlock.
  ///
  /// In en, this message translates to:
  /// **'Set up PIN quick sign-in'**
  String get setUpQuickUnlock;

  /// No description provided for @setUpFaceIdOrPin.
  ///
  /// In en, this message translates to:
  /// **'Set up Face ID or PIN'**
  String get setUpFaceIdOrPin;

  /// No description provided for @setUpFingerprintOrPin.
  ///
  /// In en, this message translates to:
  /// **'Set up fingerprint or PIN'**
  String get setUpFingerprintOrPin;

  /// No description provided for @setUpQuickUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your device biometrics or a PIN for this organization'**
  String get setUpQuickUnlockSubtitle;

  /// No description provided for @quickUnlockAsUser.
  ///
  /// In en, this message translates to:
  /// **'Quick sign-in as {email}'**
  String quickUnlockAsUser(String email);

  /// No description provided for @orContinueWithPassword.
  ///
  /// In en, this message translates to:
  /// **'or sign in with password'**
  String get orContinueWithPassword;

  /// No description provided for @setUpQuickUnlockAfterLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable quick sign-in?'**
  String get setUpQuickUnlockAfterLoginTitle;

  /// No description provided for @setUpQuickUnlockAfterLoginMessage.
  ///
  /// In en, this message translates to:
  /// **'Set up Face ID, fingerprint, or a PIN to sign in faster next time for this organization. You can also change this later in Settings.'**
  String get setUpQuickUnlockAfterLoginMessage;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @setUpNow.
  ///
  /// In en, this message translates to:
  /// **'Set up now'**
  String get setUpNow;

  /// No description provided for @enableFaceIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Face ID?'**
  String get enableFaceIdTitle;

  /// No description provided for @enableFingerprintTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable fingerprint?'**
  String get enableFingerprintTitle;

  /// No description provided for @enableBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable biometrics?'**
  String get enableBiometricTitle;

  /// No description provided for @enableBiometricAfterPinMessage.
  ///
  /// In en, this message translates to:
  /// **'Use your device biometrics together with your PIN for faster sign-in.'**
  String get enableBiometricAfterPinMessage;

  /// No description provided for @useFaceIdUnlock.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID'**
  String get useFaceIdUnlock;

  /// No description provided for @useFingerprintUnlock.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint'**
  String get useFingerprintUnlock;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @reportPeriodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get reportPeriodYear;

  /// No description provided for @reportPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get reportPeriodMonth;

  /// No description provided for @reportPeriodRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get reportPeriodRange;

  /// No description provided for @reportPeriodDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get reportPeriodDay;

  /// No description provided for @reportPeriodFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get reportPeriodFrom;

  /// No description provided for @reportPeriodTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get reportPeriodTo;

  /// No description provided for @reportPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get reportPeriod;

  /// No description provided for @reportAllPurchases.
  ///
  /// In en, this message translates to:
  /// **'All purchases'**
  String get reportAllPurchases;

  /// No description provided for @reportBeforeTax.
  ///
  /// In en, this message translates to:
  /// **'Before tax'**
  String get reportBeforeTax;

  /// No description provided for @reportRevenueRetained.
  ///
  /// In en, this message translates to:
  /// **'Revenue retained'**
  String get reportRevenueRetained;

  /// No description provided for @reportHideDetails.
  ///
  /// In en, this message translates to:
  /// **'Hide details'**
  String get reportHideDetails;

  /// No description provided for @reportShowDetails.
  ///
  /// In en, this message translates to:
  /// **'Show details'**
  String get reportShowDetails;

  /// No description provided for @reportSalesRevenue.
  ///
  /// In en, this message translates to:
  /// **'Sales revenue'**
  String get reportSalesRevenue;

  /// No description provided for @reportDiscountsGiven.
  ///
  /// In en, this message translates to:
  /// **'Discounts Given'**
  String get reportDiscountsGiven;

  /// No description provided for @reportNetRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net revenue'**
  String get reportNetRevenue;

  /// No description provided for @reportOperatingExpenses.
  ///
  /// In en, this message translates to:
  /// **'Operating expenses'**
  String get reportOperatingExpenses;

  /// No description provided for @reportTotalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total expenses'**
  String get reportTotalExpenses;

  /// No description provided for @reportGrossProfit.
  ///
  /// In en, this message translates to:
  /// **'Gross profit'**
  String get reportGrossProfit;

  /// No description provided for @reportGrossProfitChart.
  ///
  /// In en, this message translates to:
  /// **'Gross Profit'**
  String get reportGrossProfitChart;

  /// No description provided for @reportOperatingPlDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Tax, depreciation & payroll liabilities not yet accounted — operating-level P&L approximation.'**
  String get reportOperatingPlDisclaimer;

  /// No description provided for @reportContraLabel.
  ///
  /// In en, this message translates to:
  /// **'contra'**
  String get reportContraLabel;

  /// No description provided for @reportNoDataForPeriod.
  ///
  /// In en, this message translates to:
  /// **'No data for selected period'**
  String get reportNoDataForPeriod;

  /// No description provided for @reportRevenueVsExpenses.
  ///
  /// In en, this message translates to:
  /// **'Revenue vs Expenses'**
  String get reportRevenueVsExpenses;

  /// No description provided for @reportExpenseBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Expense Breakdown'**
  String get reportExpenseBreakdown;

  /// No description provided for @reportExpenseFallback.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get reportExpenseFallback;

  /// No description provided for @reportGrossMarginPercent.
  ///
  /// In en, this message translates to:
  /// **'Gross Margin %'**
  String get reportGrossMarginPercent;

  /// No description provided for @reportRoomVsFnB.
  ///
  /// In en, this message translates to:
  /// **'Room vs F&B'**
  String get reportRoomVsFnB;

  /// No description provided for @reportSegmentRoom.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get reportSegmentRoom;

  /// No description provided for @reportSegmentFnB.
  ///
  /// In en, this message translates to:
  /// **'F&B'**
  String get reportSegmentFnB;

  /// No description provided for @reportKeyMetrics.
  ///
  /// In en, this message translates to:
  /// **'Key Metrics'**
  String get reportKeyMetrics;

  /// No description provided for @reportIncomeStatement.
  ///
  /// In en, this message translates to:
  /// **'Income Statement'**
  String get reportIncomeStatement;

  /// No description provided for @reportChartsSection.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get reportChartsSection;

  /// No description provided for @reportSegmentSummary.
  ///
  /// In en, this message translates to:
  /// **'Segment Summary'**
  String get reportSegmentSummary;

  /// No description provided for @reportFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load report'**
  String get reportFailedToLoad;

  /// No description provided for @reportOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get reportOverview;

  /// No description provided for @reportOverviewCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get reportOverviewCash;

  /// No description provided for @reportOverviewBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get reportOverviewBank;

  /// No description provided for @reportMonthlyOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Monthly opening balance'**
  String get reportMonthlyOpeningBalance;

  /// No description provided for @reportOpeningBalanceHint.
  ///
  /// In en, this message translates to:
  /// **'Cash position at the start of each month'**
  String get reportOpeningBalanceHint;

  /// No description provided for @reportCashInOut.
  ///
  /// In en, this message translates to:
  /// **'Cash In / Out'**
  String get reportCashInOut;

  /// No description provided for @reportCashIn.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get reportCashIn;

  /// No description provided for @reportCashOut.
  ///
  /// In en, this message translates to:
  /// **'Cash Out'**
  String get reportCashOut;

  /// No description provided for @reportBankReceiptsPayments.
  ///
  /// In en, this message translates to:
  /// **'Bank Receipts / Payments'**
  String get reportBankReceiptsPayments;

  /// No description provided for @reportReceipts.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get reportReceipts;

  /// No description provided for @reportPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get reportPayments;

  /// No description provided for @reportDailyCashVsQr.
  ///
  /// In en, this message translates to:
  /// **'Daily Cash vs QR'**
  String get reportDailyCashVsQr;

  /// No description provided for @reportSummariesSection.
  ///
  /// In en, this message translates to:
  /// **'Summaries'**
  String get reportSummariesSection;

  /// No description provided for @reportCashSummary.
  ///
  /// In en, this message translates to:
  /// **'Cash summary'**
  String get reportCashSummary;

  /// No description provided for @reportBankSummary.
  ///
  /// In en, this message translates to:
  /// **'Bank summary'**
  String get reportBankSummary;

  /// No description provided for @reportDailySummary.
  ///
  /// In en, this message translates to:
  /// **'Daily summary'**
  String get reportDailySummary;

  /// No description provided for @reportTabPurchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get reportTabPurchase;

  /// No description provided for @reportTabSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get reportTabSales;

  /// No description provided for @reportTabDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get reportTabDashboard;

  /// No description provided for @reportSingleDayTrend.
  ///
  /// In en, this message translates to:
  /// **'Single day — daily trend'**
  String get reportSingleDayTrend;

  /// No description provided for @reportFullYearTrend.
  ///
  /// In en, this message translates to:
  /// **'Full year — monthly trend charts'**
  String get reportFullYearTrend;

  /// No description provided for @reportYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year {year}'**
  String reportYearLabel(String year);

  /// No description provided for @reportJanDec.
  ///
  /// In en, this message translates to:
  /// **'Jan – Dec {year}'**
  String reportJanDec(String year);

  /// No description provided for @reportTotalPurchases.
  ///
  /// In en, this message translates to:
  /// **'Total purchases'**
  String get reportTotalPurchases;

  /// No description provided for @reportTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Total sales'**
  String get reportTotalSales;

  /// No description provided for @reportTotalInvoices.
  ///
  /// In en, this message translates to:
  /// **'Total invoices'**
  String get reportTotalInvoices;

  /// No description provided for @reportUnpaidBalance.
  ///
  /// In en, this message translates to:
  /// **'Unpaid balance'**
  String get reportUnpaidBalance;

  /// No description provided for @reportAvgPerInvoice.
  ///
  /// In en, this message translates to:
  /// **'Avg per invoice'**
  String get reportAvgPerInvoice;

  /// No description provided for @reportPerTransaction.
  ///
  /// In en, this message translates to:
  /// **'Per transaction'**
  String get reportPerTransaction;

  /// No description provided for @reportMonthlySpend.
  ///
  /// In en, this message translates to:
  /// **'Monthly Spend ({symbol})'**
  String reportMonthlySpend(String symbol);

  /// No description provided for @reportMonthlySalesChart.
  ///
  /// In en, this message translates to:
  /// **'Monthly Sales ({symbol})'**
  String reportMonthlySalesChart(String symbol);

  /// No description provided for @reportInvoiceCountByMonth.
  ///
  /// In en, this message translates to:
  /// **'Invoice Count by Month'**
  String get reportInvoiceCountByMonth;

  /// No description provided for @reportTopItemsBySpend.
  ///
  /// In en, this message translates to:
  /// **'Top items by spend ({symbol})'**
  String reportTopItemsBySpend(String symbol);

  /// No description provided for @reportSpendByCategory.
  ///
  /// In en, this message translates to:
  /// **'Spend by category'**
  String get reportSpendByCategory;

  /// No description provided for @reportOtherCategory.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reportOtherCategory;

  /// No description provided for @reportSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get reportSuppliers;

  /// No description provided for @reportTableSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get reportTableSupplier;

  /// No description provided for @reportTableAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get reportTableAmount;

  /// No description provided for @reportTableBills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get reportTableBills;

  /// No description provided for @reportSalesTotal.
  ///
  /// In en, this message translates to:
  /// **'Sales total'**
  String get reportSalesTotal;

  /// No description provided for @reportPurchaseTotal.
  ///
  /// In en, this message translates to:
  /// **'Purchase total'**
  String get reportPurchaseTotal;

  /// No description provided for @reportPositiveMargin.
  ///
  /// In en, this message translates to:
  /// **'Positive margin'**
  String get reportPositiveMargin;

  /// No description provided for @reportNegativeMargin.
  ///
  /// In en, this message translates to:
  /// **'Negative margin'**
  String get reportNegativeMargin;

  /// No description provided for @reportGrossMargin.
  ///
  /// In en, this message translates to:
  /// **'Gross margin'**
  String get reportGrossMargin;

  /// No description provided for @reportOfTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Of total sales'**
  String get reportOfTotalSales;

  /// No description provided for @reportFailedToLoadAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Failed to load analytics'**
  String get reportFailedToLoadAnalytics;

  /// No description provided for @reportMarginKpi.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get reportMarginKpi;

  /// No description provided for @reportExpensesKpi.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get reportExpensesKpi;

  /// No description provided for @partyPickerNoResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String partyPickerNoResultsFor(String query);

  /// No description provided for @partyPickerNoPartiesForRole.
  ///
  /// In en, this message translates to:
  /// **'No {role} parties found'**
  String partyPickerNoPartiesForRole(String role);

  /// No description provided for @partyPickerLoadParties.
  ///
  /// In en, this message translates to:
  /// **'Load parties'**
  String get partyPickerLoadParties;

  /// No description provided for @invoiceCashCustomer.
  ///
  /// In en, this message translates to:
  /// **'Cash Customer'**
  String get invoiceCashCustomer;

  /// No description provided for @invoiceQuickAddItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick add items'**
  String get invoiceQuickAddItemsTitle;

  /// No description provided for @invoiceQuickLoadingMenu.
  ///
  /// In en, this message translates to:
  /// **'Loading menu…'**
  String get invoiceQuickLoadingMenu;

  /// No description provided for @invoiceQuickInvoiceCreated.
  ///
  /// In en, this message translates to:
  /// **'Invoice created'**
  String get invoiceQuickInvoiceCreated;

  /// No description provided for @invoiceQuickAddAtLeastOneItem.
  ///
  /// In en, this message translates to:
  /// **'Add at least one item'**
  String get invoiceQuickAddAtLeastOneItem;

  /// No description provided for @invoiceQuickNoResults.
  ///
  /// In en, this message translates to:
  /// **'No Result Found!'**
  String get invoiceQuickNoResults;

  /// No description provided for @invoiceQuickNoItemsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No items in this category'**
  String get invoiceQuickNoItemsInCategory;

  /// No description provided for @invoiceQuickNoItemsInCategorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first item here to start billing from this category.'**
  String get invoiceQuickNoItemsInCategorySubtitle;

  /// No description provided for @invoiceQuickNoResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check the spelling or try searching in a different category.'**
  String get invoiceQuickNoResultsSubtitle;

  /// No description provided for @invoiceQuickAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get invoiceQuickAddItem;

  /// No description provided for @invoiceQuickLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get invoiceQuickLoadMore;

  /// No description provided for @invoiceQuickScrollLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Scroll to load more ({count} per page)'**
  String invoiceQuickScrollLoadMore(int count);

  /// No description provided for @invoiceQuickSupplierEmployee.
  ///
  /// In en, this message translates to:
  /// **'Supplier / Employee'**
  String get invoiceQuickSupplierEmployee;

  /// No description provided for @invoiceQuickEditItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get invoiceQuickEditItem;

  /// No description provided for @invoiceQuickFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get invoiceQuickFavorites;

  /// No description provided for @invoiceQuickManageFavorites.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get invoiceQuickManageFavorites;

  /// No description provided for @invoiceQuickRepeated.
  ///
  /// In en, this message translates to:
  /// **'Repeated'**
  String get invoiceQuickRepeated;

  /// No description provided for @invoiceQuickRepeatedHint.
  ///
  /// In en, this message translates to:
  /// **'Items you sell most often'**
  String get invoiceQuickRepeatedHint;

  /// No description provided for @invoiceQuickAddFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get invoiceQuickAddFavorite;

  /// No description provided for @invoiceQuickRemoveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get invoiceQuickRemoveFavorite;

  /// No description provided for @invoiceQuickFavoriteAdded.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get invoiceQuickFavoriteAdded;

  /// No description provided for @invoiceQuickFavoriteRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get invoiceQuickFavoriteRemoved;

  /// No description provided for @invoiceQuickNoFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite items yet'**
  String get invoiceQuickNoFavorites;

  /// No description provided for @invoiceQuickNoFavoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the star on a dish you sell often so it shows up here.'**
  String get invoiceQuickNoFavoritesSubtitle;

  /// No description provided for @invoiceQuickNoRepeated.
  ///
  /// In en, this message translates to:
  /// **'No repeated sales yet'**
  String get invoiceQuickNoRepeated;

  /// No description provided for @invoiceQuickNoRepeatedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Items you sell more than once will appear here automatically.'**
  String get invoiceQuickNoRepeatedSubtitle;

  /// No description provided for @closeSelectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get closeSelectDateRange;

  /// No description provided for @closeStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get closeStartDate;

  /// No description provided for @closeEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get closeEndDate;

  /// No description provided for @closeSelectBothDates.
  ///
  /// In en, this message translates to:
  /// **'Please select both start and end dates'**
  String get closeSelectBothDates;

  /// No description provided for @closeDeleteSummary.
  ///
  /// In en, this message translates to:
  /// **'Delete Summary'**
  String get closeDeleteSummary;

  /// No description provided for @closeDeleteSummaryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this summary?'**
  String get closeDeleteSummaryConfirm;

  /// No description provided for @closeSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get closeSelectDate;

  /// No description provided for @closeNoDataToExport.
  ///
  /// In en, this message translates to:
  /// **'No data to export'**
  String get closeNoDataToExport;

  /// No description provided for @closeNoDataToShare.
  ///
  /// In en, this message translates to:
  /// **'No data to share'**
  String get closeNoDataToShare;

  /// No description provided for @closeNoDataToPrint.
  ///
  /// In en, this message translates to:
  /// **'No data to print'**
  String get closeNoDataToPrint;

  /// No description provided for @closePdfGenerateError.
  ///
  /// In en, this message translates to:
  /// **'Error generating PDF: {error}'**
  String closePdfGenerateError(String error);

  /// No description provided for @closePdfShareError.
  ///
  /// In en, this message translates to:
  /// **'Error sharing PDF: {error}'**
  String closePdfShareError(String error);

  /// No description provided for @closePdfPrintError.
  ///
  /// In en, this message translates to:
  /// **'Error printing PDF: {error}'**
  String closePdfPrintError(String error);

  /// No description provided for @closeExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get closeExportPdf;

  /// No description provided for @closeSharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get closeSharePdf;

  /// No description provided for @closePrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get closePrint;

  /// No description provided for @closeExportOptions.
  ///
  /// In en, this message translates to:
  /// **'Export Options'**
  String get closeExportOptions;

  /// No description provided for @closeExportPdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save or view as PDF document'**
  String get closeExportPdfSubtitle;

  /// No description provided for @closeSharePdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share via apps or email'**
  String get closeSharePdfSubtitle;

  /// No description provided for @closePrintSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Print the report'**
  String get closePrintSubtitle;

  /// No description provided for @closeDailyCashSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Cash Summary'**
  String get closeDailyCashSummaryTitle;

  /// No description provided for @closeDailyCashSummaryReport.
  ///
  /// In en, this message translates to:
  /// **'Daily Cash Summary Report'**
  String get closeDailyCashSummaryReport;

  /// No description provided for @closeGeneratedAt.
  ///
  /// In en, this message translates to:
  /// **'Generated: {date}'**
  String closeGeneratedAt(String date);

  /// No description provided for @closeTotalRecords.
  ///
  /// In en, this message translates to:
  /// **'Total Records'**
  String get closeTotalRecords;

  /// No description provided for @closeSummaryOverview.
  ///
  /// In en, this message translates to:
  /// **'Summary Overview'**
  String get closeSummaryOverview;

  /// No description provided for @closeAllRecords.
  ///
  /// In en, this message translates to:
  /// **'All Records'**
  String get closeAllRecords;

  /// No description provided for @closePeriodRange.
  ///
  /// In en, this message translates to:
  /// **'Period: {start} to {end}'**
  String closePeriodRange(String start, String end);

  /// No description provided for @closeDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get closeDetails;

  /// No description provided for @closePageN.
  ///
  /// In en, this message translates to:
  /// **'Page {n}'**
  String closePageN(int n);

  /// No description provided for @invoiceQuickShowingItems.
  ///
  /// In en, this message translates to:
  /// **'Showing {shown} of {total}'**
  String invoiceQuickShowingItems(int shown, int total);

  /// No description provided for @invoiceQuickLoadedItems.
  ///
  /// In en, this message translates to:
  /// **'Loaded: {count}'**
  String invoiceQuickLoadedItems(int count);

  /// No description provided for @invoiceQuickRoomCabinEmployee.
  ///
  /// In en, this message translates to:
  /// **'Room / Cabin / Employee'**
  String get invoiceQuickRoomCabinEmployee;

  /// No description provided for @reportPercentOfRevenue.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of revenue'**
  String reportPercentOfRevenue(String percent);

  /// No description provided for @reportParties.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get reportParties;

  /// No description provided for @reportMonthYearDailyTrend.
  ///
  /// In en, this message translates to:
  /// **'{month} {year} — daily trend charts'**
  String reportMonthYearDailyTrend(String month, String year);

  /// No description provided for @invoiceQuickCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get invoiceQuickCart;

  /// No description provided for @invoiceQuickCartWithCount.
  ///
  /// In en, this message translates to:
  /// **'Cart ({count})'**
  String invoiceQuickCartWithCount(int count);

  /// No description provided for @invoiceQuickClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get invoiceQuickClearSearch;

  /// No description provided for @organizationLogoHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload organization logo'**
  String get organizationLogoHint;

  /// No description provided for @employeeProfilePhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload profile photo'**
  String get employeeProfilePhotoHint;

  /// No description provided for @closeAddSummary.
  ///
  /// In en, this message translates to:
  /// **'Add Summary'**
  String get closeAddSummary;

  /// No description provided for @closeSalesAmount.
  ///
  /// In en, this message translates to:
  /// **'Sales Amount'**
  String get closeSalesAmount;

  /// No description provided for @closeClosingBalance.
  ///
  /// In en, this message translates to:
  /// **'Closing Balance'**
  String get closeClosingBalance;

  /// No description provided for @closeLostMoney.
  ///
  /// In en, this message translates to:
  /// **'Lost Money'**
  String get closeLostMoney;

  /// No description provided for @closeDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get closeDiscount;

  /// No description provided for @closeExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get closeExpenses;

  /// No description provided for @closeUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get closeUnpaid;

  /// No description provided for @closeTotalOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Opening Balance'**
  String get closeTotalOpeningBalance;

  /// No description provided for @closeTotalSalesAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Sales Amount'**
  String get closeTotalSalesAmount;

  /// No description provided for @closeTotalCashAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Cash Amount'**
  String get closeTotalCashAmount;

  /// No description provided for @closeTotalQrAmount.
  ///
  /// In en, this message translates to:
  /// **'Total QR Amount'**
  String get closeTotalQrAmount;

  /// No description provided for @closeTotalDiscount.
  ///
  /// In en, this message translates to:
  /// **'Total Discount'**
  String get closeTotalDiscount;

  /// No description provided for @closeTotalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get closeTotalExpenses;

  /// No description provided for @closeTotalClosingBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Closing Balance'**
  String get closeTotalClosingBalance;

  /// No description provided for @closeTotalLostMoney.
  ///
  /// In en, this message translates to:
  /// **'Total Lost Money'**
  String get closeTotalLostMoney;

  /// No description provided for @closeTotalExtraAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Extra Amount'**
  String get closeTotalExtraAmount;

  /// No description provided for @closeShowingCurrentMonth.
  ///
  /// In en, this message translates to:
  /// **'Showing current month data'**
  String get closeShowingCurrentMonth;

  /// No description provided for @closeNoSummariesFound.
  ///
  /// In en, this message translates to:
  /// **'No summaries found'**
  String get closeNoSummariesFound;

  /// No description provided for @closeNoSummariesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No summaries available'**
  String get closeNoSummariesAvailable;

  /// No description provided for @closeTryAdjustingDateRange.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your date range'**
  String get closeTryAdjustingDateRange;

  /// No description provided for @closeCreateFirstSummary.
  ///
  /// In en, this message translates to:
  /// **'Create your first summary to get started'**
  String get closeCreateFirstSummary;

  /// No description provided for @closeClearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear Filter'**
  String get closeClearFilter;

  /// No description provided for @closeFiltered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get closeFiltered;

  /// No description provided for @closeFilteredWithRange.
  ///
  /// In en, this message translates to:
  /// **'Filtered: {range}'**
  String closeFilteredWithRange(String range);

  /// No description provided for @closeSummarySingular.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get closeSummarySingular;

  /// No description provided for @closeSummariesPlural.
  ///
  /// In en, this message translates to:
  /// **'Summaries'**
  String get closeSummariesPlural;

  /// No description provided for @closeSummaryUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Summary updated successfully'**
  String get closeSummaryUpdatedSuccess;

  /// No description provided for @closeSummaryDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Summary deleted successfully'**
  String get closeSummaryDeletedSuccess;

  /// No description provided for @premiumUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock {appName} Premium'**
  String premiumUnlockTitle(String appName);

  /// No description provided for @premiumTagline.
  ///
  /// In en, this message translates to:
  /// **'Full offline POS, invoicing, inventory, and reports — one subscription for your business.'**
  String get premiumTagline;

  /// No description provided for @premiumFeatureUnlimitedInvoices.
  ///
  /// In en, this message translates to:
  /// **'Unlimited invoices & receipts'**
  String get premiumFeatureUnlimitedInvoices;

  /// No description provided for @premiumFeatureInventoryStock.
  ///
  /// In en, this message translates to:
  /// **'Inventory & stock tracking'**
  String get premiumFeatureInventoryStock;

  /// No description provided for @premiumFeatureReportsAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Sales reports & analytics'**
  String get premiumFeatureReportsAnalytics;

  /// No description provided for @premiumFeatureOfflineLocal.
  ///
  /// In en, this message translates to:
  /// **'Works offline — your data stays local'**
  String get premiumFeatureOfflineLocal;

  /// No description provided for @premiumContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Continue with {plan}'**
  String premiumContinueWith(String plan);

  /// No description provided for @premiumRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get premiumRestorePurchases;

  /// No description provided for @premiumRestorePreviousPurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore previous purchase'**
  String get premiumRestorePreviousPurchase;

  /// No description provided for @premiumPaywallSubscriptionLegal.
  ///
  /// In en, this message translates to:
  /// **'Payment is charged to your Apple ID or Google Play account at confirmation. Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period.'**
  String get premiumPaywallSubscriptionLegal;

  /// No description provided for @premiumPaywallLifetimeLegal.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase. Payment is charged to your Apple ID or Google Play account at confirmation. Lifetime access does not renew.'**
  String get premiumPaywallLifetimeLegal;

  /// No description provided for @premiumPaywallAgreePrefix.
  ///
  /// In en, this message translates to:
  /// **'By subscribing you agree to our '**
  String get premiumPaywallAgreePrefix;

  /// No description provided for @premiumPaywallAgreeConjunction.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get premiumPaywallAgreeConjunction;

  /// No description provided for @premiumPaywallTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get premiumPaywallTermsOfUse;

  /// No description provided for @premiumPaywallPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get premiumPaywallPrivacyPolicy;

  /// No description provided for @premiumSubscriptionLegal.
  ///
  /// In en, this message translates to:
  /// **'Payment charged to your Apple ID. Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period.'**
  String get premiumSubscriptionLegal;

  /// No description provided for @premiumPurchaseRestored.
  ///
  /// In en, this message translates to:
  /// **'Purchase restored.'**
  String get premiumPurchaseRestored;

  /// No description provided for @premiumNoActiveSubscription.
  ///
  /// In en, this message translates to:
  /// **'No active subscription found.'**
  String get premiumNoActiveSubscription;

  /// No description provided for @premiumPlanMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get premiumPlanMonthly;

  /// No description provided for @premiumPlanMonthlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Flexible — cancel anytime'**
  String get premiumPlanMonthlySubtitle;

  /// No description provided for @premiumPlanYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get premiumPlanYearly;

  /// No description provided for @premiumPlanYearlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Best value — save {percent}%'**
  String premiumPlanYearlySubtitle(int percent);

  /// No description provided for @premiumPlanLifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get premiumPlanLifetime;

  /// No description provided for @premiumPlanLifetimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay once, keep forever'**
  String get premiumPlanLifetimeSubtitle;

  /// No description provided for @premiumPlanPopular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get premiumPlanPopular;

  /// No description provided for @premiumOneTimePurchase.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase'**
  String get premiumOneTimePurchase;

  /// No description provided for @subscriptionSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscriptionSectionTitle;

  /// No description provided for @subscriptionPremiumLabel.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get subscriptionPremiumLabel;

  /// No description provided for @subscriptionUpgradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get subscriptionUpgradeTitle;

  /// No description provided for @subscriptionPremiumPricing.
  ///
  /// In en, this message translates to:
  /// **'Monthly {monthly} · Yearly {yearly}'**
  String subscriptionPremiumPricing(String monthly, String yearly);

  /// No description provided for @subscriptionPremiumActiveUntil.
  ///
  /// In en, this message translates to:
  /// **'{plan} active until {date}'**
  String subscriptionPremiumActiveUntil(String plan, String date);

  /// No description provided for @subscriptionPremiumActive.
  ///
  /// In en, this message translates to:
  /// **'{plan} active'**
  String subscriptionPremiumActive(String plan);

  /// No description provided for @premiumRequired.
  ///
  /// In en, this message translates to:
  /// **'Premium required'**
  String get premiumRequired;

  /// No description provided for @upgradeToPremiumContinue.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium to continue.'**
  String get upgradeToPremiumContinue;

  /// No description provided for @freemiumFreePlanLimit.
  ///
  /// In en, this message translates to:
  /// **'Free plan allows up to {limit} {label}. Upgrade to Premium for unlimited access.'**
  String freemiumFreePlanLimit(int limit, String label);

  /// No description provided for @freemiumPartyRoleRequired.
  ///
  /// In en, this message translates to:
  /// **'Party role is required.'**
  String get freemiumPartyRoleRequired;

  /// No description provided for @freemiumLabelSalesInvoices.
  ///
  /// In en, this message translates to:
  /// **'sales invoices'**
  String get freemiumLabelSalesInvoices;

  /// No description provided for @freemiumLabelPurchaseInvoices.
  ///
  /// In en, this message translates to:
  /// **'purchase invoices'**
  String get freemiumLabelPurchaseInvoices;

  /// No description provided for @freemiumLabelEmployees.
  ///
  /// In en, this message translates to:
  /// **'employees'**
  String get freemiumLabelEmployees;

  /// No description provided for @freemiumLabelItems.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get freemiumLabelItems;

  /// No description provided for @freemiumLabelCategories.
  ///
  /// In en, this message translates to:
  /// **'categories'**
  String get freemiumLabelCategories;

  /// No description provided for @freemiumLabelPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'payment methods'**
  String get freemiumLabelPaymentMethods;

  /// No description provided for @freemiumLabelCustomPartyRoles.
  ///
  /// In en, this message translates to:
  /// **'custom party roles'**
  String get freemiumLabelCustomPartyRoles;

  /// No description provided for @freemiumLabelPartiesForRole.
  ///
  /// In en, this message translates to:
  /// **'parties for {role}'**
  String freemiumLabelPartiesForRole(String role);

  /// No description provided for @freemiumLabelOrganizations.
  ///
  /// In en, this message translates to:
  /// **'organizations'**
  String get freemiumLabelOrganizations;

  /// No description provided for @freemiumPremiumReports.
  ///
  /// In en, this message translates to:
  /// **'Reports are available with Premium.'**
  String get freemiumPremiumReports;

  /// No description provided for @freemiumPremiumBackupSync.
  ///
  /// In en, this message translates to:
  /// **'Backup & sync requires Premium.'**
  String get freemiumPremiumBackupSync;

  /// No description provided for @freemiumPremiumPayroll.
  ///
  /// In en, this message translates to:
  /// **'Payroll requires Premium.'**
  String get freemiumPremiumPayroll;

  /// No description provided for @freemiumPremiumAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance requires Premium.'**
  String get freemiumPremiumAttendance;

  /// No description provided for @freemiumPremiumStock.
  ///
  /// In en, this message translates to:
  /// **'Stock management requires Premium.'**
  String get freemiumPremiumStock;

  /// No description provided for @freemiumPremiumInvoiceExport.
  ///
  /// In en, this message translates to:
  /// **'Download and print requires Premium.'**
  String get freemiumPremiumInvoiceExport;

  /// No description provided for @shiftReminderOpeningTitle.
  ///
  /// In en, this message translates to:
  /// **'Opening reminder'**
  String get shiftReminderOpeningTitle;

  /// No description provided for @shiftReminderOpeningMessage.
  ///
  /// In en, this message translates to:
  /// **'Did you open the register for today?'**
  String get shiftReminderOpeningMessage;

  /// No description provided for @shiftReminderOpeningProceed.
  ///
  /// In en, this message translates to:
  /// **'Yes, open now'**
  String get shiftReminderOpeningProceed;

  /// No description provided for @shiftReminderClosingTitle.
  ///
  /// In en, this message translates to:
  /// **'Closing reminder'**
  String get shiftReminderClosingTitle;

  /// No description provided for @shiftReminderClosingMessage.
  ///
  /// In en, this message translates to:
  /// **'Did you close the register for today?'**
  String get shiftReminderClosingMessage;

  /// No description provided for @shiftReminderClosingProceed.
  ///
  /// In en, this message translates to:
  /// **'Yes, close now'**
  String get shiftReminderClosingProceed;

  /// No description provided for @shiftReminderSkipToday.
  ///
  /// In en, this message translates to:
  /// **'Skip for today'**
  String get shiftReminderSkipToday;

  /// No description provided for @shiftReminderOpeningNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Opening reminder'**
  String get shiftReminderOpeningNotificationTitle;

  /// No description provided for @shiftReminderOpeningNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Did you open the register for today? Tap here if you still need to open.'**
  String get shiftReminderOpeningNotificationBody;

  /// No description provided for @shiftReminderClosingNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Closing reminder'**
  String get shiftReminderClosingNotificationTitle;

  /// No description provided for @shiftReminderClosingNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Did you close the register for today? Tap here if you still need to close.'**
  String get shiftReminderClosingNotificationBody;

  /// No description provided for @closeExchangePayQrGetCashHint.
  ///
  /// In en, this message translates to:
  /// **'{business} pays QR to the customer; the customer provides cash.'**
  String closeExchangePayQrGetCashHint(String business);

  /// No description provided for @closeExchangePayCashGetQrHint.
  ///
  /// In en, this message translates to:
  /// **'{business} pays cash to the customer; the customer provides QR payment.'**
  String closeExchangePayCashGetQrHint(String business);

  /// No description provided for @closePaymentExchange.
  ///
  /// In en, this message translates to:
  /// **'Payment exchange'**
  String get closePaymentExchange;

  /// No description provided for @closePayQrGetCashExchangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pay QR → Get cash exchange'**
  String get closePayQrGetCashExchangeLabel;

  /// No description provided for @closePayCashGetQrExchangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pay cash → Get QR exchange'**
  String get closePayCashGetQrExchangeLabel;

  /// No description provided for @closePayQrGetCashDetail.
  ///
  /// In en, this message translates to:
  /// **'Pay QR get cash'**
  String get closePayQrGetCashDetail;

  /// No description provided for @closePayCashGetQrDetail.
  ///
  /// In en, this message translates to:
  /// **'Pay cash get QR'**
  String get closePayCashGetQrDetail;

  /// No description provided for @faqSectionPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium & billing'**
  String get faqSectionPremium;

  /// No description provided for @faqPremiumWhatsIncludedQuestion.
  ///
  /// In en, this message translates to:
  /// **'What does Premium include?'**
  String get faqPremiumWhatsIncludedQuestion;

  /// No description provided for @faqPremiumWhatsIncludedAnswer.
  ///
  /// In en, this message translates to:
  /// **'Premium unlocks unlimited invoices, full reports (P&L, statement, analytics), backup & sync, payroll, attendance, stock tools, invoice export/print, and additional organizations. The free tier still lets you use core POS features within fair limits.'**
  String get faqPremiumWhatsIncludedAnswer;

  /// No description provided for @faqPremiumFreeTierQuestion.
  ///
  /// In en, this message translates to:
  /// **'What is included in the free tier?'**
  String get faqPremiumFreeTierQuestion;

  /// No description provided for @faqPremiumFreeTierAnswer.
  ///
  /// In en, this message translates to:
  /// **'You can create up to 10 sales and 10 purchase invoices, 4 employees, 30 items, and other limits shown when you reach them. Opening, closing, calculator, and browsing your data stay free.'**
  String get faqPremiumFreeTierAnswer;

  /// No description provided for @faqPremiumRestoreQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I restore my purchase?'**
  String get faqPremiumRestoreQuestion;

  /// No description provided for @faqPremiumRestoreAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open More → Upgrade to Premium (or the paywall) and tap Restore purchases. Use the same Apple ID you used to subscribe.'**
  String get faqPremiumRestoreAnswer;

  /// No description provided for @faqPremiumCancelQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel my subscription?'**
  String get faqPremiumCancelQuestion;

  /// No description provided for @faqPremiumCancelAnswer.
  ///
  /// In en, this message translates to:
  /// **'Manage or cancel in iPhone Settings → Apple ID → Subscriptions. You keep access until the end of the paid period.'**
  String get faqPremiumCancelAnswer;

  /// No description provided for @faqDarkModeQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I turn on dark mode?'**
  String get faqDarkModeQuestion;

  /// No description provided for @faqDarkModeAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open More → Appearance and enable Dark mode. When your device uses system theme, the app follows it automatically.'**
  String get faqDarkModeAnswer;

  /// No description provided for @faqOpeningClosingReminderQuestion.
  ///
  /// In en, this message translates to:
  /// **'What are opening and closing reminders?'**
  String get faqOpeningClosingReminderQuestion;

  /// No description provided for @faqOpeningClosingReminderAnswer.
  ///
  /// In en, this message translates to:
  /// **'{appName} can remind you to open or close the daily cash register. You can proceed, skip for today, or dismiss the reminder.'**
  String faqOpeningClosingReminderAnswer(String appName);

  /// No description provided for @faqPartyRolesQuestion.
  ///
  /// In en, this message translates to:
  /// **'What are party roles?'**
  String get faqPartyRolesQuestion;

  /// No description provided for @faqPartyRolesAnswer.
  ///
  /// In en, this message translates to:
  /// **'Party roles classify contacts such as customers, suppliers, rooms, or employees. Customize roles under Operations → Party roles and add a short description for your team.'**
  String get faqPartyRolesAnswer;

  /// No description provided for @faqRateAppQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I rate {appName}?'**
  String faqRateAppQuestion(String appName);

  /// No description provided for @faqRateAppAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open More → Rate us to leave a review on the App Store. Your feedback helps us improve offline billing for your business.'**
  String get faqRateAppAnswer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bn',
        'de',
        'en',
        'es',
        'fa',
        'fil',
        'fr',
        'hi',
        'id',
        'it',
        'ja',
        'ko',
        'ms',
        'ne',
        'nl',
        'pl',
        'pt',
        'ru',
        'sw',
        'th',
        'tr',
        'ur',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'ne':
      return AppLocalizationsNe();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
