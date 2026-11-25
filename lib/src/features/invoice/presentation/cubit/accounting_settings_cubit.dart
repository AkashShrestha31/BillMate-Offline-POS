import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/features/invoice/data/datasources/accounting_settings_remote_data_source.dart';
import 'package:injectable/injectable.dart';

/// `null` until first fetch completes — UI must treat only `true` as enabled.
@injectable
class AccountingSettingsCubit extends Cubit<bool?> {
  AccountingSettingsCubit(this._dataSource) : super(null);

  final AccountingSettingsRemoteDataSource _dataSource;
  Future<void>? _loadFuture;

  /// Idempotent; safe to call from invoice screen [initState].
  Future<void> loadIfNeeded() {
    _loadFuture ??= _fetch();
    return _loadFuture!;
  }

  /// Clears cached fetch so the next [loadIfNeeded] reads fresh DB values.
  Future<void> reload() {
    _loadFuture = null;
    return loadIfNeeded();
  }

  Future<void> _fetch() async {
    try {
      final settings = await _dataSource.fetchSettings();
      emit(settings.enableInvoiceReturns);
    } catch (_) {
      emit(false);
    }
  }
}
