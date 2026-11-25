import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel/src/core/di/injection.config.dart';
import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/features/contact_book/data/datasources/contact_remote_data_source.dart';
import 'package:hotel/src/features/contact_book/data/repositories/contact_repository_impl.dart';
import 'package:hotel/src/features/contact_book/domain/repositories/contact_repository.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/create_contact_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/delete_contact_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/get_contact_by_id_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/get_contacts_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/update_contact_use_case.dart';
import 'package:hotel/src/features/contact_book/presentation/cubit/contact_cubit.dart';
import 'package:hotel/src/features/opening/data/datasources/opening_remote_data_source.dart';
import 'package:hotel/src/features/opening/data/repositories/opening_repository_impl.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';
import 'package:hotel/src/features/opening/domain/usecases/close_register_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/delete_register_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/get_registers_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/migrate_cash_register_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/open_register_use_case.dart';
import 'package:hotel/src/features/invoice/data/datasources/accounting_settings_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_remote_data_source.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/invoice_return_cubit.dart';
import 'package:hotel/src/features/opening/presentation/cubit/opening_cubit.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/payroll/data/repositories/payroll_repository_impl.dart';
import 'package:hotel/src/features/payroll/domain/repositories/payroll_repository.dart';
import 'package:hotel/src/features/role/data/datasources/roles_local_data_source.dart';
import 'package:hotel/src/features/role/data/datasources/roles_remote_data_source.dart';
import 'package:hotel/src/features/role/data/repositories/roles_repository_impl.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';
import 'package:hotel/src/features/role/presentation/cubit/role_manage_cubit.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/themes/app_theme_mode_service.dart';
import 'package:hotel/src/core/services/app_rating/app_rating_service.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/billing/subscription_entitlement_storage.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';
import 'package:hotel/src/core/services/notifications/shift_notification_service.dart';
import 'package:hotel/src/core/services/notifications/shift_reminder_monitor.dart';
import 'package:hotel/src/features/backup/data/google_drive_api_client.dart';
import 'package:hotel/src/features/backup/data/google_drive_auth_service.dart';
import 'package:hotel/src/features/backup/domain/auto_backup_coordinator.dart';
import 'package:hotel/src/features/backup/domain/books_delta_exporter.dart';
import 'package:hotel/src/features/backup/domain/books_data_exporter.dart';
import 'package:hotel/src/features/backup/domain/books_data_importer.dart';
import 'package:hotel/src/features/backup/domain/google_drive_backup_service.dart';
import 'package:hotel/src/features/backup/domain/google_drive_restore_service.dart';
import 'package:hotel/src/features/org/domain/tax_settings_service.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  getIt.init();
  if (!getIt.isRegistered<AppLocaleService>()) {
    getIt.registerLazySingleton<AppLocaleService>(AppLocaleService.new);
  }
  if (!getIt.isRegistered<AppThemeModeService>()) {
    getIt.registerLazySingleton<AppThemeModeService>(AppThemeModeService.new);
  }
  if (!getIt.isRegistered<LiveStockTrackingService>()) {
    getIt.registerLazySingleton<LiveStockTrackingService>(
      () => LiveStockTrackingService(getIt<LocalDb>()),
    );
  }
  if (!getIt.isRegistered<BankAccountService>()) {
    getIt.registerLazySingleton<BankAccountService>(
      () => BankAccountService(getIt<LocalDb>()),
    );
  }
  if (!getIt.isRegistered<LoggedInProfileStore>()) {
    getIt.registerLazySingleton<LoggedInProfileStore>(LoggedInProfileStore.new);
  }
  if (!getIt.isRegistered<AppRatingService>()) {
    getIt.registerLazySingleton<AppRatingService>(AppRatingService.new);
  }
  if (!getIt.isRegistered<ShiftNotificationService>()) {
    getIt.registerLazySingleton<ShiftNotificationService>(ShiftNotificationService.new);
  }
  if (!getIt.isRegistered<ShiftReminderMonitor>()) {
    getIt.registerLazySingleton<ShiftReminderMonitor>(ShiftReminderMonitor.new);
  }
  if (!getIt.isRegistered<SubscriptionEntitlementStorage>()) {
    getIt.registerLazySingleton<SubscriptionEntitlementStorage>(
      SubscriptionEntitlementStorage.new,
    );
  }
  if (!getIt.isRegistered<SubscriptionService>()) {
    getIt.registerLazySingleton<SubscriptionService>(
      () => SubscriptionService(getIt<SubscriptionEntitlementStorage>()),
    );
  }
  if (!getIt.isRegistered<FreemiumGateService>()) {
    getIt.registerLazySingleton<FreemiumGateService>(
      () => FreemiumGateService(
        getIt<LocalDb>(),
        getIt<SubscriptionService>(),
      ),
    );
  }
  if (!getIt.isRegistered<TaxSettingsService>()) {
    getIt.registerLazySingleton<TaxSettingsService>(
      () => TaxSettingsService(getIt<LocalDb>()),
    );
  }

  ensureLoyaltyProgramServiceRegistered();
  _registerContactBookIfMissing();
  _registerOpeningIfMissing();
  _registerInvoiceReturnIfMissing();
  _registerPayrollRepositoryIfMissing();
  _registerRolesIfMissing();
  _registerGoogleDriveBackupIfMissing();
}

