import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/other/data/datasources/other_remote_data_source.dart';
import 'package:hotel/src/features/other/data/models/item_counter_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtherRemoteDataSource)
class OtherLocalDataSource implements OtherRemoteDataSource {
  OtherLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<ApiResponse<ItemCounterResponseModel>> getItemCounter(
      ItemCounterRequestParams params) async {
    try {
      final rows = await _db.rawQuery('''
        SELECT i.name as item,
          COALESCE((SELECT SUM(CAST(quantity AS REAL)) FROM SalesInvoiceItem WHERE item = i.name), 0) as total_sold,
          COALESCE((SELECT SUM(CAST(quantity AS REAL)) FROM PurchaseInvoiceItem WHERE item = i.name), 0) as total_purchased
        FROM Item i
        ORDER BY total_sold DESC
        LIMIT 50
      ''');
      final counts = rows.map((r) => ItemCount(
        item: r['item'] as String,
        totalSold: (_d(r['total_sold'])).toInt(),
        totalPurchased: (_d(r['total_purchased'])).toInt(),
      )).toList();
      return ApiResponse(
        data: ItemCounterResponseModel(itemCounts: counts),
        message: 'Item counts fetched',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  double _d(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}
