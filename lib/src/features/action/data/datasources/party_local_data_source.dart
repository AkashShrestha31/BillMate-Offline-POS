import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/datasources/party_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/action/data/models/request/party_update_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_update_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: PartyRemoteDataSource)
class PartyLocalDataSource implements PartyRemoteDataSource {
  PartyLocalDataSource(this._db);
  final LocalDb _db;
  final _uuid = const Uuid();

  @override
  Future<ApiResponse<PartyResponseModel>> getParties({
    required PartyRequestParams params,
  }) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];

      if (params.partyRoles != null && params.partyRoles!.isNotEmpty) {
        final roles = params.partyRoles!
            .map((r) => r.trim().toLowerCase())
            .where((r) => r.isNotEmpty)
            .toList();
        if (roles.isNotEmpty) {
          conditions.add(
            'LOWER(p.role) IN (${List.filled(roles.length, '?').join(', ')})',
          );
          args.addAll(roles);
        }
      } else if (params.partyType != null && params.partyType!.isNotEmpty) {
        conditions.add('LOWER(p.role) = ?');
        args.add(params.partyType!.trim().toLowerCase());
      }
      if (params.status != null) {
        conditions.add('p.status = ?');
        args.add(params.status);
      }
      if (params.search != null && params.search!.isNotEmpty) {
        final s = '%${params.search!.trim()}%';
        conditions.add('(p.name LIKE ? OR p.email LIKE ? OR p.phone LIKE ?)');
        args.addAll([s, s, s]);
      }

      final whereClause =
          conditions.isNotEmpty ? 'WHERE ${conditions.join(' AND ')}' : '';
      final page = params.page ?? 1;
      final perPage = params.perPage ?? 20;
      final offset = (page - 1) * perPage;

      final db = await _db.database;
      final rows = await db.rawQuery(
        '''
        SELECT p.*,
               e.id AS employee_id,
               e.employment_status,
               e.is_active AS employee_is_active
        FROM Party p
        LEFT JOIN Employee e ON e.party_id = p.name
        $whereClause
        ORDER BY p.name ASC
        LIMIT ? OFFSET ?
        ''',
        [...args, perPage, offset],
      );

      final countConditions = conditions
          .map((c) => c.replaceAll('p.', ''))
          .toList();
      final countWhere =
          countConditions.isNotEmpty ? countConditions.join(' AND ') : null;
      final total = await _db.count(
        'Party',
        where: countWhere,
        whereArgs: args.isNotEmpty ? args : null,
      );
      final totalPages = total == 0 ? 1 : (total / perPage).ceil();

      final parties = rows.map(_rowToPartyItem).toList();

      return ApiResponse(
        data: PartyResponseModel(
          data: parties,
          pagination: Pagination(
            current_page: page,
            per_page: perPage,
            total_pages: totalPages,
            total_rows: total,
          ),
        ),
        message: 'Parties fetched',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<PartyResponseModel>> getPartyById({
    required String id,
  }) async {
    try {
      final rows = await _db.query('Party', where: 'name = ?', whereArgs: [id]);
      if (rows.isEmpty) throw const AppException(message: 'Party not found');

      return ApiResponse(
        data: PartyResponseModel(
          data: [_rowToPartyItem(rows.first)],
          pagination: const Pagination(
            current_page: 1,
            per_page: 1,
            total_pages: 1,
            total_rows: 1,
          ),
        ),
        message: 'Party fetched',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<PartyResponseModel>> createParty({
    required CreatePartyRequest request,
  }) async {
    try {
      await getIt<FreemiumGateService>().assertCan(
        FreemiumFeature.party,
        partyRole: request.partyType,
      );
      final now = DateTime.now().toIso8601String();
      final id = _uuid.v4();

      await _db.upsert('Party', {
        'id': id,
        'name': request.name,
        'email': request.email,
        'phone': request.phone,
        'address': request.address,
        'role': request.partyType,
        'panNumber': request.panNumber,
        'created': now,
        'modified': now,
      });

      final created = PartyItem(
        id: null,
        name: request.name,
        outstandingAmount: 0.0,
        role: request.partyType,
      );

      return ApiResponse(
        data: PartyResponseModel(
          data: [created],
          pagination: const Pagination(
            current_page: 1,
            per_page: 1,
            total_pages: 1,
            total_rows: 1,
          ),
        ),
        message: 'Party created successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<PartyUpdateResponseModel>> updateParty({
    required PartyUpdateRequestParams request,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;

      final count = await db.update(
        'Party',
        {'name': request.newName, 'modified': now},
        where: 'name = ?',
        whereArgs: [request.oldName],
      );

      return ApiResponse(
        data: PartyUpdateResponseModel(
          success: true,
          message: 'Party updated successfully',
          totalRecordsUpdated: count,
          updatesByTable: const UpdatesByTable(
            party: 1,
            salesInvoice: 0,
            salesQuote: 0,
            purchaseInvoice: 0,
            purchaseReceipt: 0,
            payment: 0,
            shipment: 0,
            accountingLedgerEntry: 0,
            loyaltyPointEntry: 0,
          ),
          updatedParty: UpdatedParty(
            name: request.newName,
            role: '',
            email: null,
            phone: null,
            address: null,
            loyaltyProgram: null,
            loyaltyPoints: 0,
            outstandingAmount: 0.0,
            created: now,
            modified: now,
            modifiedBy: request.modifiedBy,
          ),
        ),
        message: 'Party updated successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<void>> deleteParty({required String id}) async {
    try {
      final db = await _db.database;
      // Party table uses 'name' as the natural key, id param is the name string
      await db.delete('Party', where: 'name = ?', whereArgs: [id]);
      return ApiResponse(data: null, message: 'Party deleted', success: true);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  // ── helper ──────────────────────────────────────────────────────────────────

  PartyItem _rowToPartyItem(Map<String, dynamic> r) {
    final employeeId = r['employee_id'];
    PartyItemEmployeeDetails? employeeDetails;
    if (employeeId != null ||
        r['employment_status'] != null ||
        r['employee_is_active'] != null) {
      employeeDetails = PartyItemEmployeeDetails.fromJson({
        'employee_id': employeeId,
        'employment_status': r['employment_status'],
        'is_active': r['employee_is_active'],
      });
    }

    return PartyItem(
      id: r['id'] as int?,
      name: r['name'] as String?,
      phone: r['phone'] as String?,
      outstandingAmount:
          double.tryParse(r['outstandingAmount']?.toString() ?? '0') ?? 0.0,
      role: r['role'] as String?,
      currency: r['currency'] as String?,
      employeeDetails: employeeDetails,
    );
  }
}
