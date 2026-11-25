import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/login/data/datasources/login_remote_data_source.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/login/data/models/login_response_model.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:hotel/src/features/setup/domain/test_data_login_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginLocalDataSourceImpl implements LoginRemoteDataSource {
  LoginLocalDataSourceImpl(this._db);

  final LocalDb _db;

  @override
  Future<ApiResponse<LoginResponseModel>> postLoginToken(
    LoginRequestParams params,
  ) async {
    final email = params.email.trim().toLowerCase();
    final password = params.password;

    if (email.isEmpty) {
      throw const AppException(message: 'Email is required');
    }

    final setupComplete = await LocalSetupStorage.isCompleted();
    if (!setupComplete && !await LocalDb.databaseFileExists()) {
      throw const AppException(
        message: 'Local database not set up. Complete setup first.',
      );
    }

    if (!await _validateCredentials(email, password)) {
      throw const AppException(message: 'Invalid email or password');
    }

    return ApiResponse(
      data: const LoginResponseModel(access: '', refresh: ''),
      message: 'Signed in',
      success: true,
    );
  }

  Future<bool> _validateCredentials(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();

    final storedEmail =
        (await LocalSetupStorage.getSavedAdminEmail())?.trim().toLowerCase();
    final storedPassword = await LocalSetupStorage.getSavedAdminPassword();

    if (storedEmail != null &&
        storedPassword != null &&
        storedEmail == normalizedEmail &&
        storedPassword == password) {
      return true;
    }

    if (!await _emailExistsLocally(normalizedEmail)) {
      return false;
    }

    if (await TestDataLoginService.isActiveOrganizationDemo()) {
      final creds =
          await TestDataLoginService.resolveCredentialsForActiveOrganization();
      return normalizedEmail == creds.email && password == creds.password;
    }

    if (storedPassword != null && storedPassword.isNotEmpty) {
      return storedPassword == password;
    }

    return false;
  }

  Future<bool> _emailExistsLocally(String email) async {
    try {
      final db = await _db.database;

      final employees = await db.query(
        'Employee',
        where: 'LOWER(email) = ?',
        whereArgs: [email],
        limit: 1,
      );
      if (employees.isNotEmpty) return true;

      final settings = await db.query(
        'SingleValue',
        where: 'parent = ? AND fieldname = ? AND LOWER(value) = ?',
        whereArgs: ['AccountingSettings', 'email', email],
        limit: 1,
      );
      return settings.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
