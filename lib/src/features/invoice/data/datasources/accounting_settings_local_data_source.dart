import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/invoice/data/datasources/accounting_settings_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/models/response/accounting_settings_model.dart';
import 'package:hotel/src/features/setup/domain/default_books_single_values.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AccountingSettingsRemoteDataSource)
class AccountingSettingsLocalDataSource
    implements AccountingSettingsRemoteDataSource {
  AccountingSettingsLocalDataSource({LocalDb? db}) : _db = db ?? getIt<LocalDb>();

  final LocalDb _db;

  @override
  Future<AccountingSettingsModel> fetchSettings() async {
    try {
      final db = await _db.database;
      final enableInvoiceReturns = await DefaultBooksSingleValues.readBool(
        db,
        parent: 'AccountingSettings',
        fieldname: 'enableInvoiceReturns',
        defaultValue: true,
      );
      return AccountingSettingsModel(
        enableInvoiceReturns: enableInvoiceReturns,
      );
    } catch (_) {
      return const AccountingSettingsModel(enableInvoiceReturns: true);
    }
  }
}
