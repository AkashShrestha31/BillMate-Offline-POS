import 'package:hotel/src/core/config/app_freemium_config.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/payment_methods/data/datasources/payment_methods_remote_data_source.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_request.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentMethodsRemoteDataSource)
class PaymentMethodsLocalDataSource implements PaymentMethodsRemoteDataSource {
  PaymentMethodsLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<PaymentMethodsResponse> getPaymentMethods(PaymentMethodsQuery query) async {
    try {
      if (getIt.isRegistered<BankAccountService>()) {
        await getIt<BankAccountService>().listBanks();
      }
      final rows = await _db.query('PaymentMethod', orderBy: 'name ASC');
      final methods = rows.map(_rowToItem).toList();
      return PaymentMethodsResponse(success: true, count: methods.length, data: methods);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PaymentMethodItem> getPaymentMethod(String name) async {
    try {
      final rows = await _db.query('PaymentMethod', where: 'name = ?', whereArgs: [name]);
      if (rows.isEmpty) throw AppException(message: 'Payment method not found');
      return _rowToItem(rows.first);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PaymentMethodItem> createPaymentMethod(PaymentMethodRequest request) async {
    try {
      if (!AppFreemiumConfig.isFreePaymentMethod(request.name)) {
        await getIt<FreemiumGateService>().assertCan(
          FreemiumFeature.paymentMethod,
        );
      }
      final type = request.type.trim().toLowerCase();
      if (type != 'cash' && (request.account == null || request.account!.trim().isEmpty)) {
        throw const AppException(message: 'Select a bank for this payment method');
      }
      final now = DateTime.now().toIso8601String();
      await _db.upsert('PaymentMethod', {
        'name': request.name,
        'type': request.type,
        'account': request.account,
        'createdBy': '',
        'modifiedBy': '',
        'created': now,
        'modified': now,
      });
      return PaymentMethodItem(name: request.name, type: request.type, account: request.account);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PaymentMethodItem> updatePaymentMethod({
    required String name,
    required PaymentMethodRequest request,
  }) async {
    try {
      final db = await _db.database;
      await db.update('PaymentMethod', {
        if (request.type != null) 'type': request.type,
        if (request.account != null) 'account': request.account,
        'modified': DateTime.now().toIso8601String(),
      }, where: 'name = ?', whereArgs: [name]);
      return PaymentMethodItem(name: name, type: request.type ?? '', account: request.account);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> deletePaymentMethod(String name) async {
    try {
      final db = await _db.database;
      await db.delete('PaymentMethod', where: 'name = ?', whereArgs: [name]);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  PaymentMethodItem _rowToItem(Map<String, dynamic> r) => PaymentMethodItem(
    name: r['name'] as String,
    type: r['type'] as String? ?? '',
    account: r['account'] as String?,
  );
}
