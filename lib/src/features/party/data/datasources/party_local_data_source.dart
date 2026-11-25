import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/employee_party_helper.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart';
import 'package:hotel/src/features/party/data/datasources/party_remote_data_source.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/reconcile_party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_delete_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_detail_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_pagination_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/reconcile_party_response.dart';
import 'package:hotel/src/features/party/domain/employee_advance_constants.dart';
import 'package:hotel/src/features/role/domain/party_picker_role_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: PartyRemoteDataSource)
class PartyLocalDataSource implements PartyRemoteDataSource {
  PartyLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<PartyListResponseModel> getPartyList({
    required PartyRequestParams params,
  }) async {
    try {
      final roleFilter = params.role?.trim().toLowerCase();
      if (roleFilter == 'employee') {
        await _backfillMissingEmployeeParties();
      }

      final filters = _buildListFilters(params);
      final employeeFilters = _buildListFilters(params, tableAlias: 'p');

      final page = params.page ?? 1;
      final perPage = params.pageSize ?? 20;
      final offset = (page - 1) * perPage;

      final db = await _db.database;
      final monthPrefix = DateFormat('yyyy-MM').format(DateTime.now());
      final rows = roleFilter == 'employee'
          ? await db.rawQuery(
              '''
              SELECT p.*,
                     e.id AS employee_id,
                     e.employee_code,
                     e.first_name,
                     e.last_name,
                     e.full_name,
                     e.department,
                     e.position,
                     e.employment_type,
                     e.employment_status,
                     e.basic_salary,
                     e.hire_date,
                     e.is_active AS employee_is_active,
                     COALESCE((
                       SELECT SUM(CAST(pii.amount AS REAL))
                       FROM PurchaseInvoiceItem pii
                       INNER JOIN PurchaseInvoice pi ON pii.parent = pi.name
                       WHERE pi.party = p.name
                         AND LOWER(TRIM(pii.item)) = LOWER(?)
                         AND pi.date LIKE ?
                         AND pi.submitted = 1
                         AND COALESCE(pi.cancelled, 0) = 0
                     ), 0) AS total_advance,
                     COALESCE((
                       SELECT SUM(CAST(si.outstandingAmount AS REAL))
                       FROM SalesInvoice si
                       WHERE si.party = p.name
                         AND si.submitted = 1
                         AND COALESCE(si.cancelled, 0) = 0
                     ), 0) AS computed_outstanding
              FROM Party p
              LEFT JOIN Employee e ON e.party_id = p.name
              WHERE ${employeeFilters.where}
              ORDER BY p.name ASC
              LIMIT ? OFFSET ?
              ''',
              [
                kAdvanceSalaryItemName,
                '$monthPrefix%',
                ...employeeFilters.args,
                perPage,
                offset,
              ],
            )
          : await db.query(
              'Party',
              where: filters.where,
              whereArgs: filters.args,
              orderBy: 'name ASC',
              limit: perPage,
              offset: offset,
            );

      final total = await _db.count(
        'Party',
        where: filters.where,
        whereArgs: filters.args,
      );
      final totalPages = total == 0 ? 1 : (total / perPage).ceil();

      return PartyListResponseModel(
        success: true,
        data: rows.map(_rowToPartyModel).toList(),
        pagination: PartyPaginationModel(
          currentPage: page,
          perPage: perPage,
          totalPages: totalPages,
          totalRows: total,
        ),
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  _PartyListFilters _buildListFilters(
    PartyRequestParams params, {
    String? tableAlias,
  }) {
    final prefix = tableAlias == null || tableAlias.isEmpty ? '' : '$tableAlias.';
    final conditions = <String>['1 = 1'];
    final args = <dynamic>[];

    if (params.role != null && params.role!.isNotEmpty) {
      final queryRoles = PartyPickerRoleHelper.queryRolesForTab(params.role!);
      if (queryRoles.length == 1) {
        conditions.add('LOWER(${prefix}role) = ?');
        args.add(queryRoles.first);
      } else {
        conditions.add(
          'LOWER(${prefix}role) IN (${List.filled(queryRoles.length, '?').join(', ')})',
        );
        args.addAll(queryRoles);
      }
    }
    if (params.search != null && params.search!.isNotEmpty) {
      final s = '%${params.search!.trim()}%';
      conditions.add(
        '(${prefix}name LIKE ? OR ${prefix}email LIKE ? OR ${prefix}phone LIKE ?)',
      );
      args.addAll([s, s, s]);
    }
    if (params.status != null) {
      conditions.add('${prefix}status = ?');
      args.add(params.status);
    }

    return _PartyListFilters(
      where: conditions.join(' AND '),
      args: args,
    );
  }

  @override
  Future<PartyCreateResponseModel> createParty({
    required CreatePartyRequest request,
    String? imagePath,
  }) async {
    try {
      await getIt<FreemiumGateService>().assertCan(
        FreemiumFeature.party,
        partyRole: request.role,
      );
      final now = DateTime.now().toIso8601String();
      final programName = request.loyaltyProgram?.trim();
      if (LoyaltyFeatures.enabled &&
          programName != null &&
          programName.isNotEmpty) {
        ensureLoyaltyProgramServiceRegistered();
        await getIt<LoyaltyProgramService>().createProgram(name: programName);
      }
      await _db.upsert('Party', {
        'name': request.name,
        'role': request.role,
        'email': request.email,
        'phone': request.phone,
        'address': request.address,
        'currency': request.currency,
        'loyaltyProgram': request.loyaltyProgram,
        'loyaltyPoints': request.loyaltyPoints ?? 0,
        'outstandingAmount': request.outstandingAmount ?? '0.0',
        'defaultAccount': request.defaultAccount,
        'createdBy': request.createdBy ?? '',
        'modifiedBy': request.createdBy ?? '',
        'created': now,
        'modified': now,
        'status': 1,
      });

      final party = PartyModel(
        name: request.name,
        role: request.role,
        email: request.email,
        phone: request.phone,
        address: request.address,
        currency: request.currency,
        loyaltyProgram: request.loyaltyProgram,
        loyaltyPoints: request.loyaltyPoints ?? 0,
        outstandingAmount: double.tryParse(request.outstandingAmount ?? ''),
        defaultAccount: request.defaultAccount,
        created: now,
      );

      return PartyCreateResponseModel(
        success: true,
        message: 'Party created successfully',
        party: party,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyDetailResponseModel> getPartyDetail({
    required String name,
  }) async {
    try {
      final rows = await _db.query('Party', where: 'name = ?', whereArgs: [name]);
      if (rows.isEmpty) throw AppException(message: 'Party "$name" not found');

      return PartyDetailResponseModel(
        success: true,
        party: _rowToPartyModel(rows.first),
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyUpdateResponseModel> updateParty({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      final programName = request.loyaltyProgram?.trim();
      if (LoyaltyFeatures.enabled &&
          programName != null &&
          programName.isNotEmpty) {
        ensureLoyaltyProgramServiceRegistered();
        await getIt<LoyaltyProgramService>().createProgram(name: programName);
      }

      final updates = <String, dynamic>{
        'modified': now,
        if (request.newName != null) 'name': request.newName,
        if (request.role != null) 'role': request.role,
        if (request.email != null) 'email': request.email,
        if (request.phone != null) 'phone': request.phone,
        if (request.address != null) 'address': request.address,
        if (request.currency != null) 'currency': request.currency,
        if (request.loyaltyProgram != null) 'loyaltyProgram': request.loyaltyProgram,
        if (request.loyaltyPoints != null) 'loyaltyPoints': request.loyaltyPoints,
        if (request.outstandingAmount != null)
          'outstandingAmount': request.outstandingAmount,
        if (request.defaultAccount != null) 'defaultAccount': request.defaultAccount,
        if (request.modifiedBy != null) 'modifiedBy': request.modifiedBy,
        if (clearPartyImage) 'image': null,
        if (imagePath != null && !clearPartyImage) 'image': imagePath,
      };

      await db.update('Party', updates, where: 'name = ?', whereArgs: [request.name]);

      final rows = await _db.query(
        'Party',
        where: 'name = ?',
        whereArgs: [request.newName ?? request.name],
      );

      final updated = rows.isNotEmpty
          ? _rowToPartyModel(rows.first)
          : PartyModel(name: request.newName ?? request.name, role: request.role ?? '');

      return PartyUpdateResponseModel(
        success: true,
        message: 'Party updated successfully',
        party: updated,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyDeleteResponseModel> deleteParty({
    required DeletePartyRequest request,
  }) async {
    try {
      final db = await _db.database;
      await db.delete('Party', where: 'name = ?', whereArgs: [request.name]);

      return PartyDeleteResponseModel(
        success: true,
        message: 'Party deleted successfully',
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ReconcilePartyResponse> reconcileParty({
    required ReconcilePartyRequestParams params,
  }) async {
    // Outstanding amounts are stored locally — no network reconciliation needed
    try {
      return ReconcilePartyResponse(
        success: true,
        message: 'Reconciled locally',
        summary: ReconciliationSummary(
          totalPartiesChecked: 1,
          totalMismatches: 0,
          totalFixed: 0,
          autoFixEnabled: false,
          transactionStatus: 'ok',
        ),
        reconciliationResults: [],
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  // ── helpers ─────────────────────────────────────────────────────────────────

  Future<void> _backfillMissingEmployeeParties() async {
    final db = await _db.database;
    final missing = await db.query(
      'Employee',
      where: "party_id IS NULL OR TRIM(party_id) = ''",
    );
    if (missing.isEmpty) return;

    final now = DateTime.now().toIso8601String();
    final actor = await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'system';

    for (final row in missing) {
      final fullName = (row['full_name'] as String? ?? '').trim();
      if (fullName.isEmpty) continue;

      await db.transaction((txn) async {
        final partyId = await EmployeePartyHelper.syncPartyForEmployee(
          txn,
          fullName: fullName,
          currentPartyId: null,
          email: row['email'] as String?,
          phone: row['phone'] as String?,
          address: row['address'] as String?,
          actor: actor,
          now: now,
          activeStatus: (row['is_active'] == 1 || row['is_active'] == true) ? 1 : 0,
        );
        await txn.update(
          'Employee',
          {'party_id': partyId, 'modified': now, 'modified_by': actor},
          where: 'id = ?',
          whereArgs: [row['id']],
        );
      });
    }
  }

  PartyModel _rowToPartyModel(Map<String, dynamic> r) {
    final employeeId = r['employee_id'];
    PartyEmployeeDetails? employeeDetails;
    if (employeeId != null) {
      employeeDetails = PartyEmployeeDetails(
        employeeId: employeeId is int ? employeeId : int.tryParse('$employeeId'),
        employeeCode: r['employee_code'] as String?,
        firstName: r['first_name'] as String?,
        lastName: r['last_name'] as String?,
        fullName: r['full_name'] as String?,
        department: r['department'] as String?,
        position: r['position'] as String?,
        employmentType: r['employment_type'] as String?,
        employmentStatus: r['employment_status'] as String?,
        basicSalary: (r['basic_salary'] as num?)?.toDouble(),
        hireDate: r['hire_date'] as String?,
        isActive: r['employee_is_active'] == 1 || r['employee_is_active'] == true,
      );
    }

    return PartyModel(
      id: r['id']?.toString(),
      image: r['image'] as String?,
      name: r['name'] as String,
      role: r['role'] as String? ?? '',
      email: r['email'] as String?,
      phone: r['phone'] as String?,
      address: r['address'] as String?,
      defaultAccount: r['defaultAccount'] as String?,
      currency: r['currency'] as String?,
      loyaltyProgram: r['loyaltyProgram'] as String?,
      loyaltyPoints: r['loyaltyPoints'] as int?,
      outstandingAmount: _outstandingFromRow(r),
      created: r['created'] as String?,
      modified: r['modified'] as String?,
      createdBy: r['createdBy'] as String?,
      modifiedBy: r['modifiedBy'] as String?,
      employeeDetails: employeeDetails,
      totalAdvance: _totalAdvanceFromRow(r),
    );
  }

  double _outstandingFromRow(Map<String, dynamic> r) {
    if (r.containsKey('computed_outstanding')) {
      final computed = r['computed_outstanding'];
      if (computed is num) return computed.toDouble();
      return double.tryParse(computed?.toString() ?? '') ?? 0.0;
    }
    return double.tryParse(r['outstandingAmount']?.toString() ?? '0') ?? 0.0;
  }

  double? _totalAdvanceFromRow(Map<String, dynamic> r) {
    final computed = r['total_advance'];
    if (computed != null) {
      if (computed is num) return computed.toDouble();
      return double.tryParse(computed.toString());
    }
    return _nullableDoubleFromJson(r['totalAdvance']);
  }

  double? _nullableDoubleFromJson(Object? value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}

class _PartyListFilters {
  const _PartyListFilters({required this.where, required this.args});

  final String where;
  final List<dynamic> args;
}