/// Safe to call after hot reload when [configureInjection] did not re-run.
void ensureLoyaltyProgramServiceRegistered() {
  if (!getIt.isRegistered<LoyaltyProgramService>()) {
    getIt.registerLazySingleton<LoyaltyProgramService>(
      () => LoyaltyProgramService(getIt<LocalDb>()),
    );
  }
}

void _registerGoogleDriveBackupIfMissing() {
  if (!getIt.isRegistered<GoogleDriveAuthService>()) {
    getIt.registerLazySingleton<GoogleDriveAuthService>(GoogleDriveAuthService.new);
  }
  if (!getIt.isRegistered<GoogleDriveApiClient>()) {
    getIt.registerLazySingleton<GoogleDriveApiClient>(
      () => GoogleDriveApiClient(getIt<GoogleDriveAuthService>()),
    );
  }
  if (!getIt.isRegistered<BooksDataExporter>()) {
    getIt.registerLazySingleton<BooksDataExporter>(
      () => BooksDataExporter(getIt<LocalDb>()),
    );
  }
  if (!getIt.isRegistered<BooksDeltaExporter>()) {
    getIt.registerLazySingleton<BooksDeltaExporter>(
      () => BooksDeltaExporter(getIt<LocalDb>(), getIt<BooksDataExporter>()),
    );
  }
  if (!getIt.isRegistered<BooksDataImporter>()) {
    getIt.registerLazySingleton<BooksDataImporter>(
      () => BooksDataImporter(getIt<LocalDb>()),
    );
  }
  if (getIt.isRegistered<GoogleDriveBackupService>()) {
    getIt.unregister<GoogleDriveBackupService>();
  }
  getIt.registerLazySingleton<GoogleDriveBackupService>(
    () => GoogleDriveBackupService(
      getIt<GoogleDriveAuthService>(),
      getIt<BooksDataExporter>(),
      getIt<BooksDeltaExporter>(),
      getIt<GoogleDriveApiClient>(),
      getIt<LocalDb>(),
    ),
  );
  if (!getIt.isRegistered<GoogleDriveRestoreService>()) {
    getIt.registerLazySingleton<GoogleDriveRestoreService>(
      () => GoogleDriveRestoreService(
        getIt<GoogleDriveAuthService>(),
        getIt<GoogleDriveApiClient>(),
        getIt<BooksDataImporter>(),
        getIt<LocalDb>(),
      ),
    );
  }
  if (!getIt.isRegistered<AutoBackupCoordinator>()) {
    getIt.registerLazySingleton<AutoBackupCoordinator>(
      () => AutoBackupCoordinator(
        getIt<GoogleDriveBackupService>(),
        getIt<GoogleDriveRestoreService>(),
        getIt<GoogleDriveAuthService>(),
        getIt<GoogleDriveApiClient>(),
        getIt<InternetInfo>(),
        getIt<LocalDb>(),
      ),
    );
  }
}

/// Party roles CRUD uses local SQLite ([Role] table).
void _registerRolesIfMissing() {
  if (!getIt.isRegistered<RolesRemoteDataSource>()) {
    getIt.registerLazySingleton<RolesRemoteDataSource>(
      () => RolesLocalDataSource(getIt<LocalDb>()),
    );
  }
  if (getIt.isRegistered<RolesRepository>()) {
    getIt.unregister<RolesRepository>();
  }
  getIt.registerLazySingleton<RolesRepository>(
    () => RolesRepositoryImpl(getIt<RolesRemoteDataSource>()),
  );
  if (!getIt.isRegistered<RoleManageCubit>()) {
    getIt.registerFactory<RoleManageCubit>(
      () => RoleManageCubit(getIt<RolesRepository>()),
    );
  }
}

/// Ensures payroll reads from local SQLite ([LocalDb]), not the remote API.
void _registerPayrollRepositoryIfMissing() {
  if (getIt.isRegistered<PayrollRepository>()) {
    getIt.unregister<PayrollRepository>();
  }
  getIt.registerLazySingleton<PayrollRepository>(
    () => PayrollRepositoryImpl(getIt<LocalDb>()),
  );
}

