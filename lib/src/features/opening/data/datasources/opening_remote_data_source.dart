import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/opening/data/models/request/close_register_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_movement_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/data/models/request/open_register_request.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_list_response.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_movement_model.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/data/models/response/denomination_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class OpeningRemoteDataSource {
  Future<void> migrate();
  Future<CashRegisterModel> openRegister({required OpenRegisterRequest request});
  Future<CashRegisterListResponse> getRegisters({CashRegisterQueryParams? params});
  Future<CashRegisterModel> closeRegister({required CloseRegisterRequest request});
  Future<void> deleteRegister({required int registerId});
  Future<CashMovementModel> recordCashMovement({required CashMovementRequest request});
}

// @LazySingleton(as: OpeningRemoteDataSource) - local datasource is used for offline-first mode.
class OpeningRemoteDataSourceImpl implements OpeningRemoteDataSource {
  OpeningRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> migrate() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.cashRegisterMigrate}',
        options: options,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        final raw = response.data;
        final message = raw is Map<String, dynamic>
            ? (raw['message'] ?? raw['detail'])?.toString()
            : null;
        throw AppException(
          message: message ?? 'Migration failed',
        );
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CashRegisterModel> openRegister({required OpenRegisterRequest request}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.cashRegister}',
        options: options,
        data: request.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data != null && data['register'] != null) {
          return CashRegisterModel.fromJson(
            data['register'] as Map<String, dynamic>,
          );
        }
        throw const AppException(message: 'Invalid open register response');
      }
      final raw = response.data;
      final message = raw is Map<String, dynamic>
          ? (raw['message'] ?? raw['detail'])?.toString()
          : null;
      throw AppException(
        message: message ?? 'Failed to open register',
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CashRegisterListResponse> getRegisters({CashRegisterQueryParams? params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final raw = params?.toJson() ?? <String, dynamic>{};
      final queryParams = Map<String, dynamic>.fromEntries(
        raw.entries.where((e) => e.value != null),
      );
      final response = await _dio.get<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.cashRegister}',
        options: options,
        queryParameters: queryParams,
      );
      if (response.statusCode == 200 && response.data != null) {
        return CashRegisterListResponse.fromJson(response.data!);
      }
      final errData = response.data;
      final message = errData is Map<String, dynamic>
          ? (errData['message'] ?? errData['detail'])?.toString()
          : null;
      throw AppException(
        message: message ?? 'Failed to fetch registers',
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CashRegisterModel> closeRegister({required CloseRegisterRequest request}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.cashRegister}',
        options: options,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['register'] != null) {
          return CashRegisterModel.fromJson(
            data['register'] as Map<String, dynamic>,
          );
        }
        throw const AppException(message: 'Invalid close register response');
      }
      final raw = response.data;
      final message = raw is Map<String, dynamic>
          ? (raw['message'] ?? raw['detail'])?.toString()
          : null;
      throw AppException(
        message: message ?? 'Failed to close register',
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteRegister({required int registerId}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.cashRegister}',
        options: options,
        queryParameters: {'register_id': registerId},
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        final raw = response.data;
        final message = raw is Map<String, dynamic>
            ? (raw['message'] ?? raw['detail'])?.toString()
            : null;
        throw AppException(
          message: message ?? 'Failed to delete register',
        );
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CashMovementModel> recordCashMovement({required CashMovementRequest request}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.cashMovement}',
        options: options,
        data: request.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data != null && data['movement'] != null) {
          return CashMovementModel.fromJson(
            data['movement'] as Map<String, dynamic>,
          );
        }
        throw const AppException(message: 'Invalid cash movement response');
      }
      final raw = response.data;
      final message = raw is Map<String, dynamic>
          ? (raw['message'] ?? raw['detail'])?.toString()
          : null;
      throw AppException(
        message: message ?? 'Failed to record cash movement',
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}

@LazySingleton(as: OpeningRemoteDataSource)
class OpeningLocalDataSourceImpl implements OpeningRemoteDataSource {
  OpeningLocalDataSourceImpl(this._db);

  final LocalDb _db;

  @override
  Future<void> migrate() async {
    // Local DB already contains required register tables for this app build.
    return;
  }

  @override
  Future<CashRegisterModel> openRegister({required OpenRegisterRequest request}) async {
    final db = await _db.database;
    final now = DateTime.now();
    final openingTime = '${request.shiftDate}T${_hhmmss(now)}';

    // Backend rule: only one counter per date
    final existing = await db.rawQuery(
      "SELECT id, name, status, opening_time FROM CashRegister WHERE date(opening_time) = date(?) LIMIT 1",
      [request.shiftDate],
    );
    if (existing.isNotEmpty) {
      throw AppException(message: 'A counter already exists for date ${request.shiftDate}');
    }

    int registerId = 0;
    await db.transaction((txn) async {
      registerId = await txn.insert(
        'CashRegister',
        {
          'name': request.registerName,
          'status': 'open',
          'opening_time': openingTime,
          'opening_amount': request.openingAmount,
          'total_sales': 0.0,
          'total_cash_in': 0.0,
          'total_cash_out': 0.0,
          'opening_note': request.openingNote ?? '',
          'opened_by': request.openedBy,
          'created': now.toIso8601String(),
          'modified': now.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      for (final d in request.denominations ?? const []) {
        if (d.quantity <= 0) continue;
        await txn.insert('RegisterOpeningDetail', {
          'register_id': registerId,
          'denomination': d.denomination,
          'quantity': d.quantity,
          'amount': d.denomination * d.quantity,
          'type': d.type,
          'created': now.toIso8601String(),
        });
      }
    });

    return _loadRegisterById(registerId);
  }

  @override
  Future<CashRegisterListResponse> getRegisters({CashRegisterQueryParams? params}) async {
    final db = await _db.database;
    final where = <String>[];
    final args = <dynamic>[];

    if (params?.registerId != null) {
      where.add('id = ?');
      args.add(params!.registerId);
    }
    if (params?.registerName != null && params!.registerName!.trim().isNotEmpty) {
      where.add('name = ?');
      args.add(params.registerName!.trim());
    }
    if (params?.shiftDate != null && params!.shiftDate!.trim().isNotEmpty) {
      where.add('date(opening_time) = date(?)');
      args.add(params.shiftDate!.trim());
    }
    if (params?.status != null && params!.status!.trim().isNotEmpty) {
      where.add('status = ?');
      args.add(params.status!.trim());
    }
    if (params?.dateFrom != null && params!.dateFrom!.trim().isNotEmpty) {
      where.add('date(opening_time) >= date(?)');
      args.add(params.dateFrom!.trim());
    }
    if (params?.dateTo != null && params!.dateTo!.trim().isNotEmpty) {
      where.add('date(opening_time) <= date(?)');
      args.add(params.dateTo!.trim());
    }

    final whereClause = where.isEmpty ? '' : 'WHERE ${where.join(' AND ')}';
    final rows = await db.rawQuery(
      'SELECT * FROM CashRegister $whereClause ORDER BY datetime(created) DESC',
      args,
    );

    final registers = <CashRegisterModel>[];
    for (final row in rows) {
      registers.add(await _mapRegisterRow(row));
    }

    return CashRegisterListResponse(
      success: true,
      count: registers.length,
      registers: registers,
      register: registers.isNotEmpty ? registers.first : null,
      message: null,
    );
  }

  @override
  Future<CashRegisterModel> closeRegister({required CloseRegisterRequest request}) async {
    if (request.closingAmount <= 0) {
      throw const AppException(message: 'closing_amount must be greater than 0');
    }

    final db = await _db.database;
    final now = DateTime.now();
    final closingTime = '${request.shiftDate}T${_hhmmss(now)}';

    await db.transaction((txn) async {
      final rows = await txn.rawQuery(
        '''
        SELECT id, name, status, opening_amount, total_sales, total_cash_in, total_cash_out, opening_time
        FROM CashRegister
        WHERE id = ?
        ''',
        [request.registerId],
      );
      if (rows.isEmpty) {
        throw AppException(message: 'Register with ID ${request.registerId} not found');
      }
      final row = rows.first;
      if ((row['status'] ?? '').toString() != 'open') {
        throw const AppException(message: 'Register is already closed');
      }

      final openingDate = ((row['opening_time'] ?? '').toString()).split('T').first;
      if (openingDate != request.shiftDate) {
        throw AppException(
          message:
              'Date mismatch. This counter was opened for $openingDate, but you are trying to close it for ${request.shiftDate}',
        );
      }

      final openingAmount = _toDouble(row['opening_amount']);
      final totalSales = _toDouble(row['total_sales']);
      final totalCashIn = _toDouble(row['total_cash_in']);
      final totalCashOut = _toDouble(row['total_cash_out']);
      final expectedAmount = openingAmount + totalSales + totalCashIn - totalCashOut;
      final difference = request.closingAmount - expectedAmount;

      double totalCalculated = 0;
      for (final d in request.denominations ?? const []) {
        final amount = d.denomination * d.quantity;
        totalCalculated += amount;
        if (d.quantity <= 0) continue;
        await txn.insert('RegisterClosingDetail', {
          'register_id': request.registerId,
          'denomination': d.denomination,
          'quantity': d.quantity,
          'amount': amount,
          'type': d.type,
          'created': now.toIso8601String(),
        });
      }

      if ((request.denominations ?? const []).isNotEmpty &&
          (totalCalculated - request.closingAmount).abs() > 0.01) {
        throw AppException(
          message:
              'Closing amount mismatch. Entered: ${request.closingAmount}, Calculated: $totalCalculated',
        );
      }

      await txn.update(
        'CashRegister',
        {
          'status': 'closed',
          'closing_time': closingTime,
          'closing_amount': request.closingAmount,
          'expected_amount': expectedAmount,
          'difference': difference,
          'closing_note': request.closingNote ?? '',
          'closed_by': request.closedBy,
          'modified': now.toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [request.registerId],
      );
    });

    return _loadRegisterById(request.registerId);
  }

  @override
  Future<void> deleteRegister({required int registerId}) async {
    final db = await _db.database;
    await db.transaction((txn) async {
      final rows = await txn.rawQuery(
        'SELECT id, status FROM CashRegister WHERE id = ?',
        [registerId],
      );
      if (rows.isEmpty) {
        throw AppException(message: 'Register with ID $registerId not found');
      }
      if ((rows.first['status'] ?? '').toString() == 'open') {
        throw const AppException(message: 'Cannot delete an open register. Please close it first.');
      }
      await txn.delete('CashRegister', where: 'id = ?', whereArgs: [registerId]);
    });
  }

  @override
  Future<CashMovementModel> recordCashMovement({required CashMovementRequest request}) async {
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    int movementId = 0;

    await db.transaction((txn) async {
      final reg = await txn.rawQuery(
        'SELECT id, status FROM CashRegister WHERE id = ?',
        [request.registerId],
      );
      if (reg.isEmpty) {
        throw AppException(message: 'Register with ID ${request.registerId} not found');
      }
      if ((reg.first['status'] ?? '').toString() != 'open') {
        throw const AppException(message: 'Cash movement is only allowed on open registers');
      }

      movementId = await txn.insert('CashMovement', {
        'register_id': request.registerId,
        'movement_type': request.movementType,
        'amount': request.amount,
        'reason': request.reason ?? '',
        'reference_id': request.referenceId ?? '',
        'created_by': request.createdBy,
        'created': now,
      });

      final movement = request.movementType.trim().toLowerCase();
      if (movement == 'cash_in') {
        await txn.rawUpdate(
          'UPDATE CashRegister SET total_cash_in = COALESCE(total_cash_in, 0) + ?, modified = ? WHERE id = ?',
          [request.amount, now, request.registerId],
        );
      } else if (movement == 'cash_out') {
        await txn.rawUpdate(
          'UPDATE CashRegister SET total_cash_out = COALESCE(total_cash_out, 0) + ?, modified = ? WHERE id = ?',
          [request.amount, now, request.registerId],
        );
      } else if (movement == 'sale' || movement == 'sales') {
        await txn.rawUpdate(
          'UPDATE CashRegister SET total_sales = COALESCE(total_sales, 0) + ?, modified = ? WHERE id = ?',
          [request.amount, now, request.registerId],
        );
      }
    });

    return CashMovementModel(
      id: movementId,
      registerId: request.registerId,
      movementType: request.movementType,
      amount: request.amount,
      reason: request.reason,
      referenceId: request.referenceId,
      createdBy: request.createdBy,
      created: now,
    );
  }

  Future<CashRegisterModel> _loadRegisterById(int id) async {
    final db = await _db.database;
    final rows = await db.query('CashRegister', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) throw AppException(message: 'Register with ID $id not found');
    return _mapRegisterRow(rows.first);
  }

  Future<CashRegisterModel> _mapRegisterRow(Map<String, dynamic> row) async {
    final db = await _db.database;
    final registerId = _toInt(row['id']);
    final opening = await db.query(
      'RegisterOpeningDetail',
      where: 'register_id = ?',
      whereArgs: [registerId],
      orderBy: 'id ASC',
    );
    final closing = await db.query(
      'RegisterClosingDetail',
      where: 'register_id = ?',
      whereArgs: [registerId],
      orderBy: 'id ASC',
    );
    final movements = await db.query(
      'CashMovement',
      where: 'register_id = ?',
      whereArgs: [registerId],
      orderBy: 'datetime(created) DESC, id DESC',
    );

    final openingDenoms = opening
        .map(
          (r) => DenominationModel(
            denomination: _toDouble(r['denomination']),
            quantity: _toInt(r['quantity']),
            amount: _toDouble(r['amount']),
            type: (r['type'] ?? 'note').toString(),
          ),
        )
        .toList();
    final closingDenoms = closing
        .map(
          (r) => DenominationModel(
            denomination: _toDouble(r['denomination']),
            quantity: _toInt(r['quantity']),
            amount: _toDouble(r['amount']),
            type: (r['type'] ?? 'note').toString(),
          ),
        )
        .toList();
    final cashMovements = movements
        .map(
          (r) => CashMovementModel(
            id: _toInt(r['id']),
            registerId: _toInt(r['register_id']),
            movementType: (r['movement_type'] ?? '').toString(),
            amount: _toDouble(r['amount']),
            reason: (r['reason'] ?? '').toString(),
            referenceId: (r['reference_id'] ?? '').toString(),
            createdBy: (r['created_by'] ?? '').toString(),
            created: (r['created'] ?? '').toString(),
          ),
        )
        .toList();

    final openingTime = (row['opening_time'] ?? '').toString();
    final shiftDate = openingTime.contains('T') ? openingTime.split('T').first : openingTime;
    final difference = _toDouble(row['difference']);
    final varianceNote = difference > 0
        ? 'Surplus'
        : difference < 0
            ? 'Shortage'
            : 'Exact';

    return CashRegisterModel(
      id: registerId,
      name: (row['name'] ?? '').toString(),
      status: (row['status'] ?? 'closed').toString(),
      shiftDate: shiftDate,
      openingTime: openingTime,
      closingTime: (row['closing_time'] ?? '').toString().isEmpty
          ? null
          : (row['closing_time'] ?? '').toString(),
      openingAmount: _toDouble(row['opening_amount']),
      closingAmount: _toDouble(row['closing_amount']),
      expectedAmount: _toDouble(row['expected_amount']),
      difference: difference,
      totalSales: _toDouble(row['total_sales']),
      totalCashIn: _toDouble(row['total_cash_in']),
      totalCashOut: _toDouble(row['total_cash_out']),
      openingNote: (row['opening_note'] ?? '').toString().isEmpty
          ? null
          : (row['opening_note'] ?? '').toString(),
      closingNote: (row['closing_note'] ?? '').toString().isEmpty
          ? null
          : (row['closing_note'] ?? '').toString(),
      openedBy: (row['opened_by'] ?? '').toString().isEmpty
          ? null
          : (row['opened_by'] ?? '').toString(),
      closedBy: (row['closed_by'] ?? '').toString().isEmpty
          ? null
          : (row['closed_by'] ?? '').toString(),
      openingDenominations: openingDenoms,
      closingDenominations: closingDenoms,
      totalDenominations: closingDenoms.fold<double>(0, (sum, d) => sum + d.amount),
      varianceNote: varianceNote,
      cashMovements: cashMovements,
    );
  }

  String _hhmmss(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';

  int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}