/// Contact book is annotated for injectable but may be absent from
/// [injection.config.dart] until codegen is run; register manually when needed.
void _registerContactBookIfMissing() {
  if (getIt.isRegistered<ContactCubit>()) return;

  if (!getIt.isRegistered<ContactRemoteDataSource>()) {
    getIt.registerLazySingleton<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImpl(
        getIt<Dio>(instanceName: 'authenticated'),
      ),
    );
  }
  if (!getIt.isRegistered<ContactRepository>()) {
    getIt.registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImpl(
        getIt<ContactRemoteDataSource>(),
      ),
    );
  }
  if (!getIt.isRegistered<GetContactsUseCase>()) {
    getIt.registerLazySingleton<GetContactsUseCase>(
      () => GetContactsUseCase(getIt<ContactRepository>()),
    );
  }
  if (!getIt.isRegistered<GetContactByIdUseCase>()) {
    getIt.registerLazySingleton<GetContactByIdUseCase>(
      () => GetContactByIdUseCase(getIt<ContactRepository>()),
    );
  }
  if (!getIt.isRegistered<CreateContactUseCase>()) {
    getIt.registerLazySingleton<CreateContactUseCase>(
      () => CreateContactUseCase(getIt<ContactRepository>()),
    );
  }
  if (!getIt.isRegistered<UpdateContactUseCase>()) {
    getIt.registerLazySingleton<UpdateContactUseCase>(
      () => UpdateContactUseCase(getIt<ContactRepository>()),
    );
  }
  if (!getIt.isRegistered<DeleteContactUseCase>()) {
    getIt.registerLazySingleton<DeleteContactUseCase>(
      () => DeleteContactUseCase(getIt<ContactRepository>()),
    );
  }
  getIt.registerFactory<ContactCubit>(
    () => ContactCubit(
      getIt<GetContactsUseCase>(),
      getIt<GetContactByIdUseCase>(),
      getIt<CreateContactUseCase>(),
      getIt<UpdateContactUseCase>(),
      getIt<DeleteContactUseCase>(),
    ),
  );
}

/// [injection.config.dart] registers [OpeningRemoteDataSource] only; wire the rest.
void _registerOpeningIfMissing() {
  if (getIt.isRegistered<OpeningCubit>()) return;

  if (!getIt.isRegistered<OpeningRemoteDataSource>()) {
    getIt.registerLazySingleton<OpeningRemoteDataSource>(
      () => OpeningRemoteDataSourceImpl(
        getIt<Dio>(instanceName: 'authenticated'),
      ),
    );
  }
  if (!getIt.isRegistered<OpeningRepository>()) {
    getIt.registerLazySingleton<OpeningRepository>(
      () => OpeningRepositoryImpl(
        getIt<OpeningRemoteDataSource>(),
        getIt<InternetInfo>(),
      ),
    );
  }
  if (!getIt.isRegistered<OpenRegisterUseCase>()) {
    getIt.registerLazySingleton<OpenRegisterUseCase>(
      () => OpenRegisterUseCase(getIt<OpeningRepository>()),
    );
  }
  if (!getIt.isRegistered<GetRegistersUseCase>()) {
    getIt.registerLazySingleton<GetRegistersUseCase>(
      () => GetRegistersUseCase(getIt<OpeningRepository>()),
    );
  }
  if (!getIt.isRegistered<CloseRegisterUseCase>()) {
    getIt.registerLazySingleton<CloseRegisterUseCase>(
      () => CloseRegisterUseCase(getIt<OpeningRepository>()),
    );
  }
  if (!getIt.isRegistered<DeleteRegisterUseCase>()) {
    getIt.registerLazySingleton<DeleteRegisterUseCase>(
      () => DeleteRegisterUseCase(getIt<OpeningRepository>()),
    );
  }
  if (!getIt.isRegistered<MigrateCashRegisterUseCase>()) {
    getIt.registerLazySingleton<MigrateCashRegisterUseCase>(
      () => MigrateCashRegisterUseCase(getIt<OpeningRepository>()),
    );
  }
  getIt.registerFactory<OpeningCubit>(
    () => OpeningCubit(
      getIt<OpenRegisterUseCase>(),
      getIt<GetRegistersUseCase>(),
      getIt<CloseRegisterUseCase>(),
      getIt<DeleteRegisterUseCase>(),
      getIt<MigrateCashRegisterUseCase>(),
    ),
  );
}

void _registerInvoiceReturnIfMissing() {
  if (getIt.isRegistered<InvoiceReturnCubit>()) return;

  if (!getIt.isRegistered<AccountingSettingsRemoteDataSource>()) {
    getIt.registerLazySingleton<AccountingSettingsRemoteDataSource>(
      () => AccountingSettingsRemoteDataSourceImpl(getIt<Dio>(instanceName: 'authenticated')),
    );
  }
  if (!getIt.isRegistered<InvoiceReturnRemoteDataSource>()) {
    getIt.registerLazySingleton<InvoiceReturnRemoteDataSource>(
      () => InvoiceReturnRemoteDataSourceImpl(getIt<Dio>(instanceName: 'authenticated')),
    );
  }
  if (!getIt.isRegistered<AccountingSettingsCubit>()) {
    getIt.registerLazySingleton<AccountingSettingsCubit>(
      () => AccountingSettingsCubit(getIt<AccountingSettingsRemoteDataSource>()),
    );
  }
  getIt.registerFactory<InvoiceReturnCubit>(
    () => InvoiceReturnCubit(getIt<InvoiceReturnRemoteDataSource>()),
  );
}
